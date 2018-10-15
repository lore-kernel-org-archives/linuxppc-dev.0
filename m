Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC34C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:36:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AD020652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzv6Yjjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AD020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YKHN5pBTzF0Pd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 11:36:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uzv6Yjjx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uzv6Yjjx"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YK3x0z0XzDrpw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 11:26:05 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id 78-v6so6382262pfq.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LkfoWFcm35ZeWsmFJr143DG24LEUdEKPjd4pwB8vYwk=;
 b=Uzv6YjjxexlLzpyU+vjvP21HgRYfNv92lYn/zG7KSH2fGoP3pgfyjAjHPzNdVF3LPg
 SNve7sEbcEVMTRbSGO+4c3Dmq8fR9CthPMJw9tFMUVzBo2d+JqcpJfMaT/TRyrNgvfN+
 CiPUaOHBdAPQAWhZsGI6XHFk6hhnVG6egN3bM7LS3r7pvPM9srLgW4HURs8AgrJsP+tO
 /6qTvoisEioyMFau2UAhuL4mTmZfJ9n1zDrKGiADiPT8y0c7khGZwWvZke44vh847DAF
 3gARD4Tl8o/no2EyXjTKUkJG953PpXqY7EUngcm08NTM36fMim5OWWskPrpPTBJbuQYy
 ACNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LkfoWFcm35ZeWsmFJr143DG24LEUdEKPjd4pwB8vYwk=;
 b=qSjFMyva6BF9GHuHBIFNZIbBHkgAlQCpjZ7Rok3i0T3u392635GjlkKrtcocqL+30p
 E8WblX4fgwmiLkuKq/LeQcg8jPGqJQAWSxJ3JI4u913jPrdaSSjcE2F8hGaLisAX6CAL
 lH+qYFm/7TsNsNMQBQazO8YEdRdFdZGyhPRJ8QZA/GUOIoivsmK3H+fX0n/5KA88/IVR
 wYGHlF7K0K24X33L/+Eh5J+iefHpZkrQeOCoG98mBXSIFFouzv4tR7S9wqpm4BnRQQe6
 K6/YEAY/bycdXUNfdlYnFguTy4xDw3kG0bgp5qjsLQt1QfBefgWpS6CM+bTG8NJaIipf
 1glw==
X-Gm-Message-State: ABuFfojctZbqxhAWsIWLk+cGtpBg+NMZ0QdeJL/at5RthLPuGYG94zJH
 jvr3lRBuhYgI678XA8i3mQK/efIK
X-Google-Smtp-Source: ACcGV63OIkeAqDgCl/OdYrs584MihorD9M9bqZZ8Kbp8SsSc4pi9nWKmqCOzvVGHS/DHhbEg0pz5vw==
X-Received: by 2002:a65:664e:: with SMTP id
 z14-v6mr13542613pgv.347.1539563163410; 
 Sun, 14 Oct 2018 17:26:03 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Oct 2018 17:26:02 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 03/18] of: overlay: add missing of_node_get() in
 __of_attach_node_sysfs
Date: Sun, 14 Oct 2018 17:24:15 -0700
Message-Id: <1539563070-12969-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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

There is a matching of_node_put() in __of_detach_node_sysfs()

Remove misleading comment from function header comment for
of_detach_node().

This patch may result in memory leaks from code that directly calls
the dynamic node add and delete functions directly instead of
using changesets.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/dynamic.c | 3 ---
 drivers/of/kobj.c    | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index b04ee021a891..275c0d7e2268 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -272,9 +272,6 @@ void __of_detach_node(struct device_node *np)
 
 /**
  * of_detach_node() - "Unplug" a node from the device tree.
- *
- * The caller must hold a reference to the node.  The memory associated with
- * the node is not freed until its refcount goes to zero.
  */
 int of_detach_node(struct device_node *np)
 {
diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 7a0a18980b98..c72eef988041 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -133,6 +133,9 @@ int __of_attach_node_sysfs(struct device_node *np)
 	}
 	if (!name)
 		return -ENOMEM;
+
+	of_node_get(np);
+
 	rc = kobject_add(&np->kobj, parent, "%s", name);
 	kfree(name);
 	if (rc)
@@ -159,6 +162,5 @@ void __of_detach_node_sysfs(struct device_node *np)
 		kobject_del(&np->kobj);
 	}
 
-	/* finally remove the kobj_init ref */
 	of_node_put(np);
 }
-- 
Frank Rowand <frank.rowand@sony.com>

