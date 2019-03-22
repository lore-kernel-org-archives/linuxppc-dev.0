Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1494AC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF3F218FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF3F218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QjvH5f87zDqDp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 23:41:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qjpy0l1SzDqPG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 23:37:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44Qjpv5F64z9sVy; Fri, 22 Mar 2019 23:37:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44Qjpv4TZvz9sVX; Fri, 22 Mar 2019 23:37:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3] powerpc/64: Fix memcmp reading past the end of src/dest
Date: Fri, 22 Mar 2019 23:37:24 +1100
Message-Id: <20190322123724.28435-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: chandan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Chandan reported that fstests' generic/026 test hit a crash:

  BUG: Unable to handle kernel data access at 0xc00000062ac40000
  Faulting instruction address: 0xc000000000092240
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE SMP NR_CPUS=2048 DEBUG_PAGEALLOC NUMA pSeries
  CPU: 0 PID: 27828 Comm: chacl Not tainted 5.0.0-rc2-next-20190115-00001-g6de6dba64dda #1
  NIP:  c000000000092240 LR: c00000000066a55c CTR: 0000000000000000
  REGS: c00000062c0c3430 TRAP: 0300   Not tainted  (5.0.0-rc2-next-20190115-00001-g6de6dba64dda)
  MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000842  XER: 20000000
  CFAR: 00007fff7f3108ac DAR: c00000062ac40000 DSISR: 40000000 IRQMASK: 0
  GPR00: 0000000000000000 c00000062c0c36c0 c0000000017f4c00 c00000000121a660
  GPR04: c00000062ac3fff9 0000000000000004 0000000000000020 00000000275b19c4
  GPR08: 000000000000000c 46494c4500000000 5347495f41434c5f c0000000026073a0
  GPR12: 0000000000000000 c0000000027a0000 0000000000000000 0000000000000000
  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR20: c00000062ea70020 c00000062c0c38d0 0000000000000002 0000000000000002
  GPR24: c00000062ac3ffe8 00000000275b19c4 0000000000000001 c00000062ac30000
  GPR28: c00000062c0c38d0 c00000062ac30050 c00000062ac30058 0000000000000000
  NIP memcmp+0x120/0x690
  LR  xfs_attr3_leaf_lookup_int+0x53c/0x5b0
  Call Trace:
    xfs_attr3_leaf_lookup_int+0x78/0x5b0 (unreliable)
    xfs_da3_node_lookup_int+0x32c/0x5a0
    xfs_attr_node_addname+0x170/0x6b0
    xfs_attr_set+0x2ac/0x340
    __xfs_set_acl+0xf0/0x230
    xfs_set_acl+0xd0/0x160
    set_posix_acl+0xc0/0x130
    posix_acl_xattr_set+0x68/0x110
    __vfs_setxattr+0xa4/0x110
    __vfs_setxattr_noperm+0xac/0x240
    vfs_setxattr+0x128/0x130
    setxattr+0x248/0x600
    path_setxattr+0x108/0x120
    sys_setxattr+0x28/0x40
    system_call+0x5c/0x70
  Instruction dump:
  7d201c28 7d402428 7c295040 38630008 38840008 408201f0 4200ffe8 2c050000
  4182ff6c 20c50008 54c61838 7d201c28 <7d402428> 7d293436 7d4a3436 7c295040

The instruction dump decodes as:
  subfic  r6,r5,8
  rlwinm  r6,r6,3,0,28
  ldbrx   r9,0,r3
  ldbrx   r10,0,r4      <-

Which shows us doing an 8 byte load from c00000062ac3fff9, which
crosses the page boundary at c00000062ac40000 and faults.

It's not OK for memcmp to read past the end of the source or
destination buffers if that would cross a page boundary, because we
don't know that the next page is mapped.

As pointed out by Segher, we can read past the end of the source or
destination as long as we don't cross a 4K boundary, because that's
our minimum page size on all platforms.

The bug is in the code at the .Lcmp_rest_lt8bytes label. When we get
there we know that s1 is 8-byte aligned and we have at least 1 byte to
read, so a single 8-byte load won't read past the end of s1 and cross
a page boundary.

But we have to be more careful with s2. So check if it's within 8
bytes of a 4K boundary and if so go to the byte-by-byte loop.

Fixes: 2d9ee327adce ("powerpc/64: Align bytes before fall back to .Lshort in powerpc64 memcmp()")
Cc: stable@vger.kernel.org # v4.19+
Reported-by: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/memcmp_64.S | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

v3: Just check if we're crossing a 4K boundary.

Oops, I wrote this a while back but forgot to send v3.

diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index 844d8e774492..f6554ebebeb5 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -215,11 +215,20 @@ _GLOBAL_TOC(memcmp)
 	beq	.Lzero
 
 .Lcmp_rest_lt8bytes:
-	/* Here we have only less than 8 bytes to compare with. at least s1
-	 * Address is aligned with 8 bytes.
-	 * The next double words are load and shift right with appropriate
-	 * bits.
+	/*
+	 * Here we have less than 8 bytes to compare. At least s1 is aligned to
+	 * 8 bytes, but s2 may not be. We must make sure s2 + 8 doesn't cross a
+	 * page boundary, otherwise we might read past the end of the buffer and
+	 * trigger a page fault. We use 4K as the conservative minimum page
+	 * size. If we detect that case we go to the byte-by-byte loop.
+	 *
+	 * Otherwise the next double word is loaded from s1 and s2, and shifted
+	 * right to compare the appropriate bits.
 	 */
+	clrldi	r6,r4,(64-12)	// r6 = r4 & 0xfff
+	cmpdi	r6,0xff8
+	bgt	.Lshort
+
 	subfic  r6,r5,8
 	slwi	r6,r6,3
 	LD	rA,0,r3
-- 
2.20.1

