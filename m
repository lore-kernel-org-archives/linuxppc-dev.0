Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADCAC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:20:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A6820840
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkrIIu2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A6820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rqlX0DdCzF3XW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:20:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EkrIIu2B";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EkrIIu2B"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rqSl3cX4zF3Wv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 17:07:51 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id g7-v6so437633pfo.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 22:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BPXZwtRgetnBLrUpBT+lCnjneySeub2dSLMA8WGIcW4=;
 b=EkrIIu2Bbaz7Q5a1p4vHI1Ih+6VifByNtOjp+3BxNjeFPo6IbyhKXVMpfWXEYFQNDq
 lfPXfZgxjNaPkAjSwdq9+lLNRzI+/XDcdUpZ0twKVnGeGiWSOrnzA4kLYGzYvXUuAFgv
 rtW7lu/4f2l0wDMZU2rVhxK/sLAgf6Vb1NPT4yvKVmRIAabSkWpgp3YvMZ1bwfr8wFcd
 uhLkSr6XvAD+dopD99rKwir7s6o3iRNDpM5+XkCObgBcasvSwEGcM5r+w+lMwAp67kqN
 jlPI1+gRmFLcX1t0dLWTtrL+K8GrgPvRHuxxvEDjLH25ldqVMUY7wX9CNs40DpFYwzFk
 faRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BPXZwtRgetnBLrUpBT+lCnjneySeub2dSLMA8WGIcW4=;
 b=HKLb21CdT3E9xVqUSZJsdEislAWJiWhED5wAKUbkJqx/kpzr/VkxI4m1Xz9LrSvmzd
 7lW6kE8jHImAprwp52rrWpeTFJk2hOLrlDe5od4buQItv/hi8IiuLDieu3hMhL23E3sq
 aHDWLadffF6OhO46CZToSvi9N6Q/pmR6IMYdR7gususym9ZjFigTNqowx+z1EH56OZb+
 5UWebfsd/O5+y2hfk60HWL5Z5QE346W1Snr+Q/chXxz4k/fMEqRAG7leXdED5iTIK4oN
 KEbnTXS3yYywuKPzIrYkORfVhARGyAJ7q/M3mI//I3RisYlHhzRiwMqV3gc3E9JRq/iE
 uqlA==
X-Gm-Message-State: AGRZ1gIu3qY05EFlOq2QRvBCGOKu5i+dBH2eu0L4flGT8ztktsgUGqrE
 y6isyYwqvQAi2n1/pntq1ZQ=
X-Google-Smtp-Source: AJdET5da2TcsX1KX5EyS3JIzD5KOqYlhS+7XR++v9e006tNHYTB7pPFVWI0qF7pu3+h+EPyEar7FLQ==
X-Received: by 2002:a62:8012:: with SMTP id
 j18-v6mr7624921pfd.202.1541743669402; 
 Thu, 08 Nov 2018 22:07:49 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 08 Nov 2018 22:07:48 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v7 04/17] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Date: Thu,  8 Nov 2018 22:05:52 -0800
Message-Id: <1541743565-23163-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
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

The previous commit, "of: overlay: add missing of_node_get() in
__of_attach_node_sysfs" added a missing of_node_get() to
__of_attach_node_sysfs().  This results in a refcount imbalance
for nodes attached with dlpar_attach_node().  The calling sequence
from dlpar_attach_node() to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

For more detailed description of the node refcount, see
commit 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow
during DLPAR remove").

Tested-by: Alan Tull <atull@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 7625546caefd..17958043e7f7 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -270,6 +270,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

