Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC453C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 20:21:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3959C20700
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 20:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOEVo8Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3959C20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bHTG266DzDqtS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 07:21:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tOEVo8Re"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bDbL2GF4zDr0s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 05:11:42 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id y139so12080746wmc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 10:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=F95U2Qlu3CLW/JINJmgLNqZBqMrDS9x6rBbfEzQb32Y=;
 b=tOEVo8RevMeyeTzUpAathi+A9BKpcYFB4lFo3PSTn4Du9KajN7eyvDHwELGTrJFZN0
 KS+Ru+xdktobT2H6ylEgAwy/eXYdbYVzqMKKwbevf6aJ3IKKnik56vJeGxtJEEvp22cq
 CuRZHIDMUTMLtqmcg2hY12DKI90BFFvexyrJb6L+MvCxndJbhDqkvoL8TWDaWxqb+NfM
 3ZsxmQIpMLzj2qzGIkkNPPf69arqhNADQo/mf0NMuItdjVRamy6qb3en5a+1XKJ5q/Zc
 CPSgKXeUsVRQtNYpkSVuXf+tvTLjj0mzb/YgEJlntayn8F/EGjvWZXP+87EG3lrhqANt
 nHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=F95U2Qlu3CLW/JINJmgLNqZBqMrDS9x6rBbfEzQb32Y=;
 b=SkgH+clr1G2VEzjVtTkXF0Z1WSFd1Xxak0UDMij1qW89adDSvi+LrHvrTixXFBk99S
 7EqGyTKs0Pta+yhGmDPQLO7cU4WpMBhu1hIGwQK2CHCCdST+0mjz2ifEukXc9FKf4hEd
 DPhcwJxsaU2tqIN5yYU3coOU978CthB7oaM1InGAyik4A60Fa7/B5SJPGCN0Hrx045IN
 uzLOx9g4wwQ04EbXI3/VdC6gNkBEENFbf6rSTHs/+tWq5CF9q9qWTokXuA7kYGJOkImo
 5/vfqA2Ow8vFQBRgz+/2wfJELysrd0DCnQRuDkn0TBRVecWIKlkr+t+c8vV65KMOR69w
 Bh1A==
X-Gm-Message-State: AJcUukfHg/Za3JjSG+Eb3uLEIzYw5YoyqPXgAZIyy8AlLvRPRKnJVKZ+
 dusUzwGpB0Hs2yPMBJuukHQ=
X-Google-Smtp-Source: ALg8bN6HnjmG82kk53gQCem2+/wazmCtagmL/SCj0W/BXx+T71ktWXSCgo3cMDLLtijJxV9iiA3N7w==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr10626060wmc.42.1547143899101; 
 Thu, 10 Jan 2019 10:11:39 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id 199sm19855396wmh.21.2019.01.10.10.11.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 10:11:37 -0800 (PST)
Date: Thu, 10 Jan 2019 11:11:36 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Subject: Patch series for 4.14 to compile powerpc with Clang
Message-ID: <20190110181136.GA3979@flashbox>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
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


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Attached is an mbox with a series of patches to allow building the
powerpc kernel with Clang. We have been running continuous integration
that builds and boots the kernel in QEMU for almost two months now with
no regressions. This is on top of 4.14.92, there should be no conflicts
but let me know if I messed something up.

I forgot to link the CI page in the previous email.

4.19: https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/169419117

4.14: https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/169419121

Thank you,
Nathan

--3V7upXqbjpZ4EhLz
Content-Type: application/mbox
Content-Disposition: attachment; filename="powerpc-clang-series.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom 46c76575de5db13060b901cb2007fd2b86cdcf22 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nicholas Piggin <npiggin@gmail.com>=0ADate: Fri, 14 Sep 2018 15:08:=
54 +1000=0ASubject: [PATCH 1/9] powerpc: avoid -mno-sched-epilog on GCC 4.9=
 and newer=0A=0Acommit 6977f95e63b9b3fb4a5973481a800dd9f48a1338 upstream.=
