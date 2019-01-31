Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07EDC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:38:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F582218AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F582218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qxYB2DhCzDqJm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:38:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qxMf1QwHzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:30:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qxMd4PMzz9sBn;
 Thu, 31 Jan 2019 21:30:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chandan Rajendra <chandan@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: BUG: memcmp(): Accessing invalid memory location
In-Reply-To: <17042269.pB4heZKTbK@localhost.localdomain>
References: <17042269.pB4heZKTbK@localhost.localdomain>
Date: Thu, 31 Jan 2019 21:30:37 +1100
Message-ID: <87tvhpnmpe.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Anton Blanchard <anton@au1.ibm.com>, Simon Guo <wei.guo.simon@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adding Simon who wrote the code.

Chandan Rajendra <chandan@linux.ibm.com> writes:
> When executing fstests' generic/026 test, I hit the following call trace,
>
> [  417.061038] BUG: Unable to handle kernel data access at 0xc00000062ac40000
> [  417.062172] Faulting instruction address: 0xc000000000092240
> [  417.062242] Oops: Kernel access of bad area, sig: 11 [#1]
> [  417.062299] LE SMP NR_CPUS=2048 DEBUG_PAGEALLOC NUMA pSeries
> [  417.062366] Modules linked in:
> [  417.062401] CPU: 0 PID: 27828 Comm: chacl Not tainted 5.0.0-rc2-next-20190115-00001-g6de6dba64dda #1
> [  417.062495] NIP:  c000000000092240 LR: c00000000066a55c CTR: 0000000000000000
> [  417.062567] REGS: c00000062c0c3430 TRAP: 0300   Not tainted  (5.0.0-rc2-next-20190115-00001-g6de6dba64dda)
> [  417.062660] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000842  XER: 20000000
> [  417.062750] CFAR: 00007fff7f3108ac DAR: c00000062ac40000 DSISR: 40000000 IRQMASK: 0
>                GPR00: 0000000000000000 c00000062c0c36c0 c0000000017f4c00 c00000000121a660
>                GPR04: c00000062ac3fff9 0000000000000004 0000000000000020 00000000275b19c4
>                GPR08: 000000000000000c 46494c4500000000 5347495f41434c5f c0000000026073a0
>                GPR12: 0000000000000000 c0000000027a0000 0000000000000000 0000000000000000
>                GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                GPR20: c00000062ea70020 c00000062c0c38d0 0000000000000002 0000000000000002
>                GPR24: c00000062ac3ffe8 00000000275b19c4 0000000000000001 c00000062ac30000
>                GPR28: c00000062c0c38d0 c00000062ac30050 c00000062ac30058 0000000000000000
> [  417.063563] NIP [c000000000092240] memcmp+0x120/0x690
> [  417.063635] LR [c00000000066a55c] xfs_attr3_leaf_lookup_int+0x53c/0x5b0
> [  417.063709] Call Trace:
> [  417.063744] [c00000062c0c36c0] [c00000000066a098] xfs_attr3_leaf_lookup_int+0x78/0x5b0 (unreliable)
> [  417.063851] [c00000062c0c3760] [c000000000693f8c] xfs_da3_node_lookup_int+0x32c/0x5a0
> [  417.063944] [c00000062c0c3820] [c0000000006634a0] xfs_attr_node_addname+0x170/0x6b0
> [  417.064034] [c00000062c0c38b0] [c000000000664ffc] xfs_attr_set+0x2ac/0x340
> [  417.064118] [c00000062c0c39a0] [c000000000758d40] __xfs_set_acl+0xf0/0x230
> [  417.064190] [c00000062c0c3a00] [c000000000758f50] xfs_set_acl+0xd0/0x160
> [  417.064268] [c00000062c0c3aa0] [c0000000004b69b0] set_posix_acl+0xc0/0x130
> [  417.064339] [c00000062c0c3ae0] [c0000000004b6a88] posix_acl_xattr_set+0x68/0x110
> [  417.064412] [c00000062c0c3b20] [c0000000004532d4] __vfs_setxattr+0xa4/0x110
> [  417.064485] [c00000062c0c3b80] [c000000000454c2c] __vfs_setxattr_noperm+0xac/0x240
> [  417.064566] [c00000062c0c3bd0] [c000000000454ee8] vfs_setxattr+0x128/0x130
> [  417.064638] [c00000062c0c3c30] [c000000000455138] setxattr+0x248/0x600
> [  417.064710] [c00000062c0c3d90] [c000000000455738] path_setxattr+0x108/0x120
> [  417.064785] [c00000062c0c3e00] [c000000000455778] sys_setxattr+0x28/0x40
> [  417.064858] [c00000062c0c3e20] [c00000000000bae4] system_call+0x5c/0x70
> [  417.064930] Instruction dump:
> [  417.064964] 7d201c28 7d402428 7c295040 38630008 38840008 408201f0 4200ffe8 2c050000
> [  417.065051] 4182ff6c 20c50008 54c61838 7d201c28 <7d402428> 7d293436 7d4a3436 7c295040
> [  417.065150] ---[ end trace 0d060411b5e3741b ]---
>
>
> Both the memory locations passed to memcmp() had "SGI_ACL_FILE" and len
> argument of memcmp() was set to 12. s1 argument of memcmp() had the value
> 0x00000000f4af0485, while s2 argument had the value 0x00000000ce9e316f.
>
> The following is the code path within memcmp() that gets executed for the
> above mentioned values,
>
> - Since len (i.e. 12) is greater than 7, we branch to .Lno_short.
> - We then prefetch the contents of r3 & r4 and branch to
>   .Ldiffoffset_8bytes_make_align_start.
> - Under .Ldiffoffset_novmx_cmp, Since r3 is unaligned we end up comparing
>   "SGI" part of the string. r3's value is then aligned. r4's value is
>   incremented by 3. For comparing the remaining 9 bytes, we jump to
>   .Lcmp_lt32bytes.
> - Here, 8 bytes of the remaining 9 bytes are compared and execution moves to
>   .Lcmp_rest_lt8bytes.
> - Here we execute "LD rB,0,r4". In the case of this bug, r4 has an unaligned
>   value and hence ends up accessing the "next" double word. The "next" double
>   word happens to occur after the last page mapped into the kernel's address
>   space and hence this leads to the previously listed oops.

Thanks for the analysis.

This is just a bug, we can't read past the end of the source or dest.

We have a selftest for memcmp, but clearly it doesn't exercise this
case. Here's a patch to try and trip it:

diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp.c b/tools/testing/selftests/powerpc/stringloops/memcmp.c
index b1fa7546957f..edca3abb6ecf 100644
--- a/tools/testing/selftests/powerpc/stringloops/memcmp.c
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp.c
@@ -2,6 +2,7 @@
 #include <malloc.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/mman.h>
 #include <time.h>
 #include "utils.h"
 
@@ -68,25 +69,24 @@ static void test_one(char *s1, char *s2, unsigned long max_offset,
 
 static int testcase(bool islarge)
 {
-	char *s1;
-	char *s2;
-	unsigned long i;
-
-	unsigned long comp_size = (islarge ? LARGE_SIZE : SIZE);
-	unsigned long alloc_size = comp_size + MAX_OFFSET_DIFF_S1_S2;
-	int iterations = islarge ? LARGE_ITERATIONS : ITERATIONS;
-
-	s1 = memalign(128, alloc_size);
-	if (!s1) {
-		perror("memalign");
-		exit(1);
-	}
+	unsigned long i, comp_size, alloc_size, map_chunk;
+	char *p, *s1, *s2;
+	int iterations;
 
-	s2 = memalign(128, alloc_size);
-	if (!s2) {
-		perror("memalign");
-		exit(1);
-	}
+	comp_size = (islarge ? LARGE_SIZE : SIZE);
+	alloc_size = comp_size + MAX_OFFSET_DIFF_S1_S2;
+	iterations = islarge ? LARGE_ITERATIONS : ITERATIONS;
+
+	map_chunk = 64 * 1024;
+	p = mmap(NULL, 4 * map_chunk, PROT_READ | PROT_WRITE,
+		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_IF(p == MAP_FAILED);
+
+	s1 = p + map_chunk - alloc_size;
+	s2 = p + 3 * map_chunk - alloc_size;
+
+	munmap(p + map_chunk, map_chunk);
+	munmap(p + 3 * map_chunk, map_chunk);
 
 	srandom(time(0));
 

cheers
