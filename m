Return-Path: <linuxppc-dev+bounces-28774-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630CDCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:48:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxK8B0pjXz30Qv;
	Sat, 03 Oct 2026 05:48:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790970490;
	cv=none; b=UbVqQK569zsF9i8qcgEBys93CZXTa2XnA+0PRnx5g0RQQCQAdIOx96JsH+w6zBygD9/C1BlLC7m8wFURlw1DEKEDMcmMy8dNRBz9J/Z6P0jBrzIXndAFssfhAokZCLVIfrYbRpazQY5qYR78G76HyDVSjQa6RyiZ2QLLxD+6WlT7xM3BRDEcS63iu/90HCBdhmtNA2lS9jyuQ6U11/ECj5Q1nqlwS9oaufy++8U/1jmyhAJjKXzsBqMxjotm89ETioEj7/G/Nxl96dLKqVC4tHXaKW8V9G6bmrE7bACanHbWclWIpRk++yBBa4qsZmFSLEONhj6yBzQ2J0p+r/xyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790970490; c=relaxed/relaxed;
	bh=doS8d5OZpw1xxXeF9uWp+A9weIfqE/dyEXBrkjrl1wA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzcIhXKcYltC+U0Lb76UXcTxUxbbxVA9f1Cgvi6dg5mz+zmxFL82LSAL26DuuRS/F9Xf9ouXQtgbOxe/mmTXojuiCJ4dnLJKlWbgzVe13vszQLSZB6XkU1G+K5LzbUuWYi4Pl8GImiFZpwYErlnB6vOViMLdfAfuNVZSB+ljy6br0ErkAGplGaDei+IoH99cAehLBSZVL5SgL/OpXgXSOcXSlNtviMgPomM+g9+PA17iHVHcGtOvDRsRZxkCjt49Ke7ZVeVmamrBbUW0CJN/VcFiZMumE8Ef46sQbjm2wjycF13GQIVs8NXuINbE6lwPoNEOzaN2OHTp0oyeT3ctzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ANvTx+88; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ANvTx+88;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxK892fcjz30DK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 05:48:09 +1000 (AEST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-917a2800e83so875646d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970486; x=1791575286; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=doS8d5OZpw1xxXeF9uWp+A9weIfqE/dyEXBrkjrl1wA=;
        b=ANvTx+88FMw5L/f61S56ws6hcl0JoDlJ8FwUd4YlLDU9cb7/ufIvPkrohVAkEIxA8j
         zcAyz28pKLCxuCrDrJ+/32u7gYnSNiXr/n9cedGMpEC2Tt5HD5vV6oC3cjSjC2N9plyK
         FJte1LNG14QbzCBRZDD+GvdD6QNtw8rCQJBxRa15EUEuupzgXli80OTVa32sQF0Apbql
         Po0HFwGXhc7UDQnc2P+6bK3/uIbFUGQ4xqB8Ov+vmzJLTHz/AkjPRdvTW8QNbGTpSvDo
         1/rhqjcQZaQx384+Om2A6Jx+Gpa3Hbkdal9k3bTcF0EkP0hS6iJCV48EmR2GdyXAtS1g
         ZGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970486; x=1791575286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=doS8d5OZpw1xxXeF9uWp+A9weIfqE/dyEXBrkjrl1wA=;
        b=M9aO96d8Yz2JHDZ99D2m14YgZAIR7ev6VzlydJv41BLAX6O2NMCJQODlunK/bD1+O/
         09Kzs7Tl0cPYPPmsyeLMg3WzKPivcEVVqNKH5sQT7bQu6SZl01yT0WFlXBlffwUXIlii
         vZJs7vodrTfURmEwlWnCYhhYG0e/imrvX9makcpXq4iCwG6UxXmdg6t1EyLxkdwhOFGj
         6ovjfpbfDuH504xlCot2dAAYZly/7U5ojldrMFINSynZHRUJed0NZbq/S5bAKN7SLpd8
         oruxL7GiDScn9BTh70btgK/9WrFeKHOeZ1Kheyp0pD6WNYGkDuIuVA/iMaFpwrKWPikM
         d2hg==
X-Forwarded-Encrypted: i=1; AKwUvBwHZKuwGhNa7PkYP4YiB+yUm6NsU3sSUHRT32nK882x6cb6/E8WyZPIc8ZEAReinvyaTCvwPxUgkKcPNLw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lrKo9hVAprc6fbK06T8487q960EaZJaMRLe37hXksW+JpY0SqQ
	KSr22wjAyOBnwXAitgjYMhnhaOMBedMafUfFHJcT9QIUJpjOMQn8wuY=
X-Gm-Gg: AYBFou1EX4f6FZy0ByUNT9eWPmZcGCp7s+/ltuWaXhTYMHIjSCvdkPnst9ubbwq0hYy
	GqNmIWIoDbO89kQ/r4zadCuj4c7B1sT5nhxmEZX8JrsN4R08wz7XRmKbQhAqvZe9jKd39mbFr3M
	adFVAzRT6A00vzmWfFzAgFc5nBLCoROo0tCGRtcCnnn1DGIbP6HEib0XZQWgb/wV6wa1ksH/xOi
	tvXAn756HONl1+fgbT8aNInb8qLdHsDYctKOXt+/cgjr0zVuun3odTnpX/DMkfkqDztWiNZXx1r
	BdmHADkMMkTOX7yH0QKFqi+CmnhRhdFyd0CgTAoDHYtqbRCg0I9bIDPqh3UtT0aT09hCsIUZkaZ
	ybEwpl4lLAlXTPcS5EEWD+9+SKFCoEKRsMctHNjSy1R3IoHg9v5zku9JLDtRRaBIvssi0UGtKKG
	jXlCy46zaZdr9UNtqvnbaN4twbd8Fb+Ej/iPo0Eq8moNxI3/d94R9jenZxcR4FBkvlXQx6TVuFt
	2c71SDQQiJVX1RTbf8gj6hbUVU3vIiagYEFsjiylRuNSS7d3Idut+tK/ubN+e6dKlsxHLbrDGwr
	mJ2OYhF1/tadaI2DbRRnYpj52gpW
X-Received: by 2002:a05:620a:404c:b0:93c:b7f3:9f5b with SMTP id af79cd13be357-93e51081bbcmr76979085a.45.1790970486211;
        Fri, 02 Oct 2026 12:48:06 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2ed5e2sm296846985a.47.2026.10.02.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:48:05 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	mhun512@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] soc: fsl: dpio: Fix IRQ cleanup during probe and removal
