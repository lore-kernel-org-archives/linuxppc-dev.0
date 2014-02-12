Return-Path: <anton@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 381062C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 17:17:29 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anton@au1.ibm.com>;
 Wed, 12 Feb 2014 16:17:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B03FD2CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 17:17:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C5vt2q3408342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 16:57:55 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C6HM4O012535
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 17:17:23 +1100
Date: Wed, 12 Feb 2014 17:17:05 +1100
From: Anton Blanchard <anton@au1.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com
Subject: [PATCH 1/2] powerpc: Link VDSOs at 0x0
Message-ID: <20140212171705.71d2bd7c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


perf is failing to resolve symbols in the VDSO. A while (1)
gettimeofday() loop shows:

93.99%  [vdso]  [.] 0x00000000000005e0
 3.12%  test    [.] 00000037.plt_call.gettimeofday@@GLIBC_2.18
 2.81%  test    [.] main

The reason for this is that we are linking our VDSO shared libraries
at 1MB, which is a little weird. Even though this is uncommon, Alan
points out that it is valid and we should probably fix perf userspace.

Regardless, I can't see a reason why we are doing this. The code
is all position independent and we never rely on the VDSO ending
up at 1M (and we never place it there on 64bit tasks).

Changing our link address to 0x0 fixes perf VDSO symbol resolution:

73.18%  [vdso]  [.] 0x000000000000060c
12.39%  [vdso]  [.] __kernel_gettimeofday
 3.58%  test    [.] 00000037.plt_call.gettimeofday@@GLIBC_2.18
 2.94%  [vdso]  [.] __kernel_datapage_offset
 2.90%  test    [.] main

We still have some local symbol resolution issues that will be
fixed in a subsequent patch.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index 0d9cecd..c53f5f6 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -4,11 +4,11 @@
 #ifdef __KERNEL__
 
 /* Default link addresses for the vDSOs */
-#define VDSO32_LBASE	0x100000
-#define VDSO64_LBASE	0x100000
+#define VDSO32_LBASE	0x0
+#define VDSO64_LBASE	0x0
 
 /* Default map addresses for 32bit vDSO */
-#define VDSO32_MBASE	VDSO32_LBASE
+#define VDSO32_MBASE	0x100000
 
 #define VDSO_VERSION_STRING	LINUX_2.6.15
 
