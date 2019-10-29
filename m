Return-Path: <SRS0=NKNt=YW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4432CA9EAE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 08:28:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EF520717
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 08:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjkBTnV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EF520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 472Pqd1v8MzF1g1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 19:28:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=saurav.girepunje@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sjkBTnV7"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 472Pj00fzszF1XC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2019 19:22:43 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id v5so7193781ply.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2019 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=zXO/8cyF+ovBR8syYWZ7NPcga9VHQrumYWTLb4MSqY0=;
 b=sjkBTnV7Guvfs+Z8OZf0gV7sHV3mo4ataXjg0YyLe1icOgl0DkniiSCNJ9V3IUcH7K
 fDFkRuE1KtzGNnXClFSVBF+ZRLIRakPwsg9U6BDigR98Z+IWEPxZk/AliCJA3zZtnTol
 8kBjbRKHAxRFUYThH6CB6iJooVE91bUhtoeXrlmF1XyBALfxMxtySwM58KldQDvWGmsq
 bz/fUqKhQCATsh7d23i3aPV79mnPqfTb8UJSVsiLWAqaXj0iip5f0KrKzFQvGFZALHGd
 D9o7WzTGcm0xcaoIsnnXIbJd/yVllqBCrCxhEid+ITY+3y9Lwrk2eXVYGyDhgwP9rh6V
 xI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=zXO/8cyF+ovBR8syYWZ7NPcga9VHQrumYWTLb4MSqY0=;
 b=L07YBkyrdJr/+CYnj/mfLkTHM+7ev9IKS3ETBNKFoNuXvOAyeDCtr3DHiQG4Z4DVU2
 l6aNGJPcRFy/0Y2w95tmb7qjh80aMU49S5YcPdRDKULZs1e3jtBsF1YAChy8Tsuprs7f
 xLVjFvvrj4lmssndkXzldlxtVu2eLwZR9l5/lfKWzKvdXgyRQJs9MPyCw6uggr8Pgcuf
 AccHbq3lYaD1hDSwEJzAw39RrPzRg58P0xx4o0lkXU9JPxCayGsu2TBbIpV2EK/LappO
 PHRNqXHgYmIlgGtrEHebwrZvymqiO7pgBQjfsfSXtqLlrUuY94YAtusfD3K8/XEoJnxw
 FuOA==
X-Gm-Message-State: APjAAAWABdqkFQnEkWAdUovjpRU58sAENSx79X/k4tGpQFfoWQT7Eekh
 2MW1r+VKPtcJsi105v9BhCw=
X-Google-Smtp-Source: APXvYqyx4LMCvmSv6QXJ6Ogdrxw4bFy8T8q1hPnjUl3fZmaGvH4aDCo3IRGLQ5KdvFJiL6INIU9xCA==
X-Received: by 2002:a17:902:7c07:: with SMTP id
 x7mr2717230pll.210.1572337359983; 
 Tue, 29 Oct 2019 01:22:39 -0700 (PDT)
Received: from saurav ([27.62.167.137])
 by smtp.gmail.com with ESMTPSA id c69sm11848071pga.69.2019.10.29.01.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 01:22:39 -0700 (PDT)
Date: Tue, 29 Oct 2019 13:52:16 +0530
From: Saurav Girepunje <saurav.girepunje@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 groug@kaod.org, clg@kaod.org, christophe.jaillet@wanadoo.fr,
 saurav.girepunje@gmail.com, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: sysdev: xive: Use true/false for bool type
Message-ID: <20191029082215.GA7160@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: saurav.girepunje@hotmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use true/false for bool return type in xive_spapr_cleanup_queue
function. issue found using coccicheck .

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 arch/powerpc/sysdev/xive/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 33c10749edec..74e3ffae0be6 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -533,7 +533,7 @@ static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *xc,
 static bool xive_spapr_match(struct device_node *node)
 {
 	/* Ignore cascaded controllers for the moment */
-	return 1;
+	return true;
 }
 
 #ifdef CONFIG_SMP
-- 
2.20.1

