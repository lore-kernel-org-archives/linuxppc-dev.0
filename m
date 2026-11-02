Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E566085561
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIWGBig/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFrv0RGnz3cHS;
	Tue, 03 Nov 2026 02:25:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633135;
	cv=none; b=FurLJh7Xc6X88Jgm6PM6rjXrYKauj7UKd/zF4OiMVxlOGNSGB4stUSZLgEXWpHHD15SUsXds54RzztDMC0vCa9oIStWUi/AJkOobu4u2Jz5VjKGDBuanqSwZPdTTrvDr+2YZhiJcWy8il0AFwjHousP/f+dUY7W6WEc8UR5/8m+S8DYQsf5KbOiSF9UhuapdySKuxoUeF61D7/os5dNwxE0+yIEB46Ol12lfc9hIzBiHOAopuRApuArgHPJGblVEY7CLmUx7ekNpWayJYK4/V4m86zqjNLLwP+f+LnJyAftimtIOcEdKQqyJ6GmRb8oalRScZ7XVBK2NwIBy013qYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633135; c=relaxed/relaxed;
	bh=el6PFkO3xcLBJA86iuA3itBWUpq/ZBw6RIw3oM8RbD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuaNNbiiFGhyM+Yfsa/0hhcUtVSjUISUDQpGXi+dsC+hFWAEizrteYKkYbztgRMSYsadoXYtMgF4SfTmA/MS8WyA8gwMGMQ9NfqDRjcS/p4Oqy7PObEiaQt1PDLXmqMxu6ibrliZ5IQqm4Wo22PNytQwWg7s1t3u4ndE58ZlVG/lftRlVtwKaNmvQD+a6f9P0mfYHpPp2RzfRNkSqPIivgyGmVNTjwoUdZkZYE0kwPoFLd1H/dzayogzvvYtexIy2gVaGBry0BVaEqxHvKCWuTTzTj+LcaUh0UCBF8bN8i1tWV9eK697qNhgXle1CgMlw40LaJDUe0wFEQTvBqwd/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIWGBig/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIWGBig/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFrt2FHsz3bZf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:25:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C7E5C41A9D;
	Mon,  2 Nov 2026 15:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18D61F00A17;
	Mon,  2 Nov 2026 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633132;
	bh=el6PFkO3xcLBJA86iuA3itBWUpq/ZBw6RIw3oM8RbD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UIWGBig/hERSv8UC2SBY2/AHoKZwbp+vwJFVHzMXkPYGqF9dt5+0EHsg4lTeFLkeY
	 CX0dkWtDTbDh5piV0+jALeqJO7PUPJCWq1rupoLvRrR9hiV3ruK5lQ5JOwWAGeI3m9
	 WHFwZ3fPrTC2yVGxGOTIiQVUBriwWhb2Nv/E2ooxajbFUJ7ShCeNadjFtrTnu8oFHf
	 xwdUD2zrQXvpkIQ0+Qui98P3kjE0XPPvTcVbSYvw3ebU20McuSBsFpLwx/BeWQxlQ8
	 9LtMFh6B4imtlAnC4skherstPQYyR/MSLL3rf0G6z64tTDIw/TLE29S7Z0kORviOLo
	 N/TEiOL6+fxLg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:26 +0100
Subject: [PATCH RFC 16/27] sched/psi: let procfs own the seq_file of the
 pressure files
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
Message-Id: <20261102-work-procfs-fs-v1-16-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nkKdnljsMnki7Ruy8D8hScsbrXYOUFXONWdXZYhGvI8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG40a+nMGLu2+z9eheoKh0w5ullw+0k5Y81bXIHrm
 k3i/y2o6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIhQCGvxKS9lN+rOr+uvCY
 g43mie7/U77u6rTN7Zd/x/ExmrlJaCLDf8eDZ2sYnGNzPy0zajRR3fOy/on3y7yddT/K6nOLk54
 ZsAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the show functions and let procfs open and free the seq_file of
/proc/pressure/*. That makes the open functions unnecessary and
->proc_release() only destroys the trigger now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/sched/psi.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7c5381423334..bcb8bf4e0b69 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1535,21 +1535,6 @@ static int psi_cpu_show(struct seq_file *m, void *v)
 	return psi_show(m, &psi_system, PSI_CPU);
 }
 
-static int psi_io_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, psi_io_show, NULL);
-}
-
-static int psi_memory_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, psi_memory_show, NULL);
-}
-
-static int psi_cpu_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, psi_cpu_show, NULL);
-}
-
 static ssize_t psi_write(struct file *file, const char __user *user_buf,
 			 size_t nbytes, enum psi_res res)
 {
@@ -1635,31 +1620,25 @@ static int psi_fop_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 
 	psi_trigger_destroy(seq->private);
-	return single_release(inode, file);
+	return 0;
 }
 
 static const struct proc_ops psi_io_proc_ops = {
-	.proc_open	= psi_io_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
+	.proc_show	= psi_io_show,
 	.proc_write	= psi_io_write,
 	.proc_poll	= psi_fop_poll,
 	.proc_release	= psi_fop_release,
 };
 
 static const struct proc_ops psi_memory_proc_ops = {
-	.proc_open	= psi_memory_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
+	.proc_show	= psi_memory_show,
 	.proc_write	= psi_memory_write,
 	.proc_poll	= psi_fop_poll,
 	.proc_release	= psi_fop_release,
 };
 
 static const struct proc_ops psi_cpu_proc_ops = {
-	.proc_open	= psi_cpu_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
+	.proc_show	= psi_cpu_show,
 	.proc_write	= psi_cpu_write,
 	.proc_poll	= psi_fop_poll,
 	.proc_release	= psi_fop_release,
@@ -1671,11 +1650,6 @@ static int psi_irq_show(struct seq_file *m, void *v)
 	return psi_show(m, &psi_system, PSI_IRQ);
 }
 
-static int psi_irq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, psi_irq_show, NULL);
-}
-
 static ssize_t psi_irq_write(struct file *file, const char __user *user_buf,
 			     size_t nbytes, loff_t *ppos)
 {
@@ -1683,9 +1657,7 @@ static ssize_t psi_irq_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct proc_ops psi_irq_proc_ops = {
-	.proc_open	= psi_irq_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
+	.proc_show	= psi_irq_show,
 	.proc_write	= psi_irq_write,
 	.proc_poll	= psi_fop_poll,
 	.proc_release	= psi_fop_release,

-- 
2.53.0


