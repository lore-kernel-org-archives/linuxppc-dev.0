Return-Path: <linuxppc-dev+bounces-22782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477EFCD98E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 04:41:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghQ0j2Ypnz3bpx;
	Fri, 19 Jun 2026 14:41:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781844101;
	cv=none; b=RzT8WU4goWwnj1ZSbf3ybR/R8fbJHAChOdPjHVREzvDiizztFURQUdCSzs3Hsw9uxYYbGoX4ErFAHILHkE1VjgkDbbqm2AbbdP2Lbr+QPkfrVQgUxlYyCHDZPcaxLMBRMz4819zHUPMmAup4eo+lATgPq7dtW+ayjm6Pwl9mX0sBG16O8T+8R7aPk4RqETb4G3lhMyCcyfucldWnt5yfh5q7TGttEZVUukCJyfPbHHM1vFzZiQIrQzRGMYd6i5KIEs/w81u0qaokUyUQaiQl5KD2vYy+D/0HD9dJg3DlzPM1xqGWcBIMlJJdbj5Y67rCqYAhuiSNfshmQaqragfAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781844101; c=relaxed/relaxed;
	bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exRRSp4Q5nQAdSp3W8JG3/of0fN5U3WYFUlJUhst6EIKNajuZZCKHy+ZkC6PBiGgcjDONifAfH2vBYmwsceh4Umo7fXsTKrlNk+UU32CVshCz1VTwAW173RLl0uym1ZZ5xt0Rcms+Pr5n2Wfk2TlE7eJmbkXrwHZi7gC5bni8XxYF4C2J4i3OukyUpnZmzbU+S0XuonHE8qkgzJ3nhVAqNxmrE3ZayofraD/y8C/NIi3G5hGrueE5wdUiapaBH6S4i9iWfaG4Y0jD09k15D5INSL3oCRWbzIhyqKdzARPLOL5vE0c7FcTDiiCGrN11w322jlMMSZ0Cxe60SnmqtauQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T2EF6+0s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T2EF6+0s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghQ0h4NZHz3bpp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 14:41:40 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2c6c57c5bcfso15438985ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 21:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844099; x=1782448899; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
        b=T2EF6+0ssnmsS38cB2NoFBWgzInQy85+8+M2obR5wcUEduHJxJfSzfugBbjHZydH4z
         03dg//415VF2ym9ycAfx85INzQ8DVD4Mn8+C2vI3hZfShNKydACvEK+fr2gnNXHIupu5
         0/UJpUIlufvj8+P0ygX01CabX16lDyG0oxirN9DCpIlBQQ9O5Pue1bVh8vPIaEs1TBK/
         KGo0E3wi3vXDqK2PPeUIoDg5DoMME7/Z27X9MtGWZp/8aOFgYtqKaP77Kt2yOXX4PVFy
         pAktM2RibDJM/WxzvVpivTGUv07qFNR9JTknmLwDMsCsXZN3aWUZkCSD82vw/peFpQyu
         u3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844099; x=1782448899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5UsMmNx5K2MhulwAdPqrD4ef826gnyJGcd1eOHt5Pg=;
        b=F5a/aGPmtwBjQbeaNmXRwdm9s6w7jO0rvPUzfSCG2SmpyprppEmEcSxCg/731f835b
         wI08QTLoiOM3v/VGSXI5AiuBHoCfmpdmcHu7MJUTGCd1LrHiimIihGxVJV2Dekfn+2Cl
         qDgQZHk2P+y3LUd3W+OhPA1rHz1EuPK3Mnj22cp2YBPD9ncMFWIyQlH1IjCBw3rN7Q4a
         KlGYu2nrCdLAPSigr/zbpfcuvmiwM8E5SmGFMQ2PgSDrRvMSAs2E08+BuHhoL16GtXEt
         UxO6mS1P7TxjpefdOJBzlkI07UNjae4WNk+OAMvDQEeONNP6gvTZsfqu9He0DQQhgSyG
         JxoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zl6h7Dpf12r6CrtXX74kxnuVe4DlKOk+RUM4hIIx+gTxkHxYTOsybTx7j+pD803xtErnfW1/fHqbmshs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YziaAZ6WG+IoaSurDDMLNEsyXp94nBQ/3Fuw8w4xXIyBN5ier3O
	Lke73WWDl5Xxss6/dBDDbfxfUp/6EJqVLIpWl0iqoHbKwOqQs7F+wZ55
X-Gm-Gg: AfdE7cnReXjsZk0Fd2tl95qFJOZhbxVjXPrnQzBtOOe+UORWFCf9Dd+oVaU1CSpe4/P
	89y5I/IXgKT3F1xWErh/Hiw7fQtyYXTRqXQP9/NVan4iFIy+FiH/b2b98ZaKaxgQpjNoPsbp+rH
	6GY/NoPpU/4IwFPiWnegZibhf63LaLCv45/eqRNicFibyIUmZoGKuHIg6LiBf4WfPpO7ubd9ZHQ
	LyEXJxRcjYm2h8aenjjgESt+9Zm3KzkxQ1owJh3Lqs5VpD90/yMErFA2ImqqDLlI+9KxYMU8wW5
	fyofP4Fhcpm+gCzaECQbkwNzM/+Nx5zb8mWhcqOXQ0EqKPJSUxvcCf6UnM1uCuYGRRnN448j75R
	JVeSgi6sg8wrELpptk21C8DZCVPZNuALQiiOtYzgoJMVLRzDcoKtK5d3GdmplqF93S/FHrHOJf1
	ddRTlIS0URVslu0nPMYJYTWg==
X-Received: by 2002:a17:902:d54f:b0:2b7:a350:463f with SMTP id d9443c01a7336-2c718dd8598mr24155975ad.10.1781844098519;
        Thu, 18 Jun 2026 21:41:38 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208e5760sm8293735ad.36.2026.06.18.21.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:41:37 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sayali Patil <sayalip@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
Date: Fri, 19 Jun 2026 10:10:59 +0530
Message-Id: <ecbca3be3fa8bd7e213d013a2ec6ff9a11c6e0d1.1781843449.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781843449.git.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com>
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

THP_SWAP avoids splitting of a transparent huge folio into 32 smaller
64K folios (Radix-64K pagesize / 2M PMD) or into 256 smaller 64K folios
(Hash-64K pagesize / 16M PMD), during swapout. This improves the
swapping performance since all the bookking & I/O submission happens
once per large folio. More details at [1].

PowerPC Book3S64 could not enable this before because PMD_ORDER is
selected at runtime depending upon the chosen MMU. The earlier patches
in this series turn SWAPFILE_CLUSTER into a runtime value and introduce
an ARCH_MAX_PMD_ORDER upperbound override for SWAP_NR_ORDERS. With those
changes, we can now enable THP SWAP for Book3S64.

This increases bandwidth throughput with zram backend for swapout by
40-50% with Radix and 100-130% with Hash (Tested by Sayali)

[1]: https://lore.kernel.org/all/20170515112522.32457-2-ying.huang@intel.com/

Tested-by: Sayali Patil <sayalip@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index bac02c83bb3e..48f74bd22343 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -113,6 +113,7 @@ config PPC_THP
        select HAVE_ARCH_TRANSPARENT_HUGEPAGE
        select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
        select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
+       select ARCH_WANTS_THP_SWAP	if TRANSPARENT_HUGEPAGE
 
 choice
 	prompt "CPU selection"
-- 
2.39.5


