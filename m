Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD9C38A2A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 05:08:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BCA208D6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 05:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeoiCp66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BCA208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JJHv6HJzzDr3N
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 15:08:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PeoiCp66; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JHYb0jbYzDqvp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 14:34:58 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id v63so290683pfb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2020 21:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hGMx/GhOm4RxkjPqXcJGh/pt4EublTjg+RR69QfMk7U=;
 b=PeoiCp66YB8mpKd/EjbEC5QLTfS74+GUUjOSjJe8hYorhegMUVQcZaSf5vycgXgidW
 XdbYQOsAUfVsZN75KEIq/w+EYYBEslg7rxWJG/vyucnc+CI8megcynHVSjE4W7Bp/5NF
 CfMnwXkqZtwAPVw2Hge3LUGHa+1wr6Ehbv4EAGFAT6aUTQTUzubdwjaaIC+wy5oXFc52
 Wp+7NIL89rw6w2s5jUgJI9U6z/wWfymRZnMuE9VqkW5TV6LHG74fx1BAzPM9Mf8YPIVl
 Kmjl5YCxcWI+rhDkIOM0ARlw+FRiuIYfxGGsu375u9kXiqvjxb8Y2QPFej3jqrF01Ysd
 GvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hGMx/GhOm4RxkjPqXcJGh/pt4EublTjg+RR69QfMk7U=;
 b=XBOKoLw85JdmjkA1ViV/2QRAgMYN/MZ2MKUlyywaT4JbmKiT8vCYl6teMWnoAMIblz
 evf4Om5AkjCeaXYIygydmemGMaL9/GvP/hHskYeYiyTCMIoX65WG1o7mNbiDm3D/hkab
 p4rO3/WUq2Ppa1UcMAR0yZvQsdZRpMoUgqE8i5hXIzv9iFId0TInL9+zgn8NetloBYNu
 bZFR0LmPwLTYS6rCtkKBMrNE6TrtAvmnZ/2RWw56bUgda6Opg1cteftQYAULsIPiG5PL
 iyHeNpaKNznX+VFP2gbnb4QRr1mJWXBLatw06uqNMQ2hlLKQ5cHvMaffW6ug5v3JM4Us
 1PJw==
X-Gm-Message-State: AGi0PubqEVRJBQJ2o4LvgqzyHIE0aJgLzRSJyv9hbkowCArc9JjoGTLJ
 KdxQ1HXnMEBniqqzcMcKp12WpGKn
X-Google-Smtp-Source: APiQypIWVBD3PqkAVi1isVC2gRBHnY6w8Xe9/3g1DPes/kiZWM4Si1yYwRnaWgqnPdq34hA79k8sjQ==
X-Received: by 2002:a65:6797:: with SMTP id e23mr530224pgr.409.1588912496019; 
 Thu, 07 May 2020 21:34:56 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-214-199.tpgi.com.au. [61.68.214.199])
 by smtp.gmail.com with ESMTPSA id i9sm358813pfk.199.2020.05.07.21.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 21:34:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 16/16] powerpc/traps: Machine check fix RI=0 recoverability
 check
Date: Fri,  8 May 2020 14:34:08 +1000
Message-Id: <20200508043408.886394-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200508043408.886394-1-npiggin@gmail.com>
References: <20200508043408.886394-1-npiggin@gmail.com>
MIME-Version: 1.0
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The MSR[RI]=0 recoverability check should be in the recovered machine
check case. Without this, a machine check that hits in a RI region that
has for example live SRRs, will cause the interrupted context to resume
with corrupted registers and crash unpredictably.

This does not affect 64s at the moment, because it does its own early
handling with RI check, but it may affect 32s.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 477befcda8d3..759d8dbf867b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -873,13 +873,13 @@ void machine_check_exception(struct pt_regs *regs)
 
 	die("Machine check", regs, SIGBUS);
 
+	return;
+
+bail:
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		die("Unrecoverable Machine check", regs, SIGBUS);
 
-	return;
-
-bail:
 	if (!nested)
 		nmi_exit();
 }
-- 
2.23.0

