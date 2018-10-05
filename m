Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751AAC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:27:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38A820875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB/pc7f8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38A820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RGtq5L6dzF3G7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:27:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aB/pc7f8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aB/pc7f8"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGbt4GKlzF3FT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:14:18 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id m77-v6so4425685pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 21:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
 b=aB/pc7f8FxZc7uvWjU1rnHCfgnfN0z8C3vWsTvXR9xDr0ZaXu3l+aKzPSrD4J/PtBZ
 g6Nuvdx+FJHvQzlFn43EqB/Z0MzHmEKcv1sd7dlaF3rQKM0RC8DzbbXZ7AYmPTj0YgP7
 JaNzyAfaTGpL3cArYhv5Hh70vUMvjcEmFJ84jyhunUzqBjEFYxl6x84NDxj7okW3QMqC
 YeTjxPW8riexKDFWU3ZxE+A+p0Xfw+CoXkCmw+TbQsh7MqEXC4l5jCGSIC+Ldz5whgSA
 Yt2TKSKwgjN0TIYIlZPyDhu4d4r4EkSPrEFm8W/G3FlffIMGXsztEQkdK2uW60nMD21l
 HzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
 b=P6Z/phCyYuAyC+27LO+6XPDEOxnctDtc4OQO6Wu1TaSHRlALa8q/QRNsZxu1oPVCW/
 mPqSKo3wg+eo4HJrbiRlkiwgqD4+RlhNMXwAF2mumkTfpEvFAY1TBiwqFPAID8lvjvMX
 6K+nXscUJ3lw3eiGYqSE5APfMxctjpxs01xY6yVaf9WfvQUb6kXX0DEqTG5gyfoR2r1F
 AUmUX5NFXjJEi/Aa2Q22OxZDBvF5D/cJrqI/2yBiUBjf2rZr1+QdIB5V7TtOFp6U/UKX
 PhOx0ULQCoVMfRoBV8r4eEZAoKDxAQP/I2j9Ky5WdilfpIO0ZoA5r41ubroWX8jXuLrS
 +58A==
X-Gm-Message-State: ABuFfogFCEotdaV0d3hUFRfc+QakivGle9nNdVyCDxyBXplz/8AkJ3ZQ
 Laqz2TmzWYtHdmS3Ag5KmU4=
X-Google-Smtp-Source: ACcGV61470fq1TFoZi6jkEm12Z57jOx/YB0UTtMISFtSwg/fGVSHpMljSvPiU4o8Onwg3riTLIACxg==
X-Received: by 2002:a63:6203:: with SMTP id w3-v6mr8425138pgb.53.1538712857052; 
 Thu, 04 Oct 2018 21:14:17 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 04 Oct 2018 21:14:16 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 04/16] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Date: Thu,  4 Oct 2018 21:12:35 -0700
Message-Id: <1538712767-30394-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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

