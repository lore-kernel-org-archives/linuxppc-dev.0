Return-Path: <SRS0=QJlM=AF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4427BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 21:15:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF0B20768
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ur1fLf5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF0B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49sbXf0ztrzDqhK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 07:15:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--brendanhiggins.bounces.google.com
 (client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3zl7zxg4kak0oeraqnauvttvaftbbtyr.pbz@flex--brendanhiggins.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=Ur1fLf5i; dkim-atps=neutral
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49sb8Z0hjYzDqWj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 06:58:15 +1000 (AEST)
Received: by mail-qk1-x74a.google.com with SMTP id e185so2522053qkd.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2020 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=9cJ18y40uUPYFZL7TN4SHcIdjwmkZDveAIhoXIvPo38=;
 b=Ur1fLf5iHlKMYZXC1PTBS+I+vVSZLrwtsudyGKcS4apEjTlQlWHIVHccmjstZTZ2A0
 XpAesa/HexpPJ9lkMkGhBnF6Qskxhzu2Ugio6H/p+KIiUclPfy8g1bBrcb7XDtFj1fPA
 VhqqvTyBMz+4f1As4j6RChLXUWDpJpaCKf8s+VcdwMv144usfln+/z4SjWwh8S8wWOIT
 zIFXsZgc2COv4+INh8ZCWPZm65Gi+O1lsnv8GiFgvCUD1bjd/Dw8gnuPmXj6lL0ut1uv
 GSJrpDJHuaTL4yqBLz4GZSN4VLUjQGoPlUwe84SvdDiBJQ8E5KFn34V8W7sRUPNHp5K5
 x9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=9cJ18y40uUPYFZL7TN4SHcIdjwmkZDveAIhoXIvPo38=;
 b=uGf/6v4rwKVZnax/m6rS5Ak1Ds60qQZtpLeM78Z43j7adkDE/Dg6tt58QLTIXlp3Ez
 Y9xelQdvMOrn1icI8RAzKNIepGsC79RG9TGFMK32ocQ34x/3pQ3PmN41QNewauEKaFBW
 lmDjskxqlDkNSG+oqRiqy+HVeYmMM/ETmg4rF5y+lk3H/EKpgpYlZ63iObjqyRn+aMLN
 0pd39uMqU43Woqwtfon/QmRcwY2jDgsmIX2NuiRcjnyh0olq2ubjxe0teAYFjzyuKdjK
 XIDmR7QLm94n9DTCtY0bAZAQ1S5tNVEPYNbCc+st79LcYpg/9pjqYgqxw5IekT/6WvRA
 MrTQ==
X-Gm-Message-State: AOAM533p1pbLtfq+LYJSLYs++xEowRtztYGzozZ753ANjlGmruQBdXEd
 ASE1o5xHjGSaqkdFwoEzUnjzOenGdHxDiYc5qUSsUw==
X-Google-Smtp-Source: ABdhPJxiJGG91wgEwxBBSujXoL0BDsw9UNFVENxNw1T3itcMUFGteR1x45PAf5QA98p+dstOOYTnC7ogGU5jYKFNmTfkvg==
X-Received: by 2002:a0c:b346:: with SMTP id a6mr33657229qvf.142.1593032292307; 
 Wed, 24 Jun 2020 13:58:12 -0700 (PDT)
Date: Wed, 24 Jun 2020 13:55:41 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 02/11] arch: arm64: add linker section for KUnit test suites
From: Brendan Higgins <brendanhiggins@google.com>
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
 arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, 
 alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, 
 akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, 
 catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, 
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, 
 chris@zankel.net, jcmvbkbc@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Jun 2020 07:08:14 +1000
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

Add a linker section to arm64 where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa54..a1cae9cc655d7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -181,6 +181,9 @@ SECTIONS
 		INIT_RAM_FS
 		*(.init.rodata.* .init.bss)	/* from the EFI stub */
 	}
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
 	.exit.data : {
 		EXIT_DATA
 	}
-- 
2.27.0.212.ge8ba1cc988-goog

