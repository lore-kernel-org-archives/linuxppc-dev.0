Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A9606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=c+gpwuqz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjm0vkCz30dj;
	Wed, 28 Oct 2026 14:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156859;
	cv=none; b=BNYZuCmaAKBgFeM4lapYoGbyHlAcRTn85UBKErmdm9gxbRJ/Vb/Mo0IHTn1jAN+kClIubCdzlOp1weaI/bOKOtEtqO7wse87h4Zzv79vLo50qOG1UHb6Tu2gzPS7qVPSsNuTIiEZ4eQyXOP4gWPel7cJq4IX9OPbuY1D2nSIMa+GwiXNg5kRGCkqcqOqnPM2zI54T+0y8t72Jz7br4pQ8xxERiOUpVD7TmaMXByxygtM5akfwwP82zA4+k6zfVFPxSUS/8djdJMU4DX8SvbfWANuEVc1LHT5yQNtPt9bgwqn8fOvbC788ocWne2m83sJ0IwNMIsK0nekBNid0o+aJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156859; c=relaxed/relaxed;
	bh=gvYgj8/VtDiXCuQH4R2FXsxKr1lVxn6Z5zkOXet1cl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjyMXIl7SzUaNzaEddhtCdQO0PwGZFxSDy6To+sU978pQU2IJeykBAsd3IT1VZUyqgmfDhW3bajtqwzsoL6P6nLtl7j2b867Rn3IBtN1y0Y/c5ZExkMyvZI7NGI+ahLjwvXcXh2NyEv67PzqoKSyOFFoaoN2TWsp2ZvAAasNvpq6GioEe739M4MbJ0L1W5ZYbfziYQKR7UOLHzrMcM2fTn3Ol98S64O9sg8Rd5i7Dat/8kCZgFlfR2STPCCkQJt6hu/oMKE/9yqa3Sq0aoOchMqJ/DYpxGiT4EF04m72lgKVx22gTiXgUangy3FbA6VRky98ZVyl4E48rO2l8tuYag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=c+gpwuqz; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=c+gpwuqz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjj3Xffz30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gv
	Ygj8/VtDiXCuQH4R2FXsxKr1lVxn6Z5zkOXet1cl0=; b=c+gpwuqzqtT532VjV9
	nrjYgYtKt+9aGWJ1k+EHtUXPiGCZ7WmfxNid/58TcqDyFhiNTjHn2hY7oEeO51rt
	D1XC4G/eKZLUOKBjAkgQstQDrFInvB0eO9yAcFOVgqxvdENWegJoEAq4rvdGNADf
	XPXpXW/64fglaQv6JxiHFdbT0=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S3;
	Wed, 28 Oct 2026 11:07:10 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 09/16] PCI: dwc: intel-gw: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:45 +0800
Message-ID: <20261028030652.2917756-10-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8Zw4xKw15uw48KryrXrb_yoWDArbE9r
	y5CrnrA3y5CFZ3CF12yw13AFy2ya42q3W09ayrtFZxZ3WxXw1vgws7ZFWDZ3W8Grs8Jr97
	tr1DAF18J347JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNJPEtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x7jh2rhZt7GZQAA3B
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

intel_pcie_link_setup() is called from intel_pcie_host_setup(), which
runs from the .init callback after the controller resources have been
enabled. Replace the capability search with dw_pcie_get_pcie_cap().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 348e579e683fa..a891c3f8eb012 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -119,7 +119,7 @@ static void intel_pcie_ltssm_disable(struct intel_pcie *pcie)
 static void intel_pcie_link_setup(struct intel_pcie *pcie)
 {
 	u32 val;
-	u8 offset = dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(&pcie->pci);
 
 	val = pcie_rc_cfg_rd(pcie, offset + PCI_EXP_LNKCTL);
 
-- 
2.43.0


