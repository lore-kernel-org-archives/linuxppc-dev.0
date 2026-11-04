Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80432606D327
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs900pf/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXzg1tZwz2yDr;
	Thu, 05 Nov 2026 04:50:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814655;
	cv=none; b=O98iwXDhPYs77qCLQmF7ivxHZHMe72KhvQlwOnR8Un8uFiAXdCcIXHvkOCFqGaRz21Lz2FH3aRorWF6cOcba2MzPxCUNDPyz/xa0rEVjzrSoenCnvIulxJivbN+5BW4RUYFzuTb9xRi2Zem+gjkJAEGtiyQVAETP/1oaM6YVg3o9mqwTGjizS3TsE+OXCJfA8TO/l0dKesC0RhjTIpTGFNl5ZDTdNA4eIyXK7IJp1EBk5fXa21lh9do4AGIZ/u3sOxoGcjPDUAbZeln2eCPAD12+0YBFLPBn0YcMsPbQnVl7LUsNi4J6TXr7WV85yzdHkTgKftqP5JGlm+cMdyT87w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814655; c=relaxed/relaxed;
	bh=ih8EKkL3fEFrmnOibnSg6zuDA24U9CpFmMUb1+ThTQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juBvGb04LOphfWjPMggIWisuTN/NgsDqgdnnvJS0nzeqsvgQdfHDpuE2rBtwpYmHurEUWxZcUy3+ugFXPfwSNCBwj2vlcz2DD9dEtc0W36DesMDTjT9/u5tU0yoHSIiQ8Y92aP4fTFnd24yu+BXOVLnJ/s5wL5HV+WbVc9AZvlpz+3WOK1mid9kUmb2s1tn2ShWmrSQQh4ptsivL8Fy+/Hf2lUDTzssPuISjEmGPzLpFlKbnAN4QkBcN0eBdMpkRKBkzShjBy3sT+JBxgSd0pY1M73gCqV1jvXG6TiHVWOdnX7PkaYYwsLkLxstvSVIE5DzWJnfwoRVAUQwInkNMgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs900pf/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs900pf/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXzf2gHHz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:50:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7977560A6B;
	Wed,  4 Nov 2026 17:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A5D1F00919;
	Wed,  4 Nov 2026 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814652;
	bh=ih8EKkL3fEFrmnOibnSg6zuDA24U9CpFmMUb1+ThTQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rs900pf/e96en+TLGDsSEaZDMSU5oZQyH5nZF7UwPtKKPbnRGVFWZ00+YoXP6F4Is
	 q0FuLwKaUF4nN3gz2xJIMC1lUGMhu05g4EQmKbrK+q0N8NJzLb9mePMfp7AcDBYc10
	 x61YX33cPuH/8i8ufX0WghhS/B3zq07hwoKbuiqX72KPAMBcVqLQvk07L0+V7P/Tdr
	 40YtyYcMx0U/wZ/Yjv8DvJGoDR8zXAMEeTQuW2MXE0nFHOsHJCtQqwc7JWZq4qZj7/
	 4xvxSNCcWgEK4gFORKmZhaLtRdAL9biaxJIFwBQ3BbvkWhj9sqmIOkeZP6BWLhtYp2
	 6TwkPAQH74hwA==
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
Subject: [PATCH v2 22/51] ALSA: info: don't write past the end of a data entry
Date: Wed,  4 Nov 2026 18:47:08 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-22-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=brauner@kernel.org; h=from:subject:message-id; bh=/wIh+WZXKaFyyFYwMjXKmLvFs42DoCHjOzS3J0v96D0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zrsptH6O04ab9YvmrtGx55O9VOyReez3z/NfPx/vP bHVeEsQV0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEvhsyMqz6Zx61me86u+1+ Z73TMTGbvt9IUwoxnH1ZvumySeeKiAeMDJPbtrXoiO+Y8M60S/DOI8mwolZ5lkfT2EO5qks1+iT vcwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 sound/core/info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/info.c b/sound/core/info.c
index 023b4736aa6d..f608d335b6c9 100644
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


