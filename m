Return-Path: <linuxppc-dev+bounces-29444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2B8CC6B0F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48S01s9xz3c56;
	Wed, 14 Oct 2026 09:40:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1348"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931232;
	cv=none; b=JXG5+AI9IipkLqvn2PzyAbGbbjLVN5GB/EKmTmZQ1qOEuTUUEltNdC1UNiLrgnkL8iO/CHJtjdkDQ/cNiH2aZZPUhXhW494DT50wBaXHm/U2Av+sJfGhNpNvqH+u/3WlU7Tg7wYjgU2axlaj+9EV1ZNmFLeTJVNjfLbTGDzUhhTma8l+/Rfu3tPsjGyOxCr0tcQRTiMHiN7jT5/URAlp2Xm3eXUhdVxk1JjNjJBhhJRWOYvPqPl6ymo1zKSBTMpTWDhYUo2HHT0Pvobr9jzVLIyh08nZ5SV/v7+fCVWMP7b9HC50Q0At9SgCfeLc0bFedysMWP1U6ML+dlgfXnGNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931232; c=relaxed/relaxed;
	bh=SzuEQJa4uF6wSn0s7ZpxNvjcEHFt9KB4NkbiARikmlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKbySYRYNv6bSpgckVdiI/sEYDYR66oaeuI8oaMxLpip+rd8DRidPtEXeXYkEXAPCRcxdeBwsAPUiuCTCOw6hMLzheQ+Il24SyA2ltCPnxERodkrpTDsegDiP6dqhDQzkRxngpVRVaqJbXi3YVdbPO/k3sDdeWmOFTlmURz8d39TPgERs/7WXsnkYseDGW4lCVAS4StyrFa6DWWaW+e8NxYKlqGdIJ51tjNy3d+GVQfHSkh7wUbN9d+A+E/uqZCB5DRqdHcJ0R5Ysk7FxJsMcJ91Wzu22uJ3nylkQiliPbmde3KuzGNioDV0G9/9LnPQ9+7vaCt2nuXvHORCGQhhnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XhZe7GxO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1348; helo=mail-dy1-x1348.google.com; envelope-from=3xlpoagckdfsbkh97kl9hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XhZe7GxO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1348; helo=mail-dy1-x1348.google.com; envelope-from=3xlpoagckdfsbkh97kl9hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1348.google.com (mail-dy1-x1348.google.com [IPv6:2607:f8b0:4864:20::1348])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48Rz51f6z3c13
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:31 +1100 (AEDT)
Received: by mail-dy1-x1348.google.com with SMTP id 5a478bee46e88-3580c07911eso9020118eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931230; x=1792536030; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzuEQJa4uF6wSn0s7ZpxNvjcEHFt9KB4NkbiARikmlQ=;
        b=XhZe7GxOlZcEF+0gEgjgL0oBJRdlgI5z2/Pf3w+yTMX2Wos8ztdlrjsMFW/OQqrBDh
         LukzoCtrSLpv7SFrUUiRy6J+/AeiO52L4ztTgtsxC54Z+Xfd2HgdIrKd9iag2zJ0y9IM
         nwwefXW4sZyRTgc8mU/9wpjyF5mCBMQA4K/LxMirhjGCGLsJcmi66agN8OLfxAlsA8wI
         ippFFzrSxvf8AiM6RCA/NjHSsPG9A2OSc77fxHiMdw1p3cX8aoA0LJOt+u4cE6ZiSWPB
         PBZpWG31xk+9LtmQZ2k0ESV1X6vaFQuYN0acXFHPs8PG+h/hD18vnK+mYM0NTHAMuGLI
         8VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931230; x=1792536030;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzuEQJa4uF6wSn0s7ZpxNvjcEHFt9KB4NkbiARikmlQ=;
        b=PNPRSQkd82lUM+H0Q2yKV/pul+39+SQXGobqIisZha6OXSFV39D3Y4cayu6BLZjh1K
         KxCv239jk7opdNyk4ZzazImeSssELEDMpxnQgoquXuOOFwfjKkH5DFs9TIUAEKFxi1+/
         z/A0jB5L1CEPwXPOQN8MHv8ZYtFpEEJZMrwwF2keELfxz28/1dJfsshgVXfCvktHGQe7
         FV8HwMSpX/WQ7cpJf3j02x1hObs/AZ8BKBnV2FUefDD1zG/DOhEdJvYEaqOJLtUR72zX
         GUTn4WdqCb9MoIzDOwwgqZtFEEZRRr6Qe/orFelfQDhhl5/Ni9VH1PbnyXY/YFh/agyQ
         lltw==
X-Forwarded-Encrypted: i=1; AKwUvBw+UqD5kPzmsSg/bV14A5TvKeP6jGQ69HSSdDFtO+eqoPYzeoVBmog2zaUyB+nmV6+69qxw5Hiqtaq4hoY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIpn616ZU2lEvN8qscC13EGBazZ6+/g4C5FNnWD4+5OpRcZ1YdW
	bogorfaLoNwbmpIxGdnKu2By7E0giQE85JD8iyClfiRljNF5/OwSyyZTK3rmkYocqpb4PO3p17Q
	XTI6bemt5yw==
X-Received: from dybmf44.prod.google.com ([2002:a05:7301:92c:b0:358:41fa:f46f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c8c2:b0:35a:8dad:6724
 with SMTP id 5a478bee46e88-35a8dad7ec8mr9213311eec.22.1791931228757; Tue, 13
 Oct 2026 15:40:28 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:42 -0700
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
Message-ID: <20261013223946.1836757-8-irogers@google.com>
Subject: [PATCH 07/11] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.0.385.gd3acb90ef8-goog


