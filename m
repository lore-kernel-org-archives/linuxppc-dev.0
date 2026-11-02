Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D256085554
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C84U6Gw3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFr81t41z3fJZ;
	Tue, 03 Nov 2026 02:24:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633096;
	cv=none; b=eB1K5JWTNI8Qei/QkYCvPGwdW/TWeKQ1Os1Ko4HmLlh26/tWM1jKkPbqFhyMEUDRzgxMXpqjEaz76MRjobKEYh3oAY2/VIoaGifPXC3yJaewOIOa5M8d/psRehzJhJqe5f4v1BrWrFRkdcmTK66o2IatDsti6PKX7naMY2TlPifPw/712ABe59sAeUa9IOfyXmKUsu8XIOOfC2hBZUssh9xGBwO7O2cUl/xAn0tqXek8RN1JyQSoH2rU6B4EogaTYfUfry6wbe3AHMJDdleKgn1Vif5OgFHbFPKFJa+BRsdNUPNMc445Eaf9O34dN+FF3Kc8zJ/yfG1O0U2HgbrmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633096; c=relaxed/relaxed;
	bh=6w6X6v78H1W1MVXKcJJM4gA/sIdjDlKonl9LFE5zQjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GolqN+ATFjYTgg6+2Ou2GnITHeF6V95u/7h+nV6gUp98RVEzyf/RfLRsSET3ZWCEtduTnAm7ORdU3Hyhe/1/ZBywEnq4+cDpr3CaGHXXkdzwF5oCMzm4yG3xvil3yW/zHr4dKCaox4xcl/V6fhb+TteQtxWXqeY93BUGoF3+Epkv8tcf+SzENUJf1JRnyX/abn5SfoBKe6DabKvW+v943oWwN1wLVPv0GzLg6js0ZmO4wwQ3+LdA/4JZS3D0dimfFaW6rM47EAaU5+bB34X6AOqM4qAJ/0IUSo5Zm9OREP1mn5lz1oGvIzv37SkJHJvi2ozhYGfGCtQSO9a0a3SDKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C84U6Gw3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C84U6Gw3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFr72Xqzz3dVr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:24:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 757DC60A4E;
	Mon,  2 Nov 2026 15:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61831F00A21;
	Mon,  2 Nov 2026 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633093;
	bh=6w6X6v78H1W1MVXKcJJM4gA/sIdjDlKonl9LFE5zQjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C84U6Gw3/7NEIEUX8wm5aL+w+p7nAtzL3Ye+Ut/KhKaxTRXTfZospYsPa7VSOz5cs
	 uYRf12TBs7aUroCeRblzf+4dkXCp+IFPpb3DPQ8WNMEWUjjQuGaO0igdG/1FcnT2sk
	 +Nnt45slpztD2ntlOu/8ls0Zsfr4+xCPx06oa8Issc3Es4DkDNDArFw8ZSKvEW1hh6
	 u0Ea0BzvEinh2dT3lDdRxHUYCzC8d+8dq43Yq1AogBxlWH3/qsEKacpMbyqrSCk3Vj
	 X3K/Zj3rcCm7HgLR/AXQpaSck7PV9j54FNLH1pxrv6FHNrJt7646S7muiBZu8zKYLm
	 G/IY4zAlhr6qA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:25 +0100
Subject: [PATCH RFC 15/27] profiling: mark /proc/profile permanent
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
Message-Id: <20261102-work-procfs-fs-v1-15-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qIZMo2xD6WijzH8eCxcoPQWkqyhBdrmfr/XH6W+8iSI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG7ExefxM/s4z6HMuLP3ZGefX+6xsmVr7IUfm4u2V
 Ki6Fvx831HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARt2CG/0EfvR80+J/5o3qz
 ZXre4ifTW10KtD3PvVi8oa/zDvf2QnNGhsUVyZFdtvc9vu1c+ij2Ws/3EP9Zmx8qpokHcu3cW7w
 2ghUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

/proc/profile is created when profiling is turned on and never removed.
Say so with PROC_ENTRY_PERMANENT, procfs then calls into it without
pinning it. It keeps reading straight into userspace through
->proc_read() since readprofile reads the whole file in one go and a
copy of all of it through a procfs buffer doesn't buy anything for an
entry that can't go away.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/profile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/profile.c b/kernel/profile.c
index 6e4b34f35e3b..6f2441dd4a00 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -206,6 +206,7 @@ static ssize_t write_profile(struct file *file, char *buf, size_t count,
 }
 
 static const struct proc_ops profile_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_read	= read_profile,
 	.proc_write_buf	= write_profile,
 	.proc_lseek	= default_llseek,

-- 
2.53.0


