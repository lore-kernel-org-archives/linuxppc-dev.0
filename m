Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B080606A338
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYzQuqq1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKY1W6Tltz2yDr;
	Thu, 05 Nov 2026 04:52:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814751;
	cv=none; b=EEIyRKKTYbxtO55SmihbPOyegVbBk3MRUEsu6nT301KjNLERwwT59i0MbCHpDhiekrY9pL4yMWTbFELv+nRrnf3dwvLsC2IuIK6t97zRVvSQ/09aQ4TP5dB+Mgbci5ooV/NAj3mPKkAS0O0WETtbAH5NlbTNQkICiAuzwb+oV1oBfDpWcKK7loigGIpQTqnElFaTXMF+lYXBN0LduFAnR3LREn0jEbipjEyLVOHELfthwTeG4Nv4Tgo9SJDXfFc2GMc1b9i14Y/qxezT5pb3tGF4kkElBsNwRmksvnNtoSusKZmkdp1Gb+ueGST5yHuu5KuSN4sA6ENuk9qH42PW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814751; c=relaxed/relaxed;
	bh=yb3WLcVokXU6BuV8DQIS3cnoxrtkXR+HXTNSt4lhnr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiMAD17lBA00pclQe+VnlhlyW7uOtcaCNMI/58U6HTFXbUkpJN1J0fLU4HHxxFm0GkYhT2N3CluTYabDUFVGOI0jgJA3BFO+v+t4Jq6COrdn9dbJADtKqBu4NKkVVYwa522D7jnC2oZ8FHvlOkWEMsyxtPOnlFxFqUdq4OW35eaXhHbgO68t6dj4XtB1VctTLSUJuw7iy2JBRWgFzH1EM1cABO3UVCONC9Itjx2Nw3YHInXmsxkavxW52k7VuJdks7Ol6oicm+o1IM9hiTZwvyEBJ91MbPoo37YT4Ck3/fpc9cBVNkhJdi3Ygu3Y81BgW5V7gajY1JpjKFpoWX5fTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYzQuqq1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYzQuqq1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKY1W1HKTz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:52:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7BAB8434A7;
	Wed,  4 Nov 2026 17:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5214C1F00919;
	Wed,  4 Nov 2026 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814749;
	bh=yb3WLcVokXU6BuV8DQIS3cnoxrtkXR+HXTNSt4lhnr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYzQuqq14/wTRRzzUwsG17Ab+8tgoUHpySPnl84Mr25NNzcLhEp7Tq87twOltFKtA
	 dLD4dH0S9ylQ5twpfaifjPBB9F9nLw9N+znijKLYLcOnWkObGODYTAZeChhNq2O2Ca
	 IQI8NCRh7J2BZ5sI7mVRJjsoRWd+WGQFkSSMno0hv8VCeplcjuV9ER78Y79IneS3ww
	 A/5asZFiMwgLRWg3CnX7bPRgzhBlLJJ299YG81hHCGwYVIYI6Vtka99WENBzIlbtj9
	 RDwPxtwzVpVgN2qYy6WEMTlYIhf+ZUrM+RRJ4JaWwLGuxFHxYcI/kP7k045W27PJnL
	 9gvSnUTnaD3zQ==
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
Subject: [PATCH v2 27/51] um: NUL-terminate what is written to /proc/exitcode
Date: Wed,  4 Nov 2026 18:47:13 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-27-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=brauner@kernel.org; h=from:subject:message-id; bh=wRElBRQ5ywf1BhvCA77KtICLks8yyr6GFoKnZLCCyMo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9znsQFfC+I/C0Ra1Qv94XtoNfmEzj9zwr/ak74frKN 6dmt7y52lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRvl6Gf8ru0zvmyVXlJJn5 RX64VRT8c5vVqQOhHe+XJk+QCA1678rI0PD9gNXt6xMOWujrbTe9wyTBv3D/B9HmPSse+sbVn4l X4wAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

exitcode_proc_write() copies up to sizeof(buf) bytes of the write into
buf and hands it to simple_strtol() without terminating it. So
"echo -n 5" parses whatever the stack held after the '5', and a write of
seven bytes or more reads past the end of buf. Terminate the copy.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/um/kernel/exitcode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
index 43edc2aa57e4..0230354f4812 100644
--- a/arch/um/kernel/exitcode.c
+++ b/arch/um/kernel/exitcode.c
@@ -43,9 +43,10 @@ static ssize_t exitcode_proc_write(struct file *file,
 	size_t size;
 	int tmp;
 
-	size = min(count, sizeof(buf));
+	size = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, buffer, size))
 		return -EFAULT;
+	buf[size] = '\0';
 
 	tmp = simple_strtol(buf, &end, 0);
 	if ((*end != '\0') && !isspace(*end))

-- 
2.53.0


