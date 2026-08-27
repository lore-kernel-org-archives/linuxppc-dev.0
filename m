Return-Path: <linuxppc-dev+bounces-26146-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB5DC61DC2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:21:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVzc91c1hz2y2b;
	Thu, 27 Aug 2026 21:21:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787829689;
	cv=none; b=Z6chnrAcawbxVQuaBu/fLIxvAz+fpFX85lpyhwRRQw/UQFnHzCXk1g5aArws6XZGZ3SW5Neqo5BdQkj8+vxEDvS0zBH+j+GSGur/FfEtl0gFNmglZNEwXvIgmDJUefcnKMtRDJ0fDiwbsTieobTGBP2kJ7TZ0vyhUclaMLzRtOM0FVRW/HN4SUkwIiS4g7V4Zi9Zcq10B+pqrBkYU7vFCiNzMVj14qK/Xne6uEbB+oRA3F0YD4atT0KnmFG/j4aOV2Bk3opCLRsSBV2vnoaGt54lTiUwc9hQVRgAlqGO+pLyZd29Bk1Vj2A/JK9kO1XbZBMctwYqQ/m/exHb54fGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787829689; c=relaxed/relaxed;
	bh=6AQl5RP9TxXn81ZgXLlb05Y9y6XA1JA2H2ttGtX56P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3wOXey8BQExmXA4p3ODExGT8A4NvIomCoYc3P+yDtGZrc9fyGv4Ux7MaLJa+EaeMdVPqRwcKuOox9v8JZb3w6kmUBP4UDH9o6wHxBlBNqUk3wOwN3p140BeX35MJ5rMersVUNDhrPdWjAkS94EgUsgE6al0vOUW3OjRip4RbgFWriGGBtYRz5rKTQAFRZ2jUV0odaXmBHSpg6wNqyCTOAOVQ+iNr5od/HVthnF1EcCz0UudDNia9lTTi4nN66l+/VXkCuLqZ8WTiW0sjiIA+ywcE9/H01/WVNOsYWePwTRgILPPg7yo0CP9vOlgCHgyAWY8Ewnm2yWD3bG1VNQHDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SglKLgkw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=falakreyaz@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SglKLgkw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=falakreyaz@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVzc83Gm1z2y2L
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 21:21:28 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso686844a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787829686; x=1788434486; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AQl5RP9TxXn81ZgXLlb05Y9y6XA1JA2H2ttGtX56P8=;
        b=SglKLgkw+wDZcrXDphDed/FlwyWm4pRACHP0aohgepJ5Vqe/bu7mbqYS+AscLGkgnl
         4GBQ6753DvFw1QCqDwcDc6rQ7peBGMiLjgJVF7I/jADHrt/UYeA3FJ6D0tHW9oY4J4hu
         EZQC/0kSqh+ON2WkRuHP77HpGuPcMNh5QKjL+hcNn/D1sBrWFYwVMBIQSjbf0uc8rc5C
         kLnFdtobrkA9U9kHehV4lCcvuRgBlwES8c9wip0pPeizMvatE58toVKxOEZzOFHnKUiO
         Mgd2Uz4Vjs+N3neYvFt+0qkf/Jh8eBF9XB+wxdTT8lrS1xTt++C9FdN/90iIaVIkr8KI
         uyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787829686; x=1788434486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6AQl5RP9TxXn81ZgXLlb05Y9y6XA1JA2H2ttGtX56P8=;
        b=hY5iPQM0POsyHvjUJhC3lxIxVOTFGcxAK/lEnQgooGjITr/vORAM8mb5LbNdeLI/na
         6n2ZLYoNRxjcJyHBoUqptXBLka52q43L8vcOc6PbtBY9tsg1q5DQI9kXfk+TylBg+IGS
         yQ4S2My88Ki6bgh1CucZddoa/RAI0cC6wOVzSy3u8f7PkYzQPutP64E51SOkhjGWaT5J
         EYuWAwVJU+JcEmeBRCRQ7jXYVRH0ePihL23EsVxhasnqoqrvrPlkgUH/VhJDHfK+9rtj
         sUj9lwfmGKVanbLZMer0kb3u7wNQ52mgurI1wPBxsPYU/01dguppe/FJrz/MOEeMJYsF
         WI8w==
