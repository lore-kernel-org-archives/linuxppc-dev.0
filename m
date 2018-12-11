Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54383C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 18:08:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE7020851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 18:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE7020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dnx610n2zDqmT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 05:08:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.49; helo=2.mo173.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 2.mo173.mail-out.ovh.net (2.mo173.mail-out.ovh.net
 [178.33.251.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dntn1PRJzDqlh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 05:06:07 +1100 (AEDT)
Received: from player159.ha.ovh.net (unknown [10.109.159.20])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id A2770E52B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 18:58:28 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 959CDA2945C;
 Tue, 11 Dec 2018 17:58:21 +0000 (UTC)
Subject: [PATCH v2] ocxl: Fix endiannes bug in read_afu_name()
From: Greg Kurz <groug@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 11 Dec 2018 18:58:21 +0100
Message-ID: <154455110114.974105.12136076223072629095.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18069567608208988466
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudegjedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The AFU Descriptor Template in the PCI config space has a Name Space
field which is a 24 Byte ASCII character string of descriptive name
space for the AFU. The OCXL driver read the string four characters at
a time with pci_read_config_dword().

This optimization is valid on a little-endian system since this is PCI,
but a big-endian system ends up with each subset of four characters in
reverse order.

This could be fixed by switching to read characters one by one. Another
option is to swap the bytes if we're big-endian.

Go for the latter with le32_to_cpu().

Cc: stable@vger.kernel.org      # v4.16
Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
v2: - silence sparse with (__force __le32) cast
    - new changelog
---
 drivers/misc/ocxl/config.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index 57a6bb1fd3c9..8f2c5d8bd2ee 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -318,7 +318,7 @@ static int read_afu_name(struct pci_dev *dev, struct ocxl_fn_config *fn,
 		if (rc)
 			return rc;
 		ptr = (u32 *) &afu->name[i];
-		*ptr = val;
+		*ptr = le32_to_cpu((__force __le32) val);
 	}
 	afu->name[OCXL_AFU_NAME_SZ - 1] = '\0'; /* play safe */
 	return 0;

