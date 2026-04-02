Return-Path: <linuxppc-dev+bounces-19188-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576F2CC6B00
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 06:56:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmXhW0LPDz2ySk;
	Thu, 02 Apr 2026 17:56:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775113003;
	cv=none; b=lHTBmFC9uhAGBnpTXkmZFPBYcfslY0/QnuQzYLyrYCScpZdDa1GChn9NlbNvbGCKbWepUoJ5N8IO6Fj9enRtUxFCIISiXCHFe+DKH3Qv/6wcFH0wQvoWn4Rh2t6ssoxtxjnJ+ectlxfGRf99dfv0G8HZeg7wZu24dVaAxet8ljeZvoVDg/Gfve7sn10OOWAtl/XdQ1mu7OtboOIB/p9gCC/Uopdq76DHcchF5ETdza93rlZs4br68gYh2a0O3raKQ5T/Z/kL3cf0+bf7/vOvyDdSyLvV4MscyK7MI+7FrkbQAIXGBLnYAR/KxMTDuRBGe8LDtBiwOV5AGV10AX8YbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775113003; c=relaxed/relaxed;
	bh=FlpdYf1WLDHAMV/rn1y6xYHlGkLnTRJ4f+O5zsHNUww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hft0ImdGtBViEPKGf9Bw9npGl3hxu8/+6uHbgbRehjmGIUL+S+VhKN6b1lkdMAUmg2pFFtpzD8MgmksUxPszcvFvJ3KtdSGhKbfBWvclaX9+M9wWY6oXqxJKn1i0TM6NUkxzHvxRBk9wpXcxBUZ2NcdMizkD5l/ovZ/7SaqoaajSKF+tj7pTLQwBcv+Uw8m86VFOAERvjipMkFLuIm1oCI6fSozPZiNJ7bE6YD2hA6ruPx4xJmjmtrz4GJ/PYSjzp9Ppf7dVzxsck/lVOmDpRPmN/myR9iIYd8E+XlR2VuDbGIFVHY56KsltXVW+bq9u9qmOn4tHTcxfqy5UScGurw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UxMz6fL7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=liuhangbin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UxMz6fL7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=liuhangbin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmXhV0B4Wz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 17:56:41 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so4580455ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775112999; x=1775717799; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlpdYf1WLDHAMV/rn1y6xYHlGkLnTRJ4f+O5zsHNUww=;
        b=UxMz6fL7j3IwA1D5jgsLb3GdWwUovmivxVvdwdwBdHZYUc7SBY1Y6OB1x1MWdU9qrH
         cmoVGGklUDQ2CC6gkxVCLAI84+bgxrsVgb3A35IDpDDWlIzQE6484ZRpLhEm0iKf+tKr
         WB+6H/PdH7Q8RWZFexvn5Vjx8lAJdf4yNE1W4MCVln/vu+I/LyckZiIW6QK+eDQI0kuU
         w4VjHB5Q01JU5VO6eppdJ2vOB/pOPdCMmW1h/j7a/YV5qDSWYbiDjlKhuHqiXGbtbxD/
         hptwzdEoYH8UYHDn0J375bhXU0+sezi8aNgQ1VPVMno2+kZMJs/uDZVOENGfut7zVmm0
         Genw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775112999; x=1775717799;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlpdYf1WLDHAMV/rn1y6xYHlGkLnTRJ4f+O5zsHNUww=;
        b=Kgzg5ogQl8OJCfo1Pk2tzNV60sJnVVAm9NsiHtEtyDuhOjF6cLnyUebIGIH4DPoqlC
         gjnGnrmRw/Q4mkl5e1CPGMO5vsmwpZXSolJN16yhnEiGNr5OFPJWS2C166FMbXLf4rJf
         0aP7mxUA0wtPVGJNd74m0qoz8Kgf0a3CTFZaG3rGFJo8L2/OMqrgw0ZAO+seuQufSS36
         j+7cdAFviKYfBha+8wvIRgnRqGfDbXzTDY9sDQZZk27bYOFsn+6PrdjIJIJbRP5PbcOx
         NXeBMjzSTyneZWLL5sArY0sl//eUYczSxWnQ7FiTjsgvC6M+7casHKL0tZor0j9dcM2D
         7QIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7b56e6hQ/dtIlYmXLgTwKvB19AK8I+tsHFRqGHhoDj4SWCgkNbhq91t41cSTkFOILNUkOX3b1OL0fLM4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1dT5ATcsgQIQRsxA2sNx/reyhEir0UFDCuywXr4YdbfK/JbNx
	MrjbykhsaVSYjNCPqyadMiG3U3ySsRPjaXR439Ribm68AmU3+K9+G9ZZ
