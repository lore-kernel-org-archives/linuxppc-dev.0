Return-Path: <SRS0=FJcg=WK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A31C433FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 08:27:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C45820843
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 08:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="FqMXxIMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C45820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467jP65W5wzDqpK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 18:27:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.b="FqMXxIMa"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467jLs1jsRzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 18:25:06 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id m9so50234676pls.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0rpKBQceBN5zUsdD9UzIHV+FqR0WBSXrACuRfsl6/m0=;
 b=FqMXxIMaWexz3HrcdGtlBPLcFDGrIT4cGYTE4MI4krIWAVRts2whuO4aprJZMIbiuw
 WY78HMken3awwYL1twwiHfaR9BkXo8CJ7FwqDfw/mUAXDvixoWoksBgnaJR2V8i8X3QW
 PaL37g5F65Jybuxno/dYXm0dNYa68jhNeG11NXMUZPCSLvZXwwabcpNaHMjMRdNuqYQB
 ndWQHac4OPiWEgHUqkV4zmcQpIMqzFs7F1xxfJDZW2E5OVfSQqpH2DIECqCsZnqfbsNB
 aAzpT/8nEq2AK+CJWChOzWtOnLPM75bpXgRW0FKUsaQaZdHmUBF6kuBcm8ahcuIQY8p1
 ToHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0rpKBQceBN5zUsdD9UzIHV+FqR0WBSXrACuRfsl6/m0=;
 b=Am0V2wNvsSE2xq18vN1AVBu8v0Gsm9YecnC/UUDeJk6yvZkVcghW6jBgSN3aStIxay
 ulN29H0zcFemxkz0noTTKeHsebyRQLs6LcHwkRyt8iYemh7oWut845x8C5OrWew8qw5q
 DFcHHKStjHiKlhpxdyod8YAlCyD1KWlAw7JwgHK8NGTtcgjtGBkWUDXMTFbJvuvHDUJ2
 geoD8jhzudX+LqpZGebRXksk0Tx/jfRnKb19iyiOeJ1OElm1L1D50ul+qx/g0M98x7GD
 kgdQDB1+0iQW6DeuRFHNBVJPHs5psG8DKZTYWzrtb4iXeGd3tCEc382kUzWuiBEMLQlM
 Tmiw==
X-Gm-Message-State: APjAAAVvHoxza9t8lMDUKOWTUsNzccGOEWjOQZImq25pQWmK72cZl3ay
 3JI3kkpiXTdyfOM2KoAZoGIVGVcTTG8=
X-Google-Smtp-Source: APXvYqxSXvuWsbaBOqxrxTh6yDbkfkaYxwEBLvEBLRfCNnO+i5aWd4ImhamuN7JmxU8pX2U8CNUZuQ==
X-Received: by 2002:a17:902:9689:: with SMTP id
 n9mr42285411plp.241.1565771103154; 
 Wed, 14 Aug 2019 01:25:03 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.76])
 by smtp.gmail.com with ESMTPSA id y194sm124672463pfg.116.2019.08.14.01.25.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 01:25:02 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/3] Add bad pmem bad blocks to bad range
Date: Wed, 14 Aug 2019 13:54:49 +0530
Message-Id: <20190814082452.28013-1-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Chandan Rajendra <chandan@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series, which should be based on top of the still un-merged
"powerpc: implement machine check safe memcpy" series, adds support
to add the bad blocks which generated an MCE to the NVDIMM bad blocks.
The next access of the same memory will be blocked by the NVDIMM layer
itself.

Santosh Sivaraj (3):
  powerpc/mce: Add MCE notification chain
  of_pmem: Add memory ranges which took a mce to bad range
  papr/scm: Add bad memory ranges to nvdimm bad ranges

 arch/powerpc/include/asm/mce.h            |   3 +
 arch/powerpc/kernel/mce.c                 |  15 +++
 arch/powerpc/platforms/pseries/papr_scm.c |  65 ++++++++++++
 drivers/nvdimm/of_pmem.c                  | 122 ++++++++++++++++++----
 4 files changed, 186 insertions(+), 19 deletions(-)

-- 
2.21.0

