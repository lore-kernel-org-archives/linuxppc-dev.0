Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AD606A32D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7eNSc/k
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXVr41yKz2xjQ;
	Thu, 05 Nov 2026 04:29:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793813364;
	cv=none; b=bHc9utQPGvyCcXIgG8Y4HwKfOpvfx8nHIH+1eR0ITW8I3C3z7wI+UzGkQPS/gtNHfSqzMDXQq8SKKwZxaimQHZy/SCxz5/kRr45TRUQ+iCWVDYUx8gWWqOzkdMSnR4kLa7prhQ3fNAYa1DxeDO6UKxVEE8MsdKByUdk0B28yxEUDFafQiSDeHanSxQukNPTrKH0WtUJo/ziTGASE5Jk/lwP0h4bpSy1cbmQJRpfTVngJF1LjySBDN3FN3OF3ZsmtDJLyWmFE2jD8Zg4nLjiG9RwQVp6u2RU+LIiBPug6E1qqOr4LRPpVXicqbvYWYw1ny1J43WZjufxSSxKwIN9C2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793813364; c=relaxed/relaxed;
	bh=Cbujoj2vf5W42joV5o7W0AvKkij9cCOpaGGghku9+G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T6biuqstNtE04AYPP4Tf/pWuKO2V3nxbFg8qnH01oaz/EpFCkETmk8RjJwRjKZMN/4MegZD2M/9qwnrZ+WNk88i4XkYmNTN6LIfl+YnL7rxoF9kOdtzzyhvU4hgQFFt/HO0yNllN1+uCQJu5ejq3yQRsXiCwEjhMtHpTRMS1O8mGM4S7YFlMt7ATHaBFbn+E7QQ5H08HNh+zmdgpHhDI0ms9fR11GynFh/wzAM8k+oGwf9Dt5xGgd/gw2OcbHWD6Vbl5I3VbiDbecv59J2gbK5ISRYBwf7fkJjDzSmz5DVY7um7W5V2kVjuQQpfWYUqvPz/2T86LWHwsYRnWetRhnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7eNSc/k; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7eNSc/k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXVq4xs5z2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:29:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3353560A70;
	Wed,  4 Nov 2026 17:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB89C1F00A02;
	Wed,  4 Nov 2026 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813360;
	bh=Cbujoj2vf5W42joV5o7W0AvKkij9cCOpaGGghku9+G8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z7eNSc/k4A3ciQiMKYVuHgvIuitZuUBG1LsDDKn2PGqkyeTI60C2aGeIX/gOrwywh
	 xtfTPVHdVi6oqn1gTkn9QtwCdpb9vO92jUAd8quwbbgGzLCmHr2yCQVt+CNwsUokAf
	 3PdNxsqj0EooTVaHTwU9Byq22F9nTmWr9AhaMKmjfOIuszcJH2mYIrP4Rr4AnPpZkH
	 h+7C63tA9sMWXTQV0Do399ArkxTfLMrSAloe1ryjs6twcaS2ODw+QTAKVaUx5fGvQN
	 pG82LTMb3cdXiyyhejWUAX1q+C1HwuXnFf38S34Yh0i88ZGrZX053f2X4mX3pSqwVw
	 kTy4TQ+sMGDOw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:20 +0100
Subject: [PATCH v2 03/51] ALSA: cs46xx: hand the region to the region proc
 files
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
Message-Id: <20261104-work-procfs-bugfixes-v2-3-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Z6ZRkJrhuCU4H5MdQ4cObdjJffW/paOotMbfYVXoKlo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zvpj7yWamixwZtfSkBurLcoYw1rMGKfuu3YuiV09R
 c7uw2HtjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImc3c3wT+Hkjp3MZso6HVei
 D0VKbZS5oKGx7I6p6Yuo7iatL+17dRkZfi8SqbU+57c5383JSH9+xYYuliMbRHb8cOA9JBYQHeL
 GDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

snd_cs46xx_proc_init() stores the chip in the private data of the five
region entries, but snd_cs46xx_io_read() reads that back as the region,
so a read of /proc/asound/cardN/CS46xx_BA0 and friends copies from
whatever sits at the region's offset in struct snd_cs46xx instead of
the mapped registers. Store the region.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 sound/pci/cs46xx/cs46xx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 797a5f09cade..efc7df444cb5 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2764,7 +2764,7 @@ static int snd_cs46xx_proc_init(struct snd_card *card, struct snd_cs46xx *chip)
 		struct snd_cs46xx_region *region = &chip->region.idx[idx];
 		if (! snd_card_proc_new(card, region->name, &entry)) {
 			entry->content = SNDRV_INFO_CONTENT_DATA;
-			entry->private_data = chip;
+			entry->private_data = region;
 			entry->c.ops = &snd_cs46xx_proc_io_ops;
 			entry->size = region->size;
 			entry->mode = S_IFREG | 0400;

-- 
2.53.0