=0A=0ASigned-off-by: Nicholas Piggin <npiggin@gmail.com>=0AReviewed-by: Joe=
l Stanley <joel@jms.id.au>=0ASigned-off-by: Michael Ellerman <mpe@ellerman.=
id.au>=0A[nc: Adjust context due to lack of f2910f0e6835 and 2a056f58fd33]=
=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A arc=
h/powerpc/Makefile | 7 ++++++-=0A 1 file changed, 6 insertions(+), 1 deleti=
on(-)=0A=0Adiff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile=0Aind=
ex 1381693a4a51..7452e50f4d1f 100644=0A--- a/arch/powerpc/Makefile=0A+++ b/=
arch/powerpc/Makefile=0A@@ -236,7 +236,12 @@ endif=0A =0A # Work around a g=
cc code-gen bug with -fno-omit-frame-pointer.=0A ifeq ($(CONFIG_FUNCTION_TR=
ACER),y)=0A-KBUILD_CFLAGS		+=3D -mno-sched-epilog=0A+# Work around gcc code=
-gen bugs with -pg / -fno-omit-frame-pointer in gcc <=3D 4.8=0A+# https://g=
cc.gnu.org/bugzilla/show_bug.cgi?id=3D44199=0A+# https://gcc.gnu.org/bugzil=
la/show_bug.cgi?id=3D52828=0A+ifneq ($(cc-name),clang)=0A+KBUILD_CFLAGS		+=
=3D $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)=0A+endif=0A endif=0A=
 =0A cpu-as-$(CONFIG_4xx)		+=3D -Wa,-m405=0A-- =0A2.20.1=0A=0A=0AFrom 9f2f3=
51151c1fb1f9a053ff28c167aa7f9663c4d Mon Sep 17 00:00:00 2001=0AFrom: Joel S=
tanley <joel@jms.id.au>=0ADate: Mon, 17 Sep 2018 17:16:21 +0930=0ASubject: =
[PATCH 2/9] powerpc: Disable -Wbuiltin-requires-header when setjmp is=0A us=
ed=0A=0Acommit aea447141c7e7824b81b49acd1bc785506fba46e upstream.=0A=0AThe =
powerpc kernel uses setjmp which causes a warning when building=0Awith clan=
g:=0A=0A  In file included from arch/powerpc/xmon/xmon.c:51:=0A  ./arch/pow=
erpc/include/asm/setjmp.h:15:13: error: declaration of=0A  built-in functio=
n 'setjmp' requires inclusion of the header <setjmp.h>=0A        [-Werror,-=
Wbuiltin-requires-header]=0A  extern long setjmp(long *);=0A              ^=
=0A  ./arch/powerpc/include/asm/setjmp.h:16:13: error: declaration of=0A  b=
uilt-in function 'longjmp' requires inclusion of the header <setjmp.h>=0A  =
      [-Werror,-Wbuiltin-requires-header]=0A  extern void longjmp(long *, l=
ong);=0A              ^=0A=0AThis *is* the header and we're not using the b=
uilt-in setjump but=0Arather the one in arch/powerpc/kernel/misc.S. As the =
compiler warning=0Adoes not make sense, it for the files where setjmp is us=
ed.=0A=0ASigned-off-by: Joel Stanley <joel@jms.id.au>=0AReviewed-by: Nick D=
esaulniers <ndesaulniers@google.com>=0A[mpe: Move subdir-ccflags in xmon/Ma=
kefile to not clobber -Werror]=0ASigned-off-by: Michael Ellerman <mpe@eller=
man.id.au>=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A=
---=0A arch/powerpc/kernel/Makefile | 3 +++=0A arch/powerpc/xmon/Makefile  =
 | 5 ++++-=0A 2 files changed, 7 insertions(+), 1 deletion(-)=0A=0Adiff --g=
