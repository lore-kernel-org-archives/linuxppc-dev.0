Return-Path: <SRS0=DFH+=DY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B04C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 00:51:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFA721D81
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 00:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HR6TiUoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFA721D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCkx10DPszDr3G
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 11:51:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com;
 envelope-from=3qt-kxwukdooyadnasaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=HR6TiUoq; dkim-atps=neutral
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCks75hMNzDqcq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 11:48:04 +1100 (AEDT)
Received: by mail-pf1-x44a.google.com with SMTP id t26so2344585pfl.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=jAqXNk0u0bLFPugoNWCXsYqJIRxd7ATu/6k8nOgdJT0=;
 b=HR6TiUoqu3YiI+dW9M6qpJoUaneIr/cmBIDpcvWWRv4+rmokSY/Ebv3x8HJeztSQdd
 jP7MfhZ3Ye7nF8m0YuRjtYsxIr2RkVRuyrt8ueSv78E3BT5EDAI5nctnRBUqO8SREyz3
 nN1/pE+D2Z9zw4skjZ1xVRZAEN+l9jRLaDCG9wLau9EOCPMxOTmGwzxToNiCsSWVXq4E
 9Tfh7BkM7BbTf1VjnvqCCJLuuOhhzr3U2lF09I9++CdJFr7vorj+CgfGAKFZEfw+gEeL
 EM4zkpu7ciB4VP7puytWt6zKDP8uqntWTpFEAH8t+2579h6uAxoDf37bTJApxcYjurV+
 2m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jAqXNk0u0bLFPugoNWCXsYqJIRxd7ATu/6k8nOgdJT0=;
 b=jucGhqPib4bWoT6R1k1vDbT+0UgfbCQcowXjwAE4kvljplHj8J6BbOy4sSGq1kL7QB
 wovLh0Z7Qx7FO5w/UpaFCRpw8xbq36L/pfq+BfrIlgsY7M7lJ1AWtOa2zAcjH0by5egU
 7J/0FjGgXz2tC22dgJdt/NpWVCPyeq0tWW6zcQGtRlBbM8ZgwIpzm51VX62OFuMeKSjz
 JZ/FswwhsAz2UHd34qossTggxajncV1F/aRFU37kx0+NeBDisAb681GFfJipVaTxn8Io
 GaMNxGrZHUTtOCSmIRoDlolJfMViJxl+6gPC9yKXyjIje+tLTIfFIM9C6pRCsr5QaIRB
 qMhQ==
X-Gm-Message-State: AOAM533nX/2r9xnfWR47LsUY+ERL9h511sntXQyfDSQPBRWU49hF8ewH
 HjHshUZr1555gpr2pKVPeHUo/dYLMVkVNnpBBZ2onvnxFN+Pgo4FNblI2xuMCakdRzHbh3RMBSl
 T924Tlfv7ZN2Eg5MiX+M9+4RnPIqavAD5DNQNYCpy4fDTcC11HshYfMyf2kHhyPUPuy4=
X-Google-Smtp-Source: ABdhPJyAPLeeGHxL+1Mi9LdXRCjLyxO1VwHIPVEFlOLIWv8M+I0HlobJ0IkxYtTmJdErvvHaTit+DSjhIw==
X-Received: from fawn.svl.corp.google.com
 ([2620:15c:2cd:202:7220:84ff:fe0f:9f6a])
 (user=morbo job=sendgmr) by 2002:a17:90b:3314:: with SMTP id
 kf20mr6760043pjb.19.1602895681009; Fri, 16 Oct 2020 17:48:01 -0700 (PDT)
Date: Fri, 16 Oct 2020 17:47:51 -0700
In-Reply-To: <20201017004752.415054-1-morbo@google.com>
Message-Id: <20201017004752.415054-2-morbo@google.com>
Mime-Version: 1.0
References: <20201017004752.415054-1-morbo@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH 1/2] powerpc/wrapper: Add "-z notext" flag to disable
 diagnostic
From: Bill Wendling <morbo@google.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Fangrui Song <maskray@google.com>, Alan Modra <amodra@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The "-z notext" flag disables reporting an error if DT_TEXTREL is set.

  ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against
    symbol: _start in readonly segment; recompile object files with
    -fPIC or pass '-Wl,-z,notext' to allow text relocations in the
    output
  >>> defined in
  >>> referenced by crt0.o:(.text+0x8) in archive arch/powerpc/boot/wrapper.a

The BFD linker disables this by default (though it's configurable in
current versions). LLD enables this by default. So we add the flag to
keep LLD from emitting the error.

Cc: Fangrui Song <maskray@google.com>
Cc: Alan Modra <amodra@gmail.com>
Signed-off-by: Bill Wendling <morbo@google.com>
---
 arch/powerpc/boot/wrapper | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index cd58a62e810d..e576d3e4b23f 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -46,6 +46,7 @@ compression=.gz
 uboot_comp=gzip
 pie=
 format=
+notext=
 
 # cross-compilation prefix
 CROSS=
@@ -353,6 +354,7 @@ epapr)
     platformo="$object/pseries-head.o $object/epapr.o $object/epapr-wrapper.o"
     link_address='0x20000000'
     pie=-pie
+    notext='-z notext'
     ;;
 mvme5100)
     platformo="$object/fixed-head.o $object/mvme5100.o"
@@ -493,8 +495,8 @@ if [ "$platform" != "miboot" ]; then
         text_start="-Ttext $link_address"
     fi
 #link everything
-    ${CROSS}ld -m $format -T $lds $text_start $pie $nodl -o "$ofile" $map \
-	$platformo $tmp $object/wrapper.a
+    ${CROSS}ld -m $format -T $lds $text_start $pie $notext $nodl -o "$ofile" \
+        $map $platformo $tmp $object/wrapper.a
     rm $tmp
 fi
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

