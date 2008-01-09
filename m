Return-Path: <jay_chen@alphanetworks.com>
Received: from smtpr6.alphanetworks.com (smtpr6.alphanetworks.com
	[210.202.42.130]) by ozlabs.org (Postfix) with ESMTP id DABF6DDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jan 2008 15:22:06 +1100 (EST)
From: "jay_chen" <jay_chen@alphanetworks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Use 2G RAM in 8548, vmalloc fail, adjust_total_lowmem
Date: Wed, 9 Jan 2008 12:06:40 +0800
MIME-Version: 1.0
Message-ID: <OF590B6FCB.576A8335-ON482573CB.00169CC3@alphanetworks.com>
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, all~~~

I am using a MCP8548 board with 2.6.14.5 kernel.
And I would like to upgrade memory from 512MB to 2048MB.
Finally, I realize this is not so easy as I think. I encounter several
problems. :~~

First, I change mem=512M to mem=2048M.

1. vmalloc fail problem
So, I change kernel config in "advanced setup"
Change  "Set maximum low memory" from 0x30000000 to 0x80000000.
Change "Virtual address of kernel base" from 0xC0000000 to 0x60000000.
Change "Set custom user task size" from 0x80000000 to 0x60000000

Someone said that he could change "Virtual address of kernel base" to
0xA0000000 without problem.
Could I change it to 0x60000000? Any possible problem?

2.
In MMU_init( ), init.c
#ifdef CONFIG_FSL_BOOKE
	/* Freescale Book-E parts expect lowmem to be mapped by fixed TLB
	 * entries, so we need to adjust lowmem to match the amount we can
map
	 * in the fixed entries */
	adjust_total_lowmem();
#endif /* CONFIG_FSL_BOOKE */

In adjust_total_lowmem(), fsl_booke_mmu.c 
It always limits the low memory to 768MB.  (no matter we set mem=768MB or
mem=1024MB, or mem=2048MB) 
__max_low_memory = max_low_mem = __cam0 + __cam1 + __cam2; (each TLB could
map up to 256MB)

My question is could I use more than 3 TLBs here? Such as 8 TLBs to map 2G
ram?
Or could I use e500v2 new feature, that is 1 TLB could map up to 4G? Any
reference code?

Any comment is welcom. Thanks a lot.

          Jay Chen...
