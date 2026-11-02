Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462F6076709
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9KQjE5w
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDXC5N9Sz2xnv;
	Tue, 03 Nov 2026 01:26:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793629563;
	cv=none; b=kbCb3Uk+aXq+pBxCgErX5XTd7hzSx9hbaAE42YGWhnhp1ZOO4UYQLxtRQCWmEMDwtrMQDomZjnkF8DulGT8CB6OwW98yWxJHG7yZ3GNEnO66Q1pN8Z2jEHrRHC3jUUfVBBxSb18Wp9lD0NuIzrgrMUJBUk1aF+14w7YUIMXhJrKR+RRHrGrVfvgDba6uvEk7GPG0WkBSs8ZXCE9HRLCooZ3I7JgC4sZfccIRU6O4ciDSxXxXl/kZV4KfMwddG3fWLgI3ilzUN/Hr7WZjWMSELXcWSe+R1YcycPdOPgK55pfHPWM9iqe3WodenKP0XZtRvPLIHrL7V1mbvvwFjLfDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793629563; c=relaxed/relaxed;
	bh=qYcECRdDX1PrLgMJOdiUzXJ2kaKILzuHrLaM8GQSRjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7+4GWnA7N+B9mZzEEzhLxCXrJry53SKC2AF/IgyftZwDeZ4JkiGVJZwU1pmctTvgig9WSgecIvw/heMel+doG8QxJK3MzLAViJyxKOSIsTUIEArL3iomRZyefe00i4QJFlLsYxo+2tPLUNxHP4tLAOL3Yfe3V4GL9Vo4KiFisp9IOng5ePeeYB6PAlxfFdNelkIQ4lu5uR2A0/SrvBUcgVbw2xW5wA6i2nNHfHqjsVlOt9sL9CiD827JOcYd3ny60W3ErwleTee1UvdKPPE4wAYHkcJyQWYaItmQQCn/T5B3EmlqLhVyccoSbnHlfX9GG+b5FEdf2Oz0UnWv429OA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9KQjE5w; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9KQjE5w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDXB6bNbz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:26:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6FFF160236;
	Mon,  2 Nov 2026 14:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139161F00A17;
	Mon,  2 Nov 2026 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629560;
	bh=qYcECRdDX1PrLgMJOdiUzXJ2kaKILzuHrLaM8GQSRjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S9KQjE5wRZaW8pMK48TuAEmOLD748GqwlgZgKrfSco97/731a7MDcvtdowW3T/B3m
	 NvPqfIKQwOF2sxhuKNeKw2glbD9GcUTLKErI1N8MeSY2feI0MfU6hQ0PDqhrSxlAax
	 ysx6+msJ3hHzjq6HRREY3YeW3DHo+bXrboL45uA1tUVTth9lHX0m7ISaar/jKS0zMf
	 IYZHmi5qTiRrg7GVbV4rddIoHh/fUlFGqHzxDtnW0GBToUrP55eD+22JF1NKxgOElA
	 EhFTmchNaS1rz8TR2eJwc5sdtCFgjqMQFTOhS+e8PSQ5scuItmZ72v036nNEZPi/4u
	 grk/S5BPt88Hg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:33 +0100
Subject: [PATCH RFC 18/38] proc: don't WARN about a name that is already
 registered
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
Message-Id: <20261102-work-procfs-bugfixes-v1-18-59422ed3e465@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aKtCMuJhN5pC0AyNIxMzKE8+AJEG5eL6v+vagw86wsU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJMtrTidr2u/hEYo58Xov6ysMy+tyPQIcGfZ/8nw1
 F7R28+edZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE3YeR4YrY7evvwlZMuvjO
 T2W501ZR+/rFjmErd1jlrvaS/Heoz5nhn/Z+UxH3og0pqhNqZy+2Y5tgn39oqvmlQwLG8Uf9Zic
 oMgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_register() WARNs when the directory already has an entry of the
same name and fails the registration. Callers that pick their names
themselves should never get there but some take names from userspace.
pktgen creates a file for each device a writer of "add_device" adds,
named after the device. A device can have any name, including "pgctrl"
or "kpktgend_0", the names of pktgen's own files:

  ip link set lo name pgctrl
  ip link set pgctrl up
  echo "add_device pgctrl" > /proc/net/pktgen/kpktgend_0

  proc_dir_entry 'pktgen/pgctrl' already registered
  WARNING: fs/proc/generic.c:404 at proc_register+0x555/0x8b0, CPU#0: bash/241
  Call Trace:
   proc_create_data+0x9f/0xf0
   pktgen_thread_write+0xd9b/0x1780
   proc_reg_write+0x1c2/0x3c0
   vfs_write+0x1cd/0xfa0

The files of a network namespace belong to the root of its user
namespace and none of this requires a capability. So once pktgen is
loaded an unprivileged user can taint the kernel, or crash it with
panic_on_warn, from namespaces of its own. pktgen itself copes with
the failed registration just fine.

So go back to what proc_register() did before commit 6c2f91e077f1
("proc: use WARN() rather than printk+backtrace") and what
sysfs_warn_dup() does for sysfs: report the name with pr_warn() and
dump the stack. While at it, do that after dropping proc_subdir_lock
instead of printing a backtrace while holding the lock that every
lookup and readdir in procfs needs.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 6c2f91e077f1 ("proc: use WARN() rather than printk+backtrace")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index c560c96a64eb..ef804cd3ec45 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -401,9 +401,10 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
 	if (pde_subdir_insert(dir, dp) == false) {
-		WARN(1, "proc_dir_entry '%s/%s' already registered\n",
-		     dir->name, dp->name);
 		write_unlock(&proc_subdir_lock);
+		pr_warn("proc_dir_entry '%s/%s' already registered\n",
+			dir->name, dp->name);
+		dump_stack();
 		goto out_free_inum;
 	}
 	write_unlock(&proc_subdir_lock);

-- 
2.53.0


