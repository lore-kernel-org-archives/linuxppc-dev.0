Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6B606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BPJW0wsm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jN7CH4FS2z2y32;
	Mon, 09 Nov 2026 09:39:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1248"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794177595;
	cv=none; b=Mg+TwsrECA8H2UQVe/XfAyk6UivF/8OpUB9nWIJvJ5xIPwjPewezz27jgFyLz3hiai7qflWoChkR2QWihebhFI3m5DDHM+q/NCvfWDQl2iG5YYUNiOAH8WHJ2ZfbYI5o0w/rneXfex58tgFijBLHCAEMsySL77caVpE1NbbUzIS9Ab5piakknMGYUjVilFPg08W9Fe299CGFSemkjSOJDE+qNavdlB9jfhqVKAftzds82GMsrCKUbiBrIbVIUlSJmuNhhsaJ7nvQ7bYJIaOqhpMaTzKNh/PqoZpV/WNdG0dtXD8Yz28VS/TKAm/UZsgdii+aL7ghMjQ916rZG4YM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794177595; c=relaxed/relaxed;
	bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XpQU4RoAHiSGir4m+xuUKLiyD65/UACRkkxT6q19pHs1rhA0+S1sGiXCape+Sk7Zrsy8TV4F6KbRIXbuBL+u7CYAJzTFVWWqPFX7bTEcg7/LOnWwOudrerhSUlrhqyHnlfvDqmtgXTsdqXKOwpYcd59vxv1zz5s1mUBxckLWIvHxDlJQtVTc7cmhVLzlwAjPCBqZ+CrwvCwzI/6uedcNooj4psv7KgdzpgQiexfQzw7/pCorSG9eQHoNte2NAqa8/U9fDjVBe00nlyCRalZI3BYfFd8BFiL3HtKqiufTVtn+u2I1iPNpMPModwPpmDZHGEOnJHdHIbC9U6DiBMGHAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BPJW0wsm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1248; helo=mail-dl1-x1248.google.com; envelope-from=3oprwagckde8z85xv89x55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BPJW0wsm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1248; helo=mail-dl1-x1248.google.com; envelope-from=3oprwagckde8z85xv89x55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1248.google.com (mail-dl1-x1248.google.com [IPv6:2607:f8b0:4864:20::1248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jN7CH0Cpbz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 09:39:54 +1100 (AEDT)
Received: by mail-dl1-x1248.google.com with SMTP id a92af1059eb24-1ac19c6bc71so293005c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 14:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177593; x=1794782393; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
        b=BPJW0wsmJ2TlF6k+1G4FJl+6Smpndpcc6SW8SsZrHG4b4hJfB8tYMOubrNjqEzyJz4
         xgd3enkn5q0m+EzMPmqNTHH6diu4Bc84uc57VCmLQeRpoLSw6wmM0R6mf79PYneiryng
         d3RYqjrLXRAaFjcoX+NIDVMhDnXSI+aGsYRkQvuejoH7mLoyvr4TPurw+4zg7K14wLCI
         GDuMcWACDhZciQsMxo2TeNQkuN45/kJEZhLYZfYf1gweJD2VnHxFtyka+2kYOX7hLggY
         sAnx53or6CPQ56SWu/bxBJRRu+rc2lHqkmIiOkD40MGw433nluik88CmoSeEXfSpnOot
         /WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177593; x=1794782393;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noN8ey05POi7MkRY5IldCk9pju5ZMENfN/kneqqJ3/c=;
        b=0bUKaJ4cMhKD35KWg+ztT32ZqjdUqYXfzTljNHhjD/hLKAJ6mLsXuibC0+xxHfHDkJ
         sAhP0H2OwU0DgjgCTXJk/OWKc1M7p3g9fnYyGJfaccZCazbsBjPXw9dT1aVj8Qsrjew/
         D+AepclxplOpz4yXix9F2I6KfRgDNefKQpYBXq+4bTa7sdYQQPV1LmjSfpEDlrzuNxea
         6qMZMSDKCIX6ElPVvU/pQtIPhzbjzrWX+E5oerOWCMBP8SNYBdVJ6lCsbtZxSZ307n8I
         vVtD4XnJQr1ok7bYgH89v23v9QYNGgPYR5ZPg2z6hgvdwWpUVv+jvL2PZgsVyDSkITrd
         FkMg==
X-Forwarded-Encrypted: i=1; AL+hErEMo1Q7ZuMQbeYsuqaE0EsFYWqvszN2rZPHDFMvuTqA7UTdpE4rmhUV+AYFCf8AcIPijgI1nevxMJ21bkI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/lHhZwyzUGxqJQtJ/6XWCwdXVVA/5PfYgix2ZM776Rhqiaxzxe
	K1W3tz8dpAmFdVhJLF77XcT3lHFG49be3bb8hvVogGQ51TkA7sMh7x0fQSAZgKnWibtyPNO+HYw
	azmNT74ulSA==
X-Received: from dlam9-n1.prod.google.com ([2002:a05:701b:2089:10b0:195:beb6:14cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28b:10b0:1b0:430d:d81c
 with SMTP id a92af1059eb24-1b39feab6a4mr3897188c88.25.1794177592505; Sun, 08
 Nov 2026 14:39:52 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:10 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-7-irogers@google.com>
Subject: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
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
2.56.0.455.g6c5a503b38-goog


