Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2CC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 20:20:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB9D208E3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 20:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxWIejOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB9D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bHRN5KBZzDqt0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 07:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CxWIejOy"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bCP65NNlzDq9y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 04:17:45 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id b11so12033170wmj.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 09:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=AhFvNX4xxQBV9phwFRS55uStvo6Gsc8VKVPzqrFZq8Y=;
 b=CxWIejOyCmBLPclqe+J1rsdj8VBBVeOeuhlyFGsLaASrHmLWEn2bW4dOPzuUgFnnpc
 Fe+RcU/dL69yy3re1dpKDZ3CZwAddg3h4Sds6uRVhxlSGHxFyuKN8i8v2vpkalxa9jbG
 K01NIKrgobk2ZQJp7UwwIIRNl02Igrmif82T4BOO5GtHacmrXk4RuVoPW0T9f94ghZlK
 KLucA0qQDqfgQoUqRGYlRpQ3vLLaciCBGQ1g/B5XIN+fVN/LTt9H+G5jkBkv725q/XpT
 lIgjRhMIR6g+T7Uw0WPS00Uyn/muWFIr+pErjlzWk8RhR1pedZ8W0DHRD6WNTDMMWlSa
 UmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=AhFvNX4xxQBV9phwFRS55uStvo6Gsc8VKVPzqrFZq8Y=;
 b=LLlPafz517RENsK3ly5/iOPXZo6kGio1c8tDvG6DUbwm4kFvvlHKOFOWuEiDJVgqbw
 popf3u3vmLXXTBsJ3UIxjSNU77ODV6knlKKwEDs11HryQ/lcxo6FcyLLy4jW7yM7Ouzg
 l19XoLb5tOA/s1g93cvQKquZgGaDjmIhWyRiChJB/a60tSaxudQwX90ACcXUsEXmpNyZ
 3TNgX9S558rtZ6VF5ffa41VJMFiFCMMKJmqyLmg0/R+e+rwxdESSigxt/rIUHEe8RpJo
 Pnic0PLsq45KA+aQy+bMngawGUMEXrC6PRF1u61nCDjBqpxavkVPRsf3xsOOISP2WKEZ
 qmwg==
X-Gm-Message-State: AJcUuker9BDg8Dww1ZIMrzQuWKdr8eUvwvcKKVoAiNu4XoG5plVWO8eh
 t07UnDb7SbGHxG8yJMXxvuk=
X-Google-Smtp-Source: ALg8bN43Mgq1wYJJrowCVcNjyKdZCK0opINEzmrG+XtuJ1bXEWXR4PjW5kT14A+wdiLFsgQXUuHzvA==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr10298807wma.90.1547140661244; 
 Thu, 10 Jan 2019 09:17:41 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id e27sm66285871wra.67.2019.01.10.09.17.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 09:17:40 -0800 (PST)
Date: Thu, 10 Jan 2019 10:17:38 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Subject: Patch series for 4.19 to compile powerpc with Clang
Message-ID: <20190110171738.GA15747@flashbox>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Mailman-Approved-At: Fri, 11 Jan 2019 07:18:25 +1100
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Attached is an mbox with a series of patches to allow building the
powerpc kernel with Clang. We have been running continuous integration
that builds and boots the kernel in QEMU for almost two months now with
no regressions. This is on top of 4.19.14, there should be no conflicts
but let me know if I messed something up.

I will send a series for 4.14 in a little bit as well.

Thank you,
Nathan

