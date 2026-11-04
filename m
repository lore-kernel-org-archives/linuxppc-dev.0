Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF35606C592
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay5fDaWt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbjZ2Mjtz3cPf;
	Thu, 05 Nov 2026 06:53:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822034;
	cv=none; b=Y1/Ue/snAC5WUjF1iv0osAWEfUiZ8Tesm0n2K+IZuF/XYF6Henp1fN1LkVvmEap4GDy/wAjQfiANvgJHrGQOkrKZTBXVlhMA0scwKRHi/Jrum593AXshyOQpHIPhQdcYbvLZtFZdjJARkqFTY5WvjVKzh7ZHBrUqzmQBGwbtQbMzxpBTawks8WWCgK27BATTUVK4DImHk3FFb4xmVRyaOJEuHl0NwzXrGjVpzcqLftC9e/nDcTJJswSBAD9JbBbsxOk7IGrUzBc0OEeDmgjGXpc6VJi6/ERk9/cvR8qJnbW+CuEPVujy76j4vJ+75GdMnDwCl57UDQoR/8c3fQNXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822034; c=relaxed/relaxed;
	bh=f4E5LhgvAcYWZljBgO/W1U3MMJwdn+qZCE/pQraBe8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gs3NAOgC1+2IWJtdMiEICyIUSxnIMoyKcD4gK9VQc0BlHzSgDFgPfUkLk2I5UPY4kcRRvx2Cp0jFUy6HGgcJVZISN43ExOINf3S6HjoisZbvgH04kBphM0MoHGcFqft4P0v0VEm+zuhHoEJU8D1RNPWz74w06x+HWSqA+L405ZWQl4/nhEoaY1bJGOo6gGoBVjZ1tE80z8EsogOXbemTpBmNHTeJoP4r0YSKG+CPhuUS/ZdMJox7GYJlqVjoZ3lXSnqFcthu5stZ/YfCzukBRG2XNGoP8p0N0XePOwvHWaUjfWDVsU4YYruxNqL5eyRWCyRkktt0i5S+JdPJhYh44Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay5fDaWt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay5fDaWt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbjY3kdjz3c57
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:53:53 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C9C660F33;
	Wed,  4 Nov 2026 19:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC11F00919;
	Wed,  4 Nov 2026 19:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822031;
	bh=f4E5LhgvAcYWZljBgO/W1U3MMJwdn+qZCE/pQraBe8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ay5fDaWtG/yWIDOYM+DggFzTN2LWbh0BW6otP+jIWAHXSuBEsVaLRZz5ZGfpgRvCE
	 6shldu61dY4NwBfkCYbw7q4cTqz3itoS1DSO0jJ/m80wdS5Zd4cXDBc3qovYZ0srLC
	 U+IQP3Cf9hMAd3vazbsilUbA8DkxquoHSwEkBJ+7nEkOcCIfxO9SZLsKEJkxUQ3qC/
	 DcxdbWZq7MCNC9JXaZdePv4FyzB69QN2POFSFhjzDTIlCOpxPJ8V89Q5VWoSMQ/EHp
	 J1FcUjC8ycDtKpuAOuzPui/5hlEvRP7hunia1FQ4b8dx3JEke6caIeMQIFr6OP34Hm
	 Nxddkhn+cC83A==
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
Subject: [PATCH RESEND v2 16/30] profiling: mark /proc/profile permanent
Date: Wed,  4 Nov 2026 20:53:37 +0100
Message-ID: <20261104-work-procfs-fs-v2-16-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=brauner@kernel.org; h=from:subject:message-id; bh=G0gwYdZ16oKFC7EZJsDlPxepqJg/P4CRWLJP6izrYeU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97rGrTu0wWKSzkuXO+Urv0AN64bf3zr/V5uClEO3wY I7J/p1/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyag7DP5V5JQ833nexiq6f s5gt0f6uqxUzZ/T9PH2FDXJ9PK+sWhkZJl1nDLj2O2fpAYUv714J5enO/mdzabLGrvDt7b2/l0U pcQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

/proc/profile is created when profiling is turned on and never removed.
Say so with PROC_ENTRY_PERMANENT, procfs then calls into it without
pinning it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/profile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 64f6a45834b1..0c2672adcbb5 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -203,7 +203,7 @@ static ssize_t write_profile(struct file *file, char *buf, size_t count,
 }
 
 static const struct proc_ops profile_proc_ops = {
-	.proc_flags	= PROC_ENTRY_FULL_READS,
+	.proc_flags	= PROC_ENTRY_PERMANENT | PROC_ENTRY_FULL_READS,
 	.proc_read_buf	= read_profile,
 	.proc_write_buf	= write_profile,
 	.proc_lseek	= default_llseek,

-- 
2.53.0


