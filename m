Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356F8C48285
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jan 2024 12:06:29 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=q8lyiM9W;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TN9Bq5py3z3bxZ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jan 2024 23:06:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=q8lyiM9W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wanadoo.fr (client-ip=80.12.242.16; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 1802 seconds by postgrey-1.37 at boromir; Sun, 28 Jan 2024 23:05:39 AEDT
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TN99v2Q66z303d
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jan 2024 23:05:39 +1100 (AEDT)
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id U3QhrO2WGJujcU3Qirni2Q; Sun, 28 Jan 2024 12:34:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706441671;
	bh=bty2xukFdRkPEFlCnTL1HrECxC57pxJIVp0ohvU2AgA=;
	h=From:To:Cc:Subject:Date;
	b=q8lyiM9WQo/EgvGQysdvx+kePnrw+P5IQ8+wLP2buInfRszrFigPMdnwqTLcwekay
	 vxgYWtn0UQ+qlLLJH6llJzZRvaCGAwdSDbWvN6MzDu9zJPkJlMt2ntFi93UwdbbudT
	 KhHTSLQ4dxRf+1xEoK3P5vX3oQwnX1hfDina0d1b4sFDov8yKJA3eUUXk6ppcwcRf8
	 599nG14+4uqV+HixiKORto7wOAZ2vzJr3Z9XKK6lCBItSgDixxsBCp6rPYHzNRHZ8U
	 Gt+ZlR2tLvuG91dcgdYNZABgVG238N+WPdZrts6wUkezYezM+bH9s7SjtfUkAomxjO
	 jFHBjw2MxLgNw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Jan 2024 12:34:31 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Kautuk Consul <kconsul@linux.vnet.ibm.com>,
	Amit Machhiwal <amachhiw@linux.vnet.ibm.com>,
	Jordan Niethe <jniethe5@gmail.com>
Subject: [PATCH] KVM: PPC: Book3S HV nestedv2: Fix an error handling path in gs_msg_ops_kvmhv_nestedv2_config_fill_info()
Date: Sun, 28 Jan 2024 12:34:25 +0100
Message-ID: <a7ed4cc12e0a0bbd97fac44fe6c222d1c393ec95.1706441651.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
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
Cc: kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The return value of kvmppc_gse_put_buff_info() is not assigned to 'rc' and
'rc' is uninitialized at this point.
So the error handling can not work.

Assign the expected value to 'rc' to fix the issue.

Fixes: 19d31c5f1157 ("KVM: PPC: Add support for nestedv2 guests")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/kvm/book3s_hv_nestedv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nestedv2.c b/arch/powerpc/kvm/book3s_hv_nestedv2.c
index 5378eb40b162..be5f87e69637 100644
--- a/arch/powerpc/kvm/book3s_hv_nestedv2.c
+++ b/arch/powerpc/kvm/book3s_hv_nestedv2.c
@@ -71,8 +71,8 @@ gs_msg_ops_kvmhv_nestedv2_config_fill_info(struct kvmppc_gs_buff *gsb,
 	}
 
 	if (kvmppc_gsm_includes(gsm, KVMPPC_GSID_RUN_OUTPUT)) {
-		kvmppc_gse_put_buff_info(gsb, KVMPPC_GSID_RUN_OUTPUT,
-					 cfg->vcpu_run_output_cfg);
+		rc = kvmppc_gse_put_buff_info(gsb, KVMPPC_GSID_RUN_OUTPUT,
+					      cfg->vcpu_run_output_cfg);
 		if (rc < 0)
 			return rc;
 	}
-- 
2.43.0

