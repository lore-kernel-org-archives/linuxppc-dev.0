Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 25B711007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 05:47:33 +1000 (EST)
Message-ID: <4C11414F.5070602@harris.com>
Date: Thu, 10 Jun 2010 15:47:27 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH][RFC] ibm_newemac and SIOCGMIIREG
References: <4C10EFE0.6030106@harris.com> <201006101631.29591.arnd@arndb.de>
	<4C11046D.4080205@harris.com> <201006101903.43882.arnd@arndb.de>
In-Reply-To: <201006101903.43882.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2010 01:03 PM, Arnd Bergmann wrote:
> 
> On Thursday 10 June 2010, Steven A. Falco wrote:
>>> The ifreq structure passed into the ndo_ioctl function is in kernel
>>> space, it gets copied there by net/core/dev.c:dev_ioctl().
>>> emac_ioctl only accesses the data in that structure, so a copy_from_user
>>> is wrong here as far as I can tell.
>>
>> net/core/dev.c:dev_ioctl() does a copy_from_user on the overall structure,
>> but the structure contains a union, one member of which is an embedded
>> pointer to an array.  This pointer member is only used in the case of these
>> two ioctls.  Other ioctls use different union members, which are not pointers.
> 
> Still unconvinced.

Ok - here is the user-space program I am using to test this.  It simply
uses the ioctl to peek and poke the phy.  If I run it on an unmodified
kernel, and I read the phy ID registers, i.e. registers 2 and 3, I get:

# ./phy -r -a 2
2: 0000
# ./phy -r -a 3
3: 0000

which is clearly wrong.  Once I load my modified kernel, I get:

# ./phy -a 2
2: 0022
# ./phy -a 3
3: 1512

which is correct for the phy on my board (i.e. phy id is 00221512).  If you
could try this program on a sequoia or similar, I'd be interested in whether
you see the problem.

------ cut here ------

#define _GNU_SOURCE

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include <getopt.h>
#include <string.h>
#include <unistd.h>

#include <linux/mii.h>
#include <linux/sockios.h>

#include <net/if.h>

#include <sys/ioctl.h>
#include <sys/socket.h>

#define READING 0
#define WRITING 1

void use()
{
    fprintf(stderr, "\nphy [OPTIONS]\n\n");
    fprintf(stderr, "  -a address (register within phy to access)\n");
    fprintf(stderr, "  -d device (something like eth0, eth1, etc.)\n");
    fprintf(stderr, "  -r (read the register)\n");
    fprintf(stderr, "  -w (write the register)\n");
    fprintf(stderr, "  -v value (the value to write)\n");
    fprintf(stderr, "  -h (this help message)\n");
}

int
main(int argc, char *argv[])
{
    int		    fd;
    struct ifreq    request;
    struct mii_ioctl_data data;
    int		    opt;
    int		    dir = READING;
    char	    *pDev = "eth0";
    uint32_t	    addr = 0;
    uint32_t	    value = 0;

    while((opt = getopt(argc, argv, "a:d:hrv:w")) != -1) {
	switch(opt) {
	    case 'a':
		addr = strtoul(optarg, NULL, 16);
		break;

	    case 'd':
		pDev = optarg;
		break;

	    case 'h':
		use();
		exit(0);

	    case 'r':
		dir = READING;
		break;

	    case 'v':
		value = strtoul(optarg, NULL, 16);
		break;

	    case 'w':
		dir = WRITING;
		break;

	    default:
		fprintf(stderr, "bad option\n");
		use();
		exit(1);
	}
    }

    fd = socket(AF_INET, SOCK_DGRAM, 0);
    if(fd < 0) {
	fprintf(stderr, "no sock\n");
	exit(1);
    }

    memset(&request, 0, sizeof(request));
    memset(&data, 0, sizeof(data));
    strncpy(request.ifr_name, pDev, sizeof(request.ifr_name));
    data.reg_num = addr;
    y

    if(dir == READING) {
	if(ioctl(fd, SIOCGMIIREG, &request) < 0) {
	    fprintf(stderr, "SIOCGMIIREG failed\n");
	    exit(1);
	}

	printf("%d: %04x\n", addr, data.val_out);
    } else {
	data.val_in = value;
	if(ioctl(fd, SIOCSMIIREG, &request) < 0) {
	    fprintf(stderr, "SIOCSMIIREG failed\n");
	    exit(1);
	}
    }

    exit(0);
}

