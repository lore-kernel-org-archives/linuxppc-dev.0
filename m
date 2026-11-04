Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86B606A32D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVG35mDd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXwV6cfQz2xjQ;
	Thu, 05 Nov 2026 04:48:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814490;
	cv=none; b=BrnSdy7mlDwiSLQqsfapUFdPDZJ7iyTNrJl2IrE6/O7zXaK0MEV+XvLz0586DaRObilwOwk5UY9UV508bOayC1GmaTWcrnmLHauwsBn+5eAmhZcU590QATzTHfgUNT0BDU7Lffl99AeaGHtBOinf35TI2WDHLqo3t/yyKdkSyCIAKdGJ3uXxpm39XEYtfb60gqKI7kXN1rKxotTkGW3dfsLIJoJnRxnAth3kkLi4GOhYbbHcqL7J/AnPfVxlmqKq6INtLPx97wZ5urxxt7lg08vYLe3WodlTdrcrkJ7rxzYKQjGeKz2BLbGHJoSecvpaEWk2KYuSWiGo06/T6JtbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814490; c=relaxed/relaxed;
	bh=+QMuJvtMuQ+CXnn6xLeWoxU7H9VJY0mzKEyTXi76/+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+JUhg+25bQHoa8w0WGzkhfoMN15hQwP+2tXdc+BYJD3IwfWRjpkg9SB7j0sCY5m0IoEIvQsoFQ+5rC5rDrStnfZ5WYvPZeIdMjTbvmSjwQhkJqfygUA33vUG10VRzKcRZ/zesYrl/T2VEirwH9W8KuuQxrV1NmlUrEjG31oispCiZ1OAxAIv2QXvY0b9LhNrpNV7uH8eal/Kv7oaztJYhdGqaPVrRcpaOQ8p+lM44OeYKY5bMYXKJqIvaC8KkrcoXCJwamyQNYjkHQxhAdmu76DfNt0CMM1gzVsOy2wgpLIHpUrR3gpBlb4cslcAxFqG5FuhITP+dx9AkcdhH+CyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVG35mDd; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVG35mDd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXwV05Zgz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:48:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F1D886021D;
	Wed,  4 Nov 2026 17:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9FB1F00919;
	Wed,  4 Nov 2026 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814487;
	bh=+QMuJvtMuQ+CXnn6xLeWoxU7H9VJY0mzKEyTXi76/+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVG35mDdrJ+w70lYp9CqgpxTuoGTpj4temyLsY3vuBl9elVVBnmHrviotaVGY/ppP
	 UdOgypZXpDWtJ7enRd3iIIX4vWx3xyqPaHPzOZWq/P4JUJrwgIpI4MwtSTSz/6po8R
	 Yvz02Y/vDREj2xNfVXWxFSvrw7Bvuiwjqz0knxKP5rsjzaWDW5qaKyJ9F3yEnh+EWh
	 A3TtW5nyoi8NpYae3YAaKFmJ3QPX5Rij2cVvQ/1JMiWehFHBZSo4em6YfVuXhfiqDi
	 JqHLo3hhdvujnwykhoFrIyHzHBnGpPwJgUwVLui5mJv4lfTVDRPXKF7pOVu2XHYste
	 DuNdex110TFZw==
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
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 13/51] sched/psi: don't drop the last byte of a trigger write
Date: Wed,  4 Nov 2026 18:46:59 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-13-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=brauner@kernel.org; h=from:subject:message-id; bh=/5ST8groFWC3ZYrB9+5K2L5OtN8hrslkTr6MpvXzbng=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zjv/59LFdb+4Nqzr+cU3P2cS7+L2yauySvlfWb8/9 eufsCjT0o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJmJkw/FM9sG/u0ochUvwi r25NnfqcY/Wv3m+1Rk6yc5TfvmHn3j+V4X8gx3Wx2Wp7OP7b/lW+zLTMQ+Qde1X2zk2aTqESmTX LCxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

psi_write() copies at most 32 bytes of the write into its buffer and
terminates the buffer by overwriting its last byte. For a write shorter
than 32 bytes that is the last byte the writer sent. A trigger written
without a trailing newline loses its last digit then, "some 150000
1000000" turns into "some 150000 100000", and a shorter one like
"some 150 10000" fails with -EINVAL because the window doesn't fit
anymore. Only writes that end in a newline parse as intended.

Copy at most 31 bytes and terminate behind them.

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/sched/psi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7c5381423334..8b59635e95d4 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1566,11 +1566,11 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	if (!nbytes)
 		return -EINVAL;
 
-	buf_size = min(nbytes, sizeof(buf));
+	buf_size = min(nbytes, sizeof(buf) - 1);
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
 
-	buf[buf_size - 1] = '\0';
+	buf[buf_size] = '\0';
 
 	seq = file->private_data;
 

-- 
2.53.0


