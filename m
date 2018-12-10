Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10AFC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:28:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277C020672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277C020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D6Rg71LMzDqTW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 02:28:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.76.148; helo=9.mo179.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 946 seconds by postgrey-1.36 at bilbo;
 Tue, 11 Dec 2018 02:26:49 AEDT
Received: from 9.mo179.mail-out.ovh.net (9.mo179.mail-out.ovh.net
 [46.105.76.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D6PP0HlCzDqcH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 02:26:48 +1100 (AEDT)
Received: from player688.ha.ovh.net (unknown [10.109.143.209])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2664810A68E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:10:58 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id E09069855C5;
 Mon, 10 Dec 2018 15:10:50 +0000 (UTC)
Subject: [PATCH] ocxl: Fix endiannes bug in read_afu_name()
From: Greg Kurz <groug@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 10 Dec 2018 16:10:50 +0100
Message-ID: <154445465027.866316.3631489273007908874.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9368050178655426866
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudeghedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

The double word returned by read_afu_info(OCXL_DVSEC_TEMPL_NAME) contains
four characters of the AFU name, read from the PCI config space, hence
with a little-endian ordering. When composing the string, a big-endian
system must swap the bytes so that the characters appear in the right
order.

Do this with le32_to_cpu().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 drivers/misc/ocxl/config.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index 57a6bb1fd3c9..b76198ba8630 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -318,7 +318,7 @@ static int read_afu_name(struct pci_dev *dev, struct ocxl_fn_config *fn,
 		if (rc)
 			return rc;
 		ptr = (u32 *) &afu->name[i];
-		*ptr = val;
+		*ptr = le32_to_cpu(val);
 	}
 	afu->name[OCXL_AFU_NAME_SZ - 1] = '\0'; /* play safe */
 	return 0;

