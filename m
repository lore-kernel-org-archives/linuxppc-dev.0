Return-Path: <linuxppc-dev+bounces-21323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82037CD5BB4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 13:33:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLq9m50Cgz3brD;
	Thu, 21 May 2026 23:33:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779370412;
	cv=none; b=h7Slq4hqkaeEPT2Za8lCEwbKRsXq+udfC3dpwwf/S04FBS1I9fWQ+Xdyd5I90HnjrOpleAtw3PWLiUB+YzwmtXaw+a1vbg+Q1jEwKJ8wm51KUI7XcJHlO7i2flFAln/yQh2avedGT41Q7hMUk4QJKa0s8Hi7bVJ1iekF9ryLNNrfEMx71J4yxugoB0eGco8JwWEAIpDZ6rnDsww7fNvZ3ENFqIgZuoQ+qvB2025Zjuj0X4yryczz48N9ZnwmQUbvOT72lVPrytL/tGf9/TmnZj03JoggphHRGL/M59+TMXcQtWKQguu7jSCofeN7E29uY7G6iodi5Dqt6bCbz9p8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779370412; c=relaxed/relaxed;
	bh=mCDvxzUe4SUE/8My5CdCqwCgEMUsyBtFnEQMMX6d/s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHQZbFLPyiN/M5Fxj6Mlmx+ekEl4aIV2QJFbHj4REgJ2LRWx9j0BoTBPyex9MXgL/dL60aQKAp+DjBOdk8E4P/kbMOzDPMY1UKJQ1JexEXqLCTljIMcFmQiMdD0BlEqYLe8ZBpU39S4tHpoKRCfMJu2iaohKhPnbXT8E65BcZu5oDx0nW8ahB98CL4Sk13sKvq0aGRvmf+RWIE/NYdiddWZ+nnnKS2Z4WdOoc2kfJBroEAnmrcbmMYIlUjEYByPJDOxEdJJSbeENDwNoQev+gYORKnQNgbirnllFkDkXHuQ6mkhLpMKvdf3z5KaiwtOE32x5TgSc/s1rPgO3TSc6gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKeaVp4g; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKeaVp4g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLq9k5gg4z2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 23:33:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DE51E4460A;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D611F01572;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370406;
	bh=mCDvxzUe4SUE/8My5CdCqwCgEMUsyBtFnEQMMX6d/s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gKeaVp4g+fZOCB2d1zbjK4W3dvda303iCxWkDVj8H14UNIIGY3gLpzELeZZiKDuA0
	 6JIfunc/nVUvSrBIfRk900oxZ2787B+gF2h77BXqscTXGWlKDLIlSThYYzXi6Zaf6k
	 rSGRMLv44XHHzSMHgbqg/hi8HytIpEFrRSPhR2+NF71x4bQnEWRMd+fmzjPChz9SHD
	 l99zEnTWxInewz9sw/ltbjS6dRQ4fdJNXiQJ67R4+Wc+4RYmFsK3aPla3MQMOLPRtt
	 Du0AZ41GslozrTV5c51WftQYxJqxNJ5tdYXIlfTZ4AdLpFEJ8Cy0CdC8iVcMT6c/cM
	 6A9cOjvqn/5+A==
From: Kees Cook <kees@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	kvm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 02/11] panic: Replace panic_print_get() with generic helper
Date: Thu, 21 May 2026 06:33:15 -0700
Message-Id: <20260521133326.2465264-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
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
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=kees@kernel.org; h=from:subject; bh=We2iaIAjr+4pDVj6nN4taHbnlsqb7PEX4Rc0M//7Kt8=; b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nAumTnkv6GXi6mHz69T5F/eS51xN2sf9+OYJ/5tKM a7BKpWXOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZy9S/Db7YGn+v9lrVPV4gu m3xhJm8Bs3PHO2Ofhg7+Rze8/k6O/Mzw3yuT8f9jHfbF7g9KrUVDtZlPT9yg9mVa1fd5W55tLpg ayQcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since panic_print_get() just calls the ulong helper directly, there is
no need for it to exist as a wrapper.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 kernel/panic.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 20feada5319d..42e5ebde4585 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -1214,14 +1214,9 @@ static int panic_print_set(const char *val, const struct kernel_param *kp)
 	return  param_set_ulong(val, kp);
 }
 
-static int panic_print_get(char *val, const struct kernel_param *kp)
-{
-	return  param_get_ulong(val, kp);
-}
-
 static const struct kernel_param_ops panic_print_ops = {
 	.set	= panic_print_set,
-	.get	= panic_print_get,
+	.get	= param_get_ulong,
 };
 __core_param_cb(panic_print, &panic_print_ops, &panic_print, 0644);
 
-- 
2.34.1


