Return-Path: <SRS0=ex+5=VV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C35C7618B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 08:49:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEB5227BF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 08:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4CBc+7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEB5227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tptF1ZlZzDqKt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 18:49:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q4CBc+7V"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tprC1hldzDqGN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2019 18:47:22 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id c14so21674431plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2019 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3tGfPDVejnwkWnCSlcWnnqbFggamsWGmMc5sXy1MHk=;
 b=Q4CBc+7VmcFulRnttG/sJQ9aN1lZVf3+XVKXxp7oJHleHkZoxFhLoiUNAmCbvVDy2d
 G9cD+bzYgBqSpM3FMowrZk7Zao8fjWTZgy0x0CyTWF4yrmO0MXWfxXmtEu7iEUD+xsGw
 2w8TeBp5R8zozpXtISR7AVkd7o0XqfYUASf2IqkpyvjSY+NXX5HHgyqekNeXasIYPbge
 sr1Ktrx43Aadu/87nelIw+ZHG/JPMwUD98EtZ281RJZ3+CNHTP4vuIJL1UtgQH+elXiv
 MIU/kssNuhODq2iyuVgeMK4HqiG6CjnRPRHCBr23HnxJsOX6UiCqMEdOYf7Rno70k6vM
 I3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3tGfPDVejnwkWnCSlcWnnqbFggamsWGmMc5sXy1MHk=;
 b=fvZaGp4+90xb+wS19HRV9A5541mLNLb/emORu1GTFEaVCxtVRu69p+PGxBpSMbAVBz
 uQQL7wA8ky7+uDWJpPlEAFxXz5g4AQWAE5fl85aS4eMq6jnLN+ip92C9uscaSIkuZJ90
 hnuDb3GGQAqb+qqh/ArcpWljlB+sZi50uQYU57e9XaNIVCB9napk+vJfxOCS+llR/oCK
 fNlLP6SuDoJk/2aRnvpCT1aTaI1cK5TJQA+Y/SBdhYPHxw5XGt/4uFHPYblX7Ut4Stdm
 LbxNTCe/UIjRTAD4QzK5VfP9waPSFaJDOxk/yxUoYNErXBlOsK3XTwFATvkE6oUemm/b
 3p3g==
X-Gm-Message-State: APjAAAWTOW9Qek6nVRIhtmGeXnGwkadGgk+SkAjkotPhQOeTrpEGmVxf
 EYpbHbeVwygeFO+Q5zBb+NXoOtBU
X-Google-Smtp-Source: APXvYqxzeDXN4VxSPM5Me/edo7k/zakNUefxtJ/V2rKbZWMOLoa49Kb7OzWbblDemaMW4pguuWbpqA==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr84077613plc.2.1563958040508; 
 Wed, 24 Jul 2019 01:47:20 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([220.240.251.33])
 by smtp.gmail.com with ESMTPSA id a3sm54286745pje.3.2019.07.24.01.47.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 01:47:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/64s/radix: Fix memory hotplug section page table
 creation
Date: Wed, 24 Jul 2019 18:46:34 +1000
Message-Id: <20190724084638.24982-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.22.0
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

create_physical_mapping expects physical addresses, but creating and
splitting these mappings after boot is supplying virtual (effective)
addresses. This can be irritated by booting with mem= to limit memory
then probing an unused physical memory range:

  echo <addr> > /sys/devices/system/memory/probe

This mostly works by accident, firstly because __va(__va(x)) == __va(x)
so the virtual address does not get corrupted. Secondly because pfn_pte
masks out the upper bits of the pfn beyond the physical address limit,
so a pfn constructed with a 0xc000000000000000 virtual linear address
will be masked back to the correct physical address in the pte.

Cc: Reza Arbab <arbab@linux.vnet.ibm.com>
Fixes: 6cc27341b21a8 ("powerpc/mm: add radix__create_section_mapping()")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index b4ca9e95e678..c5cc16ab1954 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -902,7 +902,7 @@ int __meminit radix__create_section_mapping(unsigned long start, unsigned long e
 		return -1;
 	}
 
-	return create_physical_mapping(start, end, nid);
+	return create_physical_mapping(__pa(start), __pa(end), nid);
 }
 
 int __meminit radix__remove_section_mapping(unsigned long start, unsigned long end)
-- 
2.22.0

