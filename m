Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DE1C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 06:52:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B277B2070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 06:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B277B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T1yr4sYTzDqML
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:52:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.214.196; helo=mail-pl1-f196.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T1x81dqkzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 17:50:51 +1100 (AEDT)
Received: by mail-pl1-f196.google.com with SMTP id q6so1181598pll.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 23:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FZhwv3yi5zyZbOFCZb2GEhrF1eNPuv7xg9JUzeBkJ/I=;
 b=Yfk6BDIw+lsrWJzIEqebw1XJh6IpbeOIU75D7ESsuUC1JczW4z5Ht2iAlYneo4xuev
 HuztCZyCJbQ6njzTEw/DUEwrtfv44RPB8hPjLk/yZTi7aaiOK95h76J9l2sMgtHRHPRi
 a2aLnpxFEK4o6wWZciAGcKMfhbxI4pyTondY3vDTk83dV3JRCgQnj1PxAGscsVL/kSop
 jjTLbxoC3+sUhD+kfK4mccbr3g7DPTK+ECiTkumx+k5yPE8hgiw//ZMILPq/GvOfRTIT
 6WYk+mbmIEOWPljuDPPICC5iFeTAdSXTJ9hjY4rj00WzSa6+V4b27rIQiRQyl6BPdvJH
 4ngA==
X-Gm-Message-State: APjAAAU0FxX4w0mKoyXtOkaQhUE6pq53HBbRHRN1VJdo8u/3fnEOhx8d
 MYsJRcnfQsHGJ5fpckLoDhzTBg==
X-Google-Smtp-Source: APXvYqy39bmf1qbyFI6moNdEPCXkx4W2gXiUlmd3KBrqDCU2xEuOLaQloNXGw74Vf1g20sAehiiMvw==
X-Received: by 2002:a17:902:142:: with SMTP id
 60mr29516055plb.191.1553583048524; 
 Mon, 25 Mar 2019 23:50:48 -0700 (PDT)
Received: from localhost ([182.69.197.66])
 by smtp.gmail.com with ESMTPSA id e13sm30256596pgb.37.2019.03.25.23.50.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Mar 2019 23:50:47 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] include/kcore: Remove left-over instances of
 'kclist_add_remap()'
Date: Tue, 26 Mar 2019 12:20:28 +0530
Message-Id: <1553583028-17804-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
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
Cc: x86@kernel.org, bhsharma@redhat.com, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Boris Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com,
 Dave Anderson <anderson@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
removed the sole usage of 'kclist_add_remap()' from
'arch/x86/mm/cpu_entry_area.c', but it did not remove the left-over
definition from the include file.

Fix the same.

Cc: James Morse <james.morse@arm.com>
Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 include/linux/kcore.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index c843f4a9c512..da676cdbd727 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -38,12 +38,6 @@ struct vmcoredd_node {
 
 #ifdef CONFIG_PROC_KCORE
 void __init kclist_add(struct kcore_list *, void *, size_t, int type);
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-	m->vaddr = (unsigned long)vaddr;
-	kclist_add(m, addr, sz, KCORE_REMAP);
-}
 
 extern int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn));
 #else
@@ -51,11 +45,6 @@ static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
 }
-
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-}
 #endif
 
 #endif /* _LINUX_KCORE_H */
-- 
2.7.4