--bp/iNruPH9dso1Pn
Content-Type: application/mbox
Content-Disposition: attachment; filename="powerpc-clang-series.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom 0f27f12a9f12b3bf8f967d2f2e26d2294cce64d6 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nicholas Piggin <npiggin@gmail.com>=0ADate: Fri, 14 Sep 2018 15:08:=
52 +1000=0ASubject: [PATCH 1/9] powerpc: remove old GCC version checks=0A=
=0Acommit f2910f0e6835339e6ce82cef22fa15718b7e3bfa upstream.=0A=0AGCC 4.6 i=
s the minimum supported now.=0A=0ASigned-off-by: Nicholas Piggin <npiggin@g=
mail.com>=0AReviewed-by: Joel Stanley <joel@jms.id.au>=0ASigned-off-by: Mic=
hael Ellerman <mpe@ellerman.id.au>=0A[nc: Applied to minimize unnecessary c=
onflicts]=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A-=
--=0A arch/powerpc/Makefile | 31 ++-----------------------------=0A 1 file =
changed, 2 insertions(+), 29 deletions(-)=0A=0Adiff --git a/arch/powerpc/Ma=
kefile b/arch/powerpc/Makefile=0Aindex d2824b0cc142..b2f6e078a357 100644=0A=
--- a/arch/powerpc/Makefile=0A+++ b/arch/powerpc/Makefile=0A@@ -408,36 +408=
,9 @@ archprepare: checkbin=0A # to stdout and these checks are run even on=
 install targets.=0A TOUT	:=3D .tmp_gas_check=0A =0A-# Check gcc and binuti=
ls versions:=0A-# - gcc-3.4 and binutils-2.14 are a fatal combination=0A-# =
- Require gcc 4.0 or above on 64-bit=0A-# - gcc-4.2.0 has issues compiling =
modules on 64-bit=0A+# Check toolchain versions:=0A+# - gcc-4.6 is the mini=
mum kernel-wide version so nothing required.=0A checkbin:=0A-	@if test "$(c=
c-name)" !=3D "clang" \=0A-	    && test "$(cc-version)" =3D "0304" ; then \=
=0A-		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>=
&1 ; then \=0A-			echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer b=
uild '; \=0A-			echo 'correctly with gcc-3.4 and your version of binutils.'=
; \=0A-			echo '*** Please upgrade your binutils or downgrade your gcc'; \=
=0A-			false; \=0A-		fi ; \=0A-	fi=0A-	@if test "$(cc-name)" !=3D "clang" \=
=0A-	    && test "$(cc-version)" -lt "0400" \=0A-	    && test "x${CONFIG_PP=
C64}" =3D "xy" ; then \=0A-                echo -n "Sorry, GCC v4.0 or abov=
e is required to build " ; \=0A-                echo "the 64-bit powerpc ke=
rnel." ; \=0A-                false ; \=0A-        fi=0A-	@if test "$(cc-na=
me)" !=3D "clang" \=0A-	    && test "$(cc-fullversion)" =3D "040200" \=0A-	=
    && test "x${CONFIG_MODULES}${CONFIG_PPC64}" =3D "xyy" ; then \=0A-		ech=
o -n '*** GCC-4.2.0 cannot compile the 64-bit powerpc ' ; \=0A-		echo 'kern=
el with modules enabled.' ; \=0A-		echo -n '*** Please use a different GCC =
version or ' ; \=0A-		echo 'disable kernel modules' ; \=0A-		false ; \=0A-	=
fi=0A 	@if test "x${CONFIG_CPU_LITTLE_ENDIAN}" =3D "xy" \=0A 	    && $(LD) =
--version | head -1 | grep ' 2\.24$$' >/dev/null ; then \=0A 		echo -n '***=
 binutils 2.24 miscompiles weak symbols ' ; \=0A-- =0A2.20.1=0A=0A=0AFrom a=