X-Forwarded-Encrypted: i=1; AHgh+Rq3XQJvMBTE/v/CAtVA/SvjnmmAAdTACRfNSnPnS4ruYtBdbhTKCGH9Pb6dGOz7/Q6UwBlddJcbbN4g4kk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++npnErvRZi05nAzKVBMm4Z4SzczkTpoHLJEh+p/3bljoYASs29A
	iiQ85Y7jnDb6xOMWQK8SjzlTy1xQ8GF9P19cezPS7W0n9mhaQ6YtQzA9
X-Gm-Gg: AR+sD13kOeZgqvKgj6CartHajiBfeZ7IYbOoaf0u+ehkvSDfzszN3o49EEtL/KShI2c
	0MT2xZKx1njp7AroTZJi3RCjiiH9R04+1cD6v0P74x8waBEuqy14WaYIs2GJDLZS36NoDuMVXzN
	1G3d7HRsNAkY89PJch2GtvwemLCXfD6hiCreODt2xRXAXERqNkZXSdIYD+InJeS5vplbBSq0Bsf
	YHFJk0tiNHT6XUBLLouZVeEOKD8//FTVsngn1rUpRs6s+IVKT/EVyyDibUuWwDcXsRwgHkFfK1t
	xk33OL4YORpwLeZeh3rf2iIAVH3kbjTMy6dwck+iF5EqRNZzpTmWq4wpTLn0aB46+U39RmKQacT
	ti5LytEKlyOepMYcPh5cwZq18ZCOsW6fSbQdxQ5/rv6dE6Jh/eplLUa5LtXlXlmWuxZXX1GyHFN
	0MWxSUye//ORxHY8eXMDDwb994eX888C+Xk8KmiZPSsuo+qIz0FcFbnWk3ORcarpz3FC1PumXgs
	Gzqjp9qvDlsBOq4U1imq6KjfZj2vkq3M+YmgM8=
X-Received: by 2002:a17:90a:e70f:b0:38f:cfe2:fd3a with SMTP id 98e67ed59e1d1-3969bc5054dmr8099705a91.15.1787829686419;
        Thu, 27 Aug 2026 04:21:26 -0700 (PDT)
Received: from baaz.tail58d41.ts.net ([2401:4900:8853:c223:d8cf:ffee:2034:18a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20095sm16423327c88.6.2026.08.27.04.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 04:21:25 -0700 (PDT)
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] scsi: ibmvfc: document protocol parameter of ibmvfc_alloc_target()
Date: Thu, 27 Aug 2026 16:50:38 +0530
Message-ID: <b073968ae020b6ae0240e91341a92f428587ebd9.1787828961.git.falakreyaz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <dd866cf2321381694af027fbd726bcbd63ac3751.1787828961.git.falakreyaz@gmail.com>
References: <dd866cf2321381694af027fbd726bcbd63ac3751.1787828961.git.falakreyaz@gmail.com>
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

Commit 249313b3f7b5 ("scsi: ibmvfc: allocate targets based on protocol")
added a protocol parameter to ibmvfc_alloc_target() but did not describe
it in the function's kernel-doc comment, so a W=1 build warns:

  drivers/scsi/ibmvscsi/ibmvfc-core.c:4996: warning: Function parameter
  or struct member 'protocol' not described in 'ibmvfc_alloc_target'

Add the missing parameter description.

Fixes: 249313b3f7b5 ("scsi: ibmvfc: allocate targets based on protocol")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608270829.lHI1FAdO-lkp@intel.com/
Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index d1956552698e0..6fd4c601f978c 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4987,6 +4987,7 @@ static void ibmvfc_tgt_query_target(struct ibmvfc_target *tgt)
  * ibmvfc_alloc_target - Allocate and initialize an ibmvfc target
  * @vhost:		ibmvfc host struct
  * @target:		Holds SCSI ID to allocate target forand the WWPN
+ * @protocol:		protocol of the target to allocate
  *
  * Returns:
  *	0 on success / other on failure
-- 
2.55.0


