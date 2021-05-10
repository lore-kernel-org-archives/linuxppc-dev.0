Return-Path: <SRS0=31b2=KF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BFFC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 04:17:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F5B613C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 04:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F5B613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fdnp54HvXz3dG7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 14:17:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.218.53; helo=mail-ej1-f53.google.com;
 envelope-from=kswilczynski@gmail.com; receiver=<UNKNOWN>)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fdnkh4k1Jz2yRX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2021 14:14:36 +1000 (AEST)
Received: by mail-ej1-f53.google.com with SMTP id zg3so22419687ejb.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 May 2021 21:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JeL2FUARGxszhpfrtswg3uTFL3yp7K/KDjvHQpNvygA=;
 b=DtpcSq3IGqmYaKlteMoejIrdll9HC6LyBmELWzi2juTv9lNPEfjVobBX2XC/iP5kX/
 dy7VLb44cIt0l7oPl/G6wFB+QC6Ya8NBK/jozOtTR6lGyD2u6uXr9aakjc4RQeVgb0uP
 Qut4R3gAsBR+cmCjVM6QcOREtEhJI1dsHysRnlgSqhI5i9zoRD9L0W72ugjkaqzQhFzc
 nvKQu6sWz8sCrgLEVQDBdB5FfGJ9/pUBZ3tdIt19qlxs+ZsNXNr9r46oXCh2ZV1mJe4l
 08PetGTlQLalfBCWDwsJN4MlxEdi0wLpWXzw/8Kkr/Vsjbj13Hp00W2wsALn9j2Tx5/L
 EurQ==
X-Gm-Message-State: AOAM533CPXRzYPDb3agaI6Fbitmos180XMsCOXoiC+f+5baAzPgyt59q
 ur5vG7L3jl2JufrUm5hEg90=
X-Google-Smtp-Source: ABdhPJws1APHRRa1UWb9NsEgDv3LVgdap2nv9ZT1B1HRkR88aNny+SIIgzZqUzA5rUM83wj3tLM7tA==
X-Received: by 2002:a17:907:62a7:: with SMTP id
 nd39mr23674832ejc.502.1620620074022; 
 Sun, 09 May 2021 21:14:34 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 May 2021 21:14:33 -0700 (PDT)
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 09/11] PCI: rpadlpar: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
Date: Mon, 10 May 2021 04:14:22 +0000
Message-Id: <20210510041424.233565-9-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
References: <20210510041424.233565-1-kw@linux.com>
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
 linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/rpadlpar_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index dbfa0b55d31a..068b7810a574 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -50,7 +50,7 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t add_slot_show(struct kobject *kobj,
 			     struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static ssize_t remove_slot_store(struct kobject *kobj,
@@ -80,7 +80,7 @@ static ssize_t remove_slot_store(struct kobject *kobj,
 static ssize_t remove_slot_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static struct kobj_attribute add_slot_attr =
-- 
2.31.1

