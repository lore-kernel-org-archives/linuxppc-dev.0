Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA3C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 20:56:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AEB218A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 20:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdJsWL37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AEB218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K9Kg4dTZzDqTF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 07:56:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YdJsWL37";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YdJsWL37"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K9GZ3gRZzDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 07:53:26 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id t27so17330130wra.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 12:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BOHy+hnH4lZnOs23lifYwnxqIe7rQvW+2oL4j+OiENU=;
 b=YdJsWL37R8oqruDF5Y2Wk55CvWa9UvYe5ev3P9fF+ZPbmFpiy1hz4aJPRp93hV9xLr
 PnlN2bUj1iBrGgRm2ImnKdi5Yufx3uEXv5P1cefwFDAujCZFcSOOVLGHLuj8lUH5dxhy
 b2jC+M6br0HN+/J/T2A1/ysD/BMk+HFmUO5r/jppCfpppuhRK7O6OCbeZWi4UB9Xk1Z6
 o/d4m3mpvrWfLGlbSzQ87k0958ZVeLSg4hiIgZ5V3X3fbXIiw+Uu20XFdEyK8+t6shpj
 rS3jBGu3h0iwk5NGbIRNajvSzzyk/DsheslfpIwW/viQ7IToJb6fbSXsxQAQGnawyca8
 TwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BOHy+hnH4lZnOs23lifYwnxqIe7rQvW+2oL4j+OiENU=;
 b=j0yOZSdyWwWRtvFqK6GDhW+zFAGK0xJLKbySm/j1+bSusWt1fcrN9XjgZ+25QbImQ+
 EKLylt5iMOOIET3U03xSyDkRsOtHvFaR3iLSK+/adLy7SyhyhBIwRaghdfseduXMzKDl
 3LdBNQ5k5Hm6Rvui2LJQ5eOXT3Rot4rQjz7SQXessVSOdNmmn9LklVfc+Pxpsf+z2qmg
 sRzerpMVy2NLQQ6oLnkj9S0493WYEIDdJKZHTKJApMrEHK7sH4ArO/PdoL9+W/nosqU8
 ib0qe5G2iKb3/RJ5ergPZ4yWHn8V2+F9WnYD4ACKQOL4MJkwshYhR0I6YiOtmV5Mb1NU
 fGKA==
X-Gm-Message-State: AA+aEWYTncysErbj5LBGVqiCKCsxAjJMTFnXrt9un9bJOGcmy4SFF6Wy
 unaOtwvmsley4LEv0DWV56E=
X-Google-Smtp-Source: AFSGD/XuiRyxHTFbWbKnIE7zw66Ng50gg4JJ0q7b3tMlrhKzde0rk0I0qOjfXCGV4w08a4S14lcvhA==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr16727434wrs.117.1545166403353; 
 Tue, 18 Dec 2018 12:53:23 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
 by smtp.gmail.com with ESMTPSA id
 m4sm3870895wmi.3.2018.12.18.12.53.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 12:53:22 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 44819114106E; Tue, 18 Dec 2018 21:53:21 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/ptrace: fix empty-body warning
Date: Tue, 18 Dec 2018 21:53:05 +0100
Message-Id: <20181218205305.26647-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
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
Cc: Mathieu Malaterre <malat@debian.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit a225f1567405 ("powerpc/ptrace: replace ptrace_report_syscall()
with a tracehook call") an empty body if(); was added.

Replace ; with {} to remove a warning (treated as error) reported by gcc
using W=1:

  arch/powerpc/kernel/ptrace.c: In function ‘do_syscall_trace_enter’:
  arch/powerpc/kernel/ptrace.c:3281:4: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]

Fixes: a225f1567405 ("powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call")
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8314e8fed0ee..e1988892b3e7 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3277,8 +3277,8 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 		 * avoid clobbering any register also, thus, not 'gotoing'
 		 * skip label.
 		 */
-		if (tracehook_report_syscall_entry(regs))
-			;
+		if (tracehook_report_syscall_entry(regs)) {
+		}
 		return -1;
 	}
 
-- 
2.19.2

