Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F15EDDF23
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 15:28:48 +1000 (EST)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support
	36-bit physical
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48B5E6B7.3000903@freescale.com>
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<48B5E6B7.3000903@freescale.com>
Content-Type: text/plain
Date: Mon, 01 Sep 2008 15:28:22 +1000
Message-Id: <1220246902.13010.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Could the stw to the same reservation granule as the stwcx cancel the 
> reservation on some implementations?

It might I suppose ... In any case, see my replies to Becky.

>   Plus, if you're assuming that the 
> entry is currently invalid and all callers have the page table lock, do 
> we need the lwarx/stwcx at all?  At the least, it should check 
> PTE_ATOMIC_UPDATES.

It shouldn't need atomic operations -if- the current entry is invalid
-and- _PAGE_HASHPTE is clear. (Ie, the current entry is invalid -and- 
the hash table has been updated).

In any case, the stw can just move out of the loop.

It might be worth just doing something along the lines of

	if (pte_val(*ptep) & _PAGE_PRESENT)
		pte_clear(pte);
	if (pte_val(*ptep) & _PAGE_HASHPTE)
		flush_hash_entry(mm, ptep, addr);
	asm v. { "stw ; eieio; stw" };

Cheers,
Ben.
