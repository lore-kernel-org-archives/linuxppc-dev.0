Return-Path: <linuxppc-dev+bounces-19923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DF94CC2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 03:52:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0lfH0tMzz2yZN;
	Wed, 22 Apr 2026 13:52:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776829927;
	cv=none; b=GIl197POi3Rk2Eh79ymyRlJjfwcR2kliIcO82Pl/qHnAAqJEr9T5ukCPW64XolNCZLcMNo2XE+NzNOHWhdL5q1pVAnq0n+YEGcZ64AgbSB6wQuJgbEzNCfpchdS7FsDXHRPsT7Oq4iE/eUSsDi4VNjxJDTzcKL30iOxga/VuVY99s5Kr3SmdlepTeGHNHUoNTDYwqOPZ1cgEjqRu4sTe7BgcsScfdMB9emwcdcQv3qNuMov+gDC44RfEtQKPVTMmtWSoBdfejCFqK2CMNfXtDQLx4cYFEDJFAc2XB54lifkpueP8Hz6INag+C+6b+IUYdDM4l1mAczXVr9yjweaAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776829927; c=relaxed/relaxed;
	bh=jOdndvNOr5tk2o0VEu1kSKqEFvkiiCDk4VA7lkVUu3w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CMLukQquXyi8oRwOI6ixJ7Z16FKyKyKsKtBcbwHzjGmp235xIdOSR75xQRkrS39+rFK1ixkH3X7Ubnae3ISXaCGRmENzzoB+F1HL/sc/Jt2cYpnMyZcU/eK08DLV9EjPg4RDafGm8XIe8PX31LoC4E6gq8EyZkLFUz6j4HycG4bcitwq56wdwnaNzLpLJ8rJ4RBvMPLnkVeQXOZHNfBHC52qxKMZySAuFPxy6e7WuPSFfcbYN+dUs61XYkmyv7olpL6n8zTamwPnliA0vOHJ8ohFRtX9Q9mkO3DxgGFmtBeo6sR6PdYuAqq1FiAmkdFw+PPYiOn3li/Kgz5cJ1IjDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hGtoO2cJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=ribalda@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hGtoO2cJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=ribalda@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0lfF1XVkz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 13:52:04 +1000 (AEST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-ba51e69988aso616649966b.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776829919; x=1777434719; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jOdndvNOr5tk2o0VEu1kSKqEFvkiiCDk4VA7lkVUu3w=;
        b=hGtoO2cJZttjA6WUhUzMcIHzYeBNfwS159YUnPip98EydkobhFafgOSRzPCUzyZFFe
         Wi9MzatwvEtDQugRGZkpR51MppQdr1bVjRAsrbrwQY2rXavPg5GMkB1ry9ZYZM1bWUOp
         12Kmp/KK90T5vlGq4ScKHv1vzNEPw8xDCQkDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829919; x=1777434719;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOdndvNOr5tk2o0VEu1kSKqEFvkiiCDk4VA7lkVUu3w=;
        b=PRWGWjSCvfhJkO5V0r+wcmKXUd1xszCLvR9RSnnQl46piMXBVL8yoXZAIgMeN+Zb+j
         oW9nEqguLJJd90ksBwKks8xIIO6iCknnRlLAHB4ODDAxnFe/43SPKCvw21MPo7WHUOHM
         K63OjGP/xXR0oFzWrZnJXJrSndbYpNO+Yc5qF+OnxsfW9I4+GWRl0qfyGOKWbodTP+4I
         qNMQgdx9rtl7JDBm2WHtjDAEK9wWURoSW2DnGugTu8q/K6Go9GZOlwWDbBVKYZVv8tp2
         v00QiNtqv0y6cEJ8LVCSMTZHHtzZmEadQnZJHCAWRR3gudOVn6/Z3al7jhn47Rsk+7pA
         2QPw==
X-Forwarded-Encrypted: i=1; AFNElJ/PWRHRjOzODKNnTN4j1BqvVwk6GqZv0arYUPzjPgHNU9YyeL9nUIO1tUZtzvrbpY/ybSdtqDHys3Tp+i8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZWGF+sdf6NXgeLKtrIveCuL9gBgwCXy0D8w+WF7i0zGLvdIa1
	GrnDWeMeEnel0yvpERFYMKRDz9mS0x6wUFLk2z1l4o63GWVsXCAwW9ceq2TMKR9wUziWsleViEy
	BIRQS5Q==
X-Gm-Gg: AeBDietJ621OenL9+o0pQHt7P1PzM0kkH+segOq/duMnrlKYVkCw7QMSxcV5HdClBAG
	wS/l0Bmq/VwNN4ZjxTY+9f59p4EDeBvDNHvuYbyO3c9n21KNUUUZoIoiixQVTBg5GjEH+/b7c+j
	7R4iIvO9vCAIwuhbKBOET3orxe+pi3xbJeK0opIsjuZ8TK0a5zPqOHg73unoY+TdqqKuwuT+MMh
	PMse1FZast/GPkF10HkOGWk0+UKHIhXftzby5yA6u1uJhxn82mXdZtpN6P98txktaZAU1qLGcW/
	nEzpJQyDEmQs9zKzYfDUA1ydqchcgqks9ILXlrPXLR3OR3me3UnnJhtfgWqp78tfExaxi0pfkcH
	u47w6vawwd/UJplzD9isW9pUH8Lksu4OMdV2g+vppbYQ/sKR4EARNRMUUxP4iwRiZS5aKN08LBA
	4z5A41hWpI8EgQ5dvXrlyy566P3bBo+83wqGEGmIlCmyPnZY9ogN47DLL3eWSfVb9tZ20WU0A=
X-Received: by 2002:a17:907:3f08:b0:ba7:5c47:7b32 with SMTP id a640c23a62f3a-ba75c4787e3mr583942666b.10.1776829919267;
        Tue, 21 Apr 2026 20:51:59 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451210e26sm505277666b.8.2026.04.21.20.51.58
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 20:51:58 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b941762394aso672970566b.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 20:51:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Ik+8XshbpEe28t2wkmCu+AN2lwoYBM6tNkPstUMpQvQSAQJV+EWMP+pTrG89VpWNhAwB0Lfpt9XNfkLo=@lists.ozlabs.org
X-Received: by 2002:a17:907:7b9a:b0:ba6:5855:1cc0 with SMTP id
 a640c23a62f3a-ba65855318bmr671250466b.2.1776829917526; Tue, 21 Apr 2026
 20:51:57 -0700 (PDT)
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
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Apr 2026 11:51:45 +0800
X-Gmail-Original-Message-ID: <CANiDSCsOy0P1if-gJZqOM5pTJ0RDcwVfru1B7KFbTOEMqjPKJw@mail.gmail.com>
X-Gm-Features: AQROBzAUxpvtmmUfT9SytqZ_vnzE8JQsTm61nRrGtQURGtsgH0JZ_vzze_Uz4hk
Message-ID: <CANiDSCsOy0P1if-gJZqOM5pTJ0RDcwVfru1B7KFbTOEMqjPKJw@mail.gmail.com>
Subject: New warning in linus/master
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

Media-CI has found a couple of new warnings in the latest kernel
version for aarch64 and powerpc. They get fixed with this patch and
before moving I wanted to know if this was under your radar.



diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makef=
ile
index 7dec05dd33b7..65914842fae0 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -50,7 +50,7 @@ CFLAGS_vgettimeofday.o =3D $(CC_FLAGS_ADD_VDSO)
 CFLAGS_vgetrandom.o =3D $(CC_FLAGS_ADD_VDSO)

 ifneq ($(c-gettimeofday-y),)
-  CFLAGS_vgettimeofday.o +=3D -include $(c-gettimeofday-y)
+  CFLAGS_vgettimeofday.o +=3D -include $(c-gettimeofday-y)
-Wno-maybe-uninitialized
 endif

 ifneq ($(c-getrandom-y),)
diff --git a/arch/powerpc/kernel/vdso/Makefile
b/arch/powerpc/kernel/vdso/Makefile
index 8834dfe9d727..4b8d40b1dfeb 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -12,12 +12,12 @@ obj-vdso32 +=3D getrandom-32.o vgetrandom-chacha-32.o
 obj-vdso64 +=3D getrandom-64.o vgetrandom-chacha-64.o

 ifneq ($(c-gettimeofday-y),)
-  CFLAGS_vgettimeofday-32.o +=3D -include $(c-gettimeofday-y)
+  CFLAGS_vgettimeofday-32.o +=3D -include $(c-gettimeofday-y)
-Wno-maybe-uninitialized
 # Go prior to 1.16.x assumes r30 is not clobbered by any VDSO code.
That used to be true
 # by accident when the VDSO was hand-written asm code, but may not be
now that the VDSO is
 # compiler generated. To avoid breaking Go tell GCC not to use r30.
Impact on code
 # generation is minimal, it will just use r29 instead.
-  CFLAGS_vgettimeofday-64.o +=3D -include $(c-gettimeofday-y) $(call
cc-option, -ffixed-r30)
+  CFLAGS_vgettimeofday-64.o +=3D -include $(c-gettimeofday-y) $(call
cc-option, -ffixed-r30) -Wno-maybe-uninitialized
 endif

 ifneq ($(c-getrandom-y),)


https://gitlab.freedesktop.org/linux-media/users/ribalda/-/pipelines/164914=
4/test_report?job_name=3Dcross-gcc


CONFIG_CC_VERSION_TEXT=3D"aarch64-linux-gnu-gcc (Debian 15.2.0-16) 15.2.0"
  SYNC    include/config/auto.conf
  CC      arch/arm64/kernel/vdso/vgettimeofday.o
In file included from <command-line>:
In function =E2=80=98vdso_set_timespec=E2=80=99,
    inlined from =E2=80=98do_aux=E2=80=99 at /workdir/lib/vdso/gettimeofday=
.c:266:2,
    inlined from =E2=80=98__cvdso_clock_gettime_common=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:293:10,
    inlined from =E2=80=98__cvdso_clock_gettime_data.constprop=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:306:7:
/workdir/lib/vdso/gettimeofday.c:104:26: warning: =E2=80=98sec=E2=80=99 may=
 be used
uninitialized [-Wmaybe-uninitialized]
  104 |         ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &=
ns);
      |                      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
