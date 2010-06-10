Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 7183FB7D88
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 01:44:56 +1000 (EST)
Message-ID: <4C11046D.4080205@harris.com>
Date: Thu, 10 Jun 2010 11:27:41 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH][RFC] ibm_newemac and SIOCGMIIREG
References: <4C10EFE0.6030106@harris.com> <201006101631.29591.arnd@arndb.de>
In-Reply-To: <201006101631.29591.arnd@arndb.de>
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

On 06/10/2010 10:31 AM, Arnd Bergmann wrote:
> 
> On Thursday 10 June 2010, Steven A. Falco wrote:
>> I believe there is a bug in the way the ibm_newemac driver handles the
>> SIOCGMIIREG (and SIOCSMIIREG) ioctl.  The problem is that emac_ioctl
>> is handed a "struct ifreq *rq" which contains a user-land pointer to
>> an array of 16-bit integers.
> 
> Did you actually see a bug here, or just think that this could be
> a problem?

I did see a problem.  I tried using the ioctl, and I didn't get the
correct result.  I then added some printk in the driver, and saw that
garbage was being passed in the data array.

I added the copy_from/copy_to, and the ioctl started working.

> 
>> However, emac_ioctl directly accesses the data, which doesn't work.
>> I added the following patch to copy the data in and out.
>>
>> Please note that this patch was tested in an older kernel (2.6.30)
>> because that is what we are using on our custom hardware.  I think
>> this is still a problem in the current code, but I'd like reviewers
>> to take a look, to be sure.
> 
> The ifreq structure passed into the ndo_ioctl function is in kernel
> space, it gets copied there by net/core/dev.c:dev_ioctl().
> emac_ioctl only accesses the data in that structure, so a copy_from_user
> is wrong here as far as I can tell.

net/core/dev.c:dev_ioctl() does a copy_from_user on the overall structure,
but the structure contains a union, one member of which is an embedded
pointer to an array.  This pointer member is only used in the case of these
two ioctls.  Other ioctls use different union members, which are not pointers.

As I understand it, the copy_from_user in dev_ioctl does not recursively
copy the array.  In fact it could not do so, because the pointer to array
is only 4 bytes long, while the array itself is 8 bytes long - so it would
not fit.  I.e., dev_ioctl would have to allocate storage, and do a second
copy_from_user to retrieve the array.  It would have to clean up after the
emac_ioctl ran.  And it would have to do this only for these specific
ioctl calls which use the array pointer in the union.

Also, the result has to be returned to the user in the same array, which
needs a copy_to_user of the array data, which is also not done in dev_ioctl.

So I think this second copy_from/copy_to needs to be done somewhere.  I
added it in the emac_ioctl because that is where the command is fully
decoded.  It also avoids the problem of allocating space for the copied
array.  But other fixes are certainly possible as well, which is why I am
not sure I've hit on the "proper" fix.

Thanks very much for reviewing - please let me know if my explanation is
unclear, or if you see a better way to fix this problem.

	Steve

> 
> 	Arnd


-- 
A: Because it makes the logic of the discussion difficult to follow.
Q: Why shouldn't I top post?
A: No.
Q: Should I top post?
