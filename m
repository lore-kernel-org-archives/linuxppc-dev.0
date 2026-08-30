Return-Path: <linuxppc-dev+bounces-26192-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326C0C61DE4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 07:48:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXkkj0r53z2ypY;
	Sun, 30 Aug 2026 17:48:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788076093;
	cv=none; b=e4rhDc3vQQoXmYvte0V1HYcTtgXJ0IdJzm4MwQJviACPHeYMWQro3eQefmSKixashu+nN71Q6INmnlCpFC5YnYtW2etv7ZY+fB9VPPwHqElxu61aejxnEs/YeafleKalYG23Mvdzp+kieTcgtAxCNIYwCbdy1/cZWS2+BKKg/BsDMteaqsceI9niZoBsknMesUq39Qi8dHsi/W5We8v9g8iRl/uvpQBHfy7SO0JNnyWRcDoxDIiXAmY4qt7bPqd9Y0IYchwBiHKy7um14aPOZXA02eeexa8su9bsqFSpe/KWOjQ2uhRn1DrRi53wPD9fW32BTfzm2npfBc6jrV6T+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788076093; c=relaxed/relaxed;
	bh=lBV4SRjso+EkgLj4PkYZQJzo+GNlBWOlH+QTKJh25O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wn82rnZ42lonHg45ej+rmenhHs5Wi0O6eO0wXbi97u8/45xHPLoMMO7+NDPi3GJ8H/HCuvGmIjJ6vn7ws3956IpVjpUf2EXXaTKU8kNTeuGBP72AEpr2Z/4TwyOieGrQvNFFffPcrXB8vmriMpBjZin80JpTubDck9jyhCpDnzToZxBghlPuq1CMoOnkC4OmsRQWZcRmq5MbZbr22yWG9tTNdlctiSbLkikL3Rlc5LDkKwqS7hvz0lm5DkP0ti/Q2K0UJdZ/mc0NJqR/xZAtyGsRO220AchpvUL0440Bpb6TDcGTQW6lKZHmU/Uw903UDE+opu0z5IXLrLsV5gLElQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5WEFdIx; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5WEFdIx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXkkh1jRSz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 17:48:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 472016020A;
	Sun, 30 Aug 2026 07:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3281F000E9;
	Sun, 30 Aug 2026 07:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076089;
	bh=lBV4SRjso+EkgLj4PkYZQJzo+GNlBWOlH+QTKJh25O4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C5WEFdIxnZu7NyCEa0917/q9m8RAavDxTcdqoLLl699TQIsq4EeOhuxI+szK6oUPX
	 BBIzv3+IJ6+fS9FQmBehVilOS0JWGi1UM3ADz5QENEJkQ7B/lCi6MWuSsmh9d24gC/
	 xqZO9ZbJgzAnKUPKUwFxOq36/mp/Mjxngs08R/Q2YejbbFqe90lyuLn5rhvLGud3X2
	 EVKuB+T3cucf4i8ZuJBhzJEXqmfg9dO6oauWM/ZNRbde/XgSesB8Mx+xxgTVU6krb/
	 +wgLp1Rk81AU4bDORSu6mDLNfdNz2kcvtvVoz/m10gaevkyEoeDi6cwxlvkD5TYLbP
	 9ZbWSJno7s5+w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:47:58 +0300
Subject: [PATCH 1/4] char: xilinx_hwicap: replace page allocator calls with
 k[mz]alloc()
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-char-misc-v1-1-05e2ce44f291@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
In-Reply-To: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>, 
 Eli Billauer <eli.billauer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

hwicap_read() and hwicap_write() allocate temporary buffers used to pass
the FPGA configuration data to and from userspace.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() and get_zeroed_page() with kmalloc() and
kzalloc() and free_page() with kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 9bb5fa642fd8..bbeb9b6060dc 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -382,7 +382,7 @@ hwicap_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		       4 - bytes_to_read);
 	} else {
 		/* Get new data from the ICAP, and return what was requested. */
-		kbuf = (u32 *) get_zeroed_page(GFP_KERNEL);
+		kbuf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!kbuf) {
 			status = -ENOMEM;
 			goto error;
@@ -412,13 +412,13 @@ hwicap_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 		/* If we didn't read correctly, then bail out. */
 		if (status) {
-			free_page((unsigned long)kbuf);
+			kfree(kbuf);
 			goto error;
 		}
 
 		/* If we fail to return the data to the user, then bail out. */
 		if (copy_to_user(buf, kbuf, bytes_to_read)) {
-			free_page((unsigned long)kbuf);
+			kfree(kbuf);
 			status = -EFAULT;
 			goto error;
 		}
@@ -426,7 +426,7 @@ hwicap_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		       kbuf,
 		       bytes_remaining);
 		drvdata->read_buffer_in_use = bytes_remaining;
-		free_page((unsigned long)kbuf);
+		kfree(kbuf);
 	}
 	status = bytes_to_read;
  error:
@@ -457,7 +457,7 @@ hwicap_write(struct file *file, const char __user *buf,
 		goto error;
 	}
 
-	kbuf = (u32 *) __get_free_page(GFP_KERNEL);
+	kbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!kbuf) {
 		status = -ENOMEM;
 		goto error;
@@ -479,13 +479,13 @@ hwicap_write(struct file *file, const char __user *buf,
 			    (((char *)kbuf) + drvdata->write_buffer_in_use),
 			    buf + written,
 			    len - (drvdata->write_buffer_in_use))) {
-				free_page((unsigned long)kbuf);
+				kfree(kbuf);
 				status = -EFAULT;
 				goto error;
 			}
 		} else {
 			if (copy_from_user(kbuf, buf + written, len)) {
-				free_page((unsigned long)kbuf);
+				kfree(kbuf);
 				status = -EFAULT;
 				goto error;
 			}
@@ -495,7 +495,7 @@ hwicap_write(struct file *file, const char __user *buf,
 				kbuf, len >> 2);
 
 		if (status) {
-			free_page((unsigned long)kbuf);
+			kfree(kbuf);
 			status = -EFAULT;
 			goto error;
 		}
@@ -516,7 +516,7 @@ hwicap_write(struct file *file, const char __user *buf,
 		}
 	}
 
-	free_page((unsigned long)kbuf);
+	kfree(kbuf);
 	status = written;
  error:
 	mutex_unlock(&drvdata->sem);

-- 
2.53.0


