Return-Path: <xenidis@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E63F2C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2012 04:43:37 +1100 (EST)
Received: by mail-ob0-f179.google.com with SMTP id eq6so464843obc.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2012 09:43:34 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
Content-Type: text/plain; charset=us-ascii
Subject: Hijacking CPU_FTR_VSX for BGQ QPX
Date: Fri, 9 Nov 2012 11:43:29 -0600
Message-Id: <29970ED2-02E3-45F5-96FD-B4270385E3ED@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU_FTR_* values are pretty tight (a few bits left) yes I need to =
save and restore the QPX registers.
There are 32 QPX registers, each 32 bytes in size, it is otherwise =
managed by the FPSCR and MSR[FP]

I was thinking that I could hijack the VSX, since there is no plan to =
add it to embedded yet.
I could be explicit or create an alieas fo the same bit, but the basic =
effect (after increasing the save area size) would be something like the =
diff below.
Thoughts?
-jx


diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index de36955..adb08af 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -25,14 +25,24 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
=20
-#ifdef CONFIG_VSX
+#if defined (CONFIG_VSX) && defined(CONFIG_BGQ)
+# error "This code depends on CONFIG_VSX and CONFIG_BGQ being exclusive
+#elif defined (CONFIG_VSX)
+# define _REST_32VSRS(n,c,base) REST_32VSRS(n,c,base)
+# define _SAVE_32VSRS(n,c,base) SAVE_32VSRS(n,c,base)
+#elif defined(CONFIG_BGQ)
+# define _REST_32VSRS(n,c,base) REST_32QRS(n,c,base)
+# define _SAVE_32VSRS(n,c,base) SAVE_32QRS(n,c,base)
+#endif
+
+#if defined (CONFIG_VSX) || defined(CONFIG_BGQ)
 #define REST_32FPVSRS(n,c,base)						=
\
 BEGIN_FTR_SECTION							=
\
 	b	2f;							=
\
 END_FTR_SECTION_IFSET(CPU_FTR_VSX);					=
\
 	REST_32FPRS(n,base);						=
\
 	b	3f;							=
\
-2:	REST_32VSRS(n,c,base);						=
\
+2:	_REST_32VSRS(n,c,base);						=
\
 3:
=20
 #define SAVE_32FPVSRS(n,c,base)						=
\
@@ -41,7 +51,7 @@ BEGIN_FTR_SECTION						=
	\
 END_FTR_SECTION_IFSET(CPU_FTR_VSX);					=
\
 	SAVE_32FPRS(n,base);						=
\
 	b	3f;							=
\
-2:	SAVE_32VSRS(n,c,base);						=
\
+2:	_SAVE_32VSRS(n,c,base);						=
\
 3:
 #else
 #define REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
