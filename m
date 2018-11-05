Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2917C46475
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:37:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2DB2085A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTlZt5u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2DB2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pcHJ19DrzF1Qn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 02:37:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTlZt5u6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTlZt5u6"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc3k0TfXzDrJP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:26:58 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id f8-v6so4382388pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Eps1KFA7lEghL7/4dmQbZz3ImKypsw61x2xaOWgNqDg=;
 b=gTlZt5u6/vzKqoG3PjCr8lAQ26z5MBBKNrCnWqffkqsJlD5p6kXawKm6ffNfxxIQT/
 RzUgUTxlCAv1sCjEsZNkIFACMb7xfs8Lf08QdG9wJHa9LQgYJuu3MhcIUwkA5OltE/nn
 KWUp8nAdz8iaay9kFo10eXDaWTkjTFtB9ikhiraNL16qwmBh2ntT1/XRkyuKfP1lGGiQ
 FI7II6KnWwG3hbiErSQXPqBbldUtlsEk5MczQ+hae+aNNE1xoWN+Py81rHXDX2ncKwQm
 OLV8oNcGGdu5RmZKELszJbV6l5rOvAQ/qkcOUVX+/hxVZ2grPzjtWPRd0gsu5USArgFB
 kANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Eps1KFA7lEghL7/4dmQbZz3ImKypsw61x2xaOWgNqDg=;
 b=Zgn+tiyhJ0BJYa4I0d+ld2NfugOjA/E+wrfOOJ4BMwD23o2OWaIXlZVkqoJy3t4xrw
 w1XvMPz4H9r4WcCafsQQNnVqRnko+ADy5qs175DzMcvjFqaiObmxMvHfpb3tE4e2GcXh
 mtTmXhxFKcMDWyjIWV60hydrBpRLclwh5cLjUjYYPP/w7KX6ZdHHUBlRcPvvduoWwMEo
 x7CSCxtlkpO/uLdh+9bW9C31TrK4bEiBAWfTRfMZIaUHImfgqB+n006nQbzD8c3H5TQt
 iz44T+tvsgUqc1tjtvFsKjM/ojJ6LYoZI5rIk3cSDP1yVtiQbnmndpk33soudZBAMsLv
 jMBg==
X-Gm-Message-State: AGRZ1gJd5kRHSE2M0UgHT7q7y1mZFzOqt17mNxca/BY64z+BeGUPmpT1
 pMw2BshK2QR/YLGMOWeEFQs=
X-Google-Smtp-Source: AJdET5el0E2+PBwqJW9dh4BMEuo83mkeQc3jYFOppW0RBR0EZIN6ZXgfPkxK0Uag69Vo4Ew5+zGS5A==
X-Received: by 2002:a63:3c44:: with SMTP id i4mr20326569pgn.286.1541431616477; 
 Mon, 05 Nov 2018 07:26:56 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.26.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:26:55 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 03/18] of: overlay: add missing of_node_get() in
 __of_attach_node_sysfs
Date: Mon,  5 Nov 2018 07:25:00 -0800
Message-Id: <1541431515-25197-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
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

Tested-by: Alan Tull <atull@kernel.org>
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
index 12c3f9a15e94..146681540487 100644
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

