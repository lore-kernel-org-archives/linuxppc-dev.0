Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4E6089C88
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvxkwJrE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbV61gLXz3byZ;
	Thu, 05 Nov 2026 06:43:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821438;
	cv=none; b=B6n3c094xVqM1tbISLtYoaK3GuDbgqe8ymt0D/5cWS5x8mko1OVWZdm28WHbQwMyVI4lmV5jb87LWl/22jsQQd4V2WXi5GxSwPPyxYIrQhzIOxrlDEMaXbUEj53dp2DRJ8J/ilrdrw+jfJq0QdeEt/MPGKQRnzE0/LLOrKzBtSTK76O0YNriFokgGVNP+Q9L3c8dJIt6sz9Enievx4var7oikHdPqzI/ZSEU4loFxNEZr0DSMJ0np1yuKkPr47Pj093VFkc9XVDo7ua7mudMld6OBDOGLKKUMHzUm4w11dpbUyj1HHNPQGjkIjznEdHbYVsg/fHsNFC4YLB1leHmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821438; c=relaxed/relaxed;
	bh=MXDP9fyzpcc9X8/ROQgrmtpQySITyZcOubu0QYlfW0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ge7kJTunTBn6C8COHl3o3ceBpTLkI4zRb18DX5crfJMctNukyzILUWPq+lHzTm5ab7ijTBAukjpfJXyNedRW/Nl2nh7Cnanm509PnFHF83/dcD1MC31JUCu82lIVFQW2g1wCaLGIkVYx4DzlTIDKbMmFkBf2m7Z1kn7uAQfJOGfcSio0B7K21QH4+UvAktpXtjRNR/c/hNiuvCESHntAGLaNBZ+YOCmObAuSyZ7SyCsOn6Z7OcxscPOEMg8U7utUBwJi98EyA2cdkjTlzArCFNG9ARzrLySJa6NGNOcF7aujm+xvnWJERxGuHJ1g5j+6dfS9qhK87xiJSXj394mkaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvxkwJrE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvxkwJrE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbV52F8Hz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:43:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3CB81422AB;
	Wed,  4 Nov 2026 19:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5111F000C1;
	Wed,  4 Nov 2026 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821435;
	bh=MXDP9fyzpcc9X8/ROQgrmtpQySITyZcOubu0QYlfW0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HvxkwJrE6yZiYOxFcQMcjejW88ZaW29hTOWaJR9YO5Tvs3/8Ku/knORgdhrkWEZnm
	 FqlvED7tkZyaWujkmmUucC82ygg0xRZPT8t1WYaFWGOQCbuZ5npn6/psp1WJsopeBc
	 /Ip4YEzyI9/mkYahhPxRdv4RqwBmNw3bGEqLSFKH7xSvANy2+6tMJK3oeMT/j06KPr
	 aV1SaTvwJyNaQmYfmPPmd7MRi8vEfKFW5IekI7JTcT9yV8aBpWOQ57VRcmy0cEhZAb
	 MM7IMfpEqYVYfJYvfiLY5AP2A/DDKBQ+DAROllTXi16lENKuE4ydpoDCGxpGPMHxZe
	 bfR3jntxCFu+g==
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
Subject: [PATCH RESEND v2 06/26] md: let procfs own the seq_file of /proc/mdstat
Date: Wed,  4 Nov 2026 20:43:40 +0100
Message-ID: <20261104-work-procfs-drivers-v2-6-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=brauner@kernel.org; h=from:subject:message-id; bh=rdu1kmejfqc5NG4cwcsJAI4WSVobA0+Qk8YSn4PPNtc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97qq6MLvj4dWlPlW/Lu/K/95xU/V2xNJbCyWiD8o4T U+5uk0tsKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAim4wZGb7tvCDdyFbA2D3h xbQ1r407Cl4f1/C3fFQsYPDizr8HIumMDFP6U2beWjP1wmONNb84O1vnWbE1dPszPL6aGeZe9b+ wjBUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare the seq_operations and let procfs open and free the seq_file.
->proc_open() only records the event count for ->proc_poll() now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/md/md.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 03e35386a802..64abf1743e41 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9167,18 +9167,13 @@ static const struct seq_operations md_seq_ops = {
 	.show   = md_seq_show,
 };
 
+/* procfs opens the seq_file */
 static int md_seq_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq;
-	int error;
-
-	error = seq_open(file, &md_seq_ops);
-	if (error)
-		return error;
+	struct seq_file *seq = file->private_data;
 
-	seq = file->private_data;
 	seq->poll_event = atomic_read(&md_event_count);
-	return error;
+	return 0;
 }
 
 static int md_unloading;
@@ -9200,10 +9195,8 @@ static __poll_t mdstat_poll(struct file *filp, poll_table *wait)
 }
 
 static const struct proc_ops mdstat_proc_ops = {
+	.proc_seq_ops	= &md_seq_ops,
 	.proc_open	= md_seq_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
 	.proc_poll	= mdstat_poll,
 };
 

-- 
2.53.0


