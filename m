Return-Path: <SRS0=DyCn=ZM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21889C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 01:33:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60D2222AB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 01:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE+nEIlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60D2222AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Hlb23HYwzDqYC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 12:33:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kE+nEIlB"; 
 dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HlTm5JTZzDqfC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 12:29:16 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id bo14so3438248pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 17:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=elQ8JPmxCpDAZUsgWC/98nXnIbsz3meQI7wrWY4Cnfs=;
 b=kE+nEIlBLdCDT9/9XBPh1K3i80UwMG8rnSOqEbNwDPOQOT03svJ7Cd5J9QeD3swKH+
 fPXSBfdn5Cv0fLBg0D56yxF2ShFsdZ4jRSCJfXsD8vEGYOv80mTmw5ghXKUPl9R2XL+R
 wExP73f0UvOtH6M5kI7U4KQML/Wd0TNy/bXjPkXcwqucUzna8t69pBAY6ishoO/blsqM
 LHI8u5PRMBU0viYzcJIS5igA/s7VoA9670PkbchS+KzYwpCpM3paH4/kEids1e5ujQqd
 sjRLZE6vYAtp2XP4TNzIyVVLtipWwpCntBooSJQtLFe8bvHzl8Gba76cwLSc2mNty8TP
 ZIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=elQ8JPmxCpDAZUsgWC/98nXnIbsz3meQI7wrWY4Cnfs=;
 b=nZcgs7V8kXNSH4ahN7Nuh1Tdmhcc9Hs1ivRZ+rEi8TydmT/drCwXtvlUvqbJS3g7uo
 nL7g0KC2uNL9YYfOkR/v3WLVjdzAhE9+t/QRDCfjlj0OAhROO1qaO3gsbksWRrofxD4a
 o+R/6P5UkWYerQUFW8Q6Q4rL17kp1lmOJoLauskq2tbUphmgmxZRG4CrnrAckM2znOCY
 4R5Trx+VWiV4He8qnu+ve2fbUvVwo5FBzEl+WNlFC3gMiXWuw1hDAWVqAXsM0WcbAzMG
 FYqPkueBOql3FQ9khrPB0LKISxV9dZsUzoa48AsNOF5Ber4ga9E4gPnEHQCdNnhRqNT4
 3jDQ==
X-Gm-Message-State: APjAAAVz7+PVHR/RubnNBb6OUk82hN2PY/UoQq65/km/4Zy/RLXRQ7fT
 J3x9sPstQJ2a+H0+60UVAxLbbvGk
X-Google-Smtp-Source: APXvYqzWhq72uQ2xPp7mfBHOeOwnm59TCc93fkpLRsJ3omxjYUmfggHF6MgX0V3nLPmrMQnl8o48gw==
X-Received: by 2002:a17:90a:9b87:: with SMTP id g7mr693570pjp.64.1574213354542; 
 Tue, 19 Nov 2019 17:29:14 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b24sm26662116pfi.148.2019.11.19.17.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 17:29:13 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Very RFC 01/46] powerpc/eeh: Don't attempt to restore VF config
 space after reset
Date: Wed, 20 Nov 2019 12:28:14 +1100
Message-Id: <20191120012859.23300-2-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120012859.23300-1-oohall@gmail.com>
References: <20191120012859.23300-1-oohall@gmail.com>
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
Cc: alistair@popple.id.au, Oliver O'Halloran <oohall@gmail.com>,
 s.miroshnichenko@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

After resetting a VF we call eeh_restore_vf_config() to restore several
registers in the VFs config space. For physical functions this is normally
handled by the pci_reinit_device() OPAL call which requests firmware to
re-program the device with whatever defaults were set at boot time. We
can't use that for VFs since OPAL (being firmware) doesn't know (or care)
about VFs.

However, the fields that are restored here are all marked as reserved for
VFs in the SR-IOV spec. In other words, eeh_restore_vf_config() doesn't
actually do anything.

There is an argument to be made that we should be saving and restoring
some of these fields since they are marked as "Reserved, but Preserve"
(ResvP) to allow these fields to be used in new versions of the SR-IOV.
However, the current code doesn't even do that properly since it assumes
they can be set to whatever the EEH core has assumed to be correct. If
the fields *are* used in future versions of the SR-IOV spec this code
is still broken since it doesn't take into account any changes made
by the driver, or the Linux IOV core.

Given the above, just delete the code. It's broken, it's mis-leading,
and it's getting in the way of doing useful cleanups.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/eeh.c                    | 59 --------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 39 +++----------
 arch/powerpc/platforms/pseries/eeh_pseries.c | 26 +--------
 3 files changed, 8 insertions(+), 116 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ae0a9c421d7b..a3b93db972fc 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -742,65 +742,6 @@ static void eeh_restore_dev_state(struct eeh_dev *edev, void *userdata)
 		pci_restore_state(pdev);
 }
 
