Message-ID: <3C7D583D.80104@bluewin.ch>
Date: Wed, 27 Feb 2002 23:05:49 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: David Ashley <dash@xdr.com>
Cc: dan@embeddededge.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
References: <200202272148.g1RLmOr06455@xdr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Ashley wrote:

>I can see the problem right in arch/ppc/mm/ppc_mmu.c, in the MMU_init_hw
>function. The code goes:
>	if ((cur_cpu_spec[0]->cpu_features & CPU_FTR_HPTE_TABLE) == 0)
>		return;
>
>But later on there is code to set hash_page[0] = 0x4e800020. Instead
>of returning it should execute that else clause, and make hash_page return.
>
>After making that change the problem appears fixed, at long last. It wasn't
>buggy hardware at all, it *was* a bug in the linux kernel.
>
Hmm, it seems to be ok in the linux_2_4_devel tree:
http://ppc.bkbits.net:8080/linuxppc_2_4_devel/anno/arch/ppc/mm/ppc_mmu.c@1.4?nav=index.html|src/.|src/arch|src/arch/ppc|src/arch/ppc/mm

Does this mean that the linux_2_4 tree is less up-to-date?

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