X-Gm-Gg: AeBDiesaccigFLyKv3u7l0DFuTaMhmaj6iqWKfHj/VwvUWW9Q9akwYij02G0N2B0JFn
	PYd4EBNwtvyAkMPB6M8pXKGGPp6MrrR+9bDRQZUIxQ2Dz0JXLKRQcjliwl0DjiSqWoMf7E4IRTr
	D0AMcSPQ9l8cALTpcoVirrZJ31H19YQLjywW0Pgafh7EOR7JAmGn/fCwUmpnjIb3pknmRf+MAq4
	EHvK886i3+ROXq/g9F5XKq52W+EykGq+Ni/c7g9ilwlN8H4KPib0YTFPK4EbAadhl8gkOwjKSAa
	3iLl13pWk70F8hvqOiSE4XRVahgGbj/fp1W8Ty9miBi2hKLH6ab+RclWEjqkGtKMTUNM8YlouWU
	kpNVzTbprnuxu+r3K22NU6ot/z2JUZU482+HamPWKiuvebVAN5aZ1+J2Uea2GK4bpMInzd64o3J
	3lOEubr2g+r1BxcYesUJfTbXmRxv/Y6+Rmgu8rRpIzcbWhmPbKKV/Fzq0TR9SKQ0Yc9b4=
X-Received: by 2002:a17:903:90b:b0:2b2:470d:6d18 with SMTP id d9443c01a7336-2b269adfea5mr73898055ad.8.1775112999356;
        Wed, 01 Apr 2026 23:56:39 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5765:500:7999:76d9:8e52:f837])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm19647945ad.55.2026.04.01.23.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:56:38 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Thu, 02 Apr 2026 14:56:01 +0800
Subject: [PATCH] cmpxchg: allow const-qualified old value in cmpxchg()
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwMj3eTcgorkjHRdo7QUYwPzNBOTRBNDJaDqgqLUtMwKsEnRsbW1AGI
 cTBRZAAAA
X-Change-ID: 20260402-cmpxchg-2fd307f44a41
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3

The old value passed to cmpxchg() is semantically read-only: it is
only loaded into a register as a comparand and is never written back.
However, the macro currently assigns it implicitly to a local variable
of type __typeof__(*(ptr)), which triggers -Werror=discarded-qualifiers
when old is a const-qualified pointer and ptr points to a non-const type.

To avoid this, let's add an explicit cast to __typeof__(*(ptr)) for the
old local variable in the cmpxchg macros. This explicit cast suppresses
the -Wdiscarded-qualifiers diagnostic.

