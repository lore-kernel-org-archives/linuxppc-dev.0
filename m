Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68BBC67863
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 23:01:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B41C204FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 23:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbj7F0ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B41C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bl0L74FlzF2Ds
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:01:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pbj7F0ml";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pbj7F0ml"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bkj76lPCzF3FL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 09:48:11 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id f18-v6so14877023pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
 b=Pbj7F0mlm1BgSQnOhWBMy0EmScJ1rGAPVbM1ESkPvgz/QYnjeV6n3/X708Q27A+3Ky
 gnjSjL1ZkosSHjqbqF2rVB7ENb0LzyxV3m1KAxDIAyy/garAd6h5XWMlL0gJ2XmBY3iO
 6TQoyvAXl72WXezqI/AqXqDnF7hyY3AiTNXJNANgr1CKjZp8JnnM/CgWHIDt+7QXZNJR
 0PP2PssKe09PvuVRX4lXRUefrCzY6kWsGN7xtcBhUj84n6FTdN7hc80As7ZWpaPoHAjV
 jbSrBIrpVTPJue6eB6unNRIAr1A3BXteo90te8718midsNcSEX5BLdNYLVOYisIOnl08
 H/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
 b=FmTF4lI22dvze7EaOEIYuc2ug8259PpZdn+32oDDnyr8EBPO5F1Un89yLCjq8h5oEJ
 UOJ2hywgknVqJbvRvmo9j9VBJT8k3pdNICAacLE6deC0jUUYlevOyDX+Gy6SjehYqYBR
 So6SpmipCodFzWxfhqZqT4JqwIalUWawYJznGs3FCVN7tO1m5F2MjWkmkvLS7sGb1fho
 Fni/ojI9TTNrDYMLoWiRD0FI1YQ0MekNdeGqH2HoG4R4TN+/iTTRcfw9e/VH5ik6aS4t
 yCGyUsP+fCuQaHQWplbXUsBMWzJo+6YNMs0S1ef9zs4TWSSm6lAyrNGeskmCwBNeLKp5
 vSqQ==
X-Gm-Message-State: ABuFfohffRAfdicJlnh0fuIg/4NSAHhT2GwVybZlqQ7t1vd2bN3salH3
 ME3CWdzE0e2wAU7CllyEg/4=
X-Google-Smtp-Source: ACcGV60XEeNoeLiDaAGNjfUHWznT5NSnonm0FxYO4wnp575TXwjcJoFz5ZDNhov90TtKuboI5CU/1Q==
X-Received: by 2002:a63:c251:: with SMTP id
 l17-v6mr2804256pgg.146.1539902889847; 
 Thu, 18 Oct 2018 15:48:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 18 Oct 2018 15:48:09 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v5 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Date: Thu, 18 Oct 2018 15:46:22 -0700
Message-Id: <1539902796-8382-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

"of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
added a missing of_node_get() to __of_attach_node_sysfs().  This
results in a refcount imbalance for nodes attached with
dlpar_attach_node().  The calling sequence from dlpar_attach_node()
to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

***** UNTESTED.  I need people with the affected PowerPC systems
*****            (systems that dynamically allocate and deallocate
*****            devicetree nodes) to test this patch.

 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..e3010b14aea5 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

