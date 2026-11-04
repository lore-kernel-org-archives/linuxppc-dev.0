Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31221606A33F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRxCl+Bf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKZzT6l3Fz3048;
	Thu, 05 Nov 2026 06:20:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820053;
	cv=none; b=jM8ldW9NgRrJHLNpTwnNmZed0TeKA8zz11kTyXUTRYJwy/EJRIJrxjde1ItFYVzYJwLkRBjXCdkrINLojYwfBtA655aQRNoU8EwF5RrIRBmWMFMxmaFMM7WaAr3yjYItJj/dL/Iz/ao2pqv61O+HlVMQZTgnHlxK6/zYyifCBldCLuxGZlXIK+WfWUxXgcpla7H+gff2/eWwSevIMmp671+mu1n1skuMj0hAFKcSIYePGc9AoHwXm+7QhB8ssynKJ8CaZgKpvWsod80Ji1NRvR8cVVUuVz7H/997qprpuAnJTGUQ5JqSlRfBxUEZ3rxqdIo4jxcQqCNk8e/4SMvoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820053; c=relaxed/relaxed;
	bh=weMUCFn2uihXk/tOxGBDEw27Pws++kgwJ6Tcia3ltcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDWKkXj3G5Yaf/38TAKLlPQl8yUK8ryofAWurqW7EpUatv4ypZ2w2MatxfzRZJ0yNBDh7ryz4aT1dFjuPf46GFutswt/plWPafNDzvy/Vx9BZ+03OAANaWdu52/y8Uw6oLBU0pCMA5URy6Lo0SSS7FqZGwcFpLYCJYSwn4ZsflvspDCvoaW504O9/JqONp9Ihzbq+GPBszJNjxJIYUJDcYyHXC+h8rUYNtbiLw5Ch4z5CKwS9gqnFJmW6u/1ZNPsuNeR0/h9aL6oClp3BkdXRX/ZViE+TO6QVnXz5X66dmI7gbTG8/4MhcLf5l1T9R+DHMgElLGhpw1bvH/OhR93cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRxCl+Bf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRxCl+Bf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKZzT13Msz303B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:20:53 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4651760D81;
	Wed,  4 Nov 2026 19:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ED11F0093A;
	Wed,  4 Nov 2026 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820051;
	bh=weMUCFn2uihXk/tOxGBDEw27Pws++kgwJ6Tcia3ltcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HRxCl+Bf2TmTIdvOsOeyzhK8jV+Bfm/AfD9cI3ivj92Dd3pOYsACEhtqy21kBrGn/
	 w5dZIxEHBlkGPyiksDR2eeyKB2QwqkCs8BxVbPOrva8f8+0RyiF4g2ftBS4+38Deq2
	 ECW+IMt2f5f3W9mcjTW+c3CS4ThGnFOYG1d7M9XEv+5D9eIa8f3cQr1EJ+w9iQ/rUC
	 XqEw7LR3pXX6IXRIprFLgivWh1G2NDVohugAan8ecdIvDwRxpUYWViMOW6AbNVUMfk
	 FUYGNVRL6tdh+iW8t1JOxMZYVBhZSDKN5vzmr7c/IALhlwuE9VxTB484IK+SvnVk+v
	 mX/CkL30zPq5w==
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
Subject: [PATCH RESEND v2 19/51] xtensa: simdisk: don't read the file name without the lock
Date: Wed,  4 Nov 2026 20:20:36 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-19-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=brauner@kernel.org; h=from:subject:message-id; bh=wpJfI2N0Y4TYbGny8B/EWcsaN47/8hdz2WKuRaZg6Os=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bny056pefW1bw+0G9QWxvIVyC3XrvoZ2bGCV5J46b YcBi0tqRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETc3jIyPJ21usJ4wx/59rrj 73oYXwhfmLvodau6v+vZpyZ2wYlGEowMHzItDeUOXp9h3ywj4N1/bRkvB++3BTNNjTf/8um/cn0 /OwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

proc_read_simdisk() looks at dev->filename without holding dev->lock. A
write to the same file detaches the disk and frees the name under the
lock, so a concurrent reader can copy out freed memory. Copy the name
with the lock held.

Fixes: b6c7e873daf7 ("xtensa: ISS: add host file-based simulated disk")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/xtensa/platforms/iss/simdisk.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index e51edb8cf872..1248d960e5d3 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -238,22 +238,21 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 			size_t size, loff_t *ppos)
 {
 	struct simdisk *dev = pde_data(file_inode(file));
-	const char *s = dev->filename;
-	if (s) {
-		ssize_t len = strlen(s);
-		char *temp = kmalloc(len + 2, GFP_KERNEL);
+	ssize_t len;
+	char *temp;
 
-		if (!temp)
-			return -ENOMEM;
+	/* a write sets at most a page, see proc_write_simdisk() */
+	temp = kmalloc(PAGE_SIZE + 2, GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
 
-		len = scnprintf(temp, len + 2, "%s\n", s);
-		len = simple_read_from_buffer(buf, size, ppos,
-					      temp, len);
+	spin_lock(&dev->lock);
+	len = scnprintf(temp, PAGE_SIZE + 2, "%s\n", dev->filename ?: "");
+	spin_unlock(&dev->lock);
 
-		kfree(temp);
-		return len;
-	}
-	return simple_read_from_buffer(buf, size, ppos, "\n", 1);
+	len = simple_read_from_buffer(buf, size, ppos, temp, len);
+	kfree(temp);
+	return len;
 }
 
 static ssize_t proc_write_simdisk(struct file *file, const char __user *buf,

-- 
2.53.0


