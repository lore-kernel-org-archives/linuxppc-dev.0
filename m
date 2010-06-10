Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 5BCAB1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 03:03:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH][RFC] ibm_newemac and SIOCGMIIREG
Date: Thu, 10 Jun 2010 19:03:43 +0200
References: <4C10EFE0.6030106@harris.com> <201006101631.29591.arnd@arndb.de>
	<4C11046D.4080205@harris.com>
In-Reply-To: <4C11046D.4080205@harris.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201006101903.43882.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 10 June 2010, Steven A. Falco wrote:
> > The ifreq structure passed into the ndo_ioctl function is in kernel
> > space, it gets copied there by net/core/dev.c:dev_ioctl().
> > emac_ioctl only accesses the data in that structure, so a copy_from_user
> > is wrong here as far as I can tell.
> 
> net/core/dev.c:dev_ioctl() does a copy_from_user on the overall structure,
> but the structure contains a union, one member of which is an embedded
> pointer to an array.  This pointer member is only used in the case of these
> two ioctls.  Other ioctls use different union members, which are not pointers.

Still unconvinced.

I don't see anywhere in the structure where we actually use a
pointer from ifr_ifru. The if_mii function is defined as

static inline struct mii_ioctl_data *if_mii(struct ifreq *rq)
{
        return (struct mii_ioctl_data *) &rq->ifr_ifru;
}

That just returns a pointer to the ifr_ifru member itself,
it does not read a __user pointer. Note how if_mii even
returns a kernel pointer (struct mii_ioctl_data *), not
a struct mii_ioctl_data __user *. You even added a cast
that otherwise should not be needed.

> As I understand it, the copy_from_user in dev_ioctl does not recursively
> copy the array.  In fact it could not do so, because the pointer to array
> is only 4 bytes long, while the array itself is 8 bytes long - so it would
> not fit.  I.e., dev_ioctl would have to allocate storage, and do a second
> copy_from_user to retrieve the array.  It would have to clean up after the
> emac_ioctl ran.  And it would have to do this only for these specific
> ioctl calls which use the array pointer in the union.
>
> Also, the result has to be returned to the user in the same array, which
> needs a copy_to_user of the array data, which is also not done in dev_ioctl.

There is no array, and no pointer in struct ifreq
 
> So I think this second copy_from/copy_to needs to be done somewhere.  I
> added it in the emac_ioctl because that is where the command is fully
> decoded.  It also avoids the problem of allocating space for the copied
> array.  But other fixes are certainly possible as well, which is why I am
> not sure I've hit on the "proper" fix.

No other device driver implementing SIOCGMIIREG does any of this,
so I'm pretty sure it's not the proper fix.

> Thanks very much for reviewing - please let me know if my explanation is
> unclear, or if you see a better way to fix this problem.

In theory, your patch should break the code. Doing a direct access
in place of a copy_to/from_user is a security hole but should still work,
while adding a copy_to/from_user on a kernel pointer should always result
in an EFAULT.

	Arnd
