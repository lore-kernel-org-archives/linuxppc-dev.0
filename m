Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6A0C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:08:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC99208D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmbiegdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC99208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z0cJ6vkDzF3Nl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 14:08:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmbiegdY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmbiegdY"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzzK6280zF3WT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:25 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id t70-v6so10068748pgd.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8rdAtrhgVyi6Idogrfim0+bEai+yITDjSwhFdlBmD7Y=;
 b=YmbiegdYLklN5/9bAGuguRxu5eclad8PvHFzU3iKCosGLQnfrylAQcPRdl7Zlxztp/
 4czZTm666ZKcb12zkutShKMOiqvMYkjqFJZfohVxQ8EviuE2IOuzB6PYug2HiyCusjc3
 umfzBawMGXrnFOTrazt9LVhxY4RkOCOJDPAMwRN1w6U3FnNczBRZrJdZDExA7pPnV1V9
 UcqNAcHDEX7MCnCrZ7jSe7iflFp+6lwZQD25mEmWgymIJcV704vrLi7vtnoVuOgIUuXH
 95yqz5hzfZJ4Y9C4Ozq4s/Qtnb7at21eNbA+6G+YcsIu50z8bOkAhlU/UpVBmxEj74ZP
 jZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8rdAtrhgVyi6Idogrfim0+bEai+yITDjSwhFdlBmD7Y=;
 b=n/AW5g+pRIfwWhW8D+PlfVH88BD3IDjeVLN5zEFLg/t2mJBeyIxEonbL/oo1AkaSxi
 dOf8Wf3HJzaxw0MQgE5Ltld6mjdOsC8DOsw8IZGVyfFqgJlP63iV6yFKKhaVquFI2h9+
 jqrhvp7I8bNq0B/JqQnOHtzItd2Ul+bHgOYwWHEjTo64QEVfdgbnQxgHQwgL2los3cIw
 u7Z5HfkKzQMPgMaaF9hrx9NVeEHgdgJIdM2j8LTtB0mk3qXt2UhyzMi9Wk9HZHuI6LSZ
 7Po629mRLMO+n6ITOVlEzxTRlVmGDIvHaHOE7eQ0L38vFV+lFEcb3+TkOzKD32zH2q63
 xnJA==
X-Gm-Message-State: ABuFfoiCYBBEgG5zAWfzfb0tvFxlr4huyi8nz77X1VJ9VyWht2XyYSND
 NHlXafCQEGbwHuoUSbbh2Iw=
X-Google-Smtp-Source: ACcGV60JdzVhetJ75MQECTdqsHhSnWMs4quVhWGlUDPXWXLRlPpjgzd66tpbWDDtKnmCykGAQHJrHQ==
X-Received: by 2002:a62:384c:: with SMTP id
 f73-v6mr20171193pfa.242.1539657563837; 
 Mon, 15 Oct 2018 19:39:23 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:23 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 10/18] of: overlay: make all pr_debug() and pr_err()
 messages unique
Date: Mon, 15 Oct 2018 19:37:30 -0700
Message-Id: <1539657458-24401-11-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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

Make overlay.c debug and error messages unique so that they can be
unambiguously found by grep.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 3e1e519c12f0..34396d6db1b3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -517,7 +517,7 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	for_each_property_of_node(overlay_symbols_node, prop) {
 		ret = add_changeset_property(ovcs, target, prop, 1);
 		if (ret) {
-			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
+			pr_debug("Failed to apply symbols prop @%pOF/%s, err=%d\n",
 				 target->np, prop->name, ret);
 			return ret;
 		}
@@ -561,7 +561,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_next_level(ovcs, &target,
 						 fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -574,7 +575,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_symbols_node(ovcs, &target,
 						   fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("symbols fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -883,7 +885,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay apply changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
@@ -1142,7 +1144,7 @@ int of_overlay_remove(int *ovcs_id)
 
 	ret = __of_changeset_revert_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay remove changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	*ovcs_id = 0;
-- 
Frank Rowand <frank.rowand@sony.com>

