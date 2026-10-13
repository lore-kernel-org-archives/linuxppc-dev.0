Return-Path: <linuxppc-dev+bounces-29440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8D0CC6B15
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:40:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48Rq0Qs6z3bx1;
	Wed, 14 Oct 2026 09:40:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1345"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931222;
	cv=none; b=FDA+MFsXOnFs3URXJ1zqIwhRpugrGP6t4/NW7ezqC+w/DlfIeKpu/RClXq4o9rCAAONr4xEzysM1Qhu5sE9wllxFpvgZ5fipVwg6qIk+0WHd74y8UrEGlvGckMnKp+mVw6Ah+J7tQarPqzPVIEdNUTyCJu49WFVvo7K2k7tKzcffxliJJimFew6W8dzLmQaGra3VYGUbBItDqZQ9Q04Jy0dmNw/Ek1QFlB8DBBDiv2d7pw1FS49Qt0wuSKi3+uSGUTGLwyLfB/MoZJg5YJ374sbgpqo0xIoI6/iaXWNv8UGAxopxL2k/hl3dd2lIPH+SlfheSt4IAARvTAqVnInfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931222; c=relaxed/relaxed;
	bh=4r3hXDLd6Bqk9XmcFR/JS5uHIdkPs2TN+2FSnsngXIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H34+2sS8kmzzAxGLEsqTM8OJnNYXq/ZBiWwFygkfPlKKBeckDbIl3QIPtI4+2Ihqoi2KNtBO/TfEkMk3dZp/WTyE0zfaBBpVr8U94rIcUUyh8TllXibXcEw3vsBic68dXj+yTTKsd41nYwbF82gkzRIafCWJhxV4Dg3l2ETfxGcdU8Upi+wd9wDonPP3Os9uS1FvueY7yPHCGgRezSK83Yd4kobtdAWbK4Yu8KdaVaQpNKVFPtXyCSALyL/q1eaJtSlVMVHp+tpwFe63UPRz0sZy5Akh0VT2DtZsoLCsMWd6vTHWYsFY1fyQpxBTgjMmaPQztD/bXUEMYcNPrvNbLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FCCaZU9a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1345; helo=mail-dy1-x1345.google.com; envelope-from=3u7poagckdfi2b80ybc08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FCCaZU9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1345; helo=mail-dy1-x1345.google.com; envelope-from=3u7poagckdfi2b80ybc08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1345.google.com (mail-dy1-x1345.google.com [IPv6:2607:f8b0:4864:20::1345])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48Rp1skBz3bsm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:21 +1100 (AEDT)
Received: by mail-dy1-x1345.google.com with SMTP id 5a478bee46e88-35c5aef2a74so1454366eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931220; x=1792536020; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4r3hXDLd6Bqk9XmcFR/JS5uHIdkPs2TN+2FSnsngXIE=;
        b=FCCaZU9ac9DzGBs7qxFpxE/TooslFuSocyMOxIL/qTN0u8j/bHL6Ys58a2kX1r7dRn
         WcxrwsuRoJdc2pyeZHmpvFyE9iR4iZCanCSGLdkFFtw/Ob3mObBQr5MCXXglkxdCWuqE
         sAVRy8fW9kjEyze/kpHUclDIsVdjEL0UnyExDSsE/t6ifl0DenylN3Yw0wbhqAroWnar
         XbuctMuoprYo9oXVXqAgO8Luj2l20xK8FouwX0s1mNeVgOcKP7TeVbkUU0oIqkT/Y5fC
         8zdXXtKTGMDee7Q56YDk3TZfvn4Nx7TE1nrnYr7oCNTOI3cptXGq4q+hFdjHZHPtYf0t
         Mhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931220; x=1792536020;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4r3hXDLd6Bqk9XmcFR/JS5uHIdkPs2TN+2FSnsngXIE=;
        b=LhSEVhILbHdfW+80Sm82SBHcGFBJMInePtr5yM+48WJo3Sw2UELHEsjxHMufSUt5CN
         mYjUGxSWwzbF3PHt20BfZFNZiYQZeHgwGy8rlgqihuB/J5akqZ8hPjqAwcwu7nQPjvRd
         puEQg8uF9r7u2Ex8wVLgKQW0C2UQk62tu2m87/guyZUCtpNCOCpzvX2Z3zR57xHMxcJI
         uuCPGlSZ090FZS1o64a4M2vPZUqhoKTGSCTalU7HfEm5N78q6REGoxL+CiGfQajv0xKt
         YeppFBZW9WdD7v89v7yofzuZhh12QSk4zwCT4hGEMRC/BPZjqNtdYl7chcw0yqXRX8Bt
         yemQ==
X-Forwarded-Encrypted: i=1; AKwUvBzouhXqfDRIWxti96PX63yDMApi5cJt91mPhWWjaNi/uF2S+aXQdfjA9SsDnAssVhlGSvknJ1LJ7qmmJAE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIpM50hbFAtnsi3paCT8khVx3JS2CvDuKiJp6+/48Ovot+wDQBV
	+Vk50pzOXVwI7tfXgTEIGmL+RC5ZGjmEJiSp1jta2nMYpfCsh3WGO5rEsdMftGxdaJUOFTj0am5
	Jqa0QDwc7gA==
X-Received: from dyu6.prod.google.com ([2002:a05:693c:8106:b0:352:94e:a8c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:71a8:b0:358:f717:ff61
 with SMTP id 5a478bee46e88-358f717ff90mr13337962eec.6.1791931219210; Tue, 13
 Oct 2026 15:40:19 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:38 -0700
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
Message-ID: <20261013223946.1836757-4-irogers@google.com>
Subject: [PATCH 03/11] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.385.gd3acb90ef8-goog


