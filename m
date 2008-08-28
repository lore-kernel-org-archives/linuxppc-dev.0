Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B68C2DE119
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 06:29:19 +1000 (EST)
Message-ID: <48B70A6A.6030407@freescale.com>
Date: Thu, 28 Aug 2008 15:28:26 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<48B5E6B7.3000903@freescale.com>
	<C16F93B0-766C-43E8-B4B5-40BC0FEE298F@freescale.com>
	<48B6CD32.2040308@freescale.com>
	<4DA58F0E-BBE8-4547-80AF-A890BACC79E7@freescale.com>
In-Reply-To: <4DA58F0E-BBE8-4547-80AF-A890BACC79E7@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
> On Aug 28, 2008, at 11:07 AM, Scott Wood wrote:
> 
>> Becky Bruce wrote:
>>> I'm pretty sure I went through this in great detail at one point
>>> and concluded that I did in fact need the lwarx/stwcx.  IIRC, it
>>> has to do with other non-set_pte_at writers not necessarily
>>> holding the page table lock. FYI, the existing 32-bit PTE code is
>>> doing atomic updates as well.
>> 
>> But will those updates happen if there isn't already a valid PTE?
> 
> I understand what you're saying, I've been here before :)  However, I
>  was never able to convince myself that it's safe without the 
> lwarx/stwcx.  There's hashing code that wanks around with the HASHPTE
>  bit doing a RMW without holding any lock (other than lwarx/stwcx-ing
> the PTE itself).

OK.  I was concerned not just about efficiency, but of the safety of the 
  "stw" write if there were other modifications going on (even if the 
set_pte_at stwcx fails, the other updater could have lwarxed an 
succesfully stwcxed after the stw and ended up with a mixed PTE), but it 
may not be an issue depending on the nature of the updates.

>>> About PTE_ATOMIC_UPDATES, I didn't add that in because hashed
>>> page table implementations require atomic updates.
>> 
>> Right, I misread it and thought it was being used for non-hashed 
>> implementations as well.
>> 
>> What happens if you enable 64-bit PTEs on a 603-ish CPU?  The
>> kconfig seems to allow it.
> 
> Don't do that :)  That's why the help is there in the Kconfig. 

People will do it anyway -- and there's multiplatform to consider.

> Otherwise, I have to list out every 74xx part that supports 36-bit 
> physical addressing.  In any event, nothing interesting will happen 
> other than that you'll waste some space.  The kernel boots fine with
> a non-36b physical u-boot and small amounts of RAM.

My concern was the generic code trying to use 64-bit PTEs, and the 603 
TLB miss handlers continuing to assume that the PTEs are 32-bit, and 
loading the wrong thing.

Wasted space alone is an acceptable consequence of turning on things you 
don't need. :-)

> I'm still not sure where you're going with this - I can remove 44x
> from the conditional part, but we still have to deal with e500 and
> 6xx.

You still need it in "depends" (in the absence of a "PHYS_64BIT_CAPABLE" 
or some such), but not "bool '...' if".  It's not a big deal, just a pet 
peeve.

> In which case you're now setting this in different places for difft
> plats, making it potentially harder to read.  Unless you're
> suggesting allowing the selection of PHYS_64BIT on any platform

No, unless the code for all platforms makes it safe to do so.

-Scott