6f434a2dda0dc553fc614a4006e028b054c4663 Mon Sep 17 00:00:00 2001=0AFrom: Ni=
cholas Piggin <npiggin@gmail.com>=0ADate: Fri, 14 Sep 2018 15:08:53 +1000=
=0ASubject: [PATCH 2/9] powerpc: consolidate -mno-sched-epilog into FTRACE =
flags=0A=0Acommit 2a056f58fd33ccc6a0261b552b0f17e7fa4a12f3 upstream.=0A=0AS=
igned-off-by: Nicholas Piggin <npiggin@gmail.com>=0AReviewed-by: Joel Stanl=
ey <joel@jms.id.au>=0ASigned-off-by: Michael Ellerman <mpe@ellerman.id.au>=
=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A arc=
h/powerpc/Makefile                    | 12 ++++++------=0A arch/powerpc/ker=
nel/Makefile             |  8 ++++----=0A arch/powerpc/kernel/trace/Makefil=
e       |  2 +-=0A arch/powerpc/platforms/powermac/Makefile |  2 +-=0A arch=
/powerpc/xmon/Makefile               |  2 +-=0A 5 files changed, 13 inserti=
ons(+), 13 deletions(-)=0A=0Adiff --git a/arch/powerpc/Makefile b/arch/powe=
rpc/Makefile=0Aindex b2f6e078a357..5fcec0e09668 100644=0A--- a/arch/powerpc=
/Makefile=0A+++ b/arch/powerpc/Makefile=0A@@ -160,8 +160,13 @@ else=0A CFLA=
GS-$(CONFIG_GENERIC_CPU) +=3D -mcpu=3Dpowerpc64=0A endif=0A =0A+ifdef CONFI=
G_FUNCTION_TRACER=0A+CC_FLAGS_FTRACE :=3D -pg=0A ifdef CONFIG_MPROFILE_KERN=
EL=0A-	CC_FLAGS_FTRACE :=3D -pg -mprofile-kernel=0A+CC_FLAGS_FTRACE +=3D -m=
profile-kernel=0A+endif=0A+# Work around a gcc code-gen bug with -fno-omit-=
frame-pointer.=0A+CC_FLAGS_FTRACE	+=3D -mno-sched-epilog=0A endif=0A =0A CF=
LAGS-$(CONFIG_TARGET_CPU_BOOL) +=3D $(call cc-option,-mcpu=3D$(CONFIG_TARGE=
T_CPU))=0A@@ -229,11 +234,6 @@ ifdef CONFIG_6xx=0A KBUILD_CFLAGS		+=3D -mcp=
u=3Dpowerpc=0A endif=0A =0A-# Work around a gcc code-gen bug with -fno-omit=
-frame-pointer.=0A-ifdef CONFIG_FUNCTION_TRACER=0A-KBUILD_CFLAGS		+=3D -mno=
-sched-epilog=0A-endif=0A-=0A cpu-as-$(CONFIG_4xx)		+=3D -Wa,-m405=0A cpu-a=
s-$(CONFIG_ALTIVEC)	+=3D $(call as-option,-Wa$(comma)-maltivec)=0A cpu-as-$=
(CONFIG_E200)		+=3D -Wa,-me200=0Adiff --git a/arch/powerpc/kernel/Makefile =
b/arch/powerpc/kernel/Makefile=0Aindex 3b66f2c19c84..1e64cfe22a83 100644=0A=
--- a/arch/powerpc/kernel/Makefile=0A+++ b/arch/powerpc/kernel/Makefile=0A@=
@ -22,10 +22,10 @@ CFLAGS_prom.o +=3D $(DISABLE_LATENT_ENTROPY_PLUGIN)=0A =
=0A ifdef CONFIG_FUNCTION_TRACER=0A # Do not trace early boot code=0A-CFLAG=
S_REMOVE_cputable.o =3D -mno-sched-epilog $(CC_FLAGS_FTRACE)=0A-CFLAGS_REMO=
VE_prom_init.o =3D -mno-sched-epilog $(CC_FLAGS_FTRACE)=0A-CFLAGS_REMOVE_bt=
ext.o =3D -mno-sched-epilog $(CC_FLAGS_FTRACE)=0A-CFLAGS_REMOVE_prom.o =3D =
-mno-sched-epilog $(CC_FLAGS_FTRACE)=0A+CFLAGS_REMOVE_cputable.o =3D $(CC_F=
LAGS_FTRACE)=0A+CFLAGS_REMOVE_prom_init.o =3D $(CC_FLAGS_FTRACE)=0A+CFLAGS_=
REMOVE_btext.o =3D $(CC_FLAGS_FTRACE)=0A+CFLAGS_REMOVE_prom.o =3D $(CC_FLAG=
S_FTRACE)=0A endif=0A =0A obj-y				:=3D cputable.o ptrace.o syscalls.o \=0A=
diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace=
/Makefile=0Aindex d22d8bafb643..d868ba42032f 100644=0A--- a/arch/powerpc/ke=
rnel/trace/Makefile=0A+++ b/arch/powerpc/kernel/trace/Makefile=0A@@ -7,7 +7=
,7 @@ subdir-ccflags-$(CONFIG_PPC_WERROR)	:=3D -Werror=0A =0A ifdef CONFIG_=
FUNCTION_TRACER=0A # do not trace tracer code=0A-CFLAGS_REMOVE_ftrace.o =3D=
 -mno-sched-epilog $(CC_FLAGS_FTRACE)=0A+CFLAGS_REMOVE_ftrace.o =3D $(CC_FL=
AGS_FTRACE)=0A endif=0A =0A obj32-$(CONFIG_FUNCTION_TRACER)		+=3D ftrace_32=
=2Eo=0Adiff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc=
/platforms/powermac/Makefile=0Aindex f2839eed0f89..561a67d65e4d 100644=0A--=
- a/arch/powerpc/platforms/powermac/Makefile=0A+++ b/arch/powerpc/platforms=
/powermac/Makefile=0A@@ -3,7 +3,7 @@ CFLAGS_bootx_init.o  		+=3D -fPIC=0A =
=0A ifdef CONFIG_FUNCTION_TRACER=0A # Do not trace early boot code=0A-CFLAG=
S_REMOVE_bootx_init.o =3D -mno-sched-epilog $(CC_FLAGS_FTRACE)=0A+CFLAGS_RE=
MOVE_bootx_init.o =3D $(CC_FLAGS_FTRACE)=0A endif=0A =0A obj-y				+=3D pic.=
o setup.o time.o feature.o pci.o \=0Adiff --git a/arch/powerpc/xmon/Makefil=
e b/arch/powerpc/xmon/Makefile=0Aindex 1bc3abb237cd..93cc1f1b8b61 100644=0A=
--- a/arch/powerpc/xmon/Makefile=0A+++ b/arch/powerpc/xmon/Makefile=0A@@ -8=
,7 +8,7 @@ UBSAN_SANITIZE :=3D n=0A =0A # Disable ftrace for the entire dir=
ectory=0A ORIG_CFLAGS :=3D $(KBUILD_CFLAGS)=0A-KBUILD_CFLAGS =3D $(subst -m=
no-sched-epilog,,$(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS)))=0A+KBUILD_CFL=
AGS =3D $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))=0A =0A ccflags-$(CONFIG=
_PPC64) :=3D $(NO_MINIMAL_TOC)=0A =0A-- =0A2.20.1=0A=0A=0AFrom 27b9227c753b=
19a6a52009d93939c8bd5f9c09a7 Mon Sep 17 00:00:00 2001=0AFrom: Nicholas Pigg=
in <npiggin@gmail.com>=0ADate: Fri, 14 Sep 2018 15:08:54 +1000=0ASubject: [=
PATCH 3/9] powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer=0A=0Acommi=
t 6977f95e63b9b3fb4a5973481a800dd9f48a1338 upstream.=0A=0ASigned-off-by: Ni=
cholas Piggin <npiggin@gmail.com>=0AReviewed-by: Joel Stanley <joel@jms.id.=
au>=0ASigned-off-by: Michael Ellerman <mpe@ellerman.id.au>=0ASigned-off-by:=
 Nathan Chancellor <natechancellor@gmail.com>=0A---=0A arch/powerpc/Makefil=