/workdir/lib/vdso/gettimeofday.c: In function
=E2=80=98__cvdso_clock_gettime_data.constprop=E2=80=99:
/workdir/lib/vdso/gettimeofday.c:242:13: note: =E2=80=98sec=E2=80=99 was de=
clared here
  242 |         u64 sec, ns;
      |             ^~~
In file included from /workdir/lib/vdso/gettimeofday.c:11:
In function =E2=80=98__iter_div_u64_rem=E2=80=99,
    inlined from =E2=80=98vdso_set_timespec=E2=80=99 at /workdir/lib/vdso/g=
ettimeofday.c:104:21,
    inlined from =E2=80=98do_aux=E2=80=99 at /workdir/lib/vdso/gettimeofday=
.c:266:2,
    inlined from =E2=80=98__cvdso_clock_gettime_common=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:293:10,
    inlined from =E2=80=98__cvdso_clock_gettime_data.constprop=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:306:7:
./include/vdso/math64.h:10:25: warning: =E2=80=98ns=E2=80=99 may be used un=
initialized
[-Wmaybe-uninitialized]
   10 |         while (dividend >=3D divisor) {
      |                ~~~~~~~~~^~~~~~~~~~
/workdir/lib/vdso/gettimeofday.c: In function
=E2=80=98__cvdso_clock_gettime_data.constprop=E2=80=99:
/workdir/lib/vdso/gettimeofday.c:242:18: note: =E2=80=98ns=E2=80=99 was dec=
lared here
  242 |         u64 sec, ns;
      |                  ^~
  LD      arch/arm64/kernel/vdso/vdso.so.dbg
  VDSOSYM include/generated/vdso-offsets.h
  OBJCOPY arch/arm64/kernel/vdso/vdso.so
/workdir/lib/vdso/gettimeofday.c:104:26: warning: =E2=80=98sec=E2=80=99 may=
 be used
uninitialized [-Wmaybe-uninitialized]
./include/vdso/math64.h:10:25: warning: =E2=80=98ns=E2=80=99 may be used un=
initialized
[-Wmaybe-uninitialized]

CONFIG_CC_VERSION_TEXT=3D"powerpc64-linux-gnu-gcc (Debian 15.2.0-15) 15.2.0=
"
  SYNC    include/config/auto.conf
  VDSO32C arch/powerpc/kernel/vdso/vgettimeofday-32.o
In file included from <command-line>:
In function =E2=80=98vdso_set_timespec=E2=80=99,
    inlined from =E2=80=98do_aux=E2=80=99 at /workdir/lib/vdso/gettimeofday=
.c:266:2,
    inlined from =E2=80=98__cvdso_clock_gettime_common=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:293:10,
    inlined from =E2=80=98__cvdso_clock_gettime32_data=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:327:7:
/workdir/lib/vdso/gettimeofday.c:104:26: warning: =E2=80=98sec=E2=80=99 may=
 be used
uninitialized [-Wmaybe-uninitialized]
  104 |         ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &=
ns);
      |                      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