The new value is intentionally left without a cast: new will be stored
into *ptr, so silently accepting a const-qualified new would allow
callers to store a pointer-to-const into a non-const location without
any compiler warning.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
This is my first time posting a patch with multi-architecture specific
changes, so I'm not sure which target repository I should use. Please
correct me if I made any mistakes.
---
 arch/alpha/include/asm/cmpxchg.h     | 4 ++--
 arch/arc/include/asm/cmpxchg.h       | 4 ++--
 arch/hexagon/include/asm/cmpxchg.h   | 2 +-
 arch/parisc/include/asm/cmpxchg.h    | 2 +-
 arch/powerpc/include/asm/cmpxchg.h   | 8 ++++----
 arch/riscv/include/asm/cmpxchg.h     | 4 ++--
 arch/sh/include/asm/cmpxchg.h        | 2 +-
 arch/sparc/include/asm/cmpxchg_32.h  | 2 +-
 arch/sparc/include/asm/cmpxchg_64.h  | 2 +-
 arch/x86/include/asm/cmpxchg.h       | 2 +-
 arch/xtensa/include/asm/cmpxchg.h    | 2 +-
 tools/arch/x86/include/asm/cmpxchg.h | 2 +-
 12 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index ae1b96479d0c..b4b8dac759c4 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -234,7 +234,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_local(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
 					  (unsigned long)_n_,		\
@@ -265,7 +265,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 #define arch_cmpxchg(ptr, o, n)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	smp_mb();							\
 	__ret = (__typeof__(*(ptr))) ____cmpxchg((ptr),			\
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890f..9637e2cdb5b1 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -42,7 +42,7 @@
 #define arch_cmpxchg_relaxed(ptr, old, new)				\
 ({									\
 	__typeof__(ptr) _p_ = (ptr);					\
-	__typeof__(*(ptr)) _o_ = (old);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(old);			\
 	__typeof__(*(ptr)) _n_ = (new);					\
 	__typeof__(*(ptr)) _prev_;					\
 									\
@@ -64,7 +64,7 @@
 #define arch_cmpxchg(ptr, old, new)				        \
 ({									\
 	volatile __typeof__(ptr) _p_ = (ptr);				\
-	__typeof__(*(ptr)) _o_ = (old);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(old);			\
 	__typeof__(*(ptr)) _n_ = (new);					\
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 9c58fb81f7fd..7e117964cb6b 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -54,7 +54,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 #define arch_cmpxchg(ptr, old, new)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
-	__typeof__(*(ptr)) __old = (old);			\
+	__typeof__(*(ptr)) __old = (__typeof__(*(ptr)))(old);	\
 	__typeof__(*(ptr)) __new = (new);			\
 	__typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;	\
 								\
diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index bf0a0f1189eb..2a87942227f8 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -78,7 +78,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 
 #define arch_cmpxchg(ptr, o, n)						 \
 ({									 \
-	__typeof__(*(ptr)) _o_ = (o);					 \
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		 \
 	__typeof__(*(ptr)) _n_ = (n);					 \
 	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index dbb50c06f0bf..36d113b13623 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -698,7 +698,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 }
 #define arch_cmpxchg(ptr, o, n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);			 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
@@ -707,7 +707,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_local(ptr, o, n)					 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);			 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_,	 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
@@ -715,7 +715,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
 			(unsigned long)_o_, (unsigned long)_n_,		\
@@ -724,7 +724,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
 			(unsigned long)_o_, (unsigned long)_n_,		\
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 8712cf9c69dc..3026a9ff43c4 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -215,7 +215,7 @@
 		      cas_prepend, cas_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(__ptr)) __old = (old);				\
+	__typeof__(*(__ptr)) __old = (__typeof__(*(__ptr)))(old);	\
 	__typeof__(*(__ptr)) __new = (new);				\
 	__typeof__(*(__ptr)) __ret;					\
 									\
@@ -331,7 +331,7 @@ union __u128_halves {
 
 #define __arch_cmpxchg128(p, o, n, cas_sfx)					\
 ({										\
-	__typeof__(*(p)) __o = (o);                                             \
+	__typeof__(*(p)) __o = (__typeof__(*(p)))(o);                           \
 	union __u128_halves __hn = { .full = (n) };				\
 	union __u128_halves __ho = { .full = (__o) };				\
 	register unsigned long t1 asm ("t1") = __hn.low;			\
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 1e5dc5ccf7bf..7fb9214d246f 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -68,7 +68,7 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 
 #define arch_cmpxchg(ptr,o,n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);			 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 8c1a3ca34eeb..f733bd5b5d3b 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -55,7 +55,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 
 #define arch_cmpxchg(ptr, o, n)						\
 ({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	\
 			(unsigned long)_n_, sizeof(*(ptr)));		\
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 3de25262c411..4a9ccf80487a 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -170,7 +170,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 
 #define arch_cmpxchg(ptr,o,n)						 \
   ({									 \
-     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);			 \
      __typeof__(*(ptr)) _n_ = (n);					 \
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
 				    (unsigned long)_n_, sizeof(*(ptr))); \
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a88b06f1c35e..a7984842c58a 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -85,7 +85,7 @@ extern void __add_wrong_size(void)
 #define __raw_cmpxchg(ptr, old, new, size, lock)			\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __old = (__typeof__(*(ptr)))(old);		\
 	__typeof__(*(ptr)) __new = (new);				\
 	switch (size) {							\
 	case __X86_CASE_B:						\
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index b6db4838b175..0f68eddb6d2d 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -83,7 +83,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 }
 
 #define arch_cmpxchg(ptr,o,n)						      \
-	({ __typeof__(*(ptr)) _o_ = (o);				      \
+	({ __typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		      \
 	   __typeof__(*(ptr)) _n_ = (n);				      \
 	   (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	      \
 	   			        (unsigned long)_n_, sizeof (*(ptr))); \
diff --git a/tools/arch/x86/include/asm/cmpxchg.h b/tools/arch/x86/include/asm/cmpxchg.h
index 0ed9ca2766ad..b71938db9422 100644
--- a/tools/arch/x86/include/asm/cmpxchg.h
+++ b/tools/arch/x86/include/asm/cmpxchg.h
@@ -35,7 +35,7 @@ extern void __cmpxchg_wrong_size(void)
 #define __raw_cmpxchg(ptr, old, new, size, lock)			\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) __old = (old);				\
+	__typeof__(*(ptr)) __old = (__typeof__(*(ptr)))(old);		\
 	__typeof__(*(ptr)) __new = (new);				\
 	switch (size) {							\
 	case __X86_CASE_B:						\

---
base-commit: 48b3cd69265f346f64b93064723492da46206e9b
change-id: 20260402-cmpxchg-2fd307f44a41

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