------ cut here ------

> 
> I don't see anywhere in the structure where we actually use a
> pointer from ifr_ifru. The if_mii function is defined as
> 
> static inline struct mii_ioctl_data *if_mii(struct ifreq *rq)
> {
>         return (struct mii_ioctl_data *) &rq->ifr_ifru;
> }
> 
> That just returns a pointer to the ifr_ifru member itself,

But that pointer points to a separate "struct mii_ioctl_data"
in user space.  In my test code above, I do:

request.ifr_data = (__caddr_t)&data;

where data is a "struct mii_ioctl_data" that is separate from the
"struct ifreq".  It's not one monolithic structure, it is two
structures, one pointing to the other, both in user space.

> it does not read a __user pointer. Note how if_mii even
> returns a kernel pointer (struct mii_ioctl_data *), not
> a struct mii_ioctl_data __user *. You even added a cast
> that otherwise should not be needed.

I disagree - the structure, as shown in "include/linux/if.h" has
"void __user *ifru_data", which is clearly a user pointer.

> 
>> As I understand it, the copy_from_user in dev_ioctl does not recursively
>> copy the array.  In fact it could not do so, because the pointer to array
>> is only 4 bytes long, while the array itself is 8 bytes long - so it would
>> not fit.  I.e., dev_ioctl would have to allocate storage, and do a second
>> copy_from_user to retrieve the array.  It would have to clean up after the
>> emac_ioctl ran.  And it would have to do this only for these specific
>> ioctl calls which use the array pointer in the union.
>>
>> Also, the result has to be returned to the user in the same array, which
>> needs a copy_to_user of the array data, which is also not done in dev_ioctl.
> 
> There is no array, and no pointer in struct ifreq

struct ifreq {
	.....
	union {
		.....
		void __user *	ifru_data;
		.....
	} ifr_ifru;
};

I claim that "ifru_data" is a pointer to a user-space structure,
which for these two ioctls is defined as:

struct mii_ioctl_data {
	__u16		phy_id;
	__u16		reg_num;
	__u16		val_in;
	__u16		val_out;
};

I misspoke when calling this an array.  In earlier versions of the
kernel code, this was simply an array of four __u16, but it is now a
struct.  Doesn't really matter though - it is a separate structure from
the ifreq one.  So in my test program, I have:

    struct ifreq    request;
    struct mii_ioctl_data data;
	.....
    request.ifr_data = (__caddr_t)&data;

which is where I fill in the "struct ifreq" with my user pointer to my
"struct mii_ioctl_data".

The key is that the union does not have:

	struct mii_ioctl_data ifru_data;

rather it has a pointer:

	void __user *	ifru_data;

and that is why the second copy_from_user is needed.  It would have been
much nicer if the union contained the actual mii_ioctl_data structure,
but I guess the void pointer is more flexible.

>  
>> So I think this second copy_from/copy_to needs to be done somewhere.  I
>> added it in the emac_ioctl because that is where the command is fully
>> decoded.  It also avoids the problem of allocating space for the copied
>> array.  But other fixes are certainly possible as well, which is why I am
>> not sure I've hit on the "proper" fix.
> 
> No other device driver implementing SIOCGMIIREG does any of this,
> so I'm pretty sure it's not the proper fix.

That is my main worry as well.  However, my test program does not work
unless I modify the kernel.  Perhaps there is something wrong with the
program, but I don't think so, based on the union definition as I showed
it above.

> 
>> Thanks very much for reviewing - please let me know if my explanation is
>> unclear, or if you see a better way to fix this problem.
> 
> In theory, your patch should break the code. Doing a direct access
> in place of a copy_to/from_user is a security hole but should still work,
> while adding a copy_to/from_user on a kernel pointer should always result
> in an EFAULT.

My patch does not give an EFAULT, as you will see if you are able to try
my test program.  I won't claim that proves I am right however. :-)

Your statement that copy_to/from_user is just there for security is
something I did not know.  Yet, that doesn't appear to be the case,
given my experiments.

I appreciate your patience - perhaps there is something unique about the
4xx CPU's that makes the direct access fail.  I should add that my
kernel does have Xenomai patches added.  I also don't know if that has
any bearing on the problem.

I'll try to resurrect my sequoia board with an unmodified kernel and
test further.  One thing for sure - something strange is going on.

	Steve

> 
> 	Arnd
> 
