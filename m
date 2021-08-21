Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A7C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Aug 2021 02:11:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EF761248
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Aug 2021 02:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0EF761248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gsf4c07gqz3cKC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Aug 2021 12:11:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uDNtxkoU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=40.107.93.61;
 helo=nam10-dm6-obe.outbound.protection.outlook.com;
 envelope-from=sdonthineni@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=uDNtxkoU; 
 dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GsKDX72Xxz306d
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Aug 2021 23:32:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8Werd2wJDl9/U2/dgQdRuTkTce71OiueaFGoFlLifQMM3QjOhQa5my2awsg5t74rdLvcvFfMyB/a7nDDFcmjcP1MRX7OQGrEtcM2kyS4a7amR7gZhpsgFvLegleI0DjHEYQFdsFpkojdwp+nZ/wcqjjjg0M0B2PdnJcDC9I9Z5Yd+/wUQrDCA7AISZNub/VW4EnaCY+RdijjK8WSJoHX49PrmujGXhXbRQ4EEvtss3bgIQ/ZVYEy+35UfWNcFbgQPC8GbA3o+NV+RLwx1LDk/C7veU5liA15JQrNV5TcC4Ca0JDjb46I+lrIGZpLbr9tJJGL3hrZxDmqjN7ZZT3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjMngojx55L/Yyn2PZu/YctnxwGMdAG6CW9w5PhbRJc=;
 b=odOl0gOq/c+PFbRYpHLl0rHSw9FQYY6tAfIAYVJdPJtfj0bJSbPMN+Dj5x3v6jrGAjvgvArSB0F6oVVZnVN1ygAjaPiTww9VMMlrBsCXudMuUTJOrXgUlSOiEWy0SI+DFSVYmXEHHOXSiyRizIbH8t/6zG7Sf7hNt5Itwj1SdL8U9UsGavV5NObpG6o/4W0sTPS5l9/KrmXwY1QKxW6U7O5JwpW+o9mV7NSNB1JRygBu45J6SnqbcGp4fQ9+UgV7+GoM/TqLU47l6BB7DmlCYzus5qT6HAmqIToPqAvdgpOMjUnSacH4xtHUm/buktJPS2mq54YUqg4nrw9tMl81Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjMngojx55L/Yyn2PZu/YctnxwGMdAG6CW9w5PhbRJc=;
 b=uDNtxkoUsg8f1H3ss5YwIH2knNIzpWhg9moYYt/9G2yyh7YX2tcM4eZCbfpGydKdoK7exOnpuhYVoaLjIcxR965j+JzRk1iWUhuQPkPNpqTAibEiD4Rbj7D4s2J+bOCG936kZuNXfvX3YNPWCZri7rd5K0wYmeTKoERuzg6CpBx00AmAkqwLj7q+BqXZyqiAkWAZjE3q655KKLJTL4BdLT6QpMxYTXeFhe0wsxkBaVRSPNDFbFiQrhpY8kdB1qAJRr36rXi5PkVKsRPux/WC/SM5aPsx+/ti6JjDw0v0Eedhh2r7rYw/tYjZ/rD6VUKK8AJc5Mq/7526/nKy67nPUA==
