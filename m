Return-Path: <SRS0=EWdz=HJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04159C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Feb 2021 16:14:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA1664E15
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Feb 2021 16:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA1664E15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DYZ416sCRzDvW4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Feb 2021 03:14:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+661ee30cee4f8a507613+6377+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=PBdwbGIJ; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DYYyT52dTzDsVV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2021 03:09:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=tHBexmHGDU8sjj38AZ8OoEmgptCGTXSoPlkiz2alw+s=; b=PBdwbGIJlKrg+agS8u5um5z3+E
 lRbcNlTzG3ntexPbto0mi2062ImrpQVKR3XGI4/cKR3mfaGRiJgDHdqMFG0mP1KLhbe2zWELau6xh
 YOi37Sez5qoaovImrcBXFeSYI28UxhVa7x6E+3aB/UaioGgM4KIS8iunU4KBsKMISwsyXxkncv/EY
 ltEqLzdq2KfRLnJTlX6hBx+PgpoKnaxT0DPfw5Cg0VXBcqnxvcAYaken/jlwA5MX8p28MsZpw1aey
 uebkJGJud2BW7OZYmg4y//+8KPP9MHqx0t9vTK7eomCKEuKDWTNHRowqZmVS/2c7Yhr8Mk8ky1CZU
 OASFkWow==;
Received: from [2001:4bb8:184:7d04:4590:5583:6cb7:77c7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l8md5-004tmP-JA; Sun, 07 Feb 2021 16:09:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4/8] xen-swiotlb: remove xen_set_nslabs
Date: Sun,  7 Feb 2021 17:09:30 +0100
Message-Id: <20210207160934.2955931-5-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210207160934.2955931-1-hch@lst.de>
References: <20210207160934.2955931-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 Claire Chang <tientzu@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The xen_set_nslabs function is a little weird, as it has just one
caller, that caller passes a global variable as the argument,
which is then overriden in the function and a derivative of it
returned.  Just add a cpp symbol for the default size using a readable
constant and open code the remaining three lines in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 4298f74a083985..57f8d5fadc1fcd 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -138,16 +138,6 @@ xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 	} while (i < nslabs);
 	return 0;
 }
-static unsigned long xen_set_nslabs(unsigned long nr_tbl)
-{
-	if (!nr_tbl) {
-		xen_io_tlb_nslabs = (64 * 1024 * 1024 >> IO_TLB_SHIFT);
-		xen_io_tlb_nslabs = ALIGN(xen_io_tlb_nslabs, IO_TLB_SEGSIZE);
-	} else
-		xen_io_tlb_nslabs = nr_tbl;
-
-	return xen_io_tlb_nslabs << IO_TLB_SHIFT;
-}
 
 enum xen_swiotlb_err {
 	XEN_SWIOTLB_UNKNOWN = 0,
@@ -170,6 +160,9 @@ static const char *xen_swiotlb_error(enum xen_swiotlb_err err)
 	}
 	return "";
 }
+
+#define DEFAULT_NSLABS		ALIGN(SZ_64M >> IO_TLB_SHIFT, IO_TLB_SEGSIZE)
+
 int __ref xen_swiotlb_init(int verbose, bool early)
 {
 	unsigned long bytes, order;
@@ -179,8 +172,10 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 
 	xen_io_tlb_nslabs = swiotlb_nr_tbl();
 retry:
-	bytes = xen_set_nslabs(xen_io_tlb_nslabs);
-	order = get_order(xen_io_tlb_nslabs << IO_TLB_SHIFT);
+	if (!xen_io_tlb_nslabs)
+		xen_io_tlb_nslabs = DEFAULT_NSLABS;
+	bytes = xen_io_tlb_nslabs << IO_TLB_SHIFT;
+	order = get_order(bytes);
 
 	/*
 	 * IO TLB memory already allocated. Just use it.
-- 
2.29.2

