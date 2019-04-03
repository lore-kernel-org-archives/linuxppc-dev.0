Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47EC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 22:36:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEB3206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 22:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWJ2ybHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEB3206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZLXj6f2dzDqGh
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=jniethe5@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GWJ2ybHD"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZLVx5lV0zDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 09:35:05 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id m10so105452plt.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2019 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=txyQ1vSV5cjL26POChaZ/GWjDuSvWioqZKZmb20Gjn0=;
 b=GWJ2ybHDvAuJo9V7QePnMCShAj4hk3jM2PWWljSE54QczY1D/fKtALdnmxwN/EAG9W
 TpvoBnHZP8inRJoFNvT34wpqvNzPHab/Ry7QqCtk0n0LG41r8JYv3d0KldSZMHskw+vY
 8HVISMRyF51jHGX4j0Vp9q4satdQ2WNs+/eHenrVJfRkQmZc+hkA8gX8Tq8lvix/Go7S
 nybtai+M0dkGRVRefdemI/y1Ra98Nm+7jCMC4+Y0UW+Cs9dzOJYUYCnXoh1EvoHiOsaa
 6/rgsCy2mVH8EI60KtQCXdtkrrR/yXNh8+tW7lMeCBkaV96tROjG/rebTtx0G1C3LZFW
 7+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=txyQ1vSV5cjL26POChaZ/GWjDuSvWioqZKZmb20Gjn0=;
 b=qp3xPHpV68R11fqy+os2DmXvxDmEWhDXu7HBfdVtj3IuC4Tf4Dn9rJFu2xEAZKaJQY
 XI2WfyZdAyMSNyIv6WSeJET1gOcwa3DlQ6w/yuWGtwXQfyx+/EsnKbECMC0t2Olzh8Zc
 Nf+IpeRdGUQH6hwxvdBNz/g/l5Gj67wN+KeFr+Ps/PT/CQSdVf2ijBc6kczq6FbpgkA/
 HWW4Muyir5JnkPA4BUrXImkanTlZ70LAdqd8H4Ny9yKzu1vJuAE8Gjx6/Nbunm31b2Xk
 v7lje5qBXWbzLt1QtRI0FqvdMI1v40isfeBzXmlRPruY5b0uWD3HJ2fP9BhiqqbRvWiy
 iEnQ==
X-Gm-Message-State: APjAAAW79cXgUVhSHpZdz0do4l21s5fViRRboSnL9vlF9ez37lsZmzni
 x0wAt3aigQpBomYHYACbZDyEFAud
X-Google-Smtp-Source: APXvYqxB0ACvEmQPUwKGzB0ZYr2XwdARmoYvuzg0eLjes7u9BAWPjAHdjU0k8ngbBF44bqysxw73sg==
X-Received: by 2002:a17:902:7c8c:: with SMTP id
 y12mr2579847pll.209.1554330902381; 
 Wed, 03 Apr 2019 15:35:02 -0700 (PDT)
Received: from pasglop.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 4sm20194152pgx.68.2019.04.03.15.35.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Apr 2019 15:35:01 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Add mmap to opal export sysfs nodes
Date: Thu,  4 Apr 2019 09:34:44 +1100
Message-Id: <20190403223444.24103-1-jniethe5@gmail.com>
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
mmap. Skiboot trace buffers are exported here with in the series
https://patchwork.ozlabs.org/cover/1073501/. Adding mmap support makes
it possible to use the functions for reading traces in external/trace.
This improves on the current read/lseek method as it handles cases like
the buffer wrapping and overflowing.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v2: ensure only whole pages can be mapped
---
 arch/powerpc/platforms/powernv/opal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b0eca104f86..3611b5b9c5d2 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -714,6 +714,15 @@ static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
 				       bin_attr->size);
 }
 
+static int export_attr_mmap(struct file *fp, struct kobject *kobj,
+			    struct bin_attribute *attr,
+			    struct vm_area_struct *vma)
+{
+	return remap_pfn_range(vma, vma->vm_start,
+			       __pa(attr->private) >> PAGE_SHIFT,
+			       attr->size, PAGE_READONLY);
+}
+
 /*
  * opal_export_attrs: creates a sysfs node for each property listed in
  * the device-tree under /ibm,opal/firmware/exports/
@@ -759,6 +768,9 @@ static void opal_export_attrs(void)
 		attr->attr.name = kstrdup(prop->name, GFP_KERNEL);
 		attr->attr.mode = 0400;
 		attr->read = export_attr_read;
+		/* Ensure only whole pages are mapped */
+		if (vals[0] % PAGE_SIZE == 0 && vals[1] % PAGE_SIZE == 0)
+			attr->mmap = export_attr_mmap;
 		attr->private = __va(vals[0]);
 		attr->size = vals[1];
 
-- 
2.20.1