it a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile=0Aindex 14=
79c61e29c5..a1089c9a9aa5 100644=0A--- a/arch/powerpc/kernel/Makefile=0A+++ =
b/arch/powerpc/kernel/Makefile=0A@@ -5,6 +5,9 @@=0A =0A CFLAGS_ptrace.o		+=
=3D -DUTS_MACHINE=3D'"$(UTS_MACHINE)"'=0A =0A+# Disable clang warning for u=
sing setjmp without setjmp.h header=0A+CFLAGS_crash.o		+=3D $(call cc-disab=
le-warning, builtin-requires-header)=0A+=0A subdir-ccflags-$(CONFIG_PPC_WER=
ROR) :=3D -Werror=0A =0A ifeq ($(CONFIG_PPC64),y)=0Adiff --git a/arch/power=
pc/xmon/Makefile b/arch/powerpc/xmon/Makefile=0Aindex 1bc3abb237cd..549e99e=
71112 100644=0A--- a/arch/powerpc/xmon/Makefile=0A+++ b/arch/powerpc/xmon/M=
akefile=0A@@ -1,7 +1,10 @@=0A # SPDX-License-Identifier: GPL-2.0=0A # Makef=
ile for xmon=0A =0A-subdir-ccflags-$(CONFIG_PPC_WERROR) :=3D -Werror=0A+# D=
isable clang warning for using setjmp without setjmp.h header=0A+subdir-ccf=
lags-y :=3D $(call cc-disable-warning, builtin-requires-header)=0A+=0A+subd=
ir-ccflags-$(CONFIG_PPC_WERROR) +=3D -Werror=0A =0A GCOV_PROFILE :=3D n=0A =
UBSAN_SANITIZE :=3D n=0A-- =0A2.20.1=0A=0A=0AFrom 4fa9ce9ca7352e9c5ac50fcac=
71047a58620bb60 Mon Sep 17 00:00:00 2001=0AFrom: Joel Stanley <joel@jms.id.=
au>=0ADate: Mon, 17 Sep 2018 17:07:54 +0930=0ASubject: [PATCH 3/9] ftrace: =
Build with CPPFLAGS to get -Qunused-arguments=0A=0AWhen building to record =
the mcount locations the kernel uses=0AKBUILD_CFLAGS but not KBUILD_CPPFLAG=
S. This means it lacks=0A-Qunused-arguments when building with clang, resul=
ting in a lot of=0Anoisy warnings.=0A=0ASigned-off-by: Joel Stanley <joel@j=
ms.id.au>=0AReviewed-by: Nick Desaulniers <ndesaulniers@google.com>=0ASigne=
d-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>=0A[nc: Fix confli=
cts due to lack of 87a32e624037 and d503ac531a52]=0ASigned-off-by: Nathan C=
hancellor <natechancellor@gmail.com>=0A---=0A scripts/Makefile.build | 2 +-=
=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/scripts=
/Makefile.build b/scripts/Makefile.build=0Aindex be9e5deb58ba..3edc9c04cb46=
 100644=0A--- a/scripts/Makefile.build=0A+++ b/scripts/Makefile.build=0A@@ =
-242,7 +242,7 @@ else=0A sub_cmd_record_mcount =3D set -e ; perl $(srctree)=
/scripts/recordmcount.pl "$(ARCH)" \=0A 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big=
,little)" \=0A 	"$(if $(CONFIG_64BIT),64,32)" \=0A-	"$(OBJDUMP)" "$(OBJCOPY=
)" "$(CC) $(KBUILD_CFLAGS)" \=0A+	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD=
_CPPFLAGS) $(KBUILD_CFLAGS)" \=0A 	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \=0A 	"$=
(if $(part-of-module),1,0)" "$(@)";=0A recordmcount_source :=3D $(srctree)/=
scripts/recordmcount.pl=0A-- =0A2.20.1=0A=0A=0AFrom d3cfe39ed6e852957770992=
d9855583872ab9bae Mon Sep 17 00:00:00 2001=0AFrom: Matthias Kaehlcke <mka@c=
hromium.org>=0ADate: Thu, 5 Oct 2017 11:28:47 -0700=0ASubject: [PATCH 4/9] =
md: raid10: remove VLAIS=0A=0Acommit 584ed9fa9532f8b9d5955628ff87ee3b2ab9f5=
a9 upstream.=0A=0AThe raid10 driver can't be built with clang since it uses=
 a variable=0Alength array in a structure (VLAIS):=0A=0Adrivers/md/raid10.c=
