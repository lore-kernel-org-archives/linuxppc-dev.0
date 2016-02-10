Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 00F9E1A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 18:17:11 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc32: PAGE_EXEC required for inittext
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160210071708.5D35D1A2446@localhost.localdomain>
Date: Wed, 10 Feb 2016 08:17:08 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAGE_EXEC is required for inittext, otherwise CONFIG_DEBUG_PAGEALLOC
ends up with an Oops

[    0.000000] Inode-cache hash table entries: 8192 (order: 1, 32768 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] bootmem::free_all_bootmem_core nid=0 start=0 end=2000
[    0.000000] Unable to handle kernel paging request for instruction fetch
[    0.000000] Faulting instruction address: 0xc045b970
[    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.000000] PREEMPT DEBUG_PAGEALLOC CMPC885
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.25-local-dirty #1673
[    0.000000] task: c04d83d0 ti: c04f8000 task.ti: c04f8000
[    0.000000] NIP: c045b970 LR: c045b970 CTR: 0000000a
[    0.000000] REGS: c04f9ea0 TRAP: 0400   Not tainted  (3.18.25-local-dirty)
[    0.000000] MSR: 08001032 <ME,IR,DR,RI>  CR: 39955d35  XER: a000ff40
[    0.000000]
GPR00: c045b970 c04f9f50 c04d83d0 00000000 ffffffff c04dcdf4 00000048 c04f6b10
GPR08: c04f6ab0 00000001 c0563488 c04f6ab0 c04f8000 00000000 00000000 b6db6db7
GPR16: 00003474 00000180 00002000 c7fec000 00000000 000003ff 00000176 c0415014
GPR24: c0471018 c0414ee8 c05304e8 c03aeaac c0510000 c0471018 c0471010 00000000
[    0.000000] NIP [c045b970] free_all_bootmem+0x164/0x228
[    0.000000] LR [c045b970] free_all_bootmem+0x164/0x228
[    0.000000] Call Trace:
[    0.000000] [c04f9f50] [c045b970] free_all_bootmem+0x164/0x228 (unreliable)
[    0.000000] [c04f9fa0] [c0454044] mem_init+0x3c/0xd0
[    0.000000] [c04f9fb0] [c045080c] start_kernel+0x1f4/0x390
[    0.000000] [c04f9ff0] [c0002214] start_here+0x38/0x98
[    0.000000] Instruction dump:
[    0.000000] 2f150000 7f968840 72a90001 3ad60001 56b5f87e 419a0028 419e0024 41a20018
[    0.000000] 807cc20c 38800000 7c638214 4bffd2f5 <3a940001> 3a100024 4bffffc8 7e368b78
[    0.000000] ---[ end trace dc8fa200cb88537f ]---

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
This patch goes on top of the following serie:
[PATCH v8 00/23] powerpc/8xx: Use large pages for RAM and IMMR and other improvments

 arch/powerpc/mm/pgtable_32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 815ccd7..ba2ee66 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -40,7 +40,7 @@
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
-extern char etext[], _stext[];
+extern char etext[], _stext[], _sinittext[], _einittext[];
 
 #define PGDIR_ORDER	(32 + PGD_T_LOG2 - PGDIR_SHIFT)
 
@@ -289,7 +289,8 @@ void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 	v = PAGE_OFFSET + s;
 	p = memstart_addr + s;
 	for (; s < top; s += PAGE_SIZE) {
-		ktext = ((char *) v >= _stext && (char *) v < etext);
+		ktext = ((char *)v >= _stext && (char *)v < etext) ||
+			((char *)v >= _sinittext && (char *)v < _einittext);
 		f = ktext ? pgprot_val(PAGE_KERNEL_TEXT) : pgprot_val(PAGE_KERNEL);
 		map_page(v, p, f);
 #ifdef CONFIG_PPC_STD_MMU_32
-- 
2.1.0
