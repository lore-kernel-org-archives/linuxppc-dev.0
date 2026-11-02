Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C460A6EE8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtwKUokO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFpB2DcGz3dPs;
	Tue, 03 Nov 2026 02:23:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632994;
	cv=none; b=ZqXDSVqdfrXxoPtG1vm5ngkOQQE+zaAc+PNYXSatxhu/FJi5CINQPJKhpyJf9DQyFfUgOHJVQytAVBIRys5FRMZP9rGC1m3Faknia0X8D9PngFACWiG+1RlS99ePN8S0ein8ORZrg4/uXoFyBJ2joxxouaOchxZ9E7RNJFU93984j+LDi+Ecs/GBB7WDKBLDohGlNKdc1Vpr3rlSQ9iHkZYrTPFqL8xwr9yWZcBJ4JnPvi9BMlkOwZUCUom3Y18gq7uk1oQFu5c4Qq2OC4BMAIV4p9GqYkQapvDJgym6OtWIBvW5rNpSUrgR16kRUYuucp/bEfnQ5ohLox0zeEwuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632994; c=relaxed/relaxed;
	bh=cbUv3n1tBnI1k6VxTZ3ZcHd/CVUe8/cnvkVP6mlO6Yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdUxQBMHYUoeeoi8dXpFocITNu92Plq8apKsn5Cn9H9R+rz+Q39kwam/dWsJCn945jHK7v49qq+U0i87ppL8iOI8fQmkjiLZEtYzjOJQjuqMrAqQfTGoDTcXW4e9L+Yyba82Zr7L4795NLyqSPyt0TteaWHJAne7uq+rogRC0smQE9nwRyPtO4OFiT1plQ9i3KoMuwZvPw9x6ERNwQsd++WU1m9+qUg7se1DoF/n8rNUW93bJNq8XbKbJzJ0ZdHkX5PlDABHSfNp+ImTQnFe78mVdcLzDY8s+iAsn3G7jCxsjZlkqeDPyUHg5sn1p/mIXBnEyCIxWPb0dHQ4zD3hvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtwKUokO; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtwKUokO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFp933Wxz3c9D
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:23:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E368343BCF;
	Mon,  2 Nov 2026 15:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB961F00A16;
	Mon,  2 Nov 2026 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632991;
	bh=cbUv3n1tBnI1k6VxTZ3ZcHd/CVUe8/cnvkVP6mlO6Yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gtwKUokOODP26lfp4y7mSUu6DYdG/zt2FxgYuDS+oho+JQ5cga5uqjc8YY6VgrcQs
	 VTaytOyGE9Q36HAhmeQO/tpkWrmaem5nfcs9DoO11v1we3+YYyPqsUjQ0RtzlSJ/r7
	 PjD7PtqydOyrhI0RMb58/TQgdn/JW1bEao0zBiP6y+8iVzXby6r+qrPSMfF1VCtR3o
	 f+fxAzOWnAKXVVQlIcMAzpg04hv/Asv4XFoEe0YrkCVsCJLh0AlwObscrypUo3bOUD
	 I88qZEPZKE9AXxN0jtQQ7Cv/rHCklqSSX1h/8YUYGnUDPn7pa9hj9iyObikXEB/IoK
	 IjWpl3b9MOeCg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:20 +0100
Subject: [PATCH RFC 10/27] genirq/proc: let procfs copy in the affinity
 masks
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
Message-Id: <20261102-work-procfs-fs-v1-10-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WZPzG5+ElQbjbcTuZJJKbql/hLS5VpybW+Y2WsbSVy8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG6Uyh8z/eu1hrs32SIFLvZ8+rqj2fax/9rr51N3L
 TzROveFV0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE5soyMtz79dy2qTFnUlGi
 7Rv7nTPlZCfr1j9uiJscE3tp0bIdbPYM/10MrwvWc26+27EhfVkc7w0pUx3fZeee9Fxveua24pn
 WK1YA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() for smp_affinity, smp_affinity_list and
default_smp_affinity so procfs copies in what is written before it pins
the entry, and parse the masks from that copy. A list of CPUs can be
longer than a page on large machines, so the files take as much as
memdup_user_nul() could copy in before. Anything larger fails with
-EINVAL instead of -ENOMEM.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/irq/proc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index aa3d5544cfc1..fe683457a088 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -9,6 +9,7 @@
 #include <linux/gfp.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
@@ -134,8 +135,11 @@ static inline int irq_select_affinity_usr(unsigned int irq)
 }
 #endif
 
+/* lists of CPUs can outgrow a page, take what memdup_user_nul() took */
+#define IRQ_AFFINITY_WRITE_SIZE	(KMALLOC_MAX_SIZE - 1)
+
 static ssize_t write_irq_affinity(int type, struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	unsigned int irq = (int)(long)pde_data(file_inode(file));
 	cpumask_var_t new_value;
@@ -148,9 +152,9 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 		return -ENOMEM;
 
 	if (type)
-		err = cpumask_parselist_user(buffer, count, new_value);
+		err = cpulist_parse(buffer, new_value);
 	else
-		err = cpumask_parse_user(buffer, count, new_value);
+		err = cpumask_parse(buffer, new_value);
 	if (err)
 		goto free_cpumask;
 
@@ -177,25 +181,27 @@ free_cpumask:
 }
 
 static ssize_t irq_affinity_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	return write_irq_affinity(0, file, buffer, count, pos);
 }
 
 static ssize_t irq_affinity_list_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	return write_irq_affinity(1, file, buffer, count, pos);
 }
 
 static const struct proc_ops irq_affinity_proc_ops = {
 	.proc_show	= irq_affinity_proc_show,
-	.proc_write	= irq_affinity_proc_write,
+	.proc_write_buf	= irq_affinity_proc_write,
+	.proc_write_size = IRQ_AFFINITY_WRITE_SIZE,
 };
 
 static const struct proc_ops irq_affinity_list_proc_ops = {
 	.proc_show	= irq_affinity_list_proc_show,
-	.proc_write	= irq_affinity_list_proc_write,
+	.proc_write_buf	= irq_affinity_list_proc_write,
+	.proc_write_size = IRQ_AFFINITY_WRITE_SIZE,
 };
 
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -217,7 +223,7 @@ static int default_affinity_show(struct seq_file *m, void *v)
 }
 
 static ssize_t default_affinity_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *ppos)
+		char *buffer, size_t count, loff_t *ppos)
 {
 	cpumask_var_t new_value;
 	int err;
@@ -225,7 +231,7 @@ static ssize_t default_affinity_write(struct file *file,
 	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
-	err = cpumask_parse_user(buffer, count, new_value);
+	err = cpumask_parse(buffer, new_value);
 	if (err)
 		goto out;
 
@@ -249,7 +255,8 @@ out:
 
 static const struct proc_ops default_affinity_proc_ops = {
 	.proc_show	= default_affinity_show,
-	.proc_write	= default_affinity_write,
+	.proc_write_buf	= default_affinity_write,
+	.proc_write_size = IRQ_AFFINITY_WRITE_SIZE,
 };
 
 static int irq_node_proc_show(struct seq_file *m, void *v)

-- 
2.53.0


