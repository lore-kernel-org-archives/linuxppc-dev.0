Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A7A606EE98
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpHzZpnF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKZvb4Ftwz2xjQ;
	Thu, 05 Nov 2026 06:17:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793819851;
	cv=none; b=MNS6tyyjXP/CDXub5/nPZ9+dlPZcPSom1d1fLX47iN7w15LWHcnXM77tScWRvDhuvFGxs5dgfBvcCiceZoDQ1xZa/NFuKKjxGaExAMlOvM+nFnHFA+Su7ab2bSWPdfEt5Yqk6y3ilS9PgjXdAYmpW43r0D1RKWMh/9wdZ5SQNcgng2/+GR11X1/FlWmK5+GDi3v38oEjke+bwy/GnPi1cMLoEh123RVVXko3rXsviH9C3j+11wQAxL2NBrTDuLxaCl0Xc/c5qwK5DD094f5A3W9uDr0OPINc110Gv9q7f/yNnF3PMYBcdvgQ4dZnwbDna4BNLg30p8HT9+C5z+o8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793819851; c=relaxed/relaxed;
	bh=jP/hayhlpAKZdjJKk3r9BHeVVOYyvJcLU3d1z3kH9u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5NwOW8Cwl1S1hpewl57AK2XwrQZDLdWeDa2Uw5SQWzP+nGkj2Tfu62H+WD7vVikRkr2LPLxm+cnz4UGeJeRSl77m0//Oh6KF8Y5UgNkKLoq045eE3cCRhQfhjYrXtqmHs2d1wQi1bkCJC2BZJeETNco0GKJbBlbb4W6TTfIkBN6gLqjHqe6y/XkN5jsoxttqwTb3nR4Ygo7qvnxXr7WKo4/mx+6YRJoUk2Y3yxvjw7L1lAJBvEkepmN37jjzjiivb1k6uOYVEWaslVcJK01XoxhhLsnnI0+UjpBrCqjJofaKjI5JCZ15S9b+GGx1QVCzIQzbsD9qsoDhNJ5+CVz7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpHzZpnF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpHzZpnF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKZvZ4TgWz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:17:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A72041388;
	Wed,  4 Nov 2026 19:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C9F1F00A24;
	Wed,  4 Nov 2026 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819848;
	bh=jP/hayhlpAKZdjJKk3r9BHeVVOYyvJcLU3d1z3kH9u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KpHzZpnFwT6+C0q0yRCi5k/OA66tRS7eBzT8lt1HaWQE8e8svE3VZCRBnfRHdCzx7
	 71y/CPv6HCeTe9zbap2gT5FJuzj5hekBtO1a4cjxKuetzIxGjHALxdRgkDffBvgqoN
	 /aj76OWmFdznND17QWfa+CPtL2LoFKokFbuci0W4IBDDUUsoZwEUSEMsIoP5ROVtaD
	 UYsfpJY8su6lg+vsurlkAT18SVCFHIc8HLWY3wDZz/GvQ7lhgYrpLIwR5WyV8knPdX
	 rwvwNGe1ypF9HhdxdQGkkPDxlpkOU61C82qjywHhkl5yTgB9ONziIAgGKfFuFYu0iv
	 y/71Zwy9XejIg==
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
Subject: [PATCH RESEND v2 05/51] xtensa: simdisk: remove the proc entry before the disk
Date: Wed,  4 Nov 2026 20:17:14 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-5-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=brauner@kernel.org; h=from:subject:message-id; bh=f7Qg/00vnZM3tuJ138yAFxD6JPv6/GBN+HDx2x0z8gg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9brxQmmA/984KHvt9Xz1eFefxl8hqpieb9fosObahV 1Ne5l9gRwkLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERykxj+u2j/eB40M+7p2v17 /GMmXT/na+Ctz77txmH9Sb+NLH5yrWH4HpzAeT45SPnv5UMnF7jMebDmtMJKXyf/NT8uPWe+O7+ RBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

simdisk_teardown() frees the gendisk and only then removes
/proc/simdisk/<n>. A write to that entry in between attaches the file
that was written to the disk, and simdisk_attach() sets the capacity of
the gendisk that is gone. Remove the entry first, remove_proc_entry()
waits for a writer that is in the middle of that.

Fixes: b6c7e873daf7 ("xtensa: ISS: add host file-based simulated disk")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/xtensa/platforms/iss/simdisk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index a2ddb49c269d..e51edb8cf872 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -379,12 +379,13 @@ static void simdisk_teardown(struct simdisk *dev, int which,
 {
 	char tmp[2] = { '0' + which, 0 };
 
+	/* a write to the entry attaches a file to the disk, so it goes first */
+	remove_proc_entry(tmp, procdir);
 	simdisk_detach(dev);
 	if (dev->gd) {
 		del_gendisk(dev->gd);
 		put_disk(dev->gd);
 	}
-	remove_proc_entry(tmp, procdir);
 }
 
 static void __exit simdisk_exit(void)

-- 
2.53.0


