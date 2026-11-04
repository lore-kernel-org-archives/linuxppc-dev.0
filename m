Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9A6071A04
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mId0rHTF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKbPM1q3jz2ygg;
	Thu, 05 Nov 2026 06:39:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793821191;
	cv=none; b=UO8hTPKNuXXPNQXk5yRF7HBNE0pPKV67nD8PgzWLn2G9yy3qAPVOuace1oEgB3kafmCvviuhpG9fRUAU5wgnPIV4L6X8a8J51BZ2Ywn0NR0Spxo52GVZ3rgcStIft8DXC4arFJF61YDY4/dNQygaQGiblefPo10pGsAQcJL3EXO+zsCFRitWzEznnNuzkhEg40dlr6c682q4eRqNzVFKNwGuTGZglSMkKx+m4BG27f9R5yycV90zUcvLoelgHn4p3H+OoHR11dmY8KjO0eIC6cTynaARWAebCxXF1OUdAjgYUNJKnv7GtVpnIIgUhiXuraywmJAwof5yfohOeBeSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793821191; c=relaxed/relaxed;
	bh=+6/VvbPNlgz2+gPXC5ytRZfMVcR9V1MzQDpcWQsb8Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvBBBalkHX4h0nEyFZ/BBOIbbZXMuvPwz2LzuIdjJRAXSalwxATlHHFucvoacAdIdYunp06F8VQrgcaNQTOL9f81xQAURzB2D6FT0NVwAtY4zS5XCT6HgES2v5xw+orQnZN/+uxxGojtYLT0+zwitGdpL8Qjs2KW6XlBNoYt9T7vNApbsv+of5WesIomiX5LKntXUlnFUxPtPRpB3KfVN2IytNJjQ38kT+gnNGjENuZ2ZACSvWq/AgCFKQT3BNzo4SW1ukwxHvh6rCbXl3Cy3fG5v0aHLav1qU+7l9aYH9v5kCXldqlg2S06euBlLil1jyVCVB7QhXNOypYdSpVfKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mId0rHTF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mId0rHTF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKbPL3Xvpz2yVT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:39:50 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9CDD241E5C;
	Wed,  4 Nov 2026 19:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6B01F000C1;
	Wed,  4 Nov 2026 19:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821188;
	bh=+6/VvbPNlgz2+gPXC5ytRZfMVcR9V1MzQDpcWQsb8Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mId0rHTFGhaCS3sdYfAY6UrikABSq9514uoQ7GPPNOveDld4OAIzV+AP1cZ5+Ixn8
	 u7k6fo+fYf2fRgma3+s5wUNjWW3+eAUKQT5zf9pbgI2+BwxF5bFCL2tWyNW8KXBYBW
	 v4NzHbeNk5FZUX1OHygbkhxJYXzZJn+Y2YoHEOPW7SRj+yqGiqHwRElrmDCDAL/nhs
	 z7wZyWQuOB07rCVv/pujZRKQ5+vDxcpmumnJK/6BxNgfLAnpurmgFd/xiClBXHam+S
	 gz17fzUUfOxo8DS399IsxAuyLQ8HZywLsxKD4Yl0ICqZpYgzoxVKhiN/rxJyP/QGLA
	 jH2iDe3ufVuWg==
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
Subject: [PATCH RESEND v2 16/23] xtensa: simdisk: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:39:34 +0100
Message-ID: <20261104-work-procfs-arch-v2-16-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=brauner@kernel.org; h=from:subject:message-id; bh=CYWbl/ymSaa+aNKLZWQVP3B9Tfxpb2fN2gwcMDszgw8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97mSwsF81Q+qzYrn2x3DTybM9wi12nvJmmnVCNNLjr 5Ey5wrnjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInse8nwP2drV3zO58/CxU67 rsubrYlJFcywLT3Csis1qG7hVNUP7Ax/xdm4jyrvPTzj5uuV2l3KAnG7rqWt63zAqn9rS3mOyGx 7fgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written to the
simdisk files before it pins the entry, and take the file name from
that copy. The files took up to PAGE_SIZE bytes and keep doing that
through ->proc_write_size.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/xtensa/platforms/iss/simdisk.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 1248d960e5d3..26c2fa39a66e 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -241,7 +241,7 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 	ssize_t len;
 	char *temp;
 
-	/* a write sets at most a page, see proc_write_simdisk() */
+	/* a write sets at most a page, see simdisk_proc_ops */
 	temp = kmalloc(PAGE_SIZE + 2, GFP_KERNEL);
 	if (!temp)
 		return -ENOMEM;
@@ -255,40 +255,34 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 	return len;
 }
 
-static ssize_t proc_write_simdisk(struct file *file, const char __user *buf,
+static ssize_t proc_write_simdisk(struct file *file, char *buf,
 			size_t count, loff_t *ppos)
 {
-	char *tmp;
 	struct simdisk *dev = pde_data(file_inode(file));
 	int err;
 
-	if (count == 0 || count > PAGE_SIZE)
+	if (count == 0)
 		return -EINVAL;
 
-	tmp = memdup_user_nul(buf, count);
-	if (IS_ERR(tmp))
-		return PTR_ERR(tmp);
-
 	err = simdisk_detach(dev);
 	if (err != 0)
-		goto out_free;
+		return err;
 
-	if (count > 0 && tmp[count - 1] == '\n')
-		tmp[count - 1] = 0;
+	if (count > 0 && buf[count - 1] == '\n')
+		buf[count - 1] = 0;
 
-	if (tmp[0])
-		err = simdisk_attach(dev, tmp);
+	if (buf[0])
+		err = simdisk_attach(dev, buf);
 
 	if (err == 0)
 		err = count;
-out_free:
-	kfree(tmp);
 	return err;
 }
 
 static const struct proc_ops simdisk_proc_ops = {
 	.proc_read	= proc_read_simdisk,
-	.proc_write	= proc_write_simdisk,
+	.proc_write_buf	= proc_write_simdisk,
+	.proc_write_size = PAGE_SIZE,
 	.proc_lseek	= default_llseek,
 };
 

-- 
2.53.0


