Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553D60A3816
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv3gFXSS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKY576hKWz2yTK;
	Thu, 05 Nov 2026 04:55:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814939;
	cv=none; b=GN1phe1hCQp1HizdxCDWSSW8mVUiAmtm9oAy7SXAn5C6dj59t1EXeCIqSQn0lFkM41zgiXjmzwbMCtrZknwcelEOWXFBfCW8J4bovnnZf7Y9a1SlkfINKNyIbLrcJvapY8gpbFj+2h6sCKjoB5KfM0earEfr/IfsmEawDvUEbWNgWqEFhB9ohqM05E1WjWU8Q1d1dvSbkzbhNIYYfJzwgeuM+mPqBCaRfoj99+RCOzzdcmsl2+GEz+XLXdqzOKyYwRF1zAg452QQc4UQ2WA8IJonC0c8VK+mgTtw///O2E0QsJrP9kV9nTUbeL0ev1MSZaPvljMSyjfcMXtccsyk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814939; c=relaxed/relaxed;
	bh=89c02+ELWuX5+S2o66zdN47fZ8jrr3os6Vl1YJUNtuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqB3Va1UwJ8BuXWBIi2pa8YPIBnkREx3FAlqRy68QqCWHMCW1k9klXDeBEOEPjC0v3EF97QihU+PNPWgoXh9SieY4yuQcKIHI2nmjP9cXonlVm1QVXaIWaSrchLSpGehIwIF+J1gGQVAaKdOd1SZOzhFldQnLhyI7qwLZqe7FiRUDjIV2V8OimcNBtQBVhJpo+WhrL18ruH5HBuNm8sSHGVJdjRSS4IYF05+0pHvieJ9eNWU36YW7MIW1YF8OPSUtF0iMaI+U7ERTgc+Iixb+hQSIoQOnT5X/q6bsfAFFeyFeB8AeWaRYM8s9mTXICs+sAg4k9471Zf/rCLLC8Oz9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv3gFXSS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv3gFXSS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKY570h6xz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:55:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 31A0960AB0;
	Wed,  4 Nov 2026 17:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4DE1F00A16;
	Wed,  4 Nov 2026 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814936;
	bh=89c02+ELWuX5+S2o66zdN47fZ8jrr3os6Vl1YJUNtuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lv3gFXSSZQ1eyeFxl4sMw4NV+sDGb399yJy5J5a617cu3SzjnnFfUG43Lfl/7N2wR
	 K+IhSwvXPWPYjM+q4YQ+IDJcS26tQY7yPe6vUEMgkrymmspdu0EotaGD42o6rpaRl9
	 0A3kHepPv/ApdT3/KV9Zp4gd4PPOjbWG6usoLl5/UMWpBcxegT2cBWuUjFbtBLH7mv
	 6ymbGGCGv3TrMbwp1kdSSvCMr+6QGHtpTwZWaklXV25iOtzvIgzYNxKq9awhT/uEik
	 dFy+Ax1siZAlHQyp0vw3cAsPNd4lTDPGDdUR7g3JwRgFyHgFv3m15tZ2mAVMcDLMbJ
	 1KqqoJMCmMAiQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org,
	kexec@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: [PATCH v2 35/51] proc: warn about entries left in /proc/net of a dying namespace
Date: Wed,  4 Nov 2026 18:47:21 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-35-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=brauner@kernel.org; h=from:subject:message-id; bh=WtI/bNxyA4ZViPTNrsQhWLRSUjQUZ6M8VP3x2XTkww0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9znslLxak6zXzI89Tlobt8x2XHObOOr/+XjXLr/wSD pcMiUNGHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZcIHhv9PR9Kbfsr9EuEwS 1OuN4o2O2Xfx2elLdO/WqT/FzfBsLsMfvrrlGXyfnU+ePfxJ5/kd5mMSt0XZXSfwl/mEMKZnOc9 mAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_net_ns_exit() runs after all the other pernet exits and frees
net->proc_net right after removing "stat" from it. An entry that some
pernet exit forgot to remove is left with a freed ->parent, and so
PDE_NET() hands seq_open_net() and single_open_net() a freed struct net
when the entry is opened through a file descriptor that someone kept.

There is no such entry in the tree that we know of, but nothing would
tell us about one either. So warn about it like remove_proc_entry()
does for a directory that isn't empty.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: e9720acd728a ("[NET]: Make /proc/net a symlink on /proc/self/net (v3)")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/proc_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index dbcf87a257e1..df5484813d5d 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -410,7 +410,13 @@ out:
 
 static __net_exit void proc_net_ns_exit(struct net *net)
 {
+	struct proc_dir_entry *left;
+
 	remove_proc_entry("stat", net->proc_net);
+	/* Whatever is left still points at net->proc_net and so at net. */
+	left = rb_entry_safe(rb_first(&net->proc_net->subdir),
+			     struct proc_dir_entry, subdir_node);
+	WARN(left, "/proc/net: leaking at least '%s'\n", left->name);
 	pde_free(net->proc_net);
 }
 

-- 
2.53.0


