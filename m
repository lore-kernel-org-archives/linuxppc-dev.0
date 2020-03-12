Return-Path: <SRS0=LwoU=45=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68794C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2020 14:01:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A4320663
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2020 14:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="CClqHLwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A4320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48dVqm0BnSzDr44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2020 01:01:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=CClqHLwq; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48dV5W2P2jzDqNR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2020 00:28:31 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id b1so3080948pgm.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2020 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ceobO9udD14LrQZbpBJ6o1PQGbHK97VsLgC6qxhMQAM=;
 b=CClqHLwq/2JiI5Z8INqms9RzXBNoQKXNgFe5NSeNFs/3HbKL/gkSJn9AnIUGBSagnm
 6G6AZ9qyWwQTx56eX9A2hizNqDE3fTdSSrEnG5KXkmwhoM/LHeitleT4237iSpEaVMli
 R8JHuBnDG0a5ffIHDOPi412aHkkPkMERdKR3N2wlb0SFhXuIaDO47mWOM+snwniuRIEg
 Fcoi+KQlyqXIyPXGM5tjumwI+FHNKL9nNC8489rl0bcgcHm1OT54lBa6XLuAGSzoQiOI
 obLUcPT8gNbRq+eD7+9lYaAGmMuMr47lR7EvyQqTB8mHOHIxS8GQUwnJmSNnCD/TC8xf
 QupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ceobO9udD14LrQZbpBJ6o1PQGbHK97VsLgC6qxhMQAM=;
 b=D6LLC2cE3K97adKvOKXeLQh48wZfG6q8vlYDsmeWjaXHLKC2ZKWtC5TITK8jkAQFlV
 YLj/Rs3w6syh6oG1eJMHcXXic6/NevrbKmzwhoSpHrJmBtNEedk+J4Bz2qUHBlwocWv/
 OjJWIs3AhPWPWq7s26vvEhmCDtWz84RJWQhEQEWs8I/ittpVL8hNq6h95OBW1+Falcnw
 CcxXJE7CYIJ+gc8M6WHjLNQsWm9n/HBltLIbEyYZkrmvFG0pYB+k/QkPCbUYhZa0xdsD
 BAeNXGsgBDG3MWQdqVvAChySJLFS59cHv16v9nQ5g31yMw84q+wGez8wqTVn7owZboCZ
 vQiA==
X-Gm-Message-State: ANhLgQ2AXhKiazoqZZAuDm3qS5bMTH69VBOEnDA8TUAI5j0GU7nwQSyc
 5hKSgaD8X6GWiIERoeLkofW9kA==
X-Google-Smtp-Source: ADFU+vsUCc8IglJOZc1JplgZ66GG8uaBvrcHlGnViNOlSTYDkiUPzaaN1tMozhOpYCNGdSM3kEcqvg==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr7779986pgi.259.1584019708733; 
 Thu, 12 Mar 2020 06:28:28 -0700 (PDT)
Received: from santosiv.in.ibm.com ([111.125.206.208])
 by smtp.gmail.com with ESMTPSA id w206sm13007435pfc.54.2020.03.12.06.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 06:28:26 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: <stable@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3 6/6] asm-generic/tlb: avoid potential double flush
Date: Thu, 12 Mar 2020 18:57:40 +0530
Message-Id: <20200312132740.225241-7-santosh@fossix.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312132740.225241-1-santosh@fossix.org>
References: <20200312132740.225241-1-santosh@fossix.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Greg KH <greg@kroah.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Peter Zijlstra <peterz@infradead.org>

commit 0758cd8304942292e95a0f750c374533db378b32 upstream.

Aneesh reported that:

	tlb_flush_mmu()
	  tlb_flush_mmu_tlbonly()
	    tlb_flush()			<-- #1
	  tlb_flush_mmu_free()
	    tlb_table_flush()
	      tlb_table_invalidate()
		tlb_flush_mmu_tlbonly()
		  tlb_flush()		<-- #2

does two TLBIs when tlb->fullmm, because __tlb_reset_range() will not
clear tlb->end in that case.

Observe that any caller to __tlb_adjust_range() also sets at least one of
the tlb->freed_tables || tlb->cleared_p* bits, and those are
unconditionally cleared by __tlb_reset_range().

Change the condition for actually issuing TLBI to having one of those bits
set, as opposed to having tlb->end != 0.

Link: http://lkml.kernel.org/r/20200116064531.483522-4-aneesh.kumar@linux.ibm.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: <stable@vger.kernel.org>  # 4.19
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
[santosh: backported to 4.19 stable]
---
 include/asm-generic/tlb.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 19934cdd143e..427a70c56ddd 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -179,7 +179,12 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
-	if (!tlb->end)
+	/*
+	 * Anything calling __tlb_adjust_range() also sets at least one of
+	 * these bits.
+	 */
+	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
+	      tlb->cleared_puds || tlb->cleared_p4ds))
 		return;
 
 	tlb_flush(tlb);
-- 
2.24.1

