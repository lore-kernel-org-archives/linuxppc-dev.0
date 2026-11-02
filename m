Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1260D0A4E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnL5jL1t
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFwx2K8jz3dlT;
	Tue, 03 Nov 2026 02:29:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633345;
	cv=none; b=FggJJ1/8Vas08lqnUawrFAYa8bfw5qbGq2pKEiV4VzklatHo5OmC8saz5n4JHgMBJuLt9QOwoCjo3+b7iSkAPd8KNnkOSFONSNZX46cccx9HVUhUbmoktXusEXgEcCtortNaBTKCf52xv1xwt0pSt7QInwSA2jviSDIUmO+TB++zIYnXzLtlJ39KXktmwsLdFzyxItEQFARmgJ3LVJQ98ZdbuJOXMFTFjkP+HScMMhUHOEdpOfIat2OzMRNVEJFJQes6QX67B4vjxbBzXL6NNoZ+EEBdLWcuf1xsYmOujaCbyZT6lBHiwLY9oCTvOJXx1Cgs6tK8ee/gCKgHEUCIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633345; c=relaxed/relaxed;
	bh=LBl2/qBMA7OV4BMTYua5kVHXByvRuxQ8RJbkH2xlEeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kw2kfwKtS1/K6AN1LyRMlfXVKvG+4OYjQunDr40+ggWZb7+zc9IotdlZuuef4AIoo2xgcEdZhDbEfJSv0rwhtMETXUE02Gq0M7ykWYIQWTd+kcwJLUixp4Fbd8z0gTOSxLFc0ljJYeX4xNN1vL+FWKDZ7rdTB1Ry0FcahsQf+CNfJwAOTFtqGEkcJiRQfkHIssg3M4mF4Bg/KGNy3+34RCzdMXZJ9pCO8uWdFBodJyh/QAVvkjpPNZJ33fJUO5lwQVfm3IR4XsUPi2+g75yzYpBdekeijmQw2lMWtgOKolY3rjOnGbXmBa2acIY/FPNAC9h+doulrz4XxNOfiWeohw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnL5jL1t; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnL5jL1t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFww3MWmz3cPw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:29:04 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E4F21434D7;
	Mon,  2 Nov 2026 15:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DFA1F00A28;
	Mon,  2 Nov 2026 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633342;
	bh=LBl2/qBMA7OV4BMTYua5kVHXByvRuxQ8RJbkH2xlEeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QnL5jL1tEy9t9hIsQkt3LByuIJ882KPXST1Vc1LfQVpUOFVJmtPqDPl7tY8JHPxCJ
	 gmd8xNU3nOvuFGws/A+3+9aTACcobIp3siitSrYhwwkjrT4inswqca73nB5LOWSMIa
	 gGXXKRCwtKQRlvorIFYPQ52q/KY/Id1kGa70Dc9UqY5W8w1sw/+9eA4OWn0UomElkO
	 ts/p1SA4HIAxSUAqUU8NGTXimFKD4VawrMb8XauLcbSF/WPIlGbMbJJmy2bdk94vgL
	 YTHmGiUOat2O0htpE7WGC5E8Rhw7yB2cZi5Bs9hAVElqV814vjKTN39YLPMJBp43E8
	 SCJm5GLHZ5dEg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:35 +0100
Subject: [PATCH RFC 25/27] mm/swapfile: let procfs own the seq_file of
 /proc/swaps
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
Message-Id: <20261102-work-procfs-fs-v1-25-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xP8svTINdkdtOq03sFDyUkKM00LKGtRsGg97ENBLGtM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG786nVF9oWW1sqzD1ne711zwHqjwVq2PUfPRB8uE
 5qxxSg9q6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi+2UYGU6ky8syZD9PsFvn
 wnogRfvDRWvVD16nimIPrPc107fJVmb4Kyb0Ma+ob8K8bRaH71p9WLH8S/zVPwIl0tHx/G6vHyj
 psgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
 mm/swapfile.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 254ce86fa923..ee4868ecc3a7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3410,26 +3410,19 @@ static const struct seq_operations swaps_op = {
 	.show =		swap_show
 };
 
+/* procfs opens the seq_file */
 static int swaps_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &swaps_op);
-	if (ret)
-		return ret;
+	struct seq_file *seq = file->private_data;
 
-	seq = file->private_data;
 	seq->poll_event = atomic_read(&proc_poll_event);
 	return 0;
 }
 
 static const struct proc_ops swaps_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
+	.proc_seq_ops	= &swaps_op,
 	.proc_open	= swaps_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
 	.proc_poll	= swaps_poll,
 };
 

-- 
2.53.0


