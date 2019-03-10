Return-Path: <SRS0=zA2x=RN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FC8C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Mar 2019 10:06:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43169207E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Mar 2019 10:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43169207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HH2Y3prNzDqHZ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Mar 2019 21:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.215.196; helo=mail-pg1-f196.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HH0Y1KWvzDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2019 21:04:55 +1100 (AEDT)
Received: by mail-pg1-f196.google.com with SMTP id h11so1721228pgl.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2019 03:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LV3A1K28ZzdlaXBJ+m4jDlY+1loO1xTntknB7j9GNVc=;
 b=uhtxkaIIa5vJP1DhXAXjFk6mp6+t2ahY+QQRyco1y2xSiF7RqyRpCam56vZxzAuvJF
 k0VShpBVVdJk6KA8UNcQ1X+5Uaqp/EHIhHoyDC9qB5Fl5aPVwgeYbkgA1K9Qkslq1Gx0
 YzGfq2PfTkb6x1yAg/VvIcnEwMseYq+7I234YvanonuEJKEsOyW+DxwEmNw1PfLqEqKo
 wjJdxjJlHDobtTSFonm60h+auQN+0fwKrI116UwIJ5GdXVkHUmJnAWbXl5zxsApkJqzh
 Kw4WdRWQ0erWw1Zagoj8ISycZnKhqU2XFYusswz6R4qjUaNxdIN6v6JyTKgajFXXU9bs
 Fslw==
X-Gm-Message-State: APjAAAXWVPmLMeztaptVWnLFYs7zqVnnmQkHgi040F79fO1FbfIELN+K
 5Txm+9TLYfm0HgfhNq3HbHUPJg==
X-Google-Smtp-Source: APXvYqwvqV+s+YSa4RrgVVU1zmYLlcj68VnkbN9gYn1E1+qoEavuXS/+Gku4N9ALNKZJO+0AiddaFQ==
X-Received: by 2002:a63:ed45:: with SMTP id m5mr3439137pgk.265.1552212292391; 
 Sun, 10 Mar 2019 03:04:52 -0700 (PDT)
Received: from localhost ([106.215.118.61])
 by smtp.gmail.com with ESMTPSA id o2sm7496739pgq.29.2019.03.10.03.04.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 10 Mar 2019 03:04:51 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Append new variables to vmcoreinfo (PTRS_PER_PGD for
 arm64 and MAX_PHYSMEM_BITS for all archs)
Date: Sun, 10 Mar 2019 15:34:00 +0530
Message-Id: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 bhsharma@redhat.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 bhupesh.linux@gmail.com, Dave Anderson <anderson@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Changes since v1:
----------------
- v1 was sent out as a single patch which can be seen here:
  http://lists.infradead.org/pipermail/kexec/2019-February/022411.html

- v2 breaks the single patch into two independent patches:
  [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
  [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)

This patchset primarily fixes the regression reported in user-space
utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
with the availability of 52-bit address space feature in underlying
kernel. These regressions have been reported both on CPUs which don't
support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
and also on prototype platforms (like ARMv8 FVP simulator model) which
support ARMv8.2 extensions and are running newer kernels.

The reason for these regressions is that right now user-space tools
have no direct access to these values (since these are not exported
from the kernel) and hence need to rely on a best-guess method of
determining value of 'PTRS_PER_PGD' and 'MAX_PHYSMEM_BITS' supported
by underlying kernel.

Exporting these values via vmcoreinfo will help user-land in such cases.
In addition, as per suggestion from makedumpfile maintainer (Kazu)
during v1 review, it makes more sense to append 'MAX_PHYSMEM_BITS' to
vmcoreinfo in the core code itself rather than in arm64 arch-specific
code, so that the user-space code for other archs can also benefit from
this addition to the vmcoreinfo and use it as a standard way of
determining 'SECTIONS_SHIFT' value in user-land.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
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

Bhupesh Sharma (2):
  arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
  crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo

 arch/arm64/kernel/crash_core.c | 1 +
 kernel/crash_core.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.7.4

