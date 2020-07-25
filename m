Return-Path: <SRS0=T73o=BE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EB7C433E1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 08:19:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D1F206E3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 08:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J88uH69C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D1F206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BDJs51svkzF1R4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 18:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=J88uH69C; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDJj20nRFzDqcx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2020 18:12:53 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id b9so5743631plx.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2020 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EtnNMRWRkvexQOTkqZ31SnrSAWw1F855iKUH9AQWyww=;
 b=J88uH69CWJ3lu3TvKvDyEYWgXd5hFw2fWBO+1z2/27D4WBb2AMQrMXzUAgQdpqerdl
 DQz3OM7cFieY7fqAejD9s02/mf9gV23YiTXgERt/DNYJA8NpVs9aYpuDRjD585Zm3zJJ
 MYcvqB/xv7g49I/vEgFV2HxTNCJlU1Fu/1frX/Wa6nZ6GmJ61cJzuRgfFZrGW69Rsm1v
 ZcfiWvNwXSwKjzgPdwWanuWqw8nDdTSqdR17CBkSts46l7Qv3+aw44WbBDwRMGlKJ0CU
 aGhZnPJ2tUG/m9YQeuBHgxbl6SxgkcWQ/UeqxjwnFMQpuWU45tpnhKLUKV8vlHGknv++
 ZGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EtnNMRWRkvexQOTkqZ31SnrSAWw1F855iKUH9AQWyww=;
 b=m6VZsJ+AMG1t748qPQPBNEAnruUBb7ySAmPvtDJDbw67xJYaUzggy10IQ2BkgRHU8/
 Q57qE5HXJJI/q2Jg1AeeaReoiCokaRa08jemhWGvV6JjH8EQ+ZyW3YVKr7tFkmgb9NhF
 MrJKYT518NDBOiJqyHW6OC3pKmJkluyewnRQx/F90nCaHvRrAHstB+1+h9zLpX7juMhz
 IXgnT1+Vk0T8X0CbO7jcsoIlM77reuw6zokkogTt68k9XXHAayVn0xmxK9fZlu/MjoZI
 M5uMrXZaNPbeSBcR/0MJtEaDjY2SBAtdUZpM6qCgbzrnVwFXlxMomxwBexbP7zgPfOtt
 1p9Q==
X-Gm-Message-State: AOAM531CcO20AJhIPNtyk5Zz/xxa2h82APqclicv6307a2DAgp4zLVKQ
 MZ6CQCOth6rJ1pG96T3LDmt8J3LJykw=
X-Google-Smtp-Source: ABdhPJxhduEd2jU5D+R0izvw7iMo8hE59t03l/m9J/wWoGhERc9URHBb9FB2aSJlP28km2/v3hPMPg==
X-Received: by 2002:a17:90a:dd44:: with SMTP id
 u4mr8504397pjv.203.1595664771806; 
 Sat, 25 Jul 2020 01:12:51 -0700 (PDT)
Received: from localhost.localdomain ([118.210.60.180])
 by smtp.gmail.com with ESMTPSA id a26sm8647360pgm.20.2020.07.25.01.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 01:12:51 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 04/14] powerpc/pseries: Stop using pdn->pe_number
Date: Sat, 25 Jul 2020 18:12:21 +1000
Message-Id: <20200725081231.39076-4-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200725081231.39076-1-oohall@gmail.com>
References: <20200725081231.39076-1-oohall@gmail.com>
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

The pci_dn->pe_number field is mainly used to track the IODA PE number of a
device on PowerNV. At some point it grew a user in the pseries SR-IOV
support which muddies the waters a bit, so remove it.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
v2: no change
v3: no change
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

