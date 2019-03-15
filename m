Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C60C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 00:56:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E9621872
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 00:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQLB95aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E9621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L6bB6KyDzDqRc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 11:56:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=jniethe5@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQLB95aK"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L6YL3tshzDqQY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 11:54:44 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id r124so5180668pgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 17:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cLUxlX+YFOAKpK7VFiA2EHSBNBNdlYrNH5UZrNd36nU=;
 b=aQLB95aKMTRBTkTOGMf8KLW5WwooOhuNXDN/mVqm7LpTf9YZhZnuEHFG/wE8ogW07Q
 BM22ULwrB4lXDGe4vv55T9V4Yl2838d5pTiVPctouTz9rdS7KMtmZbjbHLXW75iRBFRg
 nN/MmMjAIOAgpfv7db/mc8/4F62phRU3dTpNuILHFZy8hVehVEncdYHeMNOIOF+oQgP7
 vrf/+WrEHWt847hC9zMADqEnW/Da4HuZMYNW+XWZR0kB94Fd/BbzJF7AVUOzwDDltDBc
 6r3b7axIfRNtgdBHX/wHePUj4IWaQf2juzshxIZ2VNuBBHwrBwydGzsBAnQUprtR261B
 L1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cLUxlX+YFOAKpK7VFiA2EHSBNBNdlYrNH5UZrNd36nU=;
 b=T9p3IxZUzCw0O2D46ZAplz5fPiVCTnLUJi8MiOVbBsfwjXP1mtswkfaXfk+oScxmE8
 hG3lG6hBv5bU0tp642twwXFqt3AhD/lnhBVVADpC/RTy5uVhGW9bQM6brKmuptIRghct
 adVduQ2TWI5NNRTt47atFCJ8xpEQIxTqiGCcOB/6Tbq3UEHFgl5pe1s1ToipFwnECIAw
 57LxTFHegH3/CgW6FLJ5SaHkdk5vwpejpkZxHElJdQFwteXtYln5FkCfSQ8+gSN42Du8
 jltggH9ZQZKdpbVgCGb6/HSxn6iHgJeixaYSt7MMPml2LVsGfMjGeScDWh0UO1o4WObz
 N2xQ==
X-Gm-Message-State: APjAAAV/kUXbzMzUhFNad/lrnZDNyBdBt8vZNfzJ3vz/8rq6zUSHZUjM
 3WLpAcBWA8Lx/9DuBwAMpT/oxFHu
X-Google-Smtp-Source: APXvYqxoddg2yCfvZc+/jMa8a9s189uvT6wQhRvFEIitSw1Yb5EuPVH0fTCkJxjal2StBt0OC2BEag==
X-Received: by 2002:a63:4550:: with SMTP id u16mr724584pgk.73.1552611280384;
 Thu, 14 Mar 2019 17:54:40 -0700 (PDT)
Received: from pasglop.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id q7sm381036pfa.119.2019.03.14.17.54.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Mar 2019 17:54:39 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Add mmap to opal export sysfs nodes
Date: Fri, 15 Mar 2019 11:54:20 +1100
Message-Id: <20190315005420.20212-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Jordan Niethe <jniethe5@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The sysfs nodes created under /opal/exports/ do not currently support
mmap. Skiboot trace buffers are not yet added to this location but
this is a suitable for them to be exported to. Adding mmap support makes
using these trace buffers more convenient. The state in the header of
the trace buffer is needed to ensure the read position has not been
overwritten. Thus the header of the buffer must be read, then the
read position itself. Using lseek/read to do this introduces a delay
that could result in incorrect reads if the read position is overwritten
after the header is read.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b0eca104f86..3cfc683bb060 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -714,6 +714,15 @@ static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
 				       bin_attr->size);
 }
 
+static int export_attr_mmap(struct file *fp, struct kobject *kobj,
+				struct bin_attribute *attr,
+				struct vm_area_struct *vma)
+{
+	return remap_pfn_range(vma, vma->vm_start,
+				__pa(attr->private) >> PAGE_SHIFT,
+				attr->size, PAGE_READONLY);
+}
+
 /*
  * opal_export_attrs: creates a sysfs node for each property listed in
  * the device-tree under /ibm,opal/firmware/exports/
@@ -759,6 +768,7 @@ static void opal_export_attrs(void)
 		attr->attr.name = kstrdup(prop->name, GFP_KERNEL);
 		attr->attr.mode = 0400;
 		attr->read = export_attr_read;
+		attr->mmap = export_attr_mmap;
 		attr->private = __va(vals[0]);
 		attr->size = vals[1];
 
-- 
2.20.1

