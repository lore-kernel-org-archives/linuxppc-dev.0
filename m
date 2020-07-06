Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276D7C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 01:49:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EAB2070C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 01:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HweXYWfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EAB2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0T5c2VF2zDqWp
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 11:49:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::442;
 helo=mail-wr1-x442.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=HweXYWfj; dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0Spr0QxjzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 11:36:51 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id j4so36704534wrp.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2020 18:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z9zwnh1ydl0nlHwdZf+HyBKCchw5zt9SbYi8//YDBmA=;
 b=HweXYWfjRBi4BFIfmj94lYJcW9Fk5K65fumR/asL+FJ3dB063SZxSF4snobHG8XaMv
 V2I0eJBdDucvA8qNu+YP8d5np/SgOHuarxNrr/OLM/mowDhDYICld63Wo9QM/ytWlHid
 iT8imQt45TTdM/Haa/AxiyXXfolCLygXkcD+6LK2aPexBiyGsOqpBQvHWx4/wurlUo4S
 UQ6trSvAbQ7HXZGaBrQeaLbrOdzBwsJ4jZSuM+yvrT0zXEgy2N3/rCBiltVoeHkb+hXd
 NJT+wO1VMOnCYUyHqnaP7cPKLfa8sVtfzivCiUbCYOnNrGqdv9nQ+wOJXVi652R+nHTZ
 1RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z9zwnh1ydl0nlHwdZf+HyBKCchw5zt9SbYi8//YDBmA=;
 b=CxFwPtq2RiClpf9ZoE5llS2fTay81QXxkmDzZHypnibQIUZcCaMGViCT05tWjAv3Y2
 fN6Is3hVxpIHw9EAADYBBizPiRTIGT2PQewu1usGhP+InhnlItKDaNThbA74EudXq2/U
 qNU9gECibxtpHzn/Q0f+qGghbAQYZWlG85eGvCSsOO3S0dpNizfj3nflPnKUHQ6wyLDT
 rQX98CQLBUDSgjXir67HVLQhGFRe7/8PevTS/nQ+lRatIVCJsUj12HmMORB2FOe3c726
 P9MmGvYzzyrkia5ysxrIXSAXw+xnmZAM9CXmLZx2nhTt9FJ+8AGLXo1nl+jbRLYMfpeH
 Vkig==
X-Gm-Message-State: AOAM53082l18jDsPQxUUoU3MZbLfkdxqPLnFsXmBDyt/IgqidMdLOEsT
 SvU8LFefSTdkcL/kNN6iBHrGaCMNrYQ=
X-Google-Smtp-Source: ABdhPJwabYnCnkz34if9X0LEoJXYGUZDnH4QowdbzM3kgcYKUxZ6bs9lXG1eskFFocIoOEuEyA6jxA==
X-Received: by 2002:adf:fe46:: with SMTP id m6mr43974928wrs.192.1593999408436; 
 Sun, 05 Jul 2020 18:36:48 -0700 (PDT)
Received: from 192-168-1-18.tpgi.com.au (59-102-73-59.tpgi.com.au.
 [59.102.73.59])
 by smtp.gmail.com with ESMTPSA id v6sm9533392wrr.85.2020.07.05.18.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 18:36:47 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/14] powerpc/pseries: Stop using pdn->pe_number
Date: Mon,  6 Jul 2020 11:36:09 +1000
Message-Id: <20200706013619.459420-5-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706013619.459420-1-oohall@gmail.com>
References: <20200706013619.459420-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>, mahesh@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pci_dn->pe_number field is mainly used to track the IODA PE number of a
device on PowerNV. At some point it grew a user in the pseries SR-IOV
support which muddies the waters a bit, so remove it.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index ace117f99d94..18a2522b9b5e 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -52,8 +52,6 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 	dev_dbg(&pdev->dev, "EEH: Setting up device\n");
 #ifdef CONFIG_PCI_IOV
 	if (pdev->is_virtfn) {
-		struct pci_dn *physfn_pdn;
-
 		pdn->device_id  =  pdev->device;
 		pdn->vendor_id  =  pdev->vendor;
 		pdn->class_code =  pdev->class;
@@ -63,8 +61,6 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 		 * completion from platform.
 		 */
 		pdn->last_allow_rc =  0;
-		physfn_pdn      =  pci_get_pdn(pdev->physfn);
-		pdn->pe_number  =  physfn_pdn->pe_num_map[pdn->vf_index];
 	}
 #endif
 	pseries_eeh_init_edev(pdn);
@@ -772,8 +768,8 @@ int pseries_send_allow_unfreeze(struct pci_dn *pdn,
 
 static int pseries_call_allow_unfreeze(struct eeh_dev *edev)
 {
+	int cur_vfs = 0, rc = 0, vf_index, bus, devfn, vf_pe_num;
 	struct pci_dn *pdn, *tmp, *parent, *physfn_pdn;
-	int cur_vfs = 0, rc = 0, vf_index, bus, devfn;
 	u16 *vf_pe_array;
 
 	vf_pe_array = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
@@ -806,8 +802,10 @@ static int pseries_call_allow_unfreeze(struct eeh_dev *edev)
 			}
 		} else {
 			pdn = pci_get_pdn(edev->pdev);
-			vf_pe_array[0] = cpu_to_be16(pdn->pe_number);
 			physfn_pdn = pci_get_pdn(edev->physfn);
+
+			vf_pe_num = physfn_pdn->pe_num_map[edev->vf_index];
+			vf_pe_array[0] = cpu_to_be16(vf_pe_num);
 			rc = pseries_send_allow_unfreeze(physfn_pdn,
 							 vf_pe_array, 1);
 			pdn->last_allow_rc = rc;
-- 
2.26.2