e | 8 ++++++--=0A 1 file changed, 6 insertions(+), 2 deletions(-)=0A=0Adiff=
 --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile=0Aindex 5fcec0e09668=
=2E.c4c03992ee82 100644=0A--- a/arch/powerpc/Makefile=0A+++ b/arch/powerpc/=
Makefile=0A@@ -165,8 +165,12 @@ CC_FLAGS_FTRACE :=3D -pg=0A ifdef CONFIG_MP=
ROFILE_KERNEL=0A CC_FLAGS_FTRACE +=3D -mprofile-kernel=0A endif=0A-# Work a=
round a gcc code-gen bug with -fno-omit-frame-pointer.=0A-CC_FLAGS_FTRACE	+=
=3D -mno-sched-epilog=0A+# Work around gcc code-gen bugs with -pg / -fno-om=
it-frame-pointer in gcc <=3D 4.8=0A+# https://gcc.gnu.org/bugzilla/show_bug=
=2Ecgi?id=3D44199=0A+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D52828=
=0A+ifneq ($(cc-name),clang)=0A+CC_FLAGS_FTRACE	+=3D $(call cc-ifversion, -=
lt, 0409, -mno-sched-epilog)=0A+endif=0A endif=0A =0A CFLAGS-$(CONFIG_TARGE=
T_CPU_BOOL) +=3D $(call cc-option,-mcpu=3D$(CONFIG_TARGET_CPU))=0A-- =0A2.2=
0.1=0A=0A=0AFrom e4f79dc6ac185ffb744406c25fe9760b284cdfb3 Mon Sep 17 00:00:=
00 2001=0AFrom: Joel Stanley <joel@jms.id.au>=0ADate: Mon, 17 Sep 2018 17:1=
6:21 +0930=0ASubject: [PATCH 4/9] powerpc: Disable -Wbuiltin-requires-heade=
r when setjmp is=0A used=0A=0Acommit aea447141c7e7824b81b49acd1bc785506fba4=
6e upstream.=0A=0AThe powerpc kernel uses setjmp which causes a warning whe=
n building=0Awith clang:=0A=0A  In file included from arch/powerpc/xmon/xmo=
n.c:51:=0A  ./arch/powerpc/include/asm/setjmp.h:15:13: error: declaration o=
f=0A  built-in function 'setjmp' requires inclusion of the header <setjmp.h=
>=0A        [-Werror,-Wbuiltin-requires-header]=0A  extern long setjmp(long=
 *);=0A              ^=0A  ./arch/powerpc/include/asm/setjmp.h:16:13: error=
