Return-Path: <linuxppc-dev+bounces-24758-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F038AC531D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 02:30:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5sQl6TDGz2yYq;
	Fri, 24 Jul 2026 12:30:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.58.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784860207;
	cv=none; b=myzVnsPFi+jqQ7xfK5B9x+b+nfKs6U5Sh9UdI9PTCdjFBjOQ3w4ukagerI5z8uq6omPq3akuuxlkLPP5aavp4H+nmQBpkzly68g1pnxwC3dZQDDK7DRbvFGOvGF2wJAb9O/oj6lLCw9SMK094idNim5sqTsgpB883RjT5ht1xzD1n2lWoro/iwjvdeLh23H+6mLI/YHtRKyHszBBINw5v2GndpjaG0fKifdpTiCglwjFfG5dMAnAwkSHCnxL71/I1h9d0NqKhAT9KfEU0GSDV9h29J1cAwr5SUzpXjtceaybesfQLcsw8mEIZj1WeYt1Vxl5n9lro4poFajSggGFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784860207; c=relaxed/relaxed;
	bh=XcvnlsC3HhT/It5VuOwr2y7sGHW1GiSiBgnaGk3guqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Suh7a8hjjH6m1N39cSe2q37KisuejIT1iJA+D6O+Bsz5nbh2tyKX/zc0P+6ixildXTgkIB4WF0tbIvMfNoDrlHYy6d5t6tOtDQZzHSX8nFab08Tq4vaOy1Eay0liV4wFXJIFoJ6BFGmmzeolsCOxP0qJHL77OSRjKZV+fGrmrme4coEf6O8Giw6ZywEpJs/ZjTQt3DzpnCsL6Dbg8KUoFo4QTaEs0G0q19e9cmP7Mg91Lk5AOVYdE247YoG6GtwWuCL1I1chCDX0JPjQtbdCmXAGs6zf7T6hh7IGnU1p7imHeuLnpp/kYe9XJE6GFZiN3g2Blfu8vaD7YwfoR14YFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Thpc9fD+; dkim-atps=neutral; spf=pass (client-ip=114.132.58.6; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Thpc9fD+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=114.132.58.6; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65025 seconds by postgrey-1.37 at boromir; Fri, 24 Jul 2026 12:30:05 AEST
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5sQj6xXxz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:30:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784860149;
	bh=XcvnlsC3HhT/It5VuOwr2y7sGHW1GiSiBgnaGk3guqk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Thpc9fD+snLZvia4IvIECJR4/9ngZ61H2O5O1Og1QqoADevADqPMz/Bq1/8BXRRWz
	 JCrXR8+gXkama1LSqp+3/GKFYENpvhaX29P6kuiuDXji9ZyCg63LOcE/Yq33QZNkGR
	 BEJyJj84Px6hBhmJtbdXUe181psxM+dEj5Zv63ag=
X-QQ-mid: zesmtpip4t1784860141tf7457151
X-QQ-Originating-IP: mFrNixuyb/9G3t9a9hZZYveY0Gmd34ZMyBS60EAtLAY=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 10:28:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9941543075585726979
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	bharat@chelsio.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	akpm@linux-foundation.org,
	gouhao@uniontech.com,
	namcao@linutronix.de,
	ynorov@nvidia.com,
	sshegde@linux.ibm.com,
	nilay@linux.ibm.com,
	clg@kaod.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH v2 1/6] powerpc/xive: remove dead NULL check after GFP_NOFAIL allocation
Date: Fri, 24 Jul 2026 10:28:46 +0800
Message-Id: <20260724022851.466017-2-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
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
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: OZlI6rIAaqeCVBIJuOg6pSyzi2+V+qNJtXg/EdBlSl5leSYjAVpsVf8P
	4gyphOqRJvHke/U8z2EiQrL16xMAWfhmMUqq+TndOPgznxr06vEKPDe30trkjzQgYhatzsr
	5EWcCTo/4tCi71Ycj3WwxK7f8BDVkizacgveBvZfPt4kPmIV//9FJF3sGBTIqpkRl/CDlVp
	is36P/De2EY5WFqUpIeD4Mj9v3YZ/G2DlHEYq+Wu7DYYdEtwofDtFtWSnrIpm9ZmAOPBGJ3
	O54a2Fj7goQL6dvay0Hr+aokTz6bEl8yApWha629eIaTs2uC4k2eABDIfBpYrlhw0Ee38k5
	lUnc5X6RbtTrUOjZyH3IDIhaAEW+oajchAvV8DAFGM65I5uHsrZYlclgKw0BuXOa5wxk80h
	ET5+zJRwE3tcbTq7OkP4O6/tYyDNiJyvxIPYYQAFTJxTx4loS1ChCMXh0A521nldbTCMyb6
	GYUpqE0OMhErjLdM/QgdlzaWDVmwkO1+LOWGI4zM0pIgu2uApw85BbMPHWmQS03hLZYkX1E
	3BewGtX94DlAWLKO9MLUOyuGto14uP6RcrCK8NSWARq2WmBIpIQGqCZL6X43aNEX9InnX/8
	c/L7X7IxLZZ06t2orM+8oDo7r1PIJzuQKtedEiSIOosysnhRkU9Y+mQRJYlhzQG/h/j8lTe
	piMlo5t7UMX6SyfK8bAUXhqMtab/tpHOG5WkaZWqA98hh7+fPIvmwcKd6j9+YxdK5YRE70e
	OYG1EIkTAceKxm8wFX7ZcJbTKz2r1kuGTPhU66xnL1PcaN76+o9CwwpNEb1FAxvJFd1rLsi
	M6FW/6HIkHVfdjBLkNBWl5HvomQrtqrtELzNhmnAl58WO8tz5xZAPfqgDhH4wJQGwuDMQo8
	uQqtawgJiLOxXeKKH7OcskceNBA150RA3DvxqUKou79x7vnA70zxReWm/6B68gVDfoa+s7s
	T9MBcUDpmB2wgZAxz+Yy5GgJkIL/KyHa7j8514qvmq2kchkYiTZC7eGm5kIPfgsWZGrcv5Q
	I0LkxYTCDPyzYm6FQlq9bATbaDqPHB8iHmhYwZ5c/uXXx/F5tmqqhvGZnHb+NV/L/LHpXTW
	YCFIdp4JpzG83IydauxFhw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
subsequent NULL check is unreachable dead code. Remove it.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
---
 arch/powerpc/sysdev/xive/common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index dadd1f46ec939..f2904a5c2b7bf 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
 
 	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
 				 GFP_KERNEL | __GFP_NOFAIL);
-	if (!xive_ipis)
-		goto out_free_domain;
-
 	for_each_node(node) {
 		struct xive_ipi_desc *xid = &xive_ipis[node];
 		struct xive_ipi_alloc_info info = { node };
@@ -1158,7 +1155,7 @@ static int __init xive_init_ipis(void)
 
 out_free_xive_ipis:
 	kfree(xive_ipis);
-out_free_domain:
+	xive_ipis = NULL;
 	irq_domain_remove(ipi_domain);
 out_free_fwnode:
 	irq_domain_free_fwnode(fwnode);
-- 
2.20.1