:4583:17: error: fields must have a constant size:=0A  'variable length arr=
ay in structure' extension will never be supported=0A=0AAllocate the r10bio=
 struct with kmalloc instead of using the VLAIS=0Aconstruct.=0A=0AShaohua: =
set the MD_RECOVERY_INTR bit=0ANeil Brown: use GFP_NOIO=0A=0ASigned-off-by:=
 Matthias Kaehlcke <mka@chromium.org>=0AReviewed-by: Guenter Roeck <groeck@=
chromium.org>=0ASigned-off-by: Shaohua Li <shli@fb.com>=0ASigned-off-by: Na=
than Chancellor <natechancellor@gmail.com>=0A---=0A drivers/md/raid10.c | 1=
5 ++++++++++-----=0A 1 file changed, 10 insertions(+), 5 deletions(-)=0A=0A=
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c=0Aindex e786546bf3b8=
=2E.52ddfa0fca94 100644=0A--- a/drivers/md/raid10.c=0A+++ b/drivers/md/raid=
10.c=0A@@ -4591,15 +4591,18 @@ static int handle_reshape_read_error(struct =
mddev *mddev,=0A 	/* Use sync reads to get the blocks from somewhere else *=
/=0A 	int sectors =3D r10_bio->sectors;=0A 	struct r10conf *conf =3D mddev-=
>private;=0A-	struct {=0A-		struct r10bio r10_bio;=0A-		struct r10dev devs[=
conf->copies];=0A-	} on_stack;=0A-	struct r10bio *r10b =3D &on_stack.r10_bi=
o;=0A+	struct r10bio *r10b;=0A 	int slot =3D 0;=0A 	int idx =3D 0;=0A 	stru=
ct page **pages;=0A =0A+	r10b =3D kmalloc(sizeof(*r10b) +=0A+	       sizeof=
(struct r10dev) * conf->copies, GFP_NOIO);=0A+	if (!r10b) {=0A+		set_bit(MD=
_RECOVERY_INTR, &mddev->recovery);=0A+		return -ENOMEM;=0A+	}=0A+=0A 	/* re=
shape IOs share pages from .devs[0].bio */=0A 	pages =3D get_resync_pages(r=
10_bio->devs[0].bio)->pages;=0A =0A@@ -4648,11 +4651,13 @@ static int handl=
e_reshape_read_error(struct mddev *mddev,=0A 			/* couldn't read this block=
, must give up */=0A 			set_bit(MD_RECOVERY_INTR,=0A 				&mddev->recovery);=
=0A+			kfree(r10b);=0A 			return -EIO;=0A 		}=0A 		sectors -=3D s;=0A 		idx=
++;=0A 	}=0A+	kfree(r10b);=0A 	return 0;=0A }=0A =0A-- =0A2.20.1=0A=0A=0AFr=
om 87586119b2cc4f0f3cef2c109b124ea7ec5e5f7a Mon Sep 17 00:00:00 2001=0AFrom=
: Masahiro Yamada <yamada.masahiro@socionext.com>=0ADate: Tue, 6 Nov 2018 1=
2:04:54 +0900=0ASubject: [PATCH 5/9] kbuild: add -no-integrated-as Clang op=
tion=0A unconditionally=0A=0Acommit dbe27a002ef8573168cb64e181458ea23a74e2b=
6 upstream.=0A=0AWe are still a way off the Clang's integrated assembler su=
pport for=0Athe kernel. Hence, -no-integrated-as is mandatory to build the =
kernel=0Awith Clang. If you had an ancient version of Clang that does not=
=0Arecognize this option, you would not be able to compile the kernel=0Aany=
way.=0A=0ASigned-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>=0A=
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>=0ATested-by: Nick D=
esaulniers <ndesaulniers@google.com>=0ASigned-off-by: Nathan Chancellor <na=
techancellor@gmail.com>=0A---=0A Makefile | 4 ++--=0A 1 file changed, 2 ins=
ertions(+), 2 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex be=
4d1f25cb29..f8061626814c 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -489=
,8 +489,8 @@ CLANG_GCC_TC	:=3D --gcc-toolchain=3D$(GCC_TOOLCHAIN)=0A endif=
=0A KBUILD_CFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A K=
BUILD_AFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)=0A-KBUILD=
_CFLAGS +=3D $(call cc-option, -no-integrated-as)=0A-KBUILD_AFLAGS +=3D $(c=
all cc-option, -no-integrated-as)=0A+KBUILD_CFLAGS +=3D -no-integrated-as=
=0A+KBUILD_AFLAGS +=3D -no-integrated-as=0A endif=0A =0A RETPOLINE_CFLAGS_G=
CC :=3D -mindirect-branch=3Dthunk-extern -mindirect-branch-register=0A-- =
=0A2.20.1=0A=0A=0AFrom a8e0cd48898782e480b4e41cb329e0ce1096bb1e Mon Sep 17 =
00:00:00 2001=0AFrom: Masahiro Yamada <yamada.masahiro@socionext.com>=0ADat=
e: Tue, 6 Nov 2018 12:04:55 +0900=0ASubject: [PATCH 6/9] kbuild: consolidat=
e Clang compiler flags=0A=0Acommit 238bcbc4e07fad2fff99c5b157d0c37ccd4d093c=
 upstream.=0A=0ACollect basic Clang options such as --target, --prefix, --g=