: declaration of=0A  built-in function 'longjmp' requires inclusion of the =
header <setjmp.h>=0A        [-Werror,-Wbuiltin-requires-header]=0A  extern =
void longjmp(long *, long);=0A              ^=0A=0AThis *is* the header and=
 we're not using the built-in setjump but=0Arather the one in arch/powerpc/=
kernel/misc.S. As the compiler warning=0Adoes not make sense, it for the fi=
les where setjmp is used.=0A=0ASigned-off-by: Joel Stanley <joel@jms.id.au>=
=0AReviewed-by: Nick Desaulniers <ndesaulniers@google.com>=0A[mpe: Move sub=
dir-ccflags in xmon/Makefile to not clobber -Werror]=0ASigned-off-by: Micha=
el Ellerman <mpe@ellerman.id.au>=0ASigned-off-by: Nathan Chancellor <natech=
ancellor@gmail.com>=0A---=0A arch/powerpc/kernel/Makefile | 3 +++=0A arch/p=
owerpc/xmon/Makefile   | 5 ++++-=0A 2 files changed, 7 insertions(+), 1 del=
etion(-)=0A=0Adiff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kern=
el/Makefile=0Aindex 1e64cfe22a83..eac18790d1b1 100644=0A--- a/arch/powerpc/=
kernel/Makefile=0A+++ b/arch/powerpc/kernel/Makefile=0A@@ -5,6 +5,9 @@=0A =
=0A CFLAGS_ptrace.o		+=3D -DUTS_MACHINE=3D'"$(UTS_MACHINE)"'=0A =0A+# Disab=
le clang warning for using setjmp without setjmp.h header=0A+CFLAGS_crash.o=
		+=3D $(call cc-disable-warning, builtin-requires-header)=0A+=0A subdir-cc=
flags-$(CONFIG_PPC_WERROR) :=3D -Werror=0A =0A ifdef CONFIG_PPC64=0Adiff --=
git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile=0Aindex 93cc1=
f1b8b61..9d7d8e6d705c 100644=0A--- a/arch/powerpc/xmon/Makefile=0A+++ b/arc=
h/powerpc/xmon/Makefile=0A@@ -1,7 +1,10 @@=0A # SPDX-License-Identifier: GP=
L-2.0=0A # Makefile for xmon=0A =0A-subdir-ccflags-$(CONFIG_PPC_WERROR) :=
=3D -Werror=0A+# Disable clang warning for using setjmp without setjmp.h he=
ader=0A+subdir-ccflags-y :=3D $(call cc-disable-warning, builtin-requires-h=
eader)=0A+=0A+subdir-ccflags-$(CONFIG_PPC_WERROR) +=3D -Werror=0A =0A GCOV_=
PROFILE :=3D n=0A UBSAN_SANITIZE :=3D n=0A-- =0A2.20.1=0A=0A=0AFrom 1babc48=
6b88265beb0777d3b0039215b8cbbc80c Mon Sep 17 00:00:00 2001=0AFrom: Masahiro=
 Yamada <yamada.masahiro@socionext.com>=0ADate: Tue, 6 Nov 2018 12:04:54 +0=
