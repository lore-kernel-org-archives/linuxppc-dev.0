Return-Path: <SRS0=MZVM=KK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD06C433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 05:28:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668576023E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 05:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668576023E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fhv7p1cykz3c5n
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 15:28:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.218.52; helo=mail-ej1-f52.google.com;
 envelope-from=kswilczynski@gmail.com; receiver=<UNKNOWN>)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fhv3R19DQz30B3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 May 2021 15:24:51 +1000 (AEST)
Received: by mail-ej1-f52.google.com with SMTP id u21so1537211ejo.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2021 22:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B3UpkKoHQG0tf/oaVD2LnuLhgOWE3b/n2dCLRadGIF4=;
 b=kuFirOCz0OhTAQ1pkxlYYgESQyw5G/4GrkuvybktXq1onmsR5AFCqWY2AGV2o+NGGk
 HPW9N5OFAD9BpKvQc9jccqF6Q9QqmHo2APR1/YOXYgNMYDAUco85mYdB5nIfohS6p60H
 c0+T5hqIiFvyrd0oyTQP9RScUxt5rifOy+NHf0c9qr74sWXHh62JmFA9p5Ysy1wPvI9/
 wmYeiea3O/PtK/QDFgqg9SWX5wV+imBCPOQ+xQeY/4omu65MZzrGyXBJDxE6He0OJN5P
 DdO0bj5B/pd2z7DLV7C/CDh6laiovv0b2x6PXB9CmsFjX4uPh7KpCGYV3dm1qim4nH7X
 hpnQ==
X-Gm-Message-State: AOAM530ZwdwGgAT5fVK2TV+oq+jAM0hJui/jlSerzGqYpqyAg/Vq+dt9
 CCsSFopky/TlvXNPJ1PUHj4=
X-Google-Smtp-Source: ABdhPJyGXrwiw6AUEQkiZNiiFMo18eHtQ1pD3BH99lSq0gDTyHGjespN0d9GO5o1Cd76Qnuv/DwQMA==
X-Received: by 2002:a17:907:2646:: with SMTP id
 ar6mr19927960ejc.293.1621056288007; 
 Fri, 14 May 2021 22:24:48 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 22:24:47 -0700 (PDT)
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 12/14] PCI: Fix trailing newline handling of
 resource_alignment_param
Date: Sat, 15 May 2021 05:24:32 +0000
Message-Id: <20210515052434.1413236-12-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Vidya Sagar <vidyas@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Joe Perches <joe@perches.com>,
 Paul Mackerras <paulus@samba.org>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The value of the "resource_alignment" can be specified using a kernel
command-line argument (using the "pci=resource_alignment=") or through
the corresponding sysfs object under the /sys/bus/pci path.

Currently, when the value is set via the kernel command-line argument,
and then subsequently accessed through sysfs object, the value read back
will not be correct, as per:

  # grep -oE 'pci=resource_alignment.+' /proc/cmdline
  pci=resource_alignment=20@00:1f.2
  # cat /sys/bus/pci/resource_alignment
  20@00:1f.

This is also true when the value is set through the sysfs object, but
the trailing newline has not been included, as per:

  # echo -n 20@00:1f.2 > /sys/bus/pci/resource_alignment
  # cat /sys/bus/pci/resource_alignment
  20@00:1f.

When the value set through the sysfs object includes the trailing
newline, then reading it back will work as intended, as per:

  # echo 20@00:1f.2 > /sys/bus/pci/resource_alignment
  # cat /sys/bus/pci/resource_alignment
  20@00:1f.2

To fix this inconsistency, append a trailing newline in the show()
function and strip the trailing line in the store() function if one is
present.

Also, allow for the value previously set using either a command-line
argument or through the sysfs object to be cleared at run-time.

Fixes: e499081da1a2 ("PCI: Force trailing new line to resource_alignment_param in sysfs")
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ed316ea5831..7cde86bdcc8e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6439,34 +6439,37 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 
 	spin_lock(&resource_alignment_lock);
 	if (resource_alignment_param)
-		count = sysfs_emit(buf, "%s", resource_alignment_param);
+		count = sysfs_emit(buf, "%s\n", resource_alignment_param);
 	spin_unlock(&resource_alignment_lock);
 
-	/*
-	 * When set by the command line, resource_alignment_param will not
-	 * have a trailing line feed, which is ugly. So conditionally add
-	 * it here.
-	 */
-	if (count >= 2 && buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
-		buf[count - 1] = '\n';
-		buf[count++] = 0;
-	}
-
 	return count;
 }
 
 static ssize_t resource_alignment_store(struct bus_type *bus,
 					const char *buf, size_t count)
 {
-	char *param = kstrndup(buf, count, GFP_KERNEL);
+	char *param, *old, *end;
 
+	param = kstrndup(buf, count, GFP_KERNEL);
 	if (!param)
 		return -ENOMEM;
 
+	end = strchr(param, '\n');
+	if (end)
+		*end = '\0';
+
 	spin_lock(&resource_alignment_lock);
-	kfree(resource_alignment_param);
-	resource_alignment_param = param;
+	old = resource_alignment_param;
+	if (strlen(param)) {
+		resource_alignment_param = param;
+	} else {
+		kfree(resource_alignment_param);
+		resource_alignment_param = NULL;
+	}
 	spin_unlock(&resource_alignment_lock);
+
+	kfree(old);
+
 	return count;
 }
 
-- 
2.31.1

