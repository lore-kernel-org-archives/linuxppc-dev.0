Date: Wed, 27 Feb 2002 13:48:24 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202272148.g1RLmOr06455@xdr.com>
To: dan@embeddededge.com
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I can see the problem right in arch/ppc/mm/ppc_mmu.c, in the MMU_init_hw
function. The code goes:
	if ((cur_cpu_spec[0]->cpu_features & CPU_FTR_HPTE_TABLE) == 0)
		return;

But later on there is code to set hash_page[0] = 0x4e800020. Instead
of returning it should execute that else clause, and make hash_page return.

After making that change the problem appears fixed, at long last. It wasn't
buggy hardware at all, it *was* a bug in the linux kernel.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
