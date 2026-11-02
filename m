Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9360AB1BF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoCb1xon
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFY265jbz2yNj;
	Tue, 03 Nov 2026 02:11:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632310;
	cv=none; b=EA6kML1bwvm3dlBFmH9pkTpf7jXx0vHUV2LaBIBpr0nKqPSWiJzXyNObgnrgKu6/YHK6jyEtD62pzpu6gbnDLcobOMHJQ+ulPsguZ6Oh8wN4KSuhJ6PCIUitgd8sEN53ftVP+mWKHDWGcDfDB8vq1gWJ/LVl+pQeTdNkBVZ2EOo0IZgIHYAVQVyLD4JzysoLDIsHrufedR9CKICLUD4VuP7Oz6kKd5p7wYIPnFbq7zr9wsM3ba9TyJLVcfiJTHZoP/aQafrwqLXRRPMkLqRKODslNWFjpifNyQLrOXDpjaBIfFx8W+trgvQ0bTDG1Mi9+A7B/tY/2fdmvdespCNIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632310; c=relaxed/relaxed;
	bh=Q/r9Fhg2Z0/w3CqoKnG0DKCxv08Z9PpiFGMKT+radK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpJOE5igMuWkgMZkyNi40sH2oU27f7B4Wbwaf4HSDqmUqWnQdhP4buihCKfzU6e+YXDc4lkkOoVGrHorA+Bl1mWNSQ/PrgoCMhR1oUCZ9LsH351g4rJ6rCY4hopzIvrifg0bqdWy2T662IOm7eDlZQJrBvB7PjYApSbCraVbPDKnYAo3C9qUkIYrUxwCOAlCbzogvfbUkNx3428WE0W/9ymtvRjUbOZOEORZJYp8RP5qM+LXq+SCU1KhDbc14if36xDzZs20vlm2rgnFU6TvOezjFPF4qd6oqAlN8+YKdbaE9fkIIB05u4PQxzJg0QrQKpFSc70KiGqrmcZTB3Yj8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoCb1xon; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoCb1xon;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFY20s4Fz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:11:50 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 905ED4396E;
	Mon,  2 Nov 2026 15:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834C51F00A1A;
	Mon,  2 Nov 2026 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632308;
	bh=Q/r9Fhg2Z0/w3CqoKnG0DKCxv08Z9PpiFGMKT+radK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eoCb1xonaSPckn24MdF4TgpzPnhB0gLnhwB3+q7VZZ4/VwLP7qSPXNuTMQ/2dNldh
	 eVFE9vGUSsn5YYaxGqoLLphvtZLuTJd+KylQIE7mCxvO73SPam6GZq8mc3b9CVyDie
	 3exBK5rK2UuFrqmUvsRYmGiv0WPcd+dv1jT5VIdTEL0j46lSeijrTe4sxEh10rR5bK
	 zOsOn6lvifS4MnTOAh0Y2SzLal5mx1R7DipSgL85s9IzFy3jc8hi6gaFxlmb2VYUgw
	 Yg+IrbZgj5ldjUEp69Bi1JJ+66r8wybqWUuSMQZmJ6kfSVqJ9+zpEm7bXhkzV6eqzB
	 WMso6y2HpsKNQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:12 +0100
Subject: [PATCH RFC 05/23] PCI/proc: let procfs handle the ioctls
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
Message-Id: <20261102-work-procfs-drivers-v1-5-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
In-Reply-To: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2F6i7ISm6IP0WfraLShTjEfHw8rrOdRgm90gAFJMkQE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG6wz+y23KkZj6QTN7spL27IM+Bm2tTyUNrgV7+Tr
 M+uN3Y9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJymT477j82eGua2tPP5/u
 /iU1KyGvJs8tjK3vYeGHHaWzRJ14ZzH8U7obxHZv93mOC8mXehiflUxYs0bd3NzPJcDnTdn/mMJ
 9vAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PCIIOC_* commands take and return plain values and don't touch
userspace memory. Implement ->proc_ioctl_buf() and list them with
nothing to copy. 32-bit tasks go through the same table, so the compat
hook goes away. Unknown commands fail with -ENOTTY from procfs now
instead of -EINVAL, and instead of -EPERM under lockdown, since they
never reach the handler.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pci/proc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index a8d7469f222b..6b0cb5bcbea3 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -192,8 +192,7 @@ struct pci_filp_private {
 };
 #endif /* HAVE_PCI_MMAP */
 
-static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
-			       unsigned long arg)
+static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd, void *arg)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
 #ifdef HAVE_PCI_MMAP
@@ -321,16 +320,23 @@ static int proc_bus_pci_release(struct inode *inode, struct file *file)
 }
 #endif /* HAVE_PCI_MMAP */
 
+/* The commands take and return plain values. */
+static const struct proc_ioctl_arg proc_bus_pci_ioctl_args[] = {
+	PROC_IOCTL_ARG(PCIIOC_CONTROLLER, 0, 0),
+	PROC_IOCTL_ARG(PCIIOC_MMAP_IS_IO, 0, 0),
+	PROC_IOCTL_ARG(PCIIOC_MMAP_IS_MEM, 0, 0),
+	PROC_IOCTL_ARG(PCIIOC_WRITE_COMBINE, 0, 0),
+};
+
 static const struct proc_ops proc_bus_pci_ops = {
 	.proc_flags	= PROC_ENTRY_SHORT_WRITES,
 	.proc_lseek	= proc_bus_pci_lseek,
 	.proc_read_buf	= proc_bus_pci_read,
 	.proc_write_buf	= proc_bus_pci_write,
 	.proc_write_size = PCI_CFG_SPACE_EXP_SIZE,
-	.proc_ioctl	= proc_bus_pci_ioctl,
-#ifdef CONFIG_COMPAT
-	.proc_compat_ioctl = proc_bus_pci_ioctl,
-#endif
+	.proc_ioctl_buf	= proc_bus_pci_ioctl,
+	.proc_ioctl_args = proc_bus_pci_ioctl_args,
+	.proc_nr_ioctl_args = ARRAY_SIZE(proc_bus_pci_ioctl_args),
 #ifdef HAVE_PCI_MMAP
 	.proc_open	= proc_bus_pci_open,
 	.proc_release	= proc_bus_pci_release,

-- 
2.53.0


