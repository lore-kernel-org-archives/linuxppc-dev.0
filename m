Return-Path: <SRS0=sHkL=Q6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE1C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 14:03:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AACB20665
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 14:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AACB20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4469084xxbzDqW5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Feb 2019 01:03:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=neutral (mailfrom) smtp.mailfrom=lip6.fr
 (client-ip=192.134.164.83; helo=mail2-relais-roc.national.inria.fr;
 envelope-from=julia.lawall@lip6.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lip6.fr
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4468vP1M7VzDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Feb 2019 00:58:56 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.58,403,1544482800"; d="scan'208";a="370609502"
Received: from palace.lip6.fr ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 23 Feb 2019 14:58:44 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Scott Wood <oss@buserror.net>
Subject: [PATCH 03/12] PowerPC-83xx: add missing of_node_put after
 of_device_is_available
Date: Sat, 23 Feb 2019 14:20:34 +0100
Message-Id: <1550928043-14889-4-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add an of_node_put when a tested device node is not available.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
identifier f;
local idexpression e;
expression x;
@@

e = f(...);
... when != of_node_put(e)
    when != x = e
    when != e = x
    when any
if (<+...of_device_is_available(e)...+>) {
  ... when != of_node_put(e)
(
  return e;
|
+ of_node_put(e);
  return ...;
)
}
// </smpl>

Fixes: c026c98739c7e ("powerpc/83xx: Do not configure or probe disabled FSL DR USB controllers")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/powerpc/platforms/83xx/usb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -u -p a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -221,8 +221,10 @@ int mpc837x_usb_cfg(void)
 	int ret = 0;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-dr");
-	if (!np || !of_device_is_available(np))
+	if (!np || !of_device_is_available(np)) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 	prop = of_get_property(np, "phy_type", NULL);
 
 	if (!prop || (strcmp(prop, "ulpi") && strcmp(prop, "serial"))) {

