Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A7CC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 03:26:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3EE20817
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 03:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVVman/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3EE20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434Qzg3lZVzDqrF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 14:26:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NVVman/J";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=radu.rendec@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NVVman/J"; 
 dkim-atps=neutral
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434Qt50bD5zDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 14:21:32 +1100 (AEDT)
Received: by mail-it1-x141.google.com with SMTP id o19so2125030itg.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 19:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bT2cISMrMiBpdxOWHrZEfN4Sk9Tfn2LCVE5Ik81cBQ4=;
 b=NVVman/JJO9Qf78myAlszXBoQ3kC+h5zoceeKE1pzCfsmOIH2q6PwtnXCzJHjO+7aw
 nz2/b7dkDsJq9+UG760NRCAbIcy87984J+uNcdpYPTJXyElU2TmkydFoR/U2TD/Hnksj
 ICFHvda63YucZfdrbNngrRH93u3F9UDcMlPN57ze2aub0kweXCiQlGY+OYu9pCaeA3Ip
 5zQalpshYAyVW/1pyrzRk4CJ9XkjZQT8211B9LKUYCjkEId/ycxtm0fPs5oMudQEXeLE
 VvWSmI1i4ZmlZgASIDLAVdMZyzxFRstErhLFMs8zppM0ejuUwEfc4TD3RK9n7/6OVNFL
 BIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bT2cISMrMiBpdxOWHrZEfN4Sk9Tfn2LCVE5Ik81cBQ4=;
 b=FDpAZyo0lTSPYXwr3hoHFh8T9D0JLe1XTOU5RX3MsREoyI23Oefl8Fi2s3rpc77vIe
 33in2TZdut/GtJHoRdw5F/WJ446u9MweBgQ/EuZWDFHGnZ/hYaDCm0yYWubbUQwv1mBd
 SfdX3+ZO2DSj4Pi0umh0grJ+h2lQyadbG5I+dK6V35vyV5ZaNeAW2kXl5Zi/ZVo55iHR
 dM0NxqHYnHhwmg+Noa/Mkg4TEmcv/IDnkEMMI8hIHyVz0pDDI9VPLgGeKEJgHn+Vo8k1
 iFOadjcWQXr+SIzpdDPXDnVGS6JLwK/cGh72327tipSDrBsi+HfO+2kM6MVUPbSBtXIm
 /boA==
X-Gm-Message-State: AA+aEWYg5s+UwHixPSYFhJQszEF0RulvPpJ2kzITh/xggCB5DAv5Caxr
 +ossTEYvJmTMB46WAINWTzVbL91N+TqUaQ==
X-Google-Smtp-Source: AFSGD/VFlxp5TjOXUypZXp+cfGtjH8+PZ1xvy5fkbDKfAeLRbqHRXd5sk3MI2hs3zopKIpcJKB29ng==
X-Received: by 2002:a24:1d1:: with SMTP id 200mr1514758itk.146.1543375290595; 
 Tue, 27 Nov 2018 19:21:30 -0800 (PST)
Received: from bat.mindbit.ro (CPE00fc8d79db03-CM00fc8d79db00.cpe.net.fido.ca.
 [72.140.67.131])
 by smtp.gmail.com with ESMTPSA id n129sm563927itb.20.2018.11.27.19.21.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 27 Nov 2018 19:21:30 -0800 (PST)
From: Radu Rendec <radu.rendec@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] Fix NULL pointer access in PowerPC MSI teardown code
Date: Tue, 27 Nov 2018 22:20:48 -0500
Message-Id: <20181128032048.11665-2-radu.rendec@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181128032048.11665-1-radu.rendec@gmail.com>
References: <20181128032048.11665-1-radu.rendec@gmail.com>
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
Cc: Radu Rendec <radu.rendec@gmail.com>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The arch_teardown_msi_irqs() function assumes that controller ops
pointers were already checked in arch_setup_msi_irqs(), but this
assumption is wrong: arch_teardown_msi_irqs() can be called even when
arch_setup_msi_irqs() returns an error (-ENOSYS).

This can happen in the following scenario:

  * msi_capability_init() calls pci_msi_setup_msi_irqs()
  * pci_msi_setup_msi_irqs() returns -ENOSYS
  * msi_capability_init() notices the error and calls free_msi_irqs()
  * free_msi_irqs() calls pci_msi_teardown_msi_irqs()

This is easier to see when CONFIG_PCI_MSI_IRQ_DOMAIN is not set and
pci_msi_setup_msi_irqs() and pci_msi_teardown_msi_irqs() are just
aliases to arch_setup_msi_irqs() and arch_teardown_msi_irqs().

The call to free_msi_irqs() upon pci_msi_setup_msi_irqs() failure seems
legit, as it does additional cleanup; e.g. list_del(&entry->list) and
kfree(entry) inside free_msi_irqs() do happen (MSI descriptors are
allocated before pci_msi_setup_msi_irqs() is called and need to be
cleaned up if that fails).

Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
---
 arch/powerpc/kernel/msi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index dab616a33b8d..83c2043cc685 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -34,5 +34,12 @@ void arch_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct pci_controller *phb = pci_bus_to_host(dev->bus);
 
-	phb->controller_ops.teardown_msi_irqs(dev);
+	/*
+	 * We can be called even when arch_setup_msi_irqs() returns -ENOSYS,
+	 * so check the pointer again. Example: msi_capability_init() calls
+	 * pci_msi_setup_msi_irqs(), then free_msi_irqs(), which in turn calls
+	 * pci_msi_teardown_msi_irqs().
+	 */
+	if (phb->controller_ops.teardown_msi_irqs)
+		phb->controller_ops.teardown_msi_irqs(dev);
 }
-- 
2.17.2