900=0ASubject: [PATCH 5/9] kbuild: add -no-integrated-as Clang option=0A un=
conditionally=0A=0Acommit dbe27a002ef8573168cb64e181458ea23a74e2b6 upstream=
=2E=0A=0AWe are still a way off the Clang's integrated assembler support fo=
r=0Athe kernel. Hence, -no-integrated-as is mandatory to build the kernel=
=0Awith Clang. If you had an ancient version of Clang that does not=0Arecog=
nize this option, you would not be able to compile the kernel=0Aanyway.=0A=
=0ASigned-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>=0AReviewe=
d-by: Nick Desaulniers <ndesaulniers@google.com>=0ATested-by: Nick Desaulni=
ers <ndesaulniers@google.com>=0ASigned-off-by: Nathan Chancellor <natechanc=
ellor@gmail.com>=0A---=0A Makefile | 4 ++--=0A 1 file changed, 2 insertions=
(+), 2 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex 3324dd0e1=
1a3..5945f28d0643 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -492,8 +492=
,8 @@ CLANG_GCC_TC	:=3D --gcc-toolchain=3D$(GCC_TOOLCHAIN)=0A endif=0A KBUI=
LD_CFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A KBUILD_AF=
LAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A-KBUILD_CFLAGS =
+=3D $(call cc-option, -no-integrated-as)=0A-KBUILD_AFLAGS +=3D $(call cc-o=
ption, -no-integrated-as)=0A+KBUILD_CFLAGS +=3D -no-integrated-as=0A+KBUILD=
_AFLAGS +=3D -no-integrated-as=0A endif=0A =0A RETPOLINE_CFLAGS_GCC :=3D -m=
indirect-branch=3Dthunk-extern -mindirect-branch-register=0A-- =0A2.20.1=0A=
=0A=0AFrom 64a6b1c21754a6d2fb5d895664d2cdcf10948779 Mon Sep 17 00:00:00 200=
1=0AFrom: Masahiro Yamada <yamada.masahiro@socionext.com>=0ADate: Tue, 6 No=
v 2018 12:04:55 +0900=0ASubject: [PATCH 6/9] kbuild: consolidate Clang comp=
iler flags=0A=0Acommit 238bcbc4e07fad2fff99c5b157d0c37ccd4d093c upstream.=
=0A=0ACollect basic Clang options such as --target, --prefix, --gcc-toolcha=
in,=0A-no-integrated-as into a single variable CLANG_FLAGS so that it can b=
e=0Aeasily reused in other parts of Makefile.=0A=0ASigned-off-by: Masahiro =
Yamada <yamada.masahiro@socionext.com>=0AReviewed-by: Nick Desaulniers <nde=
saulniers@google.com>=0ATested-by: Nick Desaulniers <ndesaulniers@google.co=
m>=0AAcked-by: Greg Hackmann <ghackmann@google.com>=0ASigned-off-by: Nathan=
 Chancellor <natechancellor@gmail.com>=0A---=0A Makefile | 13 ++++++-------=
