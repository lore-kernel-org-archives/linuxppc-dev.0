Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347EE606F22E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTZqC8ZG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDTm6mt1z2yKn;
	Tue, 03 Nov 2026 01:23:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629436;
	cv=none; b=PXAVepI+DihyRsKsU0Zpo6UiHm6w44DzwCCQCx/lsgKgxXGe1pdbJVSznBE13r0V2hqZ4o2J7ZZeWNuK1z8wMgORPMJqNJcXC5OM7eyU/1dJhgEJstl2zTVEkpOxDvFSbg12ejY5yTYnVYYuSMVQNcUvg7vRZ+eSS6NPknHM9XNjKMRLhpZmMY9m5+PqG4sMsMtB/qFE1OEFlm4CitSDfL3OGeaB4diPSgxx05iM7SOk3NFPepslhuX8aJJdcQrsaL4tI1mjfJEhk7lCQ3KCpAJHVGO2o2D8u9iFufmpc+7SjRt7O4gdQY3AExuNDtNUrXgz4vZm4zyYvbtoaroOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629436; c=relaxed/relaxed;
	bh=5idTO632MfTOh8DHBwsM5N+e4TPz7tW3oLCXLVOM1bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLtJWV8IZaPlFZ+ifP/vmvuJiVGXnQ7v3i1MMl26qeCzzI5GRFtEBxjR7/IyuUWRrxKn3/0SRcTgP9+JfaQ4j6WOA/mqJyxFM8IqcT7rWmoLgmyea773r7mUsB0PJzhjJYnW8+TReK6Vabm2EcGHZy4rUVLCjMFwgOQyaOZQ4Uh8l44XPtEu5Q1F5PjwDDaZIssbOUrOdd9Q3k0IMJ7kC0H9cJNCIdkJukQaioiM/W80vEhLYcJ9oExnIaJzUPgc4wRytbfBhhtpvJzcPqHFjVpk4F1oZBErCiJnS/zFFnUd7hPvZDnHVWgM7kUXiBf24wCsW9Bwy0N6Mxn1udsy/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTZqC8ZG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTZqC8ZG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDTm0gSGz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:23:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 39CF2600DC;
	Mon,  2 Nov 2026 14:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FB41F00A17;
	Mon,  2 Nov 2026 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629433;
	bh=5idTO632MfTOh8DHBwsM5N+e4TPz7tW3oLCXLVOM1bU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bTZqC8ZGdXxcFQd/3hUg3IW0rejRlM5K7QNfkjVY794R3YHFyVPBjLRGBUayKfnuB
	 o4SatPA8T6TNXjcltzn1X/uXTJRuPb2Rlfe8Ay7Lihwlip36LKfkuZzZ2uLD6o1lsn
	 vWG9sGTbL522XI7qvpHjUHz0MjvfEW17lvoFh1SmnCSdWAreu8wFgjZqF1c34Gdkms
	 8WxYyheLECrp0gW7AmhDwmWf847MgsFNk7fCgXMkAYJi+8MwP0s9Ehv9+slB77KTjN
	 Sw08w8UDfVr3lkJvosLxlggPqTYkDbchMzBmGfJx4chWnQ4NiIdZtKUt6Nf2GmPnXa
	 Jl4P8fqea13Rw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:24 +0100
Subject: [PATCH RFC 09/38] ALSA: info: don't write past the end of a data
 entry
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
Message-Id: <20261102-work-procfs-bugfixes-v1-9-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
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
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QDMkZvLaF3IWyPhoUUb9QYkcrNtI4YpDxPIetQD5jl0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJOVdu4T53QO71keyQs+h0u8P+U2ReHO2uq+t72Xn
 8zfu3i/eUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE2h8x/M+p1jq63Xz2BXau
 4IAvwU63lx9v/bDSeMfWNnHlszsNnwsyMhyxXa9lwZT9csfJKq+qsC5mVf35X28Ym77fVPdQjT/
 rICMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

snd_info_entry_write() clamps the count to what is left of the entry
by computing entry->size - pos as a size_t. For a position past the end
that wraps and the write goes to the driver unclamped, for opl4 into
sample memory outside of what the entry covers. At the end of the entry
the driver gets a count of 0 and vmalloc(0) warns. Before the clamp
moved into the common code the driver ignored such writes. Fail them
with -ENOSPC instead, like a block device does at the end of the
device. Returning 0 would make writers that use stdio retry forever.

Fixes: d97e1b78239c ("ALSA: info - Check file position validity in common layer")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 sound/core/info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/info.c b/sound/core/info.c
index c4d57d0809ad..982087bc8575 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -171,6 +171,8 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
 	pos = *offset;
 	if (!valid_pos(pos, count))
 		return -EIO;
+	if (pos >= entry->size)
+		return count ? -ENOSPC : 0;
 	if (count > 0) {
 		size_t maxsize = entry->size - pos;
 		count = min(count, maxsize);

-- 
2.53.0


