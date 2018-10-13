Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F0FC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:07:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03F320895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjLKBF08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03F320895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XCPR6gmKzF3V8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:07:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjLKBF08";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjLKBF08"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XC7M14MkzF3Tr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 15:55:11 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id j23-v6so7155756pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 21:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
 b=XjLKBF08ZQ+dsEyY+1vcvgFDvIQUH+3J+mij+q0zb8rlPtPBVFuf5qpY1NOYkLMfWI
 LqJaauyLUA2EQ/lBipHWNE0gvwzV7tNahnPnfKggwln8idyWVA6EVc1MNMpOXBMduylD
 hbUgnmPJ3tMlT7Ez7ftzWY9/qtX+3Z8PEP+Wx6XfJEnvDQwMYWSHtLZezIJITXjbsgzr
 qxFUauNaVKokdPIeKVZxfVgmERQM91b3Al/4t14pd+5anf9hSVdzeG0KAt7gK3Br4dze
 MFzqaiAyDAcx9IFrwN8uYqjthUhxIim9HYDqu2myBuMCvzZsF6TY1FJsuVS7IATvdWvM
 KT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
 b=cRstl7cPo44oZ5naQjkYBEbeZ3wpI7cHJbxWo21DyTQ6+AS4HpcxviVdipyLU/c394
 HdFUZGQac8QDOaMuzxFQtiefpOaLycLqhQR/8QFqfX9mFaerW69s2AS6YBub38D+X6lc
 cPMY7xCe/gFgQHgfUMj1CK887dGsMZvDONWnZMnd1GvMCYR75GGxUSLaKUJvMv0Q42zj
 cZhH+t26apfNsSAMA7iPpSHa8yiHSpRZ7oRlwm772bFngK+qhKqS9lyTL3wGH+CvVBkC
 pxTnlyMUdMJJB8CJq618NWt4DFQpb3UXKuikLME/p3Orbx1HlWSn97/CRZWXx0wCE8kM
 GlZg==
X-Gm-Message-State: ABuFfohgE3tgvPbgar2KNBHUvRBmSOS4U7p183RId/B7Gp19qjJ9KHZF
 7BKxdFE1ibjBYLBHyxs9COc=
X-Google-Smtp-Source: ACcGV63Jw8JZON7Ti8uWdCVxtgPjcr/J6vei2RiqRNuBSRDqGBHpxXgxxuMvJCv9Z1oTfYAqhkmFJQ==
X-Received: by 2002:a63:565d:: with SMTP id
 g29-v6mr7995901pgm.227.1539406509460; 
 Fri, 12 Oct 2018 21:55:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Oct 2018 21:55:08 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Date: Fri, 12 Oct 2018 21:53:24 -0700
Message-Id: <1539406418-18162-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

