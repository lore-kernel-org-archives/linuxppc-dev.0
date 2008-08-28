Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC7B5DE1E6
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 08:42:14 +1000 (EST)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support
	36-bit physical
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <4DA58F0E-BBE8-4547-80AF-A890BACC79E7@freescale.com>
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<48B5E6B7.3000903@freescale.com>
	<C16F93B0-766C-43E8-B4B5-40BC0FEE298F@freescale.com>
	<48B6CD32.2040308@freescale.com>
	<4DA58F0E-BBE8-4547-80AF-A890BACC79E7@freescale.com>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 08:42:01 +1000
Message-Id: <1219963322.13162.366.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I understand what you're saying, I've been here before :)  However, I  
> was never able to convince myself that it's safe without the lwarx/ 
> stwcx.  There's hashing code that wanks around with the HASHPTE bit  
> doing a RMW without holding any lock (other than lwarx/stwcx-ing the  
> PTE itself).  And there's definitely code that's fairly far removed  
> from the last time you checked that an entry was valid.  I've CC'd Ben  
> on this mail - perhaps he can shed some light.  If we don't need the  
> atomics, I'm happy to yank them.
> 
> Now, it *does* seem like set_pte_at could be optimized for the non-SMP  
> case....  I'll have to chew on that one a bit.

I haven't read the whole discussion not reviewed the patches yet, so I'm
just answering to the above sentence before I head off for the week-end
(and yes, Becky, I _DO_ have reviewing your stuff high on my todo list,
but I've been really swamped those last 2 weeks).

So all generic code always accesses PTEs with the PTE lock held (that
lock can be in various places ... typically for us it's one per PTE
page).

44x and FSL BookE no longer write to the PTEs without that lock anymore
and thus don't require atomic access in set_pte and friends.

Hash based platforms still do because of -one- thing : the hashing code
proper which writes back using lwarx/stwcx. to update _PAGE_ACCESSED,
_PAGE_HASHPTE and _PAGE_DIRTY. The hash code does take a global lock to
avoid double-hashing of the same page but this isn't something we should
use elsewhere.

So on hash based platforms, updates of the PTEs are expected to be done
atomically. Now if you extend the size of the PTE, hopefully those
atomic updates are still necessary but only for the -low- part of the
PTE that contains those bits.

For the non-SMP case, I think it should be possible to optimize it. The
only thing that can happen at interrupt time is hashing of kernel or
vmalloc/ioremap pages, which shouldn't compete with set_pte on those
pages, so there would be no access races there, but I may be missing
something as it's the morning and I about just woke up :-)

Cheers,
Ben.