Date: Fri,  2 Oct 2026 15:48:00 -0400
Message-ID: <20261002194802.375497-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series fixes two DPIO I/O object lifetime issues during probe
failure and device removal.

Patch 1 releases the I/O object when IRQ registration fails and removes
the unnecessary unregister call from the probe error path. Patch 2 frees
the managed IRQ before returning its resource to the MC pool and before
releasing the I/O object during removal.

Both patches carry their respective Fixes tags and are marked for stable
backporting. Patch 2 is based on patch 1, which removes the probe error
path call to unregister_dpio_irq_handlers() before that helper starts
freeing the managed IRQ.

Changes in v2:
- Present the two previously separate patches as a series.
- Remove the unnecessary unregister call from the probe error path, as
  suggested by Ioana Ciornei.
- Move devm_free_irq() into unregister_dpio_irq_handlers(), as suggested
  by Ioana Ciornei, to keep registration and unregistration in sync.
- Add Cc: stable@vger.kernel.org to both patches.

Based on Linux 7.3-rc3 (fd73f4a6659897191fa0d40695fe370925dd3780).

Myeonghun Pak (2):
  soc: fsl: dpio: Fix cleanup on IRQ registration failure
  soc: fsl: dpio: Free the IRQ before releasing the I/O object

 drivers/soc/fsl/dpio/dpio-driver.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.53.0


