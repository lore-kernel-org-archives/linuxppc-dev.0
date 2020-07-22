Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BABC433E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 04:34:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B5A207BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 04:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2r1O6e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B5A207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBN0X6zpxzDqRk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 14:34:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=I2r1O6e6; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBMqb1TKFzDqfZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 14:26:51 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id l63so508597pge.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 21:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fF6VR3AExZocu+n/FS+1hKPnZeY7HU8dA7W8KUXHmCc=;
 b=I2r1O6e6VwF9Oc9R2u+AeaIaGCTPV0j+ZqYo3//3VSp8/aSBwdFRBKxLQV7nu7qy13
 BN6/eGQ7geha3+c22GtmDhWpFETmUX3AZmT6Ttq/pqkz3mkMvP1e0g1jfK5dSe76Qam6
 cT/Ia1x13j+3YP8B76XRv9tvovnDwRlsHuMzhEHHqnqx8GqWmcrTZIhLwhzdT+xoKwJo
 Vdkg2qbFk4DA+5eGDgTCzRQnAquRtMLh3YQm6/Rj4qs1S+5jDrziT8eVQMotgOaANXe6
 FfpjBDB29Qe3+dQ/4vryoctNkicv2UObY0LqGkktIXNhuqaL7c8pWBz3VURtv5bPUD5w
 /elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fF6VR3AExZocu+n/FS+1hKPnZeY7HU8dA7W8KUXHmCc=;
 b=cWtJ1sD1oHtej7QbiqEwxx8RJCXRrZ6NPSPDPKEBYk/zm+GpBqcrAZtx/1plFC3n2R
 pg72t01S2qF5jnVhqLLF6IjVKOAZucrQsEIUqszYr5J4c/QNLdVtz2vmeG1hgdQkIT6D
 xCRadeePLHQ9iojrb9TmmH/vEPU4XMTGqiYvklOu7JEkYVS5H//cyoZA0qGGR+wKg4Nd
 pshVuOTmW7P1z9DIU+AvcIdz9PUuFYh6oCI5KnTUXHqp5BCp3xSSbgSB1MVyBLVLRZXN
 onNofK8KnD/99CJsjScMn+QGApVLBtRuJ4IHYappK5hbWeBkPTlUnetTPLBw1chkhEfy
 B7ZQ==
X-Gm-Message-State: AOAM530kLwfI4T18/viUP19Rx+DYJe8Txk2RT3V4Cb2TPfZ5iHedkJKK
 kMR179NrFfPR4Bbw5VrTxtazGPEOYw4=
X-Google-Smtp-Source: ABdhPJyimP31DhR4NrsKlw2OVteD7qB+8y1snkfcFrwKpHAPfkhmy0fvdA/xDzjTqV9eP7XUpqqGDg==
X-Received: by 2002:a62:3741:: with SMTP id e62mr26239785pfa.127.1595392007746; 
 Tue, 21 Jul 2020 21:26:47 -0700 (PDT)
Received: from localhost.ibm.com (203-219-159-24.tpgi.com.au. [203.219.159.24])
 by smtp.gmail.com with ESMTPSA id d4sm20583709pgf.9.2020.07.21.21.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 21:26:47 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/14] powerpc/eeh: Move vf_index out of pci_dn and into
 eeh_dev
Date: Wed, 22 Jul 2020 14:26:17 +1000
Message-Id: <20200722042628.1425880-3-oohall@gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Drivers that do not support the PCI error handling callbacks are handled by
tearing down the device and re-probing them. If the device being removed is
a virtual function then we need to know the VF index so it can be removed
using the pci_iov_{add|remove}_virtfn() API.

Currently this is handled by looking up the pci_dn, and using the vf_index
that was stashed there when the pci_dn for the VF was created in
pcibios_sriov_enable(). We would like to eliminate the use of pci_dn
outside of pseries though so we need to provide the generic EEH code with
some other way to find the vf_index.

The easiest thing to do here is move the vf_index field out of pci_dn and
into eeh_dev.  Currently pci_dn and eeh_dev are allocated and initialized
together so this is a fairly minimal change in preparation for splitting
pci_dn and eeh_dev in the future.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
v2: Commit message fixup
---
 arch/powerpc/include/asm/eeh.h        | 3 +++
 arch/powerpc/include/asm/pci-bridge.h | 1 -
 arch/powerpc/kernel/eeh_driver.c      | 6 ++----
 arch/powerpc/kernel/pci_dn.c          | 7 ++++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8537dd334094..9c5ba535f6a1 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -148,7 +148,10 @@ struct eeh_dev {
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
 	bool in_error;			/* Error flag for edev		*/
+
+	/* VF specific properties */
 	struct pci_dev *physfn;		/* Associated SRIOV PF		*/
+	int vf_index;			/* Index of this VF 		*/
 };
 
 /* "fmt" must be a simple literal string */
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index b92e81b256e5..d2a2a14e56f9 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -202,7 +202,6 @@ struct pci_dn {
 #define IODA_INVALID_PE		0xFFFFFFFF
 	unsigned int pe_number;
 #ifdef CONFIG_PCI_IOV
-	int     vf_index;		/* VF index in the PF */
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
 	unsigned int *pe_num_map;	/* PE# for the first VF PE or array */
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7b048cee767c..b70b9273f45a 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -477,7 +477,7 @@ static void *eeh_add_virt_device(struct eeh_dev *edev)
 	}
 
 #ifdef CONFIG_PCI_IOV
-	pci_iov_add_virtfn(edev->physfn, eeh_dev_to_pdn(edev)->vf_index);
+	pci_iov_add_virtfn(edev->physfn, edev->vf_index);
 #endif
 	return NULL;
 }
@@ -521,9 +521,7 @@ static void eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 
 	if (edev->physfn) {
 #ifdef CONFIG_PCI_IOV
-		struct pci_dn *pdn = eeh_dev_to_pdn(edev);
-
-		pci_iov_remove_virtfn(edev->physfn, pdn->vf_index);
+		pci_iov_remove_virtfn(edev->physfn, edev->vf_index);
 		edev->pdev = NULL;
 #endif
 		if (rmv_data)
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index f790a8d06f50..bf11ac8427ac 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -146,7 +146,6 @@ static struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
 
 #ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_sriov_vf_pdn(struct pci_dn *parent,
-					   int vf_index,
 					   int busno, int devfn)
 {
 	struct pci_dn *pdn;
@@ -163,7 +162,6 @@ static struct pci_dn *add_one_sriov_vf_pdn(struct pci_dn *parent,
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
-	pdn->vf_index = vf_index;
 	pdn->pe_number = IODA_INVALID_PE;
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
@@ -194,7 +192,7 @@ struct pci_dn *add_sriov_vf_pdns(struct pci_dev *pdev)
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
 		struct eeh_dev *edev __maybe_unused;
 
-		pdn = add_one_sriov_vf_pdn(parent, i,
+		pdn = add_one_sriov_vf_pdn(parent,
 					   pci_iov_virtfn_bus(pdev, i),
 					   pci_iov_virtfn_devfn(pdev, i));
 		if (!pdn) {
@@ -207,7 +205,10 @@ struct pci_dn *add_sriov_vf_pdns(struct pci_dev *pdev)
 		/* Create the EEH device for the VF */
 		edev = eeh_dev_init(pdn);
 		BUG_ON(!edev);
+
+		/* FIXME: these should probably be populated by the EEH probe */
 		edev->physfn = pdev;
+		edev->vf_index = i;
 #endif /* CONFIG_EEH */
 	}
 	return pci_get_pdn(pdev);
-- 
2.26.2

