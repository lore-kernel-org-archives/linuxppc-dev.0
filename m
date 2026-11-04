Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1A607800D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDIYsiNB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbjr4Wmgz3dTT;
	Thu, 05 Nov 2026 06:54:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793822048;
	cv=none; b=bAAvAKJTDsu4CuXgdDyOxRafLlsDLRKCPsD3WpFmNqLEGU35sCxh/7CbaL82lZKSbhRsU7Mrz1xNGGqLakdyB9NeR5rm25qYem/ukz8D0Sclarxw/To1Ns5h1BlpvIWtBSm61ir+wwcMX2QGqlTzauOSM7DtrkjGKbdGulrWFAC2mJMyyH+4kAA+T7C/lwmSwPdqjXDeENi6oModTM6EZ++0Eobmg4MFZjxrCeTM88RgDH/wUtpSy3LTd1LtJ64qLTFw/f2U3NFJfTozQvMPhTr6BffRvKRTiYX+NbOvx5mzT6tN/3AwZiMdtCtjNUQVkSRAZka/ph5mV7LuzBkPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793822048; c=relaxed/relaxed;
	bh=Wa2DxwoY96vQ+as6UgZb3UJIgeJzEwCZb2I3vpV0xHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSCjRBT/t0sHcRrpSZDJtvgWUYt+AaIQhcfAv1AGBVdHhBa3Xh9UiCrj3E9zE2ob2Yg+5jUa2i4Wep1tD6pyNRwyAYbaZYonJp9w09GmD+LdH1HtxBBDdiZitrbWFywQLxtCfQq83wFKUwKHVoOnpVJ4a66z2ESqCfHsrjzOsAQkX77ckgMiqb1i0oBAb6H9OI3QrEhcIJmrBwBPdEVd51yXQmnXdC3827JfO9H6evbuULZTP/+LnCrUS9i8Sdk6QSsCWz67oXNKkNkUe30YxuahB4Njz3t1YsFywykVjm0y3wdaUNCBzblH8wBdkti2AFXQKN6t4zoiYvpcwOk/Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDIYsiNB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDIYsiNB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbjq6Gmtz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:54:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E2FFF6143B;
	Wed,  4 Nov 2026 19:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3BB1F000C1;
	Wed,  4 Nov 2026 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822045;
	bh=Wa2DxwoY96vQ+as6UgZb3UJIgeJzEwCZb2I3vpV0xHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDIYsiNBBbAB6nCICl2CgYVmu1Hc5MI7vg03BuY69s+e6pJT+WUTVg0+E2R7BXucW
	 ASIEwQD/8dKh5gLCW56yPPqhr/8yzBSB3mWD610B6YBFxv2MwcgJq3I6t4BOpmtLEi
	 w6X4zToEWrG1oxCry2goo1fqiSX0980JJHxIp/b3+x2Ri2+ReMv/Jb0QANsRd2Di7t
	 Rzpga7r+AFVcSz5t835+amCK62QzA458xk0IuFMIaQ5wJCfI9SpgS4G48o8mHpSNgB
	 +voP9K2fVkENG08+Y1lBh+7RUetaZbq4uubBe+qWoiy60DFlrYcnLc2yMGlLbTHf9s
	 swfqQ47cYsOow==
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
Subject: [PATCH RESEND v2 17/30] sched/psi: let procfs own the seq_file of the pressure files
Date: Wed,  4 Nov 2026 20:53:51 +0100
Message-ID: <20261104-work-procfs-fs-v2-17-319e0f9a8aae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=brauner@kernel.org; h=from:subject:message-id; bh=pvcY7H3zDMUPKTR5VRDjfAM6gaPdAO9YnwSNmLk0d3g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97rGfE8i72E/yhZutqDL7PN47uzQ8K50TT+4w3Hhbf vutkt0VHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZfZWR4efcj3di9RK3nt10 KDbRd+L7jS/X575VFDqYfmbv94ueCxcyMqxquv8teNcGj2WSIeec/c4dzeWyOO2pu//Is1kJNi7 cT1kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
index 8b59635e95d4..9f1d9742bac9 100644
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