cc-toolchain,=0A-no-integrated-as into a single variable CLANG_FLAGS so tha=
t it can be=0Aeasily reused in other parts of Makefile.=0A=0ASigned-off-by:=
 Masahiro Yamada <yamada.masahiro@socionext.com>=0AReviewed-by: Nick Desaul=
niers <ndesaulniers@google.com>=0ATested-by: Nick Desaulniers <ndesaulniers=
@google.com>=0AAcked-by: Greg Hackmann <ghackmann@google.com>=0ASigned-off-=
by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A Makefile | 13 +++=
+++-------=0A 1 file changed, 6 insertions(+), 7 deletions(-)=0A=0Adiff --g=
it a/Makefile b/Makefile=0Aindex f8061626814c..a2b89b1f8386 100644=0A--- a/=
Makefile=0A+++ b/Makefile=0A@@ -479,18 +479,17 @@ endif=0A =0A ifeq ($(cc-n=
ame),clang)=0A ifneq ($(CROSS_COMPILE),)=0A-CLANG_TARGET	:=3D --target=3D$(=
notdir $(CROSS_COMPILE:%-=3D%))=0A+CLANG_FLAGS	:=3D --target=3D$(notdir $(C=
ROSS_COMPILE:%-=3D%))=0A GCC_TOOLCHAIN_DIR :=3D $(dir $(shell which $(LD)))=
=0A-CLANG_PREFIX	:=3D --prefix=3D$(GCC_TOOLCHAIN_DIR)=0A+CLANG_FLAGS	+=3D -=
-prefix=3D$(GCC_TOOLCHAIN_DIR)=0A GCC_TOOLCHAIN	:=3D $(realpath $(GCC_TOOLC=
HAIN_DIR)/..)=0A endif=0A ifneq ($(GCC_TOOLCHAIN),)=0A-CLANG_GCC_TC	:=3D --=
gcc-toolchain=3D$(GCC_TOOLCHAIN)=0A+CLANG_FLAGS	+=3D --gcc-toolchain=3D$(GC=
C_TOOLCHAIN)=0A endif=0A-KBUILD_CFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC)=
 $(CLANG_PREFIX)=0A-KBUILD_AFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CL=
