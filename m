Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 21:20:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC62320B1F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 21:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="u6J8VuAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC62320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tqXx1QWRzDqHq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2020 07:20:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--brendanhiggins.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com;
 envelope-from=3c2t2xg4kakolboxnkxrsqqsxcqyyqvo.myw@flex--brendanhiggins.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=u6J8VuAH; dkim-atps=neutral
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tqJh4HKXzDr1D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2020 07:09:34 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id k127so6665849ybk.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=0vYZtvNiMw5LFIFKa+iHi1yqO9mFLTJ7LRF4fjft6YQ=;
 b=u6J8VuAHahXAYfZui4sfoaT0dsrVB0g/njRZ5MIakf/7bSZWFoZur8+vHZjZIgvkyd
 rsiis3HuL4AzSgVfpTFGOsNv9/7tHGdL61VbY11KBuBRNquuaThfognGBSG6XDHhjVrh
 liuTo+mvfU3D58KkhDomQtYXookl7U6ajEKfETHE1nWaRN0/gzOUI4z4bMwjPWQ6R2G4
 zVR7MS6jsimbRTLQK965Ww+Cp//ng+4aqqoiGzs9geOb61x+qHK6AUxwcP2HuU1S8dLP
 OEv3lAQzqQIPWit38K3OJmKJ+ONf/s2+d2jSKX83GtbI8ZYL+/awT6qOEcyz2uNC8LpH
 kbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=0vYZtvNiMw5LFIFKa+iHi1yqO9mFLTJ7LRF4fjft6YQ=;
 b=VnkF3RFWk5qcbe4BeJYpbgFwFA9qoCLIMU5/96/8Y/H2D+G0FefS5Bt4VdWdQ7m8fr
 E8LRkgwTHwmNeMCOeCJ4d7g98pV+FLJIWf7CkftVhwNtE/JoBNZ50RuwyQhKBp9ThG6p
 kVxKPLpMQZ8kcIWcnZueLjrm2S0h4HXRktJVHkLfANcnPkrGxZf4ut6UkdohescE9Tv0
 c4xqjq+s5eHRhcBMDkN3G9pkhpa9pzfuawJPl+ttIE0wL7hqEDK/jk7mVsTEniSbCagd
 aOzclubEvGdPx5S/m9XsrV3D8oORs4DZV2ekV6PdH6sV55jFi84xKMHCW1uydv5PEVb2
 wjMQ==
X-Gm-Message-State: AOAM532of4NE5evWFPMsDQ5GDNDjOjZKIass5KqY9PdiGXce7iiFmS2w
 Y2IbgXLPW/KNnXI7k96DJcNzML4m97ue3YlCHtcvzw==
X-Google-Smtp-Source: ABdhPJx4P+f9DA00o4x+xqsn5YNYZSrsnifEZc+MXGWM1Q+GQ6+KAVyhHfpoUwDaYub8VfOW5n9UfKxOSH6ZQNhne0KQ9w==
X-Received: by 2002:a25:99c8:: with SMTP id q8mr7798153ybo.3.1593205771432;
 Fri, 26 Jun 2020 14:09:31 -0700 (PDT)
Date: Fri, 26 Jun 2020 14:09:09 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 04/12] arch: powerpc: add linker section for KUnit test
 suites
From: Brendan Higgins <brendanhiggins@google.com>
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
 arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, 
 alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, 
 akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, 
 catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, 
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, 
 chris@zankel.net, jcmvbkbc@gmail.com
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-doc@vger.kernel.org, sboyd@kernel.org, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>,
 mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com,
 linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a linker section to powerpc where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 326e113d2e456..0cc97dbfde0ad 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -202,6 +202,10 @@ SECTIONS
 		CON_INITCALL
 	}
 
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
+
 	. = ALIGN(8);
 	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
 		__start___ftr_fixup = .;
-- 
2.27.0.212.ge8ba1cc988-goog

