Return-Path: <SRS0=bT9L=FC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C9C63697
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 07:20:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DA42225B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 07:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEPVVXvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DA42225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjjZf00xYzF19q
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 18:20:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kEPVVXvM; dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjjJ02Zt5zDsXK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2020 18:08:00 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id l17so6028025pgk.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2020 23:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RE0535OC1P2LDrGbQpaiLP7+snTRDOWBeWRNCwF421I=;
 b=kEPVVXvMUZrllW5PL0LlJocK8K5CopAhZfRJ6p2/m2QB6OvRj8LpBWdJbWR/doJ1PE
 AiG6z1pXlsOilXe1QIujaPWqKyg4a0WFD4TMqGmAjraTti5iJk8pPPIO7wxtzE2OAn3T
 S2RXVYzTeV+S3FuO3hXqRcgaxgTcAXFLo8BCfq8MfVYZfoWnxk8qlFDhi97rw9I94F6/
 fwed2CAY4WmHM8L0+NQJO4TeAz8rn30DRsWEC7JCjeGbu0qJY+Ij2LVYekiIo5BAj+/3
 aa5yVKxdd2zYzvanYOD39bvSBgVu/KwbPOpHYLsFCcfZ3uh/WcT6IzW7gkfqCnm0HNQA
 6I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RE0535OC1P2LDrGbQpaiLP7+snTRDOWBeWRNCwF421I=;
 b=oHsNkLR0xO2Q/uu7Ig8SqeSEryxOVrL9srgkJ0qMUiqEGTLFQLcMc2OeyAhbC/dW7n
 BvemXgJ384VkQAmEpKLY97tpHKdfGdkIyIoCgh+/cUoQqBUq/cvwbvwHLt9pJ4zsUDli
 EPn6sbOxOaSSZCWbW369PeUooQ96ZgFj2Dqra6YWqMEcQKyI101TUnqkNraoeNzCAeMJ
 raaug63xZDyNkiJIMa6vNkhigAs8BC77teRSMlclmIiscaWNviZQ217Bq54yD2LHvlGI
 P3JR+UDXZxWIHSi0/jow8OyArSPyR47zdFOjg02otG3iCbxUFyLFTHyjW8rJDpuTrVge
 hYyA==
X-Gm-Message-State: AOAM532qFSDf6WU772gXlDPesRzp5H4+Ff5M+SPuXL0kb7TbhUbd/jg6
 WOQMBF7AIlo54K2x9jhEnj2TSHG+yFU=
X-Google-Smtp-Source: ABdhPJz6JT2bUHFa0tJ4DVKSilozsNR3sInaVbpeaGJV/XSotUNLKJTDD2QeZs+MbOXEf88qsOjUPg==
X-Received: by 2002:a17:90a:f485:: with SMTP id
 bx5mr15072182pjb.190.1606547278505; 
 Fri, 27 Nov 2020 23:07:58 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
 by smtp.gmail.com with ESMTPSA id e31sm9087329pgb.16.2020.11.27.23.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 23:07:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] powerpc/64s: Remove "Host" from MCE logging
Date: Sat, 28 Nov 2020 17:07:27 +1000
Message-Id: <20201128070728.825934-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128070728.825934-1-npiggin@gmail.com>
References: <20201128070728.825934-1-npiggin@gmail.com>
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
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Host" caused machine check is printed when the kernel sees a MCE
hit in this kernel or userspace, and "Guest" if it hit one of its
guests. This is confusing when a guest kernel handles a hypervisor-
delivered MCE, it also prints "Host".

Just remove "Host". "Guest" is adequate to make the distinction.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 8afe8d37b983..9f3e133b57b7 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -555,7 +555,7 @@ void machine_check_print_event_info(struct machine_check_event *evt,
 	}
 
 	printk("%sMCE: CPU%d: machine check (%s) %s %s %s %s[%s]\n",
-		level, evt->cpu, sevstr, in_guest ? "Guest" : "Host",
+		level, evt->cpu, sevstr, in_guest ? "Guest" : "",
 		err_type, subtype, dar_str,
 		evt->disposition == MCE_DISPOSITION_RECOVERED ?
 		"Recovered" : "Not recovered");
-- 
2.23.0

