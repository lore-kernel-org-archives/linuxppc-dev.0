Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 6A5CEB7D66
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 06:36:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH][RFC] ibm_newemac and SIOCGMIIREG
Date: Thu, 10 Jun 2010 22:35:48 +0200
References: <4C10EFE0.6030106@harris.com> <201006101903.43882.arnd@arndb.de>
	<4C11414F.5070602@harris.com>
In-Reply-To: <4C11414F.5070602@harris.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201006102235.48632.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 10 June 2010 21:47:27 Steven A. Falco wrote:
> On 06/10/2010 01:03 PM, Arnd Bergmann wrote:
> > Still unconvinced.
> 
> Ok - here is the user-space program I am using to test this.  It simply
> uses the ioctl to peek and poke the phy.  If I run it on an unmodified
> kernel, and I read the phy ID registers, i.e. registers 2 and 3, I get:
> 
> # ./phy -r -a 2
> 2: 0000
> # ./phy -r -a 3
> 3: 0000
> 
> which is clearly wrong.  Once I load my modified kernel, I get:
> 
> # ./phy -a 2
> 2: 0022
> # ./phy -a 3
> 3: 1512
> 
> which is correct for the phy on my board (i.e. phy id is 00221512).  If you
> could try this program on a sequoia or similar, I'd be interested in whether
> you see the problem.

It seems that your program is wrong. On my PC here, it also shows zero,
while mii-tool works fine.

> int
> main(int argc, char *argv[])
> {
>     int		    fd;
>     struct ifreq    request;
>     struct mii_ioctl_data data;

This should be

struct mii_ioctl_data *data = &request.ifr_ifru

> > I don't see anywhere in the structure where we actually use a
> > pointer from ifr_ifru. The if_mii function is defined as
> > 
> > static inline struct mii_ioctl_data *if_mii(struct ifreq *rq)
> > {
> >         return (struct mii_ioctl_data *) &rq->ifr_ifru;
> > }
> > 
> > That just returns a pointer to the ifr_ifru member itself,
> 
> But that pointer points to a separate "struct mii_ioctl_data"
> in user space.  In my test code above, I do:
> 
> request.ifr_data = (__caddr_t)&data;
> 
> where data is a "struct mii_ioctl_data" that is separate from the
> "struct ifreq".  It's not one monolithic structure, it is two
> structures, one pointing to the other, both in user space.

Only in your code, when you look at mii-tool, it does (correctly)

static int mdio_read(int skfd, int location)
{
    struct mii_data *mii = (struct mii_data *)&ifr.ifr_data;
    mii->reg_num = location;
    if (ioctl(skfd, SIOCGMIIREG, &ifr) < 0) {
        fprintf(stderr, "SIOCGMIIREG on %s failed: %s\n", ifr.ifr_name,
                strerror(errno));
        return -1;
    }
    return mii->val_out;
}

> > it does not read a __user pointer. Note how if_mii even
> > returns a kernel pointer (struct mii_ioctl_data *), not
> > a struct mii_ioctl_data __user *. You even added a cast
> > that otherwise should not be needed.
> 
> I disagree - the structure, as shown in "include/linux/if.h" has
> "void __user *ifru_data", which is clearly a user pointer.

This is used for SIOCSHWTSTAMP, SIOCBONDINFOQUERY, SIOCETHTOOL
and possibly a few others but not SIOCGMIIREG.
 
> and that is why the second copy_from_user is needed.  It would have been
> much nicer if the union contained the actual mii_ioctl_data structure,
> but I guess the void pointer is more flexible.

No, the void pointer is broken for a number of reasons, that's why
we don't use it.

> My patch does not give an EFAULT, as you will see if you are able to try
> my test program.  I won't claim that proves I am right however. :-)
> 
> Your statement that copy_to/from_user is just there for security is
> something I did not know.  Yet, that doesn't appear to be the case,
> given my experiments.

Right, I misread one line of your patch: when you do

	if (copy_from_user(user_data, (char __user *)data, sizeof(user_data)))
		return -EFAULT;
	user_data->val_out = emac_mdio_read(ndev, dev->phy.address,
				       user_data->reg_num);
	if (copy_to_user((char __user *)rq->ifr_data, user_data, sizeof(user_data)))

You actually copy in from a different pointer than you copy out to.
The first one is a cast from a kernel to a user pointer, which
should actually result in -EFAULT (I don't known why it doesn't)
while the second one is where you change the interface to match
your (broken) program.

	Arnd
