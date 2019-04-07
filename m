Return-Path: <SRS0=YAae=SJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C6FC282DC
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 02:50:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5884F2171F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 02:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nKgj/rIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5884F2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cJ1c6f4DzDqRv
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 12:49:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::843; helo=mail-qt1-x843.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="nKgj/rIy"; 
 dkim-atps=neutral
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cHzz0sHFzDqN1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2019 12:48:30 +1000 (AEST)
Received: by mail-qt1-x843.google.com with SMTP id k14so11782179qtb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Apr 2019 19:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=yoXaJd9GtyVb62iXK+1ZtlbVF87kudQErpNUHAHDV6o=;
 b=nKgj/rIy9AEfu1vgeU+PNKyTrZCXSZtRRL29yKv/PbvtGYgjSFf1hF75LO2q1dTSHy
 dMHWVcynyQ2ipzCqdfG9r4NdZmEz3C9JLUfmSDu7iRbOvo6tn8xNPZJani3NJRAwbaeo
 VT3DVfXf26bFfx3tuRUnHPy6AFGWw6j96O4e73g3YluK74ll83a+duslTX8hqtc1D8ZR
 XpeRxv+zpMs9sPO0GmMwvf9sLHzzNafMTIoXl5Jjy3E+ap8waUW+3A1joRiYlguqovC2
 HFgMDaWZNh6t7ekNw4mioIphMUu9BetmujKjqhmz1siVSk2l7Dy5xWW6Dc7u2xTjCmUI
 XcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yoXaJd9GtyVb62iXK+1ZtlbVF87kudQErpNUHAHDV6o=;
 b=UzLVzJ4j9h88WUnE+H1tlRPIQb9Fu7MaGm6hBdSf/7IRvpk64sHXpugFa2yvSqNf/7
 jGBcg8CPuD2cNFB9gS8npUthtj5Dctlw4o0j++8P1zeFV4DIwzfPpvvAHH5mphjgOWH7
 sybqr36az1dBonLUZShXHeb1oFm4KKxcaQ7OfrbFsWz3lkjaMhYF6Z3PgnNFlSwoBNxa
 ikzfVqk4YUF5bhA1rJafuz5vOJurO9UoaCQbh2/N9WC13828jkm++7bRyg6MjI6xqTfx
 ch6ksgNxHjQXbzJO/oWOtah7a8i3SZ0+mhcAZNunQL8f32csEYXL+SM6LPy4H9Y5Ski3
 KaNQ==
X-Gm-Message-State: APjAAAUhbnMpdMpaNepQRnbAYVlK1Eo3Ua1ZPWdEYdxmWW+aQMl4bbOY
 dk30JPAqmG9DAWn8U2yHg+II0Q==
X-Google-Smtp-Source: APXvYqyKUeQhF6XU6NOUvDCpi7hTu0SOL9uEt/kfbvgwe/8VEwLxy0OtaEijpTeupK9aQAk0BlZ6Bw==
X-Received: by 2002:ac8:1c2c:: with SMTP id a41mr18860953qtk.292.1554605308165; 
 Sat, 06 Apr 2019 19:48:28 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id s50sm17743028qts.39.2019.04.06.19.48.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 06 Apr 2019 19:48:27 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org,
	paulus@samba.org
Subject: [PATCH] powerpc/pseries/iommu: fix set but not used values
Date: Sat,  6 Apr 2019 22:48:08 -0400
Message-Id: <20190407024808.39821-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
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
Cc: aik@ozlabs.ru, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The commit b7d6bf4fdd47 ("powerpc/pseries/pci: Remove obsolete SW
invalidate") left 2 variables unused.

arch/powerpc/platforms/pseries/iommu.c: In function 'tce_build_pSeries':
arch/powerpc/platforms/pseries/iommu.c:108:17: warning: variable 'tces'
set but not used [-Wunused-but-set-variable]
  __be64 *tcep, *tces;
                 ^~~~
arch/powerpc/platforms/pseries/iommu.c: In function 'tce_free_pSeries':
arch/powerpc/platforms/pseries/iommu.c:132:17: warning: variable 'tces'
set but not used [-Wunused-but-set-variable]
  __be64 *tcep, *tces;
                 ^~~~

Also, the commit 68c0449ea16d ("powerpc/pseries/iommu: Use memory@ nodes
in max RAM address calculation") set "ranges" in
ddw_memory_hotplug_max() but never use it.

arch/powerpc/platforms/pseries/iommu.c: In function
'ddw_memory_hotplug_max':
arch/powerpc/platforms/pseries/iommu.c:948:7: warning: variable 'ranges'
set but not used [-Wunused-but-set-variable]
   int ranges, n_mem_addr_cells, n_mem_size_cells, len;
       ^~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/pseries/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 36eb1ddbac69..03bbb299320e 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -105,7 +105,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      unsigned long attrs)
 {
 	u64 proto_tce;
-	__be64 *tcep, *tces;
+	__be64 *tcep;
 	u64 rpn;
 
 	proto_tce = TCE_PCI_READ; // Read allowed
@@ -113,7 +113,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
 
-	tces = tcep = ((__be64 *)tbl->it_base) + index;
+	tcep = ((__be64 *)tbl->it_base) + index;
 
 	while (npages--) {
 		/* can't move this out since we might cross MEMBLOCK boundary */
@@ -129,9 +129,9 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 
 static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
 {
-	__be64 *tcep, *tces;
+	__be64 *tcep;
 
-	tces = tcep = ((__be64 *)tbl->it_base) + index;
+	tcep = ((__be64 *)tbl->it_base) + index;
 
 	while (npages--)
 		*(tcep++) = 0;
@@ -945,7 +945,7 @@ static phys_addr_t ddw_memory_hotplug_max(void)
 
 	for_each_node_by_type(memory, "memory") {
 		unsigned long start, size;
-		int ranges, n_mem_addr_cells, n_mem_size_cells, len;
+		int n_mem_addr_cells, n_mem_size_cells, len;
 		const __be32 *memcell_buf;
 
 		memcell_buf = of_get_property(memory, "reg", &len);
@@ -955,9 +955,6 @@ static phys_addr_t ddw_memory_hotplug_max(void)
 		n_mem_addr_cells = of_n_addr_cells(memory);
 		n_mem_size_cells = of_n_size_cells(memory);
 
-		/* ranges in cell */
-		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
-
 		start = of_read_number(memcell_buf, n_mem_addr_cells);
 		memcell_buf += n_mem_addr_cells;
 		size = of_read_number(memcell_buf, n_mem_size_cells);
-- 
2.17.2 (Apple Git-113)

