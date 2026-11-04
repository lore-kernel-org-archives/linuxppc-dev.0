Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B9606EEAF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRm+kuQX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXws1BX2z2xjQ;
	Thu, 05 Nov 2026 04:48:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814509;
	cv=none; b=P9wy932mXghDj7NSOZu6/XzGeTgu33BiMsqd6mi4EIvREqnfMGPkGdNvTKk3kATazw+BDo9/lNdSaA+ebsl0Pt0cslRBktDXu6uVvqwcl7v0fdROSU9ycoIR2/kif1/HgbkL7gYN8soDs4WH2kV4+R1IScLKVNTQSWP4JcxpUXEuG2eNkCjMmLeT9gX1VC8HYuHJVBc7wZEACXZ/kMSSQCftgkC76gpTNf0QWPlBBmO/z1ZafKyegjotBzaw1NNqW3xRESreLNjDPQqRBQQekc9pz67yxGrpV2/51e2gSOuscH2BGNrNbdUBz6r05xseqh5Nm33hHNSKtacxn8XN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814509; c=relaxed/relaxed;
	bh=3ZyIQLij17XFBIkY/FnNnjbp2RgAs/rkMBTgRuVD6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4nUODmOLGJFLnViorVbAMSYxFl9pwRdcw8JapRw4XvejDXi73rXDTLP+v8GyiLjnZl7TVVKnt29/a1KRi9hOcJfyekjqWoMFgNpdHyfmtrcoUnzmqh0ToaGRhDGy2QhktwU8Vn5joRVbxq0KOSE/TLD/7phY/diEQ3mO2waZZWf8IOvK/dStIy+jhb1VWXYXjNSHChKBMkbD2dpxdnONv8LnQKAbJUiBWGeLZcPLVUz3azj8KA59CZ7hMK7CjqKcWlRBsbf5f73i09IXVkYLEtTzEez2wpDtohS9LtWV/m2aoSn/sEFdLBbDh1Z0uJ6Qg1iOZXFPdkfgVhRrk1O/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRm+kuQX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRm+kuQX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXwr2JS7z2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:48:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7438560A58;
	Wed,  4 Nov 2026 17:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512051F000C1;
	Wed,  4 Nov 2026 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814506;
	bh=3ZyIQLij17XFBIkY/FnNnjbp2RgAs/rkMBTgRuVD6WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jRm+kuQXLx3HxqJQ/pjoWlYGnOb5R2cVrI0BxZjs1H9Bw8isgylYtekF6fzwCYam0
	 GpULB5lXQbyTK/Edh9b2eC4kps+uu7bCEsyidT0bHm7H2HfmOVOP/JWR98p8XKggDV
	 gbR+sBOa4/o7t63orB3vACnwFADp+bNRfAOdtU2Yc/wWPiuGQBbek9DZxI+EgwmNgG
	 KWLc3uoF26LdC4oCj9qcMJD06sucvBwbhfn2X8BjLVTXyfWCytbRIvS8esUEF/ocEj
	 eFEobff+fM/wQhcYScZQ5sJRBVHN2AlsYRDXbqaRDoezJ+0bPS0RQxOsMA9AvIN8D2
	 a7u52gum9t5KQ==
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
Subject: [PATCH v2 14/51] proc: sysctl: don't stop readdir at an entry that is being unregistered
Date: Wed,  4 Nov 2026 18:47:00 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-14-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=brauner@kernel.org; h=from:subject:message-id; bh=6hLGzd3ohIjIvoG2NrLKRAR6DerSlran3UFG44ON0F0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zrvAWu/kaD6x96PK3okTN85e99fjn1Pl3U3bGJtnN F1XMW6+3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRfk9GhqVlT3f9k3gTlZE2 2Sl7qnRP89Frq6PEfR/pxi6YuOo16wdGhrWT5lf5PEid/zYw+uqn/MXSBi/y5i736erf2r1Ls/F ABg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_sys_fill_cache() creates the inode of an entry that has no dentry
yet. Since ace0c791e6c3 ("proc/sysctl: Don't grab i_lock under
sysctl_lock.") proc_sys_make_inode() refuses to do that once the table
is being unregistered and fails with -ENOENT. readdir takes every table
it lists into use and unregister_sysctl_table() marks the table as
being unregistered before it waits for readdir to let go of it. So an
entry that is unregistered right then makes proc_sys_fill_cache() fail,
proc_sys_readdir() stops there and returns 0. If that getdents64() call
hadn't emitted anything before that entry userspace sees the end of the
directory and never gets the entries behind it. A listing of
/proc/sys/net/ipv6/conf can end early that way while a device goes
away.

So skip an entry whose table is being unregistered, like readdir
already skips a link it can't follow. Lookup treats such an entry as
gone too since ea5751ccd665 ("proc/sysctl: don't return ENOMEM on
lookup when a table is unregistering").

Fixes: ace0c791e6c3 ("proc/sysctl: Don't grab i_lock under sysctl_lock.")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/proc_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c0859c66563..b4a309d49698 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -704,6 +704,9 @@ static bool proc_sys_fill_cache(struct file *file,
 			if (unlikely(res)) {
 				dput(child);
 
+				/* skip an entry whose table is being unregistered */
+				if (res == ERR_PTR(-ENOENT))
+					return true;
 				if (IS_ERR(res))
 					return false;
 

-- 
2.53.0