/workdir/lib/vdso/gettimeofday.c: In function =E2=80=98__cvdso_clock_gettim=
e32_data=E2=80=99:
/workdir/lib/vdso/gettimeofday.c:242:13: note: =E2=80=98sec=E2=80=99 was de=
clared here
  242 |         u64 sec, ns;
      |             ^~~
In file included from /workdir/lib/vdso/gettimeofday.c:11:
In function =E2=80=98__iter_div_u64_rem=E2=80=99,
    inlined from =E2=80=98vdso_set_timespec=E2=80=99 at /workdir/lib/vdso/g=
ettimeofday.c:104:21,
    inlined from =E2=80=98do_aux=E2=80=99 at /workdir/lib/vdso/gettimeofday=
.c:266:2,
    inlined from =E2=80=98__cvdso_clock_gettime_common=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:293:10,
    inlined from =E2=80=98__cvdso_clock_gettime32_data=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:327:7:
./include/vdso/math64.h:10:25: warning: =E2=80=98ns=E2=80=99 may be used un=
initialized
[-Wmaybe-uninitialized]
   10 |         while (dividend >=3D divisor) {
      |                ~~~~~~~~~^~~~~~~~~~
/workdir/lib/vdso/gettimeofday.c: In function =E2=80=98__cvdso_clock_gettim=
e32_data=E2=80=99:
/workdir/lib/vdso/gettimeofday.c:242:18: note: =E2=80=98ns=E2=80=99 was dec=
lared here
  242 |         u64 sec, ns;
      |                  ^~
In function =E2=80=98vdso_set_timespec=E2=80=99,
    inlined from =E2=80=98do_aux=E2=80=99 at /workdir/lib/vdso/gettimeofday=
.c:266:2,
    inlined from =E2=80=98__cvdso_clock_gettime_common=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:293:10,
    inlined from =E2=80=98__cvdso_clock_gettime_data=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:306:7:
/workdir/lib/vdso/gettimeofday.c:104:26: warning: =E2=80=98sec=E2=80=99 may=
 be used
uninitialized [-Wmaybe-uninitialized]
  104 |         ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &=
ns);
      |                      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
