Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57896082BCF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OegWozdU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFqn4QSKz3fG3;
	Tue, 03 Nov 2026 02:24:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633077;
	cv=none; b=BMWQhvZCqfMztY64hdoKP3ni/+2W3W1q9sp922b/amUrnok8woETwU6QRovZgMbACHpi32+FdEGCzINl1gRKGzbd7mMjo41gMT7F0TqV9rhVusWVM5diU6LUFL85g0oJdvcnCwtoiZg5h8iwiLP3eQfwCQEbklRfexVOaA6tezs5yOLUHe3EepsgzGCGOzW3MNqd32yjCA4AxDu7FZIxALTHc1XfV+lSD+gFxO2SDSsAPtZyjBpZqPo8Ko8b35RRcIcI8kJUQxT7dlvFp6+XaKVoYNHf26X07GLMcV2af3Y4ZfB85/wu9tC/3ZkiXsLPTzpzuLWt278kwrHLRBpzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633077; c=relaxed/relaxed;
	bh=oLmDMwPd5/E7rKj+sTJUI9YQ2nm5m+orCk4a0Hb3xdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwlwlR+HuoS0zcCyHcAnv8olOwVkBzz/oXbjcOSApE1t5dBBHJvqwdaSaOn0ffKrX5wgNuGxRka0Hq0RlGrLBLdtUmflnLx0gW4A2Zs3OTod35++nC2ah6nTnWNd6g4QgD7sXQgPROs9rWpyTkz12UaLSJ7+Wh0HdNt3vmxaRYHcE84r7Fgv4vN0p93LNcl2R1+8XCSAlq+b1c+jqaU1IwYzDj7Bb+ce1vcCGu3ZW2ZLh4YZCFrj+q7BLKOKvngGPMn56vgfamfNICXzr97T7xzwBEtZO5xO4ofwJoDQInhfe0FiCkmuaAmTVxeJ40pmn0Z6Co/0U70u0bWEIsZbGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OegWozdU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OegWozdU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFqm4kt9z3dVH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:24:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 91F2860054;
	Mon,  2 Nov 2026 15:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012281F00A16;
	Mon,  2 Nov 2026 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633074;
	bh=oLmDMwPd5/E7rKj+sTJUI9YQ2nm5m+orCk4a0Hb3xdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OegWozdUNrHGegNfTW2sm1HszSzrGzjh4ebMkWsD9u5gapIhy/O07QlRH3LV8M60J
	 //9uoOmD2XV9WnY62s/9qC5sYKTMOlS7YYqmfCV9USWy3TF92pR30R3sIC3bOI2cDl
	 eEYn+NqyCZgWe3RZrUPYTjFNI78jnhghKTiQ17RDj3pUBjadrdwq1A/MV0eG6aKps7
	 XvYJ1cpQlb/G4uhuL9+gJpBzSStLEg/xW7EREUkdqnqORUj3TCI9W+nv9Qji9Ee+7B
	 DnyLhoImoHxzQ28fH5V+87G43o48UQI/63qjJ9PF6kXAg+QKgEiJv0WhYMM43w1hXk
	 YkGa+9+0aqacQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:24 +0100
Subject: [PATCH RFC 14/27] profiling: let procfs copy in writes to
 /proc/profile
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-fs-v1-14-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
In-Reply-To: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZtnZ7+j/OHZGj1nwL6jF9VPBdIcnJPmE5lAHJaT+bVk=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGropzKjAwsxvRFdHBmiuO5usrlNmAf7XGR/a5n/gvJ3Bj8se
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmropzIACgkQkcYbwGV43KLjJQEA0hf3
 srBDq6EKvc+VG3c3zONfGz6/IVil9hzyZy3OB28A/RQHopfLUnFRNQfqy4yzV+dF++aZlDkaR57
 e/BjxgpoM
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and take the multiplier from that copy. Writes
larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/profile.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index e7defa90a34c..6e4b34f35e3b 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -189,16 +189,14 @@ int __weak setup_profiling_timer(unsigned mult)
  * Writing a 'profiling multiplier' value into it also re-sets the profiling
  * interrupt frequency, on architectures that support this.
  */
-static ssize_t write_profile(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t write_profile(struct file *file, char *buf, size_t count,
+			     loff_t *ppos)
 {
 #ifdef CONFIG_SMP
 	if (count == sizeof(int)) {
 		unsigned int multiplier;
 
-		if (copy_from_user(&multiplier, buf, sizeof(int)))
-			return -EFAULT;
-
+		memcpy(&multiplier, buf, sizeof(int));
 		if (setup_profiling_timer(multiplier))
 			return -EINVAL;
 	}
@@ -209,7 +207,7 @@ static ssize_t write_profile(struct file *file, const char __user *buf,
 
 static const struct proc_ops profile_proc_ops = {
 	.proc_read	= read_profile,
-	.proc_write	= write_profile,
+	.proc_write_buf	= write_profile,
 	.proc_lseek	= default_llseek,
 };
 

-- 
2.53.0


