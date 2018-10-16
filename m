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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59461C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:52:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF682089E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSe2uh2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF682089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z0Gd38cpzDrBy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:52:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QSe2uh2l";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QSe2uh2l"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzzB0054zF3Vt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:17 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id l17-v6so10655374pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
 b=QSe2uh2lmEBWzGocx1091GFtso1i+7JvcwBNHmFcLCaOD9XT58ge0nRjLWnEsf5qKW
 Q7rYPC+wn+HYN+ZQBLHSd7Jv+IT2SMyzU5ZRp3qLwxv9ZgEAD4Z6K+WVbEgXOudkKqSz
 B6qXTLLyzrEaFLq8Dv0KVfuanrf5EEk85M5YHq1EZEnXNnK19YBs56l4homFQOa+4v7Q
 PgjlMiyAafVC4bQUTijplazml94eUr68CoRd2HQb/OZm3dsktc6DA7LKol6V0jDoitAq
 n5txE/0Ol0tzKfWlBU4dLXytbimzSU1jspWGAcAFvy+XTZAOVPZutwGQjST6M6ArYaV+
 lJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
 b=mIZzpvIuQtsKKeNEzzA0+dSVWODrj7csH5qy9fkle2b35GMOu/SFVH+S7BX4dbDsIT
 thx8BeKYusLEIk34wwrRVgGX3SLQ16010g0HDlA4q+tqsc1orV2ledcuMfn5JlqPqfsG
 OHM3fjJxhMVrK1Dryp8nuEuk7fRLcuPv6cTp+OL01nEpIqZoe97xLoRcNEFYLIz8Mq6G
 uv66ZMWRe4YFGq3bRU+1O6RVUsm3oBIrTPa08h5eHpLz42y6aGxgQ3GEeJSTwEQBhRPt
 zUmMxxrylFaJRXhR820S0PPTAWqzX1CtEVPYGrVLaQPp7mdjWCCEsIVoZLf/Je8pFsXI
 JRBQ==
X-Gm-Message-State: ABuFfoiu9swQxGbTigFzebZAXmZLR60edTcH7OhVqjukX9782Kuv8bC8
 3hNzT9I5+WSGIVn5gFg3IMQ=
X-Google-Smtp-Source: ACcGV62qv6djpH8R68FA95H/QfvSFm8orbPd0ksC2pwJ88hxHx2WZA0HtD94qwQDOruHZyvKuRJZ2w==
X-Received: by 2002:a63:9612:: with SMTP id
 c18-v6mr17827455pge.21.1539657556344; 
 Mon, 15 Oct 2018 19:39:16 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:15 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Date: Mon, 15 Oct 2018 19:37:24 -0700
Message-Id: <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
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

