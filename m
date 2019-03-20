Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45807C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 05:15:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B940C2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 05:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B940C2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PJ5g6MkkzDqJR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 16:15:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.210.195; helo=mail-pf1-f195.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PHzS2dSqzDqH5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 16:09:56 +1100 (AEDT)
Received: by mail-pf1-f195.google.com with SMTP id a3so999536pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NzF2lox56cCw7G7V/HuQAT3g3XyLKaDXps4ZB1oA+bc=;
 b=mHSM6/8yboQHw7Cn2VzGWze1hPrN7+6FiC276jxlbCx9RMqVwLXmhtld9uLaGgOvP7
 pbYaXZoH2CbH2KIk+TyZKtTwi6RexL1wZb6rrWqte3PndoFkMas1VegLG5JaPIO9h9RY
 60NpDPfxkBVe1DlRrN6BfSJIt60M0tvs7AdklxatOqDVb7sWrl/sFRXm8MXsotmxQ3jI
 ZhmbZlHIJZU3UEJCqVpt5QJqBJOVtFV783AQCIlj+5ZkNW42OvmVO9Y34/DSEPyJW8JA
 rfzLcPThhbviBAx6FkAmNh+kFmbF3OpvX3CgFxE8swUoisVcK1+4RDpzMPsr7tvWrt3Y
 Pq2g==
X-Gm-Message-State: APjAAAWbdxGcks55porsYAQfDf6MhvC5T1/r55lK1N8gAgjzDJlMhsb0
 QzttU76ADoOF8bOMxPZqlPr0Ig==
X-Google-Smtp-Source: APXvYqz11gH+I/P5+wWWISa5BJ9kL4DjJeRovWcoEtWVrZ9t7h0ul+/Pcy/JsXGCFXwgldP+Gz6FQg==
X-Received: by 2002:a17:902:7b93:: with SMTP id
 w19mr5881676pll.141.1553058594147; 
 Tue, 19 Mar 2019 22:09:54 -0700 (PDT)
Received: from localhost ([122.177.144.121])
 by smtp.gmail.com with ESMTPSA id t10sm1470971pgo.27.2019.03.19.22.09.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Mar 2019 22:09:53 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Documentation/vmcoreinfo: Add documentation for
 'MAX_PHYSMEM_BITS'
Date: Wed, 20 Mar 2019 10:39:34 +0530
Message-Id: <1553058574-18606-4-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
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
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, bhsharma@redhat.com, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, James Morse <james.morse@arm.com>,
 linux-arm-kernel@lists.infradead.org, Boris Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com,
 Dave Anderson <anderson@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add documentation for 'MAX_PHYSMEM_BITS' variable being added to
vmcoreinfo.

'MAX_PHYSMEM_BITS' defines the maximum supported physical address
space memory.

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/kdump/vmcoreinfo.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/kdump/vmcoreinfo.txt b/Documentation/kdump/vmcoreinfo.txt
index bb94a4bd597a..f5a11388dc49 100644
--- a/Documentation/kdump/vmcoreinfo.txt
+++ b/Documentation/kdump/vmcoreinfo.txt
@@ -95,6 +95,11 @@ It exists in the sparse memory mapping model, and it is also somewhat
 similar to the mem_map variable, both of them are used to translate an
 address.
 
+MAX_PHYSMEM_BITS
+----------------
+
+Defines the maximum supported physical address space memory.
+
 page
 ----
 
-- 
2.7.4

