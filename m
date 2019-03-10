Return-Path: <SRS0=zA2x=RN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE2C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Mar 2019 10:08:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D80207E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Mar 2019 10:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D80207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HH4B1fZ9zDqFM
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Mar 2019 21:08:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.215.194; helo=mail-pg1-f194.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HH0b5sQ5zDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2019 21:05:03 +1100 (AEDT)
Received: by mail-pg1-f194.google.com with SMTP id l11so1697623pgq.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2019 03:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=L1C+T2uli6R0dd/vYObZu3h9qXje3TBmGHmavCoixHE=;
 b=n3m5WJOf4uiwOjOhGbKx9g9att5Hh7xSkS9nNZYHAjQcyHSq9S/4UCGUGxUKXUv/RF
 Q8oBfsmMh3/sjEZpHuPBaDCAFuE1eefPjY3PXJ0NIC6q7guMTTPGH9zpPSGJj8ntuB9Y
 TQza33W8oHIiQMrc46poulL574LvvEJXgz8Pr9YOt7pNBkxiCzb+jrdEHRJveK7SV0pq
 A3H+drvZcCBcsgikSsOvL9PClVZv6njv9utR7feRrIL7Xsesv4I4FJMIvWPb+KFMcQMM
 03YyuNftqCjTmk12sea2vrmORoauRLMVIP54QLd9/FRkdJFYS59c8CARo5jV+xpmT2l/
 iuWw==
X-Gm-Message-State: APjAAAXC9HWZ4pdOWnHT4FC5Jx2P6qT2aeX+II/OAbDdIS7h+u9ekX8Y
 KdF4AmfOUkmDMf+hMA1GGaEC0g==
X-Google-Smtp-Source: APXvYqz8b9xjsFFZhd8G7xPoAENZwwwAhyiJlWkWEOR5IOWPW8b/pqUd6GSXZ5C0atZumHSeryF4cQ==
X-Received: by 2002:a63:cd06:: with SMTP id i6mr25240388pgg.267.1552212301991; 
 Sun, 10 Mar 2019 03:05:01 -0700 (PDT)
Received: from localhost ([106.215.118.61])
 by smtp.gmail.com with ESMTPSA id e26sm3979010pfd.124.2019.03.10.03.05.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 10 Mar 2019 03:05:01 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] crash_core,
 vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date: Sun, 10 Mar 2019 15:34:02 +0530
Message-Id: <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
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
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, bhsharma@redhat.com, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, James Morse <james.morse@arm.com>,
 linux-arm-kernel@lists.infradead.org, Boris Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com,
 Dave Anderson <anderson@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Right now user-space tools like 'makedumpfile' and 'crash' need to rely
on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
supported by underlying kernel.

This value is used in user-space code to calculate the bit-space
required to store a section for SPARESMEM (similar to the existing
calculation method used in the kernel implementation):

  #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)

Now, regressions have been reported in user-space utilities
like 'makedumpfile' and 'crash' on arm64, with the recently added
kernel support for 52-bit physical address space, as there is
no clear method of determining this value in user-space
(other than reading kernel CONFIG flags).

As per suggestion from makedumpfile maintainer (Kazu), it makes more
sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
rather than in arch-specific code, so that the user-space code for other
archs can also benefit from this addition to the vmcoreinfo and use it
as a standard way of determining 'SECTIONS_SHIFT' value in user-land.

A reference 'makedumpfile' implementation which reads the
'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
is available here:

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/remove-max-phys-mem-bit-v1/arch/ppc64.c#L471

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 093c9f917ed0..44b90368e183 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -467,6 +467,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
 	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
 #endif
+	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
 
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
-- 
2.7.4