Received: from MWHPR21CA0047.namprd21.prod.outlook.com (2603:10b6:300:129::33)
 by CY4PR1201MB0229.namprd12.prod.outlook.com (2603:10b6:910:1d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Sat, 21 Aug
 2021 13:31:47 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::48) by MWHPR21CA0047.outlook.office365.com
 (2603:10b6:300:129::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.0 via Frontend
 Transport; Sat, 21 Aug 2021 13:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4436.19 via Frontend Transport; Sat, 21 Aug 2021 13:31:47 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 21 Aug
 2021 06:31:46 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 21 Aug 2021 13:31:44 +0000
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/AER: Continue AER recovery of device with NO_BUS_RESET set
Date: Sat, 21 Aug 2021 08:30:58 -0500
Message-ID: <20210821133058.31583-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 220c93d7-ec84-40d6-5c0e-08d964a80649
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0229:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0229290DCFB83C980AF9A2F3C7C29@CY4PR1201MB0229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nRHchyZ2TToZSe8E1RSwL9EyFOQcR+ed6Lkp2v+qeC0ghi4hsldNwti/vyUvC7q++L2n5IFOUIn3CRSdO1lHkeuFfVbG7zfFfQ9TGVJCSr9CMs55WeeM8Ar9OeSxpZCUOelkE9MU6ApTGBjqK0jAloJgbjSa640bSBzzUOrPpGbyVbKQUAgbEOd0hCt8+ge6Mq9+Czvp0DsuxLteR545ZJpBjW1LTwphAIW3icu/PA2jZjMK+/aeRNb9Tg6MyK8aWVQrwKxO7NICAHEHicEspRdyIax+Qm/NT+IGxd99w7AVye9WGDqEA6FXnLlxo0Q2fhmPoLYupm3DaeP+vQY3H9USdyyowO/TIsicU0MXma0hAz0Zx7IveVZOnyYZgmYPA/lavDbZzjOf2NId8RntrKQBG3O5BcblE5vBEZbeNBuGYp85ADjUmxlbOcgjSMfnClhEyrNlrUFPBx4RIquH87JAp5jMMNWriq9o9ZA8VB0lLKwY3GYvs6vA2yQRDhG4GuiYYNbfMKtXzZBY8xVE7khS8siYxjMPZn0xnNlO+TXYRpM2w/0QgQrtdKOQdl74F+fiu6OuU6btpzW33JXxpPov2Z+2RKe4OkFJN+B5sM6DKkyJ+YnaDbfRa2PCbjKlJI56Fp1i436oTkAklb9PdJnHJzbcL4xgmWq/kj5QwEI5tLjKz5GpRlILhFRQ5nlvMGRk1OM9Lg1qw9wWDt8usDki9Np2AO09p8bIDoFZTc=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(36860700001)(8936002)(16526019)(70206006)(7696005)(82310400003)(478600001)(1076003)(5660300002)(70586007)(47076005)(186003)(54906003)(83380400001)(316002)(4326008)(8676002)(2906002)(336012)(36756003)(86362001)(107886003)(6916009)(6666004)(26005)(356005)(2616005)(7636003)(82740400003)(426003)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2021 13:31:47.1270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220c93d7-ec84-40d6-5c0e-08d964a80649
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0229
X-Mailman-Approved-At: Sun, 22 Aug 2021 12:10:43 +1000
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Shanker
 Donthineni <sdonthineni@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Oliver
 O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In the current implementation, the AER FATAL and NONFTAL recovery will be
terminated for the device that exhibits NO_BUS_RESET quirk. The non-zero
return value from pci_bus_error_reset() is treated as an error condition
in aer_root_reset() which leads to return PCI_ERS_RESULT_DISCONNECT.

  aer_recover_work_func()
    pcie_do_recovery()
      report_frozen_detected()
      if (aer_root_reset() == PCI_ERS_RESULT_DISCONNECT)
         goto failed           # termimates here because of NO_BUS_RESET

      ...
      report_mmio_enabled()
      report_resume()
      pcie_clear_xxx_status()
      ...
      return 0
  failed:
      pci_uevent_ers(PCI_ERS_RESULT_DISCONNECT);

The return value -ENOTTY from pci_bus_error_reset() indicates SBR was
skipped but no real errors were encountered. This scenario could be
considered as a non-error case so that the PCI device driver gets the
opportunity to recover the device back to an operational state instead
of keeping it in the DISCONNECT state.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/pci/pcie/aer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9784fdcf30061..8cf6bd6a3376d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1414,8 +1414,12 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
 	} else {
 		rc = pci_bus_error_reset(dev);
-		pci_info(dev, "%s Port link has been reset (%d)\n",
-			pci_is_root_bus(dev->bus) ? "Root" : "Downstream", rc);
+		pci_info(dev, "%s Port link has %sbeen reset (%d)\n",
+			pci_is_root_bus(dev->bus) ? "Root" : "Downstream",
+			rc == -ENOTTY ? "not " : "", rc);
+
+		if (rc == -ENOTTY)
+			rc = 0;
 	}
 
 	if ((host->native_aer || pcie_ports_native) && aer) {
-- 
2.25.1