=0A 1 file changed, 6 insertions(+), 7 deletions(-)=0A=0Adiff --git a/Makef=
ile b/Makefile=0Aindex 5945f28d0643..e6ea36b902ec 100644=0A--- a/Makefile=
=0A+++ b/Makefile=0A@@ -482,18 +482,17 @@ endif=0A =0A ifeq ($(cc-name),cla=
ng)=0A ifneq ($(CROSS_COMPILE),)=0A-CLANG_TARGET	:=3D --target=3D$(notdir $=
(CROSS_COMPILE:%-=3D%))=0A+CLANG_FLAGS	:=3D --target=3D$(notdir $(CROSS_COM=
PILE:%-=3D%))=0A GCC_TOOLCHAIN_DIR :=3D $(dir $(shell which $(LD)))=0A-CLAN=
G_PREFIX	:=3D --prefix=3D$(GCC_TOOLCHAIN_DIR)=0A+CLANG_FLAGS	+=3D --prefix=
=3D$(GCC_TOOLCHAIN_DIR)=0A GCC_TOOLCHAIN	:=3D $(realpath $(GCC_TOOLCHAIN_DI=
R)/..)=0A endif=0A ifneq ($(GCC_TOOLCHAIN),)=0A-CLANG_GCC_TC	:=3D --gcc-too=
lchain=3D$(GCC_TOOLCHAIN)=0A+CLANG_FLAGS	+=3D --gcc-toolchain=3D$(GCC_TOOLC=
HAIN)=0A endif=0A-KBUILD_CFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLAN=
G_PREFIX)=0A-KBUILD_AFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PRE=
FIX)=0A-KBUILD_CFLAGS +=3D -no-integrated-as=0A-KBUILD_AFLAGS +=3D -no-inte=
grated-as=0A+CLANG_FLAGS	+=3D -no-integrated-as=0A+KBUILD_CFLAGS	+=3D $(CLA=
NG_FLAGS)=0A+KBUILD_AFLAGS	+=3D $(CLANG_FLAGS)=0A endif=0A =0A RETPOLINE_CF=
LAGS_GCC :=3D -mindirect-branch=3Dthunk-extern -mindirect-branch-register=
=0A-- =0A2.20.1=0A=0A=0AFrom 43b944c0f438f8f361945bc43bc24340cf562c9f Mon S=
ep 17 00:00:00 2001=0AFrom: Joel Stanley <joel@jms.id.au>=0ADate: Mon, 12 N=
ov 2018 14:51:15 +1030=0ASubject: [PATCH 7/9] Makefile: Export clang toolch=
ain variables=0A=0Acommit 3bd9805090af843b25f97ffe5049f20ade1d86d6 upstream=
=2E=0A=0AThe powerpc makefile will use these in it's boot wrapper.=0A=0ASig=
ned-off-by: Joel Stanley <joel@jms.id.au>=0ASigned-off-by: Masahiro Yamada =
<yamada.masahiro@socionext.com>=0ASigned-off-by: Nathan Chancellor <natecha=
ncellor@gmail.com>=0A---=0A Makefile | 1 +=0A 1 file changed, 1 insertion(+=
)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex e6ea36b902ec..8082a6c23706 =
100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -493,6 +493,7 @@ endif=0A CLA=
NG_FLAGS	+=3D -no-integrated-as=0A KBUILD_CFLAGS	+=3D $(CLANG_FLAGS)=0A KBU=
ILD_AFLAGS	+=3D $(CLANG_FLAGS)=0A+export CLANG_FLAGS=0A endif=0A =0A RETPOL=
INE_CFLAGS_GCC :=3D -mindirect-branch=3Dthunk-extern -mindirect-branch-regi=
ster=0A-- =0A2.20.1=0A=0A=0AFrom 4915a7c350a280949cc3d35fb148d9e690c36aad M=
on Sep 17 00:00:00 2001=0AFrom: Joel Stanley <joel@jms.id.au>=0ADate: Mon, =
12 Nov 2018 14:51:16 +1030=0ASubject: [PATCH 8/9] powerpc/boot: Set target =
when cross-compiling for clang=0A=0Acommit 813af51f5d30a2da6a2523c08465f972=
6e51772e upstream.=0A=0AClang needs to be told which target it is building =
for when cross=0Acompiling.=0A=0ALink: https://github.com/ClangBuiltLinux/l=
inux/issues/259=0ASigned-off-by: Joel Stanley <joel@jms.id.au>=0ATested-by:=
 Daniel Axtens <dja@axtens.net> # powerpc 64-bit BE=0AAcked-by: Michael Ell=
erman <mpe@ellerman.id.au>=0AReviewed-by: Nick Desaulniers <ndesaulniers@go=
ogle.com>=0ASigned-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>=
=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A arc=
h/powerpc/boot/Makefile | 5 +++++=0A 1 file changed, 5 insertions(+)=0A=0Ad=
iff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile=0Aindex=
 0fb96c26136f..25e3184f11f7 100644=0A--- a/arch/powerpc/boot/Makefile=0A+++=
 b/arch/powerpc/boot/Makefile=0A@@ -55,6 +55,11 @@ BOOTAFLAGS	:=3D -D__ASSE=