ANG_PREFIX)=0A-KBUILD_CFLAGS +=3D -no-integrated-as=0A-KBUILD_AFLAGS +=3D -=
no-integrated-as=0A+CLANG_FLAGS	+=3D -no-integrated-as=0A+KBUILD_CFLAGS	+=
=3D $(CLANG_FLAGS)=0A+KBUILD_AFLAGS	+=3D $(CLANG_FLAGS)=0A endif=0A =0A RET=
POLINE_CFLAGS_GCC :=3D -mindirect-branch=3Dthunk-extern -mindirect-branch-r=
egister=0A-- =0A2.20.1=0A=0A=0AFrom 1cf633a86a5db960332274cdfaf4d98fa81f217=
1 Mon Sep 17 00:00:00 2001=0AFrom: Joel Stanley <joel@jms.id.au>=0ADate: Mo=
n, 12 Nov 2018 14:51:15 +1030=0ASubject: [PATCH 7/9] Makefile: Export clang=
 toolchain variables=0A=0Acommit 3bd9805090af843b25f97ffe5049f20ade1d86d6 u=
pstream.=0A=0AThe powerpc makefile will use these in it's boot wrapper.=0A=
=0ASigned-off-by: Joel Stanley <joel@jms.id.au>=0ASigned-off-by: Masahiro Y=
amada <yamada.masahiro@socionext.com>=0ASigned-off-by: Nathan Chancellor <n=
atechancellor@gmail.com>=0A---=0A Makefile | 1 +=0A 1 file changed, 1 inser=
tion(+)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex a2b89b1f8386..2c7811e=
e7fe3 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -490,6 +490,7 @@ endif=
=0A CLANG_FLAGS	+=3D -no-integrated-as=0A KBUILD_CFLAGS	+=3D $(CLANG_FLAGS)=
=0A KBUILD_AFLAGS	+=3D $(CLANG_FLAGS)=0A+export CLANG_FLAGS=0A endif=0A =0A=
 RETPOLINE_CFLAGS_GCC :=3D -mindirect-branch=3Dthunk-extern -mindirect-bran=
ch-register=0A-- =0A2.20.1=0A=0A=0AFrom efb56f3898fb268f9c3071b5106aa32e477=
13d28 Mon Sep 17 00:00:00 2001=0AFrom: Joel Stanley <joel@jms.id.au>=0ADate=
: Mon, 12 Nov 2018 14:51:16 +1030=0ASubject: [PATCH 8/9] powerpc/boot: Set =
target when cross-compiling for clang=0A=0Acommit 813af51f5d30a2da6a2523c08=
465f9726e51772e upstream.=0A=0AClang needs to be told which target it is bu=
ilding for when cross=0Acompiling.=0A=0ALink: https://github.com/ClangBuilt=
Linux/linux/issues/259=0ASigned-off-by: Joel Stanley <joel@jms.id.au>=0ATes=
ted-by: Daniel Axtens <dja@axtens.net> # powerpc 64-bit BE=0AAcked-by: Mich=
ael Ellerman <mpe@ellerman.id.au>=0AReviewed-by: Nick Desaulniers <ndesauln=
iers@google.com>=0ASigned-off-by: Masahiro Yamada <yamada.masahiro@socionex=
t.com>=0A[nc: Use 'ifeq ($(cc-name),clang)' instead of 'ifdef CONFIG_CC_IS_=
CLANG'=0A     because that config does not exist in 4.14; the Kconfig rewri=
te=0A     that added that config happened in 4.18]=0ASigned-off-by: Nathan =
Chancellor <natechancellor@gmail.com>=0A---=0A arch/powerpc/boot/Makefile |=
 5 +++++=0A 1 file changed, 5 insertions(+)=0A=0Adiff --git a/arch/powerpc/=
