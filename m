Return-Path: <linuxppc-dev+bounces-25907-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098A6C5DF66
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 19:05:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hP2Mm6HXNz2y8G;
	Tue, 18 Aug 2026 05:05:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786993508;
	cv=none; b=ToKoSc0QjLqM0ByDVZPLY4jU9EFjRY4dehPN4w7F20i1fbqVebP5wjYsgVL8ZW6wxgVLOOXVXHamWu+Fd7dTSR+Dz/7ukm/ugLIl4pikKoPbIXRwdh4Lb9x3wH/ARW2Xlb7pbX1RabNFGNFvfFGcii7/un3aBO3LCobjn5pt2j0mv/8bmHmAyoHDzLVChACFb9vzDlyrDFBOPsYKzYk+b9gw0qZNZDKrYfB7da1l5WynxhHrTVLhJxjzXghtLtJbdZ2Z7G2jWILeefeRktoUrARhQt1s51ahx2p+lRkeFk3kuxSj3V1djszfmqFM8TFyfk+7dbeulUJUfmKkumQ1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786993508; c=relaxed/relaxed;
	bh=ML1B2/r+psY08wn0C4kBVmdPYnKuWxTUSYfY6GsO7Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h/SgA7T+NzWG7smHiVXtqsDIPzoDtpLdGDRYF6qCPAzs8yW9r4v7RvX064XF1mObhDN8NyTls0RMGK9q5frRTgD1rZqtDhXsUdsHmMY7Y1IFVt4jy9TjCasivuL4pQoRWNUUteiS20/7Vrs9+PmTS0CEHUqcePxJrReqDhikevN3IFtm6Y8FxIWViYorlAKH+OMH0f8aybN09ki5/jjvirb8I3KTN5J0FkNp7+qMuJblQhKLJjccIoCUg7hhf9+ByuXhTDvZGTuuA8NTQz2aUtbrjt39GLO5+7jZAwklyeA4EVwh8Dkx8ck6V+oOMI5oqO389Nn2NVQaQc3/KVqmEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAkeKTUY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAkeKTUY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hP2Ml5pK0z2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 05:05:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3EEA440DB7;
	Mon, 17 Aug 2026 19:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52D91F000E9;
	Mon, 17 Aug 2026 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786993505;
	bh=ML1B2/r+psY08wn0C4kBVmdPYnKuWxTUSYfY6GsO7Ls=;
	h=From:Date:Subject:To:Cc;
	b=AAkeKTUYakkpnGyOQ+HioxNGW3rW7dLbJrjulLpPZzlCO2om5UMh3lmBHhlxYYhdh
	 /PE+P1z9DHDY+C+OU77wpKTfPjMoxgihfoXJuX3LV7S40bQTmM1b1F1XbXWq3uxUnm
	 hBzWsDK1xiAxVgAJHgPbTlOTRHVhGN4hjn/dC9DBsgLDmqDpx0nhUWwENwsBR2fktW
	 tej/uwJL92NQQe/Ij4QyJljQuSGG/EHR2HrJSQPV5LQtWIcFhrjGhzythZj0weAU47
	 QAlr+a5LdikqDyED2ffnuvuBYKWSHvWUVwJLdkYW3MRAMm6eODXTLBmfQ3c6JQTVj1
	 /j+61+xg8T0dw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 17 Aug 2026 12:04:55 -0700
Subject: [PATCH] scsi: ibmvfc: Fix use of uninitialized rport in
 ibmvfc_do_work()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ibmvscsi-rport-wuninitialized-v1-1-0fdfb27a5f01@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBAF0KuQWTtJSwI1XsW4oO2o32ghnYJGw
 t2tunybt5JKhigdmpWyLFCMqcLuGgrXIV2EEaupNW1v9tYx/GPRoOA8jbnwc05IKBjueEtk472
 TLprO9ZbqMWU54/X7j6e/dfY3CeWb0rZ9ADuGQOGBAAAA
X-Change-ID: 20260817-ibmvscsi-rport-wuninitialized-0bb7e5d05761
To: Tyrel Datwyler <tyreld@linux.ibm.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=nathan@kernel.org;
 h=from:subject:message-id; bh=lUUmBqqkyEdjdH52ETtXEdeeJGgD/7QohYQfKSe/Bro=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnN0TF2DWbHf7glL5PhvbvTSmaPItfRr1/9WuXkV++2l
 IiaHWrTUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACbS183wz0rrbvj62OJcmfdG
 qpzyfGrbjRbaPpzPIRv1OGXtmonRRYwMT3QjEwO1PeqqLpRLVO/39hC/OnfO736t+RbMkw7+vir
 ADAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 696d1cc2aaa2 ("scsi: ibmvfc: process NVMe/FC rports in work
thread"), clang warns (or errors with CONFIG_WERROR=y / W=e):

  drivers/scsi/ibmvscsi/ibmvfc-core.c:6154:15: error: variable 'rport' is uninitialized when used here [-Werror,-Wuninitialized]
   6154 |                         } else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
        |                                    ^~~~~

The check for rport is unnecessary in this block, it was accidentally
included from copying and pasting. Remove it to clear up the warning.

Fixes: 696d1cc2aaa2 ("scsi: ibmvfc: process NVMe/FC rports in work thread")
Suggested-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Link: https://lore.kernel.org/6ccbe8c5-beb6-483f-bfa4-c2d3819ad5f2@linux.ibm.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 93b9f699c2e5..b3bc3ce872d6 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6151,7 +6151,7 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
 				timer_delete_sync(&tgt->timer);
 				kref_put(&tgt->kref, ibmvfc_release_tgt);
 				return;
-			} else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
+			} else if (tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
 				tgt_dbg(tgt, "Deleting NVMe rport with outstanding I/O\n");
 				nvme_rport = tgt->nvme_remote_port;
 				ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_LOGOUT_DELETED_RPORT);

---
base-commit: 30733f28c0347d237ffb5333fdfab7a9a2d4ed34
change-id: 20260817-ibmvscsi-rport-wuninitialized-0bb7e5d05761

Best regards,
--  
Cheers,
Nathan