MBLY__ $(BOOTCFLAGS) -traditional -nostdinc=0A =0A BOOTARFLAGS	:=3D -cr$(KB=
UILD_ARFLAGS)=0A =0A+ifdef CONFIG_CC_IS_CLANG=0A+BOOTCFLAGS +=3D $(CLANG_FL=
AGS)=0A+BOOTAFLAGS +=3D $(CLANG_FLAGS)=0A+endif=0A+=0A ifdef CONFIG_DEBUG_I=
NFO=0A BOOTCFLAGS	+=3D -g=0A endif=0A-- =0A2.20.1=0A=0A=0AFrom 7edd494f54e0=
0b7698811611aa40218386bb2d92 Mon Sep 17 00:00:00 2001=0AFrom: Joel Stanley =
<joel@jms.id.au>=0ADate: Fri, 2 Nov 2018 11:14:55 +1030=0ASubject: [PATCH 9=
/9] raid6/ppc: Fix build for clang=0A=0Acommit e213574a449f7a57d4202c1869bb=
c7680b6b5521 upstream.=0A=0AWe cannot build these files with clang as it do=
es not allow altivec=0Ainstructions in assembly when -msoft-float is passed=
=2E=0A=0AJinsong Ji <jji@us.ibm.com> wrote:=0A> We currently disable Altive=
c/VSX support when enabling soft-float.  So=0A> any usage of vector builtin=
s will break.=0A>=0A> Enable Altivec/VSX with soft-float may need quite som=
e clean up work, so=0A> I guess this is currently a limitation.=0A>=0A> Rem=
oving -msoft-float will make it work (and we are lucky that no=0A> floating=
 point instructions will be generated as well).=0A=0AThis is a workaround u=
ntil the issue is resolved in clang.=0A=0ALink: https://bugs.llvm.org/show_=
bug.cgi?id=3D31177=0ALink: https://github.com/ClangBuiltLinux/linux/issues/=
239=0ASigned-off-by: Joel Stanley <joel@jms.id.au>=0AReviewed-by: Nick Desa=
ulniers <ndesaulniers@google.com>=0ASigned-off-by: Michael Ellerman <mpe@el=
lerman.id.au>=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.com>=
=0A---=0A lib/raid6/Makefile | 15 +++++++++++++++=0A 1 file changed, 15 ins=
ertions(+)=0A=0Adiff --git a/lib/raid6/Makefile b/lib/raid6/Makefile=0Ainde=
x 2f8b61dfd9b0..7ed43eaa02ef 100644=0A--- a/lib/raid6/Makefile=0A+++ b/lib/=
raid6/Makefile=0A@@ -18,6 +18,21 @@ quiet_cmd_unroll =3D UNROLL  $@=0A =0A =
ifeq ($(CONFIG_ALTIVEC),y)=0A altivec_flags :=3D -maltivec $(call cc-option=
,-mabi=3Daltivec)=0A+=0A+ifdef CONFIG_CC_IS_CLANG=0A+# clang ppc port does =
not yet support -maltivec when -msoft-float is=0A+# enabled. A future relea=
se of clang will resolve this=0A+# https://bugs.llvm.org/show_bug.cgi?id=3D=
31177=0A+CFLAGS_REMOVE_altivec1.o  +=3D -msoft-float=0A+CFLAGS_REMOVE_altiv=
ec2.o  +=3D -msoft-float=0A+CFLAGS_REMOVE_altivec4.o  +=3D -msoft-float=0A+=
CFLAGS_REMOVE_altivec8.o  +=3D -msoft-float=0A+CFLAGS_REMOVE_altivec8.o  +=
=3D -msoft-float=0A+CFLAGS_REMOVE_vpermxor1.o +=3D -msoft-float=0A+CFLAGS_R=
EMOVE_vpermxor2.o +=3D -msoft-float=0A+CFLAGS_REMOVE_vpermxor4.o +=3D -msof=
t-float=0A+CFLAGS_REMOVE_vpermxor8.o +=3D -msoft-float=0A+endif=0A endif=0A=
 =0A # The GCC option -ffreestanding is required in order to compile code c=
ontaining=0A-- =0A2.20.1=0A=0A
--bp/iNruPH9dso1Pn--