boot/Makefile b/arch/powerpc/boot/Makefile=0Aindex b479926f0167..e2a5a932c2=
4a 100644=0A--- a/arch/powerpc/boot/Makefile=0A+++ b/arch/powerpc/boot/Make=
file=0A@@ -49,6 +49,11 @@ endif=0A =0A BOOTAFLAGS	:=3D -D__ASSEMBLY__ $(BOO=
TCFLAGS) -traditional -nostdinc=0A =0A+ifeq ($(cc-name),clang)=0A+BOOTCFLAG=
S +=3D $(CLANG_FLAGS)=0A+BOOTAFLAGS +=3D $(CLANG_FLAGS)=0A+endif=0A+=0A ifd=
ef CONFIG_DEBUG_INFO=0A BOOTCFLAGS	+=3D -g=0A endif=0A-- =0A2.20.1=0A=0A=0A=
=46rom e6884472f42aa70e3e383a98cf30c4eb415ab86f Mon Sep 17 00:00:00 2001=0A=
=46rom: Joel Stanley <joel@jms.id.au>=0ADate: Fri, 2 Nov 2018 11:14:55 +103=
0=0ASubject: [PATCH 9/9] raid6/ppc: Fix build for clang=0A=0Acommit e213574=
a449f7a57d4202c1869bbc7680b6b5521 upstream.=0A=0AWe cannot build these file=
s with clang as it does not allow altivec=0Ainstructions in assembly when -=
msoft-float is passed.=0A=0AJinsong Ji <jji@us.ibm.com> wrote:=0A> We curre=
ntly disable Altivec/VSX support when enabling soft-float.  So=0A> any usag=
e of vector builtins will break.=0A>=0A> Enable Altivec/VSX with soft-float=
 may need quite some clean up work, so=0A> I guess this is currently a limi=
tation.=0A>=0A> Removing -msoft-float will make it work (and we are lucky t=
hat no=0A> floating point instructions will be generated as well).=0A=0AThi=
s is a workaround until the issue is resolved in clang.=0A=0ALink: https://=
bugs.llvm.org/show_bug.cgi?id=3D31177=0ALink: https://github.com/ClangBuilt=
Linux/linux/issues/239=0ASigned-off-by: Joel Stanley <joel@jms.id.au>=0ARev=
iewed-by: Nick Desaulniers <ndesaulniers@google.com>=0ASigned-off-by: Micha=
el Ellerman <mpe@ellerman.id.au>=0A[nc: Use 'ifeq ($(cc-name),clang)' inste=
ad of 'ifdef CONFIG_CC_IS_CLANG'=0A     because that config does not exist =
in 4.14; the Kconfig rewrite=0A     that added that config happened in 4.18=
]=0ASigned-off-by: Nathan Chancellor <natechancellor@gmail.com>=0A---=0A li=
b/raid6/Makefile | 15 +++++++++++++++=0A 1 file changed, 15 insertions(+)=
=0A=0Adiff --git a/lib/raid6/Makefile b/lib/raid6/Makefile=0Aindex 4add700d=
dfe3..ad523be0313b 100644=0A--- a/lib/raid6/Makefile=0A+++ b/lib/raid6/Make=
file=0A@@ -18,6 +18,21 @@ quiet_cmd_unroll =3D UNROLL  $@=0A =0A ifeq ($(CO=
NFIG_ALTIVEC),y)=0A altivec_flags :=3D -maltivec $(call cc-option,-mabi=3Da=
ltivec)=0A+=0A+ifeq ($(cc-name),clang)=0A+# clang ppc port does not yet sup=
port -maltivec when -msoft-float is=0A+# enabled. A future release of clang=
 will resolve this=0A+# https://bugs.llvm.org/show_bug.cgi?id=3D31177=0A+CF=
LAGS_REMOVE_altivec1.o  +=3D -msoft-float=0A+CFLAGS_REMOVE_altivec2.o  +=3D=
 -msoft-float=0A+CFLAGS_REMOVE_altivec4.o  +=3D -msoft-float=0A+CFLAGS_REMO=
VE_altivec8.o  +=3D -msoft-float=0A+CFLAGS_REMOVE_altivec8.o  +=3D -msoft-f=
loat=0A+CFLAGS_REMOVE_vpermxor1.o +=3D -msoft-float=0A+CFLAGS_REMOVE_vpermx=
or2.o +=3D -msoft-float=0A+CFLAGS_REMOVE_vpermxor4.o +=3D -msoft-float=0A+C=
FLAGS_REMOVE_vpermxor8.o +=3D -msoft-float=0A+endif=0A endif=0A =0A # The G=
CC option -ffreestanding is required in order to compile code containing=0A=
-- =0A2.20.1=0A=0A
--3V7upXqbjpZ4EhLz--
