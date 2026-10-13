Return-Path: <linuxppc-dev+bounces-29439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1447CC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:40:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48Rn5v2Vz3brM;
	Wed, 14 Oct 2026 09:40:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1346"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931221;
	cv=none; b=GFt971W08IwMMJV49GYcgcP/fcsWG8UehrOe8qCSHZHhmtETF1YGQZmr3E50d0q0h2w1zqjvHzZrG+j/GmFVlzpIkulrHk2OACPo4FW4dleEhQD0j/63FvDVWRsi+L9+sAn/tLuw1Sg3EN7aMjZB8nauoz7jagM7kEq2Tv19j5OkBx8Rx7HS2IgwiOCmAY5nZDIHw6FXlukfVJ03nNBk8KQCbiOdFa5djbjtq4ADnCiunL6RrClmDrqDqO6Q8uTG9e3Q0nRAV4keC60gT0x0zmvmAWjhIVeY5SkQEU1ucAKy57TLVPmEcASzznLVwcjfcmxO1mWy44eBTsgOaVWwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931221; c=relaxed/relaxed;
	bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K12F3B3XNfcr4zzfmirfBzUZ7OVOJgO+eLmCidnuWCnD5pwV0pwrMalP6nw6hpkLEQJhwmZ6+70+n6GwQp3Q/f6CXw27/L8w4k3WCyTAQht+s07h01kcVk+aU6B5O2cv960F6dV+XIhGrHfA8yYLmjqd+iNnTEDJTrAI2+XEXhSrvz6rLd+dBx2MRPsN4FczJtxzhpKZoYmCdQl/UHdfADAZOSJRiQjWz07EIH2M+LGq57+Te5AsKBTY/qWm0IRSZyWBPGeXuPHRqG1DV3YwXD//ohstlVnLWV4xLJeDOpOGR8hmWE6gPvgKilHP8fWjnhrFtRKN3GDxkIbW+sdU1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LkbTUbHV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3ulpoagckde8z85xv89x55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LkbTUbHV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3ulpoagckde8z85xv89x55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1346.google.com (mail-dy1-x1346.google.com [IPv6:2607:f8b0:4864:20::1346])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48Rl4XQMz30St
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:19 +1100 (AEDT)
Received: by mail-dy1-x1346.google.com with SMTP id 5a478bee46e88-351788121cfso4936549eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931217; x=1792536017; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
        b=LkbTUbHVUH2BKFswfizACECvspUMkD9tJFIbbHQbNboij6Y26G8mMPc5YyEXiSpauL
         6XBPzlSQVoHmJt8LJD1JKlQO3ARU9UB1IKvRaKOKWuZAQ7ucNeRXOtaKadgn62eIT6eZ
         PDazRjWcxRsfcgDv0hXrdOTXLYUI/IzfEQb2FMrAJuALwzCDIocdAzUybjxer5xn75rv
         MTKllXz+Jga54e5kcPSTJW3GDDTeVDkq53AcDA5NPXo0uyCgnzGMZfvF1j5egJ7ekgbL
         vA+x+mK8K4o7DAVD0oPGhnueExZOjZCg5MGLnCbYbMLjB/3mpBgf1rwB3h/ZgLXMoUb6
         8xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931217; x=1792536017;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdtOvNbLAOJ9idJnmqNXkxs2lXj3bNW1pL8KRmE6mUU=;
        b=t2UBonz5YpGdRI7VtUh+YjXP1k75VLYtnSMtEFrPG5mSlqJqpNjDgCIanhRY8jk5DH
         gLIcZatNOSo2daBZfjDgOG60qwN/5o1/cK/sQeSJD3uXAvtssefDqrqQ9JRX13SqNH2Z
         tlSTdwQB+YoAk1i8i4nqv4amwi2pRv46FNkYxfQdTqVweQC45fQW/VKLsiZdXmGHcPmt
         3B0FUu8HsEoBJmC9DQlyGPib1shS1V6PIJQBax4yBP2A0yavhmunGHuxUkaDDYf6+S7O
         ONwAgxitFkdxKBUSVCNYTHfJ+niAu+zlF87IU02qzyIRIz82Uucy0gktIyAGv7E95GwW
         tmLA==
X-Forwarded-Encrypted: i=1; AKwUvBwAkMchrE9MBvQnMHap3kmDyrEnk4ZbVbQa28/6/nFJN2DheZRFwVZRddW3L661QOg4Eko5QefpTx82pbQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLSN45uiTmy8NcOi76akYC7BDIpDlto90e4yfLAI3SFQ32fXMYU
	fJyG/o7v6NGgcNXx7Y6WnlGQJLRbzM8UD/hjMhv17M711+9bf/YaSf02P1C7l2PExyRGz2VjxLv
	+CISi5vslPA==
X-Received: from dycrm16.prod.google.com ([2002:a05:693c:2a10:b0:358:f250:485f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4141:20b0:35c:8d1f:5634
 with SMTP id 5a478bee46e88-35c8d1f58e8mr4713972eec.12.1791931216820; Tue, 13
 Oct 2026 15:40:16 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:37 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-3-irogers@google.com>
Subject: [PATCH 02/11] powerpc/secvar: Add missing kobject release callback to secvar_ktype
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.385.gd3acb90ef8-goog


