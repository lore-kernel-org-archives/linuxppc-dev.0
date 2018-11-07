Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFC3C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 20:29:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEDEC2081D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 20:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxtj3hc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDEC2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qygH61mvzF3F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 07:28:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qxtj3hc2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qxtj3hc2"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qycn2qdWzF3Dy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 07:26:49 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id z16-v6so18826148wrv.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqwrTTqvGsUpLX2SWvD7XWIT2tTdoRIiwxsCG3LUJnc=;
 b=Qxtj3hc2m3rjDLj86DqFS0SG3/MQwRYZHk2fnZavQnjY7kRIgoVdcmHkInbTaYzn62
 n6tyvBShSyfofdBwcMWxGhCyKAUTzUH9gdMArubI8XsK8afN/hH8gf3hTEs9HmBPDZ1O
 14hvQEKJA+ZnP5VRYUQSyXOzYFjbOYyU5CKcbN/JdFt+oGnAIBSZcWxk7ffsmyztu8EX
 WWUQcfX6okOqya632GNpUA2PSWvGu8w8ZXsCnBnDQypZMEnKiCHwcVvyY6eywwdqdQl8
 wzD6FxqKl6+6/Zclmj6jgHu02YlsZQ/ycL3iBr482As5ZZfz9m5HdG45GbGfih5P3LIR
 g5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=oqwrTTqvGsUpLX2SWvD7XWIT2tTdoRIiwxsCG3LUJnc=;
 b=bR+QymJEo9ZDEkf9oqJSDk6v/PNHDlnD0zczpRE8vKplgBRL+qIsTHSWbKh60mhI/V
 nLV5nW+/6M120CagbECMaminzvauJIbg1yRr+PuRiqGlieZocsMwnEJdkt+hdkT+YGJK
 5IzHdY+Z1Q/klYyktcG8REyR6DFpPuTK37N0YSd3Z9J6SxcMg0T7npNOL/wvW569Bo5u
 PJunIPi+3zOizRM3Qp/5+UvEpMz8Pu/76eF2DxLt/lRl2F5ahtHFy51OWRSttNv6hbjn
 JWFTLcy6uR6L63Vz38OsHzWavxXqU8ADh0Rk9j9IR4BGc0m4rW4IXrD/bELh29uRuAY3
 v0GA==
X-Gm-Message-State: AGRZ1gJvaKLcnHjbh6HvJBR2kOZIwIN9IfZ+Wp7KPauqvmJjRyCYgkZ3
 l/BGq+Mm/fR4InrNG9HomkM=
X-Google-Smtp-Source: AJdET5dU6tqQvOaQgYuwZ4gHxlIvyOt476nswY8sgDNg35m/iB4Ohl9+T6NYtQ4UbPz1MRKXhVpAkw==
X-Received: by 2002:adf:d1c6:: with SMTP id
 m6-v6mr1575709wri.138.1541622405551; 
 Wed, 07 Nov 2018 12:26:45 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id f67-v6sm1892405wme.22.2018.11.07.12.26.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 07 Nov 2018 12:26:44 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 129C61142B69; Wed,  7 Nov 2018 21:26:43 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Mark variable `cpumsr` as unused
Date: Wed,  7 Nov 2018 21:26:41 +0100
Message-Id: <20181107202641.7865-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add gcc attribute unused for `cpumsr` variable.

Fix warnings treated as errors with W=1:

  arch/powerpc/kernel/process.c:231:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
  arch/powerpc/kernel/process.c:296:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96f34730010f..b9f1a2408738 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(flush_fp_to_thread);
 
 void enable_kernel_fp(void)
 {
-	unsigned long cpumsr;
+	unsigned long cpumsr __maybe_unused;
 
 	WARN_ON(preemptible());
 
@@ -293,7 +293,7 @@ EXPORT_SYMBOL(giveup_altivec);
 
 void enable_kernel_altivec(void)
 {
-	unsigned long cpumsr;
+	unsigned long cpumsr __maybe_unused;
 
 	WARN_ON(preemptible());
 
-- 
2.11.0

