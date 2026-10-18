Return-Path: <linuxppc-dev+bounces-29652-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEEFCCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:50:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70RF4gwmz30Ng;
	Mon, 19 Oct 2026 00:49:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331385;
	cv=none; b=M3QUXi4P4zOuyUm+eoUb6FEYkyH03IoRsyES2B/06cUiAa/2nhW2/g4u4KMo5PLx5cQOsR/ubFad9KeJMeHeSOpE1rdSBjNidEXUpM/f+E/FH7KMpDF/xQsiMA5Xg6ZzoSDXw+TAeQEKFamO4xB4Db8WY0OKaS9HvcB4AY+kJInSwWsV+NYSwnrIB9LJluLzvrpj6qDjh5Dbf1q2nqL24ELGD9NP8N5PAxgThyYXen7NYTFrHysqbBNZ6rwEGFITwbZUgRy7QXd5rNkaV05V3QjXgE/S8p9i+fGvyAzZL1SPalai0CrW1T8z0ZrkFYoeeIPg4Ebus2X0YcznRp50xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331385; c=relaxed/relaxed;
	bh=vELiqmiLg0My2qE0CYP1TlLdsSmoEcWN2hANkQsUo3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfjYMZM/Q8xQ62Kv/gnHEb/Z+1+t9aPz4qiJPiNLvWJFc4oGHQ3SvmJSro142WKcMmRqHXbPcBj/Qz3J7sZ9vOyvvRajAPWwuotHRkuFpGBd3jlQHBDSU+0LvSIBpXVZZUBXIFOSx8YTsc9Uqa3AcMh3gkn/sZrz78bUZL0w6K/LN8ysStmOabeBkpgmjmX7hUMxlz3YiQ2VhcA5UDX0H1IDxLFUl/vlvUrMS5F0e/mlRx/u3nZ+7OX/NGxmOp5QDx/PXRRnqDep+/5Mj/TQcKgHuidkyrDRp5QYY6X2FCintl/da7xulQ4Nt9XJ1RTc6iwfXiCsBPyx6VrK5fqilQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ki1/TKwc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ki1/TKwc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70RD2xmNz30B0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:44 +1100 (AEDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-c4086e892a4so151693766b.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331381; x=1792936181; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vELiqmiLg0My2qE0CYP1TlLdsSmoEcWN2hANkQsUo3o=;
        b=ki1/TKwcIfYLGmdkhNswI0liHSakw7IaueyIfKHmwbXqXI3KfSFrObCEecbg6lNuV4
         xliicMzMxc+yKz6x9sSOYBtwYrLCdBSi0E5U21BNlbVlp2YOKH3y5Kj/K+OqQq/f94Yv
         9WUAssZ2nkIQ8TRXkQq8qPPCdDGILEmw4maYLEEJlisZ32PV/Itp+XbJ6wVTdhBUUUQC
         8Po6Vq0fkgHIYyv+q2xNnTKy3wkf0PuHQGBEyWhq0rWaGap6kyJYTQYgrLYO9G3hTuQz
         KkUU2JHb1sM2zFvJ1bzZpt8LL7ir6McdZRwVs76zVdICm5R2pyNTI8NAv4P0MG2dv9sO
         PHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331381; x=1792936181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vELiqmiLg0My2qE0CYP1TlLdsSmoEcWN2hANkQsUo3o=;
        b=iypLClh7yKyQAxc5N+WuvvQYYlepR0Kx8bIzVmb5N1ayadoqaxl98Th1j3QEWmqD/F
         6wcRbxTLHfR+n7gVkMjk6g1AQiP5XZuzwRyEfZGN0RypI+bHT07Gefi7+sw4UEicV3oq
         lFE44t0RrqtW/+eT1Vq81gTy7r1S6KWNY47GvhmtCSFMWxOp2WdkWGP0YbRHGlUENcpk
         lLMzARFGS1So6Aw60mwROoLn7tUF6V/Jg1fdAy0fhLOMV1/1bJVpVZoOq7d7ft2c+FOo
         U4NOjrXdX70JXzfe2CRZiaJPs8SEZCjFcgx1i04+H3cSLR1d8RbE4AsYhtLFy4Md/r7x
         rSeg==
X-Forwarded-Encrypted: i=1; AKwUvBx1ExoitMv28Xwao0OWBZoewYiu+Ozjr/2JJeG0lWozSjN52TGOVrHKTVevbVH/ALOeHt9/iZNOQrymt0c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIIIkudhWTQETQh2eAZccMXUtyALxCYccL/TGrn1433R3QY/2cl
	2kfRePM5HHZUbUJsPyu5ClrQYKgNPzN89LozurI5+NswhzGRywZhpHrL
X-Gm-Gg: AYBFou38rJLr6QNdpQwpywnyqgELvS96dfLREtIpiHc0YowEXJF4Bfdq8WvnlEktwK6
	oqfNhj6JEoGabjBTMgdFxHXUouF9Y5tZlGCzznw8BYb7KBqimy3BZxlQlyEV39bz0f/cbHxAnmO
	3EOnTcEGGYNMRLMLv3JrMxkw+i8kt4eJEGVXlM9p1k8S6+VWxlF1Ny8IXelVAwVKHr0WredVJtF
	nGdtVV0sd9knbuk51a5EhQq6R1jE83Ov/zRerNs/fhn5wfDh0z9W3P6sirZjs5gK9Yqzp2G8fTx
	oNhfN30B209C9vRU9zMoQ3MU7nw0dVINLX/Bvw0Ao+QYJQZUlidD8nt/8PVfmjViyq6GpaJrDoM
	h7tY2MiO1Grpj+VgOYLJ7SBdPvYaZgTIZRjEbWv9iU9iQnUHrlE2rBRhsNuVNXa3DORGyB+TcY0
	KDunP6FtexHOU2BFN6ujsx5hrhK3UMUaV//6B/Y/jckCbEdQs6PRYbDeqvwB9XjXxduUM8GOspN
	Lk+glX2jLAPb44lHCRTACDIyQVlNi5NbGELj4uR
X-Received: by 2002:a17:907:3fa0:b0:c40:c6c8:6bd8 with SMTP id a640c23a62f3a-c419e838694mr368578466b.20.1792331380945;
        Sun, 18 Oct 2026 06:49:40 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:40 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 06/10] sparc64: retain the DMA segment start across SG entries
