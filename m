Return-Path: <linuxppc-dev+bounces-18547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FAD1094472
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 12:17:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdJMx6k4Cz2yZN;
	Sat, 21 Mar 2026 23:17:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774090907;
	cv=none; b=K4EVgQDYwlLc64TJM78eQSzK17rjLLnMtVUeLUyZrQYwG4Y9tutf/BtHjL5hyjR7SSBsrRln3m74+ewIXHm3nU+YAL3mb2QLw8sli5NBZyoI0mOU5ax+Q5FfCJ9st/cDIel6JL07NszHkkchgxEdquNk9caDAwI/ebVQTySh6yaOazXSd9T7DpZEzZT6zaCtORnRb4Fm9ueoU2wHcN1xiAcAdBLNauREn5OG9778T8ujXEyvpHgSzt8zqqhq5ogv2jfUbkmo2G/f9PEHnjONgeFPTk0l6sk8EBkZggu41g3VEQnkL8s7MXapSQEb/COq80mqri60OFxHBmAln4IKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774090907; c=relaxed/relaxed;
	bh=m5SyTiR+HYX0GBa+9X9iB4yyPmUDwfNcbJr5m3t6btA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3sb9l1AAm+NzkVCmvAr0VCDAgt8M/NAZh2V4VOfj1hDYEWZytZ/5FK7RKk8RR7x6KL1T0m/dtTEwIOwZm496PV+VSyYex4gNoZ+YE7yQ1ufYiyssxBSvcxZxsg/lsN8fP+cSghvjGorObF0zagfRn1gNVF8RgIYA777E+aSeEx++UPXdPtW4vMWdgHydITd4+TWHaE71o2zxCGS6TAJChtH2kwlrQ4ytja+Fj5GgrbJ5bi4KnMi2y9W6WDGHx3rpNDiPSBonjvZ1ERqZxh0X6hXcf/zr35OLTAGtLrPKFYRFvJu7h7nk/jtohGW3wR0sKDKnM0WCgEYCO3tJMCANw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=QjpSBSjU; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=kexinsun@smail.nju.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=QjpSBSjU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=smail.nju.edu.cn (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=kexinsun@smail.nju.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 200 seconds by postgrey-1.37 at boromir; Sat, 21 Mar 2026 22:01:40 AEDT
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdGhh4Wjnz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 22:01:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090745;
	bh=m5SyTiR+HYX0GBa+9X9iB4yyPmUDwfNcbJr5m3t6btA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=QjpSBSjUe5nllvtaEyqyZrHlbXn+VWoX/1Rq22ta5WN7/AOhTk7KIjfhukym+2sLd
	 F132vR8REY8yUqG2hirixFLRrVgBqdmXWR+0rUgK9n2YMj3StvyxZwFDKGVpkh+XsT
	 7TcHnIk1EXlgwfjDsGS+GSO2FnUFapgH5R80yG90=
X-QQ-mid: esmtpsz11t1774090728t0073daa7
X-QQ-Originating-IP: XihZKy3ls7jWQfbp729UZHQdgzd2xDeTZMS5V6WtOUk=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:58:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12542710008474920209
EX-QQ-RecipientCnt: 14
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	gbatra@linux.ibm.com,
	ritesh.list@gmail.com,
	kees@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] powerpc/pseries/iommu: update outdated comment for renamed iommu_dev_setup_pSeries()
Date: Sat, 21 Mar 2026 18:58:44 +0800
Message-Id: <20260321105844.7481-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: M9U6erWNshaG/lk8Y8/YtMCu85/SZbqJcMy5RPz+CahrYbBmMQ/UkPyN
	pDJE/WfyYAotNaIDOjPRiBQY6hf9h2TSOvODGxOZ4EhN5Bib3JoxejXUGSrrwh1Z6snGAiO
	AYAGyJDIEkLpna+8xdCXQU5VM5lqHbG7qlu5lDrgjKwuSGRqSqwwdGH0Re5pglbyRQACtOR
	S4RQw5YsJwltgDO6EJ7TKvI8GqmSM4QtoXcbQBtX01O0mEcS7HW7OmLz6uhuuxX3jYriVhx
	XgZ44ZkBOifs43WpLN7XEFW+K08NJ61H7oBpIIltoHjyjhhBr76A9PSxlz+7s4kVtLqt+4y
	96QxVUPTVnISq4IMuSno+VkwK13ep9DFP8Ex3cjcMGiH7x9pzDuF+yxXU51JiEGfiuYePFx
	kYoYQU1ADIZqSuo9lPvE8EZJeePYgfKlLNBQYE/wmpzdLV0M5VWg6SCCBYQntEhlPpuuHNc
	7XnMCXM39XemzLUZLKnH4Nz3balMsAtr0KCaJv4yCDsMyZ3lhMtAxW8TK68Noh3jNKreLtu
	TdCGKh9YJGa7M+kNvNBjyA7VAS5RncKLJFpQTYVKCeBb62sd//h1vW8ALFcjqZ249PiI/o2
	TxuwHIhvZ4+GPRaXaLsKsJkciin5Y+GLe65QGPzIVoNTiMD8ZmJUyUJ02wU3KPjQ73nUHW4
	vPi0GLOPkm8VAN+g52omyjjb5W0dxFQ83FCgdVMPPTziO2cWkmLqw07Mx2vgJWC37NLWH+U
	kXd8NgGg1JnGgPkk1YhYB3QfDuBLV5kTuy9lML0qHvZeezSee2BGqC4+rnLiXws1eUoURsx
	Cn9zM3lsLGQtdhMMJaY3v0CgHHT4WaD8u2/D9mdYoata6okQUGjDSUHZaCx21WQSmdbRYFX
	ECnVeh9+fnIXD97PtEP0CFrKgmFBDqMvfU7ZTgywhC2L5grM2RP1NaD8HcqgxuMpciverFZ
	T1LKr7QBm/kp90mSDufe975ye4r4CppdUTEb6fi6xFs0fCjixxpw5QBN2JZewfjlvLjIucF
	gQikOYIHn5nKMLjK/wt/+qCw2BhmDwv60HsIGWIA0ef1J9srRvPHjbf2Zdxf18r5R9V81/i
	uwdA8eqohhi
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

The function iommu_dev_setup_pSeries() was renamed to
pci_dma_dev_setup_pSeries() by commit 12d04eef927b
("[POWERPC] Refactor 64 bits DMA operations").  Update
the stale reference in pci_dma_bus_setup_pSeries().

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 arch/powerpc/platforms/pseries/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..93741319fad7 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -634,7 +634,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 	if (bus->self) {
 		/* This is not a root bus, any setup will be done for the
-		 * device-side of the bridge in iommu_dev_setup_pSeries().
+		 * device-side of the bridge in pci_dma_dev_setup_pSeries().
 		 */
 		return;
 	}
-- 
2.25.1


