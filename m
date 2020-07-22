Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0433C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 04:47:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672B620792
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 04:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR0XQgn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672B620792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBNHS3kySzDqsK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 14:47:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=TR0XQgn4; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBMqt26qmzDqgd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 14:27:05 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id m9so523772pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q+Vbtx6VAxAjc1QCIssQnoaRZ2QIMxsDUxcrrQGANWU=;
 b=TR0XQgn4xozKj9gW4ze6Nxrq4HIz5kK+nMxoEXGIXWkjikBB7j2hoARU9IbLEjt7fp
 q6ZZjEUqi0AshZmtf9jjOvBSxCmlTOnR5TOD7SxK2P1MO4acfMTM/LGQvfoTkUZ2gO6g
 9zDp3VxIaIPkRgpIpDvzkVzaX/ScOgVAqbpa42v4frFebr77bRWxArTGCJO0u+h1KpRE
 NTOZn9NX61aP6PoOBviBxoFF4AQcE1zQh7gPVKN2x4GIst4ZowSt262nXCRN+UeUJCcM
 47DllhOqykl7j+Tmdp+g4qpcaMQ01c6cGK64Gj3o5IDwGINdef9+o2eb4bJrjUxAxyfA
 dkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q+Vbtx6VAxAjc1QCIssQnoaRZ2QIMxsDUxcrrQGANWU=;
 b=Ad3Y+MhX5dCzOqUnYYELlTV0mIi64vW7T0XAfz84CCWuapcJ4fAYe12eMN9zCUZYGu
 6KA61hNcL2nctPGzUsXjgPAHxbeyLpc0L2cC71hIzxE5XAk4IgrabvkGM49hEpSMnKg4
 Wa7UoPreli3ADjYt1qvFUc8SOC3daL6L+VgmAGdlRb7jfW1a883Mv9QfotxxEJqtvwaH
 By+zj4LnLdzZTPiZN/SUe0rMLvOzAhXcwLNjP0IpSowl11ybYLT2G4GGc5aiUxTeV5+8
 hidP2iNQ9qhLVe4HVw6URc+rk4DUJDdf4F4lkl9Gl1S432EHYL+sw5bexCz81R5KMze7
 UWPw==
X-Gm-Message-State: AOAM532y56g/LeogeGsjaAAp5yRuRUP5d0YmNEyZ/XGEOjhh7gW9Cmwg
 Yyj8dyL/EaFBH8NYzqhh4tI6R5MKzQg=
X-Google-Smtp-Source: ABdhPJylD0cOswXE8Bjs8Dt1GDPcECq/1ClEeEqAbHEcBc6Qbvzcn8HAjLQd87qXhMdlntu3I94xlA==
X-Received: by 2002:a62:8608:: with SMTP id x8mr25835841pfd.96.1595392022319; 
 Tue, 21 Jul 2020 21:27:02 -0700 (PDT)
Received: from localhost.ibm.com (203-219-159-24.tpgi.com.au. [203.219.159.24])
 by smtp.gmail.com with ESMTPSA id d4sm20583709pgf.9.2020.07.21.21.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 21:27:01 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/14] powerpc/eeh: Remove spurious use of pci_dn in
 eeh_dump_dev_log
Date: Wed, 22 Jul 2020 14:26:24 +1000
Message-Id: <20200722042628.1425880-10-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722042628.1425880-1-oohall@gmail.com>
References: <20200722042628.1425880-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Retrieve the domain, bus, device, and function numbers from the edev.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: no change
---
 arch/powerpc/kernel/eeh.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 1a12c8bdf61e..f203ffc5c57d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -167,23 +167,17 @@ void eeh_show_enabled(void)
  */
 static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 {
-	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 	u32 cfg;
 	int cap, i;
 	int n = 0, l = 0;
 	char buffer[128];
 
-	if (!pdn) {
-		pr_warn("EEH: Note: No error log for absent device.\n");
-		return 0;
-	}
-
 	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x.%01x\n",
-		       pdn->phb->global_number, pdn->busno,
-		       PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+			edev->pe->phb->global_number, edev->bdfn >> 8,
+			PCI_SLOT(edev->bdfn), PCI_FUNC(edev->bdfn));
 	pr_warn("EEH: of node=%04x:%02x:%02x.%01x\n",
-		pdn->phb->global_number, pdn->busno,
-		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+		edev->pe->phb->global_number, edev->bdfn >> 8,
+		PCI_SLOT(edev->bdfn), PCI_FUNC(edev->bdfn));
 
 	eeh_ops->read_config(edev, PCI_VENDOR_ID, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
-- 
2.26.2

