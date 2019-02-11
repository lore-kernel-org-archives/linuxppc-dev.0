Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1150C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 16:39:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE3E218F0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TNB2/8TB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE3E218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ys220q9czDqfY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 03:39:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (mailfrom)
 smtp.mailfrom=flex--jannh.bounces.google.com
 (client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=3rarhxaukdgynerrlksskpi.gsqpmrybttg-hizpmwxw.sdpefw.svk@flex--jannh.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="TNB2/8TB"; 
 dkim-atps=neutral
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yrzV0LhjzDqb1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 03:37:03 +1100 (AEDT)
Received: by mail-qt1-x849.google.com with SMTP id k90so13514359qte.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 08:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=ISun9MAS+KVytOd1BlrXoBr37mM1yAGSGTfHJEPM32s=;
 b=TNB2/8TBwxbKKd2i42i2M7UNYFPUuZ64UIeF/y5q0W/RWfGzDCpL9oAeLllxUgbpxu
 /cvhORcFHMuixNyvvXBi8swrgkc8NK8XFMtVDmmXKI0nooslZQcTJY2isSJJYk0ivgT6
 NFHfV11v8RgZMXI890RMntZksGTENB71Ubvb5F2UW0DQOw21cGSnNJJMtGlvKhZ7IvT9
 g/y9JC1+onhZf8pbSNO66gA2hh6rV2+5h6lrXNfNvRt7jdJKA28Djl/NGpsdi5rSc/+w
 p6/3NrHFkVMS+STFZSgm/kHncRU6QkrSNBTNSCTzprdYtg16aJQEVP/RE1fsbvxc+vjY
 bRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=ISun9MAS+KVytOd1BlrXoBr37mM1yAGSGTfHJEPM32s=;
 b=PEqIeCMatxr8IO11RIpQS2cF8o32k6hGie5wXagrtuYr/bVTKDIB18b4VPwljdgh2+
 9Ly9f7KowlScyeM1FwK9xvo/XHeuHrHJ01gyxi7hWGZ0orlM7WbIR3GMkLVL5myaUYbX
 6mTOjXhiIK0mcJ1iWJGweUnwwGr2FKLLw5/Wtlyv9sFrWGABe1wIj3vtd1hD/bwdyx0M
 95z6+OHtoNpMXqr47tKWn6XyzfOh64gq3ZwSiSx89dVx3xTymVC5or3O996DbsKEuDuq
 rDZ8K1K3GfSGUPqM18yBU2I1/uf2vwWEjL6eOejY1w1i0yuVfN6n7CJOxyfIXYYcAZHQ
 7z/Q==
X-Gm-Message-State: AHQUAuYM99O+lZGRx6Q2DQtR+gCpMiIoZmeIci9GGRmNKN4Y3YS9IrKx
 DcC7ieG8Tdgil1hCV1G2oLB3rZSbvg==
X-Google-Smtp-Source: AHgI3IbIpHNITiD/z7phI27+wkBpML0Qrk8afGSQ6mMM5RujSQsYB+1u3g69NuuKIR42OGBcaDSaC7fcxA==
X-Received: by 2002:a37:d150:: with SMTP id s77mr3319763qki.35.1549903021406; 
 Mon, 11 Feb 2019 08:37:01 -0800 (PST)
Date: Mon, 11 Feb 2019 17:36:53 +0100
Message-Id: <20190211163653.97742-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH] mmap.2: describe the 5level paging hack
From: Jann Horn <jannh@google.com>
To: mtk.manpages@gmail.com, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@amacapital.net>,
 Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The manpage is missing information about the compatibility hack for
5-level paging that went in in 4.14, around commit ee00f4a32a76 ("x86/mm:
Allow userspace have mappings above 47-bit"). Add some information about
that.

While I don't think any hardware supporting this is shipping yet (?), I
think it's useful to try to write a manpage for this API, partly to
figure out how usable that API actually is, and partly because when this
hardware does ship, it'd be nice if distro manpages had information about
how to use it.

Signed-off-by: Jann Horn <jannh@google.com>
---
This patch goes on top of the patch "[PATCH] mmap.2: fix description of
treatment of the hint" that I just sent, but I'm not sending them in a
series because I want the first one to go in, and I think this one might
be a bit more controversial.

It would be nice if the architecture maintainers and mm folks could have
a look at this and check that what I wrote is right - I only looked at
the source for this, I haven't tried it.

 man2/mmap.2 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/man2/mmap.2 b/man2/mmap.2
index 8556bbfeb..977782fa8 100644
--- a/man2/mmap.2
+++ b/man2/mmap.2
@@ -67,6 +67,8 @@ is NULL,
 then the kernel chooses the (page-aligned) address
 at which to create the mapping;
 this is the most portable method of creating a new mapping.
+On Linux, in this case, the kernel may limit the maximum address that can be
+used for allocations to a legacy limit for compatibility reasons.
 If
 .I addr
 is not NULL,
@@ -77,6 +79,19 @@ or equal to the value specified by
 and attempt to create the mapping there.
 If another mapping already exists there, the kernel picks a new
 address, independent of the hint.
+However, if a hint above the architecture's legacy address limit is provided
+(on x86-64: above 0x7ffffffff000, on arm64: above 0x1000000000000, on ppc64 with
+book3s: above 0x7fffffffffff or 0x3fffffffffff, depending on page size), the
+kernel is permitted to allocate mappings beyond the architecture's legacy
+address limit. The availability of such addresses is hardware-dependent.
+Therefore, if you want to be able to use the full virtual address space of
+hardware that supports addresses beyond the legacy range, you need to specify an
+address above that limit; however, for security reasons, you should avoid
+specifying a fixed valid address outside the compatibility range,
+since that would reduce the value of userspace address space layout
+randomization. Therefore, it is recommended to specify an address
+.I beyond
+the end of the userspace address space.
 .\" Before Linux 2.6.24, the address was rounded up to the next page
 .\" boundary; since 2.6.24, it is rounded down!
 The address of the new mapping is returned as the result of the call.
-- 
2.20.1.791.gb4d0f1c61a-goog