/workdir/lib/vdso/gettimeofday.c: In function =E2=80=98__cvdso_clock_gettim=
e_data=E2=80=99:
/workdir/lib/vdso/gettimeofday.c:242:13: note: =E2=80=98sec=E2=80=99 was de=
clared here
  242 |         u64 sec, ns;
      |             ^~~
In function =E2=80=98__iter_div_u64_rem=E2=80=99,
    inlined from =E2=80=98vdso_set_timespec=E2=80=99 at /workdir/lib/vdso/g=
ettimeofday.c:104:21,
    inlined from =E2=80=98do_aux=E2=80=99 at /workdir/lib/vdso/gettimeofday=
.c:266:2,
    inlined from =E2=80=98__cvdso_clock_gettime_common=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:293:10,
    inlined from =E2=80=98__cvdso_clock_gettime_data=E2=80=99 at
/workdir/lib/vdso/gettimeofday.c:306:7:
./include/vdso/math64.h:10:25: warning: =E2=80=98ns=E2=80=99 may be used un=
initialized
[-Wmaybe-uninitialized]
   10 |         while (dividend >=3D divisor) {
      |                ~~~~~~~~~^~~~~~~~~~
/workdir/lib/vdso/gettimeofday.c: In function =E2=80=98__cvdso_clock_gettim=
e_data=E2=80=99:
/workdir/lib/vdso/gettimeofday.c:242:18: note: =E2=80=98ns=E2=80=99 was dec=
lared here
  242 |         u64 sec, ns;
      |                  ^~
  VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
  VDSO32SYM include/generated/vdso32-offsets.h
  CC      arch/powerpc/kernel/vdso/vgettimeofday-64.o
  VDSO64L arch/powerpc/kernel/vdso/vdso64.so.dbg
  VDSO64SYM include/generated/vdso64-offsets.h
/workdir/lib/vdso/gettimeofday.c:104:26: warning: =E2=80=98sec=E2=80=99 may=
 be used
uninitialized [-Wmaybe-uninitialized]
./include/vdso/math64.h:10:25: warning: =E2=80=98ns=E2=80=99 may be used un=
initialized
[-Wmaybe-uninitialized]
/workdir/lib/vdso/gettimeofday.c:104:26: warning: =E2=80=98sec=E2=80=99 may=
 be used
uninitialized [-Wmaybe-uninitialized]
./include/vdso/math64.h:10:25: warning: =E2=80=98ns=E2=80=99 may be used un=
initialized
[-Wmaybe-uninitialized]

Thanks

--=20
Ricardo Ribalda