Date: Sun, 18 Oct 2026 15:45:08 +0200
Message-ID: <20261018134738.1016106-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SG mapping loops reset out_entry to zero for each input entry.
When extending an output segment, the boundary check therefore tests
entry zero instead of the segment's actual starting IOMMU entry.
Adjacent allocations can be merged across a device segment boundary.

Keep out_entry for the lifetime of the mapping loop and update it only
when starting an output segment, in both sun4u and sun4v.

Fixes: f08802572965 ("sparc64: add the segment boundary checking to IOMMUs while merging SG entries")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/iommu.c     | 4 ++--
 arch/sparc/kernel/pci_sun4v.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 7613ab0ffb89..a23105b64fb9 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -451,7 +451,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 	int outcount, incount, i;
 	struct strbuf *strbuf;
 	struct iommu *iommu;
-	unsigned long base_shift;
+	unsigned long base_shift, out_entry = 0;
 
 	BUG_ON(direction == DMA_NONE);
 
@@ -485,7 +485,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 	seg_boundary_size = dma_get_seg_boundary_nr_pages(dev, IO_PAGE_SHIFT);
 	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
-		unsigned long paddr, npages, entry, out_entry = 0, slen;
+		unsigned long paddr, npages, entry, slen;
 		iopte_t *base;
 
 		slen = s->length;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 61f14b4c8f90..22584c4de973 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -489,7 +489,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	struct atu *atu;
 	struct iommu_map_table *tbl;
 	u64 mask;
-	unsigned long base_shift;
+	unsigned long base_shift, out_entry = 0;
 	long err;
 
 	BUG_ON(direction == DMA_NONE);
@@ -530,7 +530,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	base_shift = tbl->table_map_base >> IO_PAGE_SHIFT;
 
 	for_each_sg(sglist, s, nelems, i) {
-		unsigned long paddr, npages, entry, out_entry = 0, slen;
+		unsigned long paddr, npages, entry, slen;
 
 		slen = s->length;
 		/* Sanity check */
-- 
2.43.0


