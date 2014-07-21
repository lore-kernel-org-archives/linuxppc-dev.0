Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 978A71A019A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 19:55:24 +1000 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 21 Jul 2014 10:55:20 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 60C7B219005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 10:55:02 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6L9tGRO34013348
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 09:55:17 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6L9tGU8014514
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 03:55:16 -0600
Message-ID: <1405936513.2618.15.camel@TP-T420>
Subject: [PATCH powerpc] use _GLOBAL_TOC for memmove
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 21 Jul 2014 17:55:13 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memmove may be called from module code copy_pages(btrfs), and it may
call memcpy, which may call back to C code, so it needs to use
_GLOBAL_TOC to set up r2 correctly. 

This fixes following error when I tried to boot an le guest:

Vector: 300 (Data Access) at [c000000073f97210]
    pc: c000000000015004: enable_kernel_altivec+0x24/0x80
    lr: c000000000058fbc: enter_vmx_copy+0x3c/0x60
    sp: c000000073f97490
   msr: 8000000002009033
   dar: d000000001d50170
 dsisr: 40000000
  current = 0xc0000000734c0000
  paca    = 0xc00000000fff0000	 softe: 0	 irq_happened: 0x01
    pid   = 815, comm = mktemp
enter ? for help
[c000000073f974f0] c000000000058fbc enter_vmx_copy+0x3c/0x60
[c000000073f97510] c000000000057d34 memcpy_power7+0x274/0x840
[c000000073f97610] d000000001c3179c copy_pages+0xfc/0x110 [btrfs]
[c000000073f97660] d000000001c3c248 memcpy_extent_buffer+0xe8/0x160 [btrfs]
[c000000073f97700] d000000001be4be8 setup_items_for_insert+0x208/0x4a0 [btrfs]
[c000000073f97820] d000000001be50b4 btrfs_insert_empty_items+0xf4/0x140 [btrfs]
[c000000073f97890] d000000001bfed30 insert_with_overflow+0x70/0x180 [btrfs]
[c000000073f97900] d000000001bff174 btrfs_insert_dir_item+0x114/0x2f0 [btrfs]
[c000000073f979a0] d000000001c1f92c btrfs_add_link+0x10c/0x370 [btrfs]
[c000000073f97a40] d000000001c20e94 btrfs_create+0x204/0x270 [btrfs]
[c000000073f97b00] c00000000026d438 vfs_create+0x178/0x210
[c000000073f97b50] c000000000270a70 do_last+0x9f0/0xe90
[c000000073f97c20] c000000000271010 path_openat+0x100/0x810
[c000000073f97ce0] c000000000272ea8 do_filp_open+0x58/0xd0
[c000000073f97dc0] c00000000025ade8 do_sys_open+0x1b8/0x300
[c000000073f97e30] c00000000000a008 syscall_exit+0x0/0x7c
--- Exception: c01 (System Call) at 00003fffaabe2854

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/lib/mem_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
index 0738f96..43435c6 100644
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -77,7 +77,7 @@ _GLOBAL(memset)
 	stb	r4,0(r6)
 	blr
 
-_GLOBAL(memmove)
+_GLOBAL_TOC(memmove)
 	cmplw	0,r3,r4
 	bgt	backwards_memcpy
 	b	memcpy
