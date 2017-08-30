Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com
 [IPv6:2607:f8b0:400e:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjdj86khTzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 20:22:20 +1000 (AEST)
Received: by mail-pg0-x235.google.com with SMTP id b8so725206pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 03:22:20 -0700 (PDT)
Date: Thu, 31 Aug 2017 01:41:47 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Build failures in powerpc ptrace selftests
Message-ID: <20170830174147.GA7040@simonLocalRHEL7.x64>
References: <20170830130525.xwj3oy2cx2qdwvqc@ubuntu-xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170830130525.xwj3oy2cx2qdwvqc@ubuntu-xps13>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Seth,
On Wed, Aug 30, 2017 at 08:05:25AM -0500, Seth Forshee wrote:
> With gcc 7 from Ubuntu 17.10 I'm getting the follwing error building the
> ptrace selftests for powerpc:
> 
>   ptrace-tm-vsx.c: In function ‘tm_vsx’:
>   ptrace-tm-vsx.c:42:2: error: PIC register clobbered by ‘r2’ in ‘asm’
>     asm __volatile__(
>     ^~~
>   make[1]: *** [ptrace-tm-vsx] Error 1
>   ptrace-tm-spd-vsx.c: In function ‘tm_spd_vsx’:
>   ptrace-tm-spd-vsx.c:55:2: error: PIC register clobbered by ‘r2’ in ‘asm’
>     asm __volatile__(
>     ^~~
>   make[1]: *** [ptrace-tm-spd-vsx] Error 1
>   ptrace-tm-spr.c: In function ‘tm_spr’:
>   ptrace-tm-spr.c:46:2: error: PIC register clobbered by ‘r2’ in ‘asm’
>     asm __volatile__(
>     ^~~
> 
> Best I can tell gcc now considers any inline asm which clobbers r2 an
> error, and I get it even with -fno-pic. I'm not familiar with powerpc
> asm, but it's not obvious to me why r2 is in the clobber list for any of
> these.
Thanks for reporting this issue.

In PPC ABI, r2 is used as TOC pointer and it might be changed by inter-module 
function calls. I believe that is the reason why it was put into clobber list 
originally.

In our case, dual entry is used to save TOC pointer (r2) update for function
calls within one module. There is no r2 change and I think r2 can be moved out 
of clobber list.

I don't have a GCC-7 environment. If possible, could you help to try following 
patch?

Thanks.
- Simon



diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index fe6bc60..c836f6d 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -6,7 +6,7 @@ include ../../lib.mk
 
 all: $(TEST_PROGS)
 
-CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm
+CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pic
 
 $(TEST_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
 
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
index 0df3c23..277dade 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
@@ -79,8 +79,8 @@ void tm_spd_vsx(void)
 		: [res] "=r" (result), [texasr] "=r" (texasr)
 		: [fp_load] "r" (fp_load), [fp_load_ckpt] "r" (fp_load_ckpt),
 		[sprn_texasr] "i"  (SPRN_TEXASR)
-		: "memory", "r0", "r1", "r2", "r3", "r4",
-		"r8", "r9", "r10", "r11"
+		: "memory", "r0", "r1", "r3", "r4",
+		"r7", "r8", "r9", "r10", "r11"
 		);
 
 	if (result) {
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
index 94e57cb..51427a2 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
@@ -76,8 +76,7 @@ void tm_spr(void)
 		: [tfhar] "=r" (tfhar), [res] "=r" (result),
 		[texasr] "=r" (texasr), [cptr1] "=r" (cptr1)
 		: [sprn_texasr] "i"  (SPRN_TEXASR)
-		: "memory", "r0", "r1", "r2", "r3", "r4",
-		"r8", "r9", "r10", "r11", "r31"
+		: "memory", "r0", "r8", "r31"
 		);
 
 	/* There are 2 32bit instructions before tbegin. */
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
index b4081e2..17c23ca 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
@@ -67,7 +67,7 @@ void tm_vsx(void)
 		: [res] "=r" (result), [texasr] "=r" (texasr)
 		: [fp_load] "r" (fp_load), [fp_load_ckpt] "r" (fp_load_ckpt),
 		[sprn_texasr] "i"  (SPRN_TEXASR), [cptr1] "r" (&cptr[1])
-		: "memory", "r0", "r1", "r2", "r3", "r4",
+		: "memory", "r0", "r1", "r3", "r4",
 		"r7", "r8", "r9", "r10", "r11"
 		);
 
