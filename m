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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CC4C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:50:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F8C20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msottjjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F8C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z0CW22JBzDrBy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:49:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="msottjjT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="msottjjT"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yzz85CXXzF3Vt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:16 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id r9-v6so10641764pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NBR84y3mbc7GWOaSoRjimr7kNqkK04efsf5Z6wzYUy8=;
 b=msottjjT7t57byr3yNiOwhXhMihvPQXQigcvhD5f5pbFKd/ThIFvO8wHGibRyVHpRL
 Ub5ey294l0Pr4x3AV2gBbzJcMxky3UEdVbfQ2dcPwEMUS+fSuIiqyYEcSJtLdNxz+h4l
 H+mkwxYhtvAVvzrrc7fgzJj8ONhLwA+gbBEltr1BdtFbY1m51zbnw1sXTLEqNWjvTQTI
 fKgiGnrp01wg+cYHx3LuVuLrYy3R6jtGS4fonenuSzvXd3H5Ts5LIrv9TH5eELD0Lwlp
 NUvLm/OpUGQis62W0stkC3RS26QwXJf5caSTUCqX1bWBVph/VhekQTMy8t3V7nA+EEg8
 ypwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NBR84y3mbc7GWOaSoRjimr7kNqkK04efsf5Z6wzYUy8=;
 b=flrIFKbbVq7cnclSYeg7ZdKLpfi/Z+Ni1C+JGlvqcskH3xIPdwnJmGuz2dlp5VXL25
 cN4HQG83tL1yxrnHoezl/XcAhEl4KMXfQw9cRBHHr9NvX1dR4PDgHBWPf377YtPMwAFI
 kOrgyijRGmGrFP0zaky80HhRfA/D4ZFNq/8URWird6hDRevU/mO/KnQr/3tRuwquU4z8
 O47Ef28SOsY1YKQy/9/ix6TKw5yChuyoKPoy6nbPtmxK6q/YAnVyzWG15fDQgd3LIYsX
 IWaGXHAhVQwUGrisaLpAn0KaDwJYJKzaFxTePwwKhjzXNCqr5goLmDdw/lCC0VZ9vX3G
 EC+g==
X-Gm-Message-State: ABuFfoiUiooA4RJiSri+4JNt0IC232y5JZ8P9BI4lZlJE1YhnhA8iRwt
 kUNOc3CrKbRfTtnzZ1JQe48=
X-Google-Smtp-Source: ACcGV63OmN7WqcG9CbRZcHfri79HYMduxEyb95IIxSnJQLDhYJ3RfxSaOJnquiDr6rz5Ik9c5EcugQ==
X-Received: by 2002:a63:d64b:: with SMTP id
 d11-v6mr18251971pgj.450.1539657555084; 
 Mon, 15 Oct 2018 19:39:15 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:14 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 03/18] of: overlay: add missing of_node_get() in
 __of_attach_node_sysfs
Date: Mon, 15 Oct 2018 19:37:23 -0700
Message-Id: <1539657458-24401-4-git-send-email-frowand.list@gmail.com>
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

There is a matching of_node_put() in __of_detach_node_sysfs()

Remove misleading comment from function header comment for
of_detach_node().

This patch may result in memory leaks from code that directly calls
the dynamic node add and delete functions directly instead of
using changesets.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

This patch should result in powerpc systems that dynamically
allocate a node, then later deallocate the node to have a
memory leak when the node is deallocated.

The next patch in the series will fix the leak.

 drivers/of/dynamic.c | 3 ---
 drivers/of/kobj.c    | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 24c97b7a050f..fe8816cca99b 100644
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

