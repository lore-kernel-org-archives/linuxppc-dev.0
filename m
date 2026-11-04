Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A919609C06E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2uxiHux
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbmy2dWHz3dWv;
	Thu, 05 Nov 2026 06:56:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822210;
	cv=none; b=ULiMeYvjRvgRM5EMeiFaj5VtQqM70D4KrlEvtEAkqy9NsA2s4b2VDy/rSSaNuVFTZvUcGsGueFMa3U+eKKaTMHnmk1J89rhUIgtwXTxHyuyj7iWcdpcuQ9fPSVccMlTABaTdbibsyBH7oR1B6Oy0hN7Pm/9Zi8sBuSf0dUtLhWbFhxiCdpQ2JSaKPWNyd5vMcGisxLyFBFJDQaV7BkOj0sxTwFEhJIoEeGC4NhsWUEFa7Zh+t3QwnkZuDcQPdVtgli+JLvq8TtoWYKJaYKYj5aR6MZqbN6Ke52ZkWb4tO2tLoJZyf/E91tQE6vxPNjXPKn6gnVP1AmQ0/1WAolEv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822210; c=relaxed/relaxed;
	bh=9vYsQ2z6p4kEQ26Jb8WOubzMzQn6P43ATzZz2gRYd8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HK4ysnTqcoO1Kw/Fe/LDFDi3QICo8LaTZyoD68/hE+/GS3Ri1kzYs8ZarqJ6sAfKHx73KdJozAMD/RlVfrPRqA5gl3fzGEB65dhiB8IMRvylzTa79u3715920+ngAZZ5g7lmrT8agZagzZbTSjdeVo4dwl7sGqQJV7HVQjCO4Go9ZsWX05G1k6tyL32b7NhmGXIycrdAW0NZxmZnuGu99uamCl/waW8lTI+ZZZIU2DN81feyLsMHdia/hVOxsWjWD3BaUopsO1MFcFw8pmcZ4HjYe96EIzGr6ujua8lQ+uyTENFXmhm0ZpDtHWUyV4dqj1LPcC8mD9yMja+bJX3BEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2uxiHux; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2uxiHux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbmx3nWqz3c6c
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:56:49 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 844B84010A;
	Wed,  4 Nov 2026 19:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8051F000C1;
	Wed,  4 Nov 2026 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822207;
	bh=9vYsQ2z6p4kEQ26Jb8WOubzMzQn6P43ATzZz2gRYd8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e2uxiHuxfEJdhmjLozO9LVNrgHWWCvyZHjL6HCg7amaM22yI9yG0olu1uJ96j73/Z
	 xTQNcQbMhTyIG8P3vbMDLmuT2phtFdMJBnVFMbLXmKKNtZbqq02BRamAUB44uazdL3
	 urCr5eyZbIruy/giy8yhCYSK2FnSUIzF0uuLJu8guQkWA1W37endcFSgwzxgmXgdpv
	 WgWqivOuiipmtpXNrqJUTWyUBgi0SwINwwt/Cqe2dz7mNJDn9EIm/pVofRmhuImUVo
	 H8QqbrQNf9HFXNZ1hUfz4Fw5j+PPHT9mjrfkR6KYflVEzz/AoZKdc8Eb+kMcDaWwM1
	 H1CvOEcsSWIHA==
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
Subject: [PATCH RESEND v2 28/30] mm/swapfile: let procfs own the wait queue of /proc/swaps
Date: Wed,  4 Nov 2026 20:56:33 +0100
Message-ID: <20261104-work-procfs-fs-v2-28-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=brauner@kernel.org; h=from:subject:message-id; bh=VLC7S5nkyALdZiiw9586D7569GKKbKISIa7jUul9ZSQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97vEV3KXoYc6wwNTta5J2SbyikafkWx/po6m7FWtOr PLmcCroKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMhMA4Z/KivFpjxV2sx0std/ mh+/+VeZnyvk60UXbOG53vWE+fLyG4wMk7fu+rgnv6JzYR1H2t24xj6e5tmlRd9mX90acdHdM9y RDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

swaps_poll() sleeps the poller on a queue of its own. procfs owns the
queue poll() uses now, so leave the poll_wait() to it and wake its
pollers when a swap area comes or goes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 mm/swapfile.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ee4868ecc3a7..1d063a1cef43 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -111,7 +111,7 @@ static struct kmem_cache *swap_table_cachep;
 /* Protects si->swap_file for /proc/swaps usage */
 static DEFINE_MUTEX(swapon_mutex);
 
-static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
+static struct proc_dir_entry *proc_swaps;
 /* Activity counter to indicate that a swapon or swapoff has occurred */
 static atomic_t proc_poll_event = ATOMIC_INIT(0);
 
@@ -3307,7 +3307,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	err = 0;
 	atomic_inc(&proc_poll_event);
-	wake_up_interruptible(&proc_poll_wait);
+	proc_poll_notify(proc_swaps);
 
 out_dput:
 	filp_close(victim, NULL);
@@ -3319,8 +3319,6 @@ static __poll_t swaps_poll(struct file *file, poll_table *wait)
 {
 	struct seq_file *seq = file->private_data;
 
-	poll_wait(file, &proc_poll_wait, wait);
-
 	if (seq->poll_event != atomic_read(&proc_poll_event)) {
 		seq->poll_event = atomic_read(&proc_poll_event);
 		return EPOLLIN | EPOLLRDNORM | EPOLLERR | EPOLLPRI;
@@ -3428,7 +3426,7 @@ static const struct proc_ops swaps_proc_ops = {
 
 static int __init procswaps_init(void)
 {
-	proc_create("swaps", 0, NULL, &swaps_proc_ops);
+	proc_swaps = proc_create("swaps", 0, NULL, &swaps_proc_ops);
 	return 0;
 }
 __initcall(procswaps_init);
@@ -3907,7 +3905,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
-	wake_up_interruptible(&proc_poll_wait);
+	proc_poll_notify(proc_swaps);
 
 	error = 0;
 	goto out;

-- 
2.53.0


