Return-Path: <SRS0=sQnj=EY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F7CC5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 22:47:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDD1246DC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 22:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ejad0Eyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDD1246DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cbycq4fQNzDqWt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 09:47:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com;
 envelope-from=3l6k1xwukdlyiknxkckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=Ejad0Eyq; dkim-atps=neutral
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CbyZy6gWZzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2020 09:46:01 +1100 (AEDT)
Received: by mail-pl1-x649.google.com with SMTP id h2so2109896pll.22
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=H8TrGHNBLf006TFO6e05F3XBnE6KZCaNEclT5Nbreuk=;
 b=Ejad0Eyqg6Ci9aLGvmPTnp6kxTWDQ5ryvFTwgLz5FyIlGWECkRSsUn2Tz2amDiMvdq
 I78xbya8JkJ1RWFuWwirGU05YunqAb1mglkNLC4KedVn6FX/nVNMqyXW40LxiCBtDABr
 zwekAFJe53W0j480P6voyzTxYSQWm/K0mFiu/OmmDt9YrQwRz1aFMHigNapbGnD+aK0n
 plsHkte8pP7FZ+FJiQXFc1UVujqkBrTrdOpzWri39kaoUe35JOH6kMsE9MKkOTRsOHCY
 YRwPuGEgyyGyQox6DjXOQQ/0rfydoZpxvwZCRs+oGOXUfXl1NfwdJ2LTqX9lu32F/IIO
 YwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=H8TrGHNBLf006TFO6e05F3XBnE6KZCaNEclT5Nbreuk=;
 b=Tqt9FI258r6xfJKMlhdnNuDsZv3u+NZiv8PVPWfC5/czKcpBCkXJXDO71OK6jz7u5c
 B1CGNsHqTRlrfTlC2PB5oTCbEPw9dNmk7ug6grxL+o0fEDPEdq1klyp2Ci2pEdknEL1w
 Skf6M2/oKm5ocVtHS/mWSY2pIIKS0j17eiOKYsTCr9sWoR3mWZcOJq1tk1OobMgN8a6I
 7Uftp309vYz0p49jAGDj6MRXKyLfxqU8m77MhXIU6lIoTR861QEnrLqshnJJC90pnCfO
 bM5/YolwGWCSzp3ub0RmVbI3/LgbDWnXcHPyPauDeaipb1mJ44haWyKs4UJm4I1LNX4n
 wczg==
X-Gm-Message-State: AOAM532bz9dXsuAE6Mr7tqXPg/uoBchvJM9bLjpluiUYS5XL/Yd1MTkB
 9NPra1Dc71aa3Zx3J7tyMlqdQtwR
X-Google-Smtp-Source: ABdhPJxdsl9AVdehv0MOnP6/8WraHmX0ock3ivUdkpBDwh5IzTbAJuVoui2p03QpC+GDeAGJT+tN8tfeIw==
X-Received: from fawn.svl.corp.google.com ([100.116.77.50]) (user=morbo
 job=sendgmr) by 2002:a05:6214:20e4:: with SMTP id
 4mr7272520qvk.37.1605739159516; 
 Wed, 18 Nov 2020 14:39:19 -0800 (PST)
Date: Wed, 18 Nov 2020 14:39:10 -0800
In-Reply-To: <20201017000151.150788-1-morbo@google.com>
Message-Id: <20201118223910.2711337-1-morbo@google.com>
Mime-Version: 1.0
References: <20201017000151.150788-1-morbo@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] powerpc/wrapper: add "-z rodynamic" when using LLD
From: Bill Wendling <morbo@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Fangrui Song <maskray@google.com>,
 Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Normally all read-only sections precede SHF_WRITE sections. .dynamic and
.got have the SHF_WRITE flag; .dynamic probably because of DT_DEBUG. LLD
emits an error when this happens, so use "-z rodynamic" to mark .dynamic
as read-only.

Cc: Fangrui Song <maskray@google.com>
Cc: Alan Modra <amodra@gmail.com>
Signed-off-by: Bill Wendling <morbo@google.com>
---
 arch/powerpc/boot/wrapper | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index cd58a62e810d..e1194955adbb 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -46,6 +46,7 @@ compression=.gz
 uboot_comp=gzip
 pie=
 format=
+rodynamic=
 
 # cross-compilation prefix
 CROSS=
@@ -353,6 +354,7 @@ epapr)
     platformo="$object/pseries-head.o $object/epapr.o $object/epapr-wrapper.o"
     link_address='0x20000000'
     pie=-pie
+    rodynamic=$(if ${CROSS}ld -V 2>&1 | grep -q LLD ; then echo "-z rodynamic"; fi)
     ;;
 mvme5100)
     platformo="$object/fixed-head.o $object/mvme5100.o"
@@ -493,7 +495,7 @@ if [ "$platform" != "miboot" ]; then
         text_start="-Ttext $link_address"
     fi
 #link everything
-    ${CROSS}ld -m $format -T $lds $text_start $pie $nodl -o "$ofile" $map \
+    ${CROSS}ld -m $format -T $lds $text_start $pie $nodl $rodynamic -o "$ofile" $map \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
-- 
2.29.2.454.gaff20da3a2-goog

