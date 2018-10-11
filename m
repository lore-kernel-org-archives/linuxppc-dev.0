Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1865C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 02:45:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1106F204EC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 02:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WudHE5ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1106F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VwLs4TwLzF1Nj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 13:45:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WudHE5ED";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WudHE5ED"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VwJ70Mt0zF18l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 13:43:18 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id p24-v6so3591006pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 19:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=StUQslNWZh2skf/DXGddDSCS1225GEf83n+5tIIWU4A=;
 b=WudHE5EDv6BT4OYe0X57OSC6UQqx/F1e9XZZ99FHjZiS+9D2Y204wiH/8DVhX1PqvJ
 Ott+Snb2kFMNjkL9mwVRYhDiKLo8PE2Sv9aZvmiLp9sPK8PKzgcoL7VBbAg1phe/Zprz
 ySk1rteqj9QBJeepQcOleO3XH51xk4MbNIzLqzez6A6xptE+he2b+F6YZ1ACSKeOcITa
 vPkPlFaRyAwhUyqIoqir+i8haj+x4mxVTnggmwmAP6Qh4DvgJBIA0H281GUBsmJ14hRn
 O5ddllACYyXtkUp1Xo7hA1IYqd3Nu/MtchMG86SoLSd//JceYwgYS2pBkNSoNpVjultJ
 UTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=StUQslNWZh2skf/DXGddDSCS1225GEf83n+5tIIWU4A=;
 b=NAkIHi+JRgdGGuO6HO6Q+6NdIG/MlIuJxj+FKUowU51FUsC4q3GP3vpmIoNxzEb28V
 QmrvSB8xk7qWA/Mr4+MpR2D8oJu0UF5WoGyH0rlH2W7hxlTVvbHcd77Qcf6G+AP1t6QE
 jwlFfM86RbpomuW6tcM76CIk5I1G17fQsrYhB9MYMYqEFm/a9yOlf8uNcpj4NpYVaaTP
 Cet+j6/wj/2qnWMM2FMq874UJIkM6dXImORjmePnu3+C93HpqnTNNs4j92i+KRsqILmW
 Udhl4Je0+F36+EygxYFafArV2KelJ4mD8/Ou1mD53OOQsgUrC+nSt37fWvK6ekJj/Kna
 w80A==
X-Gm-Message-State: ABuFfojs7ickDNmcBzt9fxv9lmiZ383MUFiJVRbmfxiHcB8gCy5dQnMG
 Y6IjTFQBAMM60Te+hB1zTbWukb4i
X-Google-Smtp-Source: ACcGV60/ncbSvK8EjjwMe18sJu7KTfpitXObUHW/KRXhKYzlYh1exW8hHRplt7PwwIjwF2jJ10pMEw==
X-Received: by 2002:a62:1316:: with SMTP id
 b22-v6mr37283738pfj.37.1539225796299; 
 Wed, 10 Oct 2018 19:43:16 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id i21-v6sm41431915pgj.55.2018.10.10.19.43.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 10 Oct 2018 19:43:15 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Thu, 11 Oct 2018 13:13:08 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc/Makefile: Fix PPC_BOOK3S_64 ASFLAGS
Date: Thu, 11 Oct 2018 13:13:03 +1030
Message-Id: <20181011024303.23921-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ever since commit 15a3204d24a3 ("powerpc/64s: Set assembler machine type
to POWER4") we force -mpower4 to be passed to the assembler irrespective
of the CFLAGS used.

When building a powerpc64 kernel with clang, clang will not add -many to
the assembler flags, so any instructions that the compiler has generated
that are not available on power4 will cause an error:

 /usr/bin/as -a64 -mppc64 -mlittle-endian -mpower8 \
  -I ./arch/powerpc/include -I ./arch/powerpc/include/generated \
  -I ./include -I ./arch/powerpc/include/uapi \
  -I ./arch/powerpc/include/generated/uapi -I ./include/uapi \
  -I ./include/generated/uapi -I arch/powerpc -I arch/powerpc \
  -maltivec -mpower4 -o init/do_mounts.o /tmp/do_mounts-3b0a3d.s
 /tmp/do_mounts-51ce54.s:748: Error: unrecognized opcode: `isel'

GCC does include -many, so the GCC driven gas call will succeed:

  as -v -I ./arch/powerpc/include -I ./arch/powerpc/include/generated -I
  ./include -I ./arch/powerpc/include/uapi
  -I ./arch/powerpc/include/generated/uapi -I ./include/uapi
  -I ./include/generated/uapi -I arch/powerpc -I arch/powerpc
   -a64 -mpower8 -many -mlittle -maltivec -mpower4 -o init/do_mounts.o

Note that isel is power7 and above for IBM CPUs. GCC only generates it
for Power9 and above, but the above test was run against the clang
generated assembly.

Peter Bergner explains:

 > When using -many -mpower4, gas will first try and find a matching
 > power4 mnemonic and failing that, it will then allow any valid mnemonic
 > that gas knows about.  GCC's use of -many predates me though.
 >
 > IIRC, Alan looked at trying to remove it, but I forget why he didn't.
 > Could be either a gcc or gas issue at the time.  I'm not sure whether
 > issue still exists or not.  He and I have modified how gas works
 > internally a fair amount since he tried removing gcc use of -many
 >
 > I will also note that when using -many, gas will choose the first
 > mnemonic that matches in the mnemonic table and we have (mostly) sorted
 > the table so that server mnemonics show up earlier in the table than
 > other mnemonics, so they'll be seen/chosen first

By explicitly setting -many we can build with Clang and GCC while
retaining the -mpower4 option.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Following up on:
https://lore.kernel.org/linuxppc-dev/20180914040649.1794-2-joel@jms.id.au/
https://lore.kernel.org/linuxppc-dev/20180821010203.23213-1-anton@ozlabs.org/

mpe, please trim the commit message if you think it's a bit verbose

We could test for these flags in case -many is removed in the future,
but if an assembler does not support -many then -mpower4 will probably
break it anyway.

 arch/powerpc/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 81552c7b46eb..ae097fa9abe9 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -249,7 +249,10 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
-cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
+# When using -many -mpower4 gas will first try and find a matching power4
+# mnemonic and failing that it will allow any valid mnemonic that GAS knows
+# about. GCC will pass -many to GAS when assembling, clang does not
+cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4 -Wa,-many
 cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
2.17.1