-int eeh_restore_vf_config(struct pci_dn *pdn)
-{
-	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
-	u32 devctl, cmd, cap2, aer_capctl;
-	int old_mps;
-
-	if (edev->pcie_cap) {
-		/* Restore MPS */
-		old_mps = (ffs(pdn->mps) - 8) << 5;
-		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
-				     2, &devctl);
-		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
-		devctl |= old_mps;
-		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
-				      2, devctl);
-
-		/* Disable Completion Timeout if possible */
-		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
-				     4, &cap2);
-		if (cap2 & PCI_EXP_DEVCAP2_COMP_TMOUT_DIS) {
-			eeh_ops->read_config(pdn,
-					     edev->pcie_cap + PCI_EXP_DEVCTL2,
-					     4, &cap2);
-			cap2 |= PCI_EXP_DEVCTL2_COMP_TMOUT_DIS;
-			eeh_ops->write_config(pdn,
-					      edev->pcie_cap + PCI_EXP_DEVCTL2,
-					      4, cap2);
-		}
-	}
-
-	/* Enable SERR and parity checking */
-	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);
-	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
-	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
-
-	/* Enable report various errors */
-	if (edev->pcie_cap) {
-		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
-				     2, &devctl);
-		devctl &= ~PCI_EXP_DEVCTL_CERE;
-		devctl |= (PCI_EXP_DEVCTL_NFERE |
-			   PCI_EXP_DEVCTL_FERE |
-			   PCI_EXP_DEVCTL_URRE);
-		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
-				      2, devctl);
-	}
-
-	/* Enable ECRC generation and check */
-	if (edev->pcie_cap && edev->aer_cap) {
-		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
-				     4, &aer_capctl);
-		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
-		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
-				      4, aer_capctl);
-	}
-
-	return 0;
-}
-
 /**
  * pcibios_set_pcie_reset_state - Set PCI-E reset state
  * @dev: pci device struct
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ef727ecd99cd..b2ac4130fda7 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1649,20 +1649,13 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 	if (!edev)
 		return -EEXIST;
 
-	/*
-	 * We have to restore the PCI config space after reset since the
-	 * firmware can't see SRIOV VFs.
-	 *
-	 * FIXME: The MPS, error routing rules, timeout setting are worthy
-	 * to be exported by firmware in extendible way.
-	 */
-	if (edev->physfn) {
-		ret = eeh_restore_vf_config(pdn);
-	} else {
-		phb = pdn->phb->private_data;
-		ret = opal_pci_reinit(phb->opal_id,
-				      OPAL_REINIT_PCI_DEV, config_addr);
-	}
+	/* Nothing to do for VFs */
+	if (edev->physfn)
+		return 0;
+
+	phb = pdn->phb->private_data;
+	ret = opal_pci_reinit(phb->opal_id,
+			      OPAL_REINIT_PCI_DEV, config_addr);
 
 	if (ret) {
 		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
@@ -1691,24 +1684,6 @@ static struct eeh_ops pnv_eeh_ops = {
 	.notify_resume		= NULL
 };
 
-#ifdef CONFIG_PCI_IOV
-static void pnv_pci_fixup_vf_mps(struct pci_dev *pdev)
-{
-	struct pci_dn *pdn = pci_get_pdn(pdev);
-	int parent_mps;
-
-	if (!pdev->is_virtfn)
-		return;
-
-	/* Synchronize MPS for VF and PF */
-	parent_mps = pcie_get_mps(pdev->physfn);
-	if ((128 << pdev->pcie_mpss) >= parent_mps)
-		pcie_set_mps(pdev, parent_mps);
-	pdn->mps = pcie_get_mps(pdev);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_mps);
-#endif /* CONFIG_PCI_IOV */
-
 /**
  * eeh_powernv_init - Register platform dependent EEH operations
  *
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 95bbf9102584..fa704d7052ec 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -657,30 +657,6 @@ static int pseries_eeh_write_config(struct pci_dn *pdn, int where, int size, u32
 	return rtas_write_config(pdn, where, size, val);
 }
 
-static int pseries_eeh_restore_config(struct pci_dn *pdn)
-{
-	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
-	s64 ret = 0;
-
-	if (!edev)
-		return -EEXIST;
-
-	/*
-	 * FIXME: The MPS, error routing rules, timeout setting are worthy
-	 * to be exported by firmware in extendible way.
-	 */
-	if (edev->physfn)
-		ret = eeh_restore_vf_config(pdn);
-
-	if (ret) {
-		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
-			__func__, edev->pe_config_addr, ret);
-		return -EIO;
-	}
-
-	return ret;
-}
-
 #ifdef CONFIG_PCI_IOV
 int pseries_send_allow_unfreeze(struct pci_dn *pdn,
 				u16 *vf_pe_array, int cur_vfs)
@@ -786,7 +762,7 @@ static struct eeh_ops pseries_eeh_ops = {
 	.read_config		= pseries_eeh_read_config,
 	.write_config		= pseries_eeh_write_config,
 	.next_error		= NULL,
-	.restore_config		= pseries_eeh_restore_config,
+	.restore_config		= NULL,
 #ifdef CONFIG_PCI_IOV
 	.notify_resume		= pseries_notify_resume
 #endif
-- 
2.21.0

