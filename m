Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B5606B396
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1PL0TCS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbbq1Xbyz3cGY;
	Thu, 05 Nov 2026 06:48:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821735;
	cv=none; b=kF5yPL6exBigK4eMcxoNa6d49sOt3a/eXx/zseSdYhlhcPQQzxqFLWGU5Jg33QYPp7ZKHJQYZLn6+LJFiZu8Hgvkr7m0qjQzQ3LbdQ/cQvpfnPVjft1twCO2/1Mng5EBCsw4NPFkIRO4KVX5jumR8kjK9oQyBHLSvgSxNy6VTNYTbZqz9VYa5bcze1q5E4nwMgt5j/qgJO0/6NgE8Jhwc6itWcoiKbx3ggpTugeaPSGzm/9wUhaa9oo8mFcOUnCBFGrSxzB7Mpi1noA0URMgpPgnJ0iGxkjSkuLiBMl8PL1NHGMlRXyyQtClqd+JNkerFmVw2EekhOKw645m1GG6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821735; c=relaxed/relaxed;
	bh=b8WPUZ8Xzk4Uf3KLwo9v6zFft8hyFZnIr4Ta+1e+n9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTu6fb/W15lI/txEodcadjBp00BxWU+pW4jDpLVIkr8Jsa8RKvebQ6EIO/X5yXrAxviQRtKG3L1mXkt1sQZ+z7Z2H7aKFxxhV5ns/o6Va3IGrPiakZP+ycEcDMfkMUpQ2TaVNb4o285Rsk3jU8N7mmC5HTeHwdMgoMYykXXqGG2BhBhE+Misjd7e3xOnKqXtUM7GthzGT3w2uvAiqdIdsXyEVrC2Y8ZoBeLm5jMDl42epJ9m51Rl4YEuqCxgpJZC8xV4U70w3IRlvTChXg3c0Rjz+7f5M1qVEX8qTp4gNCMyo7wObdvJ7KUxr6KIR+nVeDy7sm+QMdyEwlA+zD9oMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1PL0TCS; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1PL0TCS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbbp2Vknz3c2q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:48:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 499E04071A;
	Wed,  4 Nov 2026 19:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A081F00A17;
	Wed,  4 Nov 2026 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821732;
	bh=b8WPUZ8Xzk4Uf3KLwo9v6zFft8hyFZnIr4Ta+1e+n9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G1PL0TCSVDwmq6lGU2BKIO3vpAy9ola4AujwmSLJkb5KMUnTLPKnCEvvzLMviPtgn
	 wND4dUemZH7RzXVci0wodw5Ce5v9lazZa2PJvSlXlL50ggFDTSmwojOvxU4655sT6V
	 da1eeT2llGyW2Eu8uZBGRP3z0bbZYTxk2n8D/Foa2zoY7iqG+BVIhTnHhNZAOkWxK4
	 00B0IFoyr+ECjUwAY17pI+6EKbEfW3y0CVh1pSS5m57e6CtXfHKw4ln+bCYcwItAdI
	 P9pOOC3vNTRs9xSAmPdROXPvJKb29eGdAkqsnQstZewCU65bM0CCjaHNhaQiD25bxA
	 MmdfbQAJQvIJw==
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
Subject: [PATCH RESEND v2 26/26] ALSA: info: drop the poll_table from the info entry poll op
Date: Wed,  4 Nov 2026 20:48:37 +0100
Message-ID: <20261104-work-procfs-drivers-v2-26-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=brauner@kernel.org; h=from:subject:message-id; bh=YteJ3j6/FblA5UteLfKk0N1VeXt3kJcYQjXVJOX1kxo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97pocuEQtOyVxSrtIrlLVW6YsviVsb7cE3Er6v6NVN EuJ7xFfRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQSWxgZzvozyXl46z6zj9qs wOZhqjrL/zyXKUPnOr7f0ol3l6+NZGTY7Dmr8rLwiZlvru6dp3epj+dff5pW5ubNCo5fef2qu8q ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

procfs owns the wait queue a /proc/asound file is polled on and wakes
the pollers through proc_poll_notify(), so the poll op of an info entry
has nothing to do with the poll_table anymore and only reports the
mask. Nothing in the tree implements the op.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/sound/info.h | 3 +--
 sound/core/info.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index d6cb0346f77d..327d92059f67 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -48,8 +48,7 @@ struct snd_info_entry_ops {
 			 void *file_private_data, struct file *file,
 			 loff_t offset, int orig);
 	__poll_t (*poll)(struct snd_info_entry *entry,
-			     void *file_private_data, struct file *file,
-			     poll_table *wait);
+			     void *file_private_data, struct file *file);
 	int (*mmap)(struct snd_info_entry *entry, void *file_private_data,
 		    struct inode *inode, struct file *file,
 		    struct vm_area_struct *vma);
diff --git a/sound/core/info.c b/sound/core/info.c
index f837cfbe7313..c8735a6ec789 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -193,7 +193,7 @@ static __poll_t snd_info_entry_poll(struct file *file, poll_table *wait)
 	if (entry->c.ops->poll)
 		return entry->c.ops->poll(entry,
 					  data->file_private_data,
-					  file, wait);
+					  file);
 	if (entry->c.ops->read)
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (entry->c.ops->write)

-- 
2.53.0


