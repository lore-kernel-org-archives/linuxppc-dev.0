Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFC606B2CB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDNbfQiY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKb0d2xDDz30P3;
	Thu, 05 Nov 2026 06:21:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793820113;
	cv=none; b=HyOFl0yPQ3dBXJUmJo+VL2tJL7YjVe0zlQ/I8ClB0RB0luMTA5OwKX30S3Q+FNzchAa+aXmk9UztSB3/ftsinyXlh4XgwiI3Yush+CQjWntsUJ/bQHydLUdjVsG6M25a7+4/cTDPsjYRW1yAY6oim5PebejtTZq9a0tIh+YWcz3h1bJ4Xlf8cwwTLLYdW/MgZteOjwDUiMeX6ryVYYF1LneLH4nZEPEQ5HjEZ7zRoGrGzp1HPaxchIwY+7zkromtQSUKhGm1PZsmffkjCNqB+cwou+rSkEesdQ/hsKLZ/7A3TuK2Pz3F7VoWOMZEqbUB2/7okrox3uAD/Qeh4JASxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793820113; c=relaxed/relaxed;
	bh=bRUY7zR2xEebSKJvbp7QJxGSJz7lwz+abCfF6bzfIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCj+XV2LfvSKeLKVOHJ7xkV/CiEHeouM7E4S19d0g1gQeKgxmkEqzfoBIj7tz0MeT7dHUIeJlgCAb80TGLcOMjpo8l22ABgMYh9i3tMTTXZiUcQZ1NZ7+QFHZSXwPbG+LwFuA7wUTd59lJ/LiMwsqOQR3X36ftDSsz+ERCIy3ZB2R0uC8WzNnx+6+0sF4ioRUKK41bOWY6remko97xBs0r//xTXmhtjOUscY6h8O+9dzsD4ap/s8T34DMJibjlg5bCKQb8IH/flY11NkaVm/qVdup8QyVf87q3Zy6rEpJTza/cHM7KDM9pV5isDegCBGSZVcHXx6aTRQh8S9QIpaMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDNbfQiY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDNbfQiY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKb0c31pTz30Ng
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 06:21:52 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81533609F0;
	Wed,  4 Nov 2026 19:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E171E1F0093A;
	Wed,  4 Nov 2026 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820110;
	bh=bRUY7zR2xEebSKJvbp7QJxGSJz7lwz+abCfF6bzfIu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NDNbfQiYTs8QxoUaV5XJChR2qHa8xOxHYJocDlHmgzzJSqms9PhEZLUwt+ANrSmDj
	 kEnl6QN4BfZZeT44wGIKe0Ixtr1WXbuqCS+Gm8dZ1ubzgeNz5DCniH6FQ1eMnuGVya
	 K3FKmWhtDu4MeA/UnhfA3jbh1Uk2LEoIKcy3gsX0Lc9JtNW5MghWVftz4tHUP/Sp6I
	 pgjw5FHUrME1RTE8Z0LLnlJw9xm3sbv7a2SltWV0Lzh5QBwPcbr1XUZ/ihWdqFLxYk
	 cmed9ZYlW4eyWeUqshn66+fHBXUJ79jWAfcuK17k8f/Cw6JoctibeULlljIfW2t0nb
	 YnhLFoFESlk2Q==
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
Subject: [PATCH RESEND v2 23/51] scsi: BusLogic: don't return 0 from writes to the proc file
Date: Wed,  4 Nov 2026 20:21:35 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-23-021c84d852e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=brauner@kernel.org; h=from:subject:message-id; bh=7Bhyn2ehZ0sKrsH+Wp9jL6/kN1Jv4nVldfkK6knOcds=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bnx+qEer98CSA4p/dlzo/8F3vWvRwRxVzfXMGkIdb bJrIsumdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkJSMjw5TaW9evl63Y5C0n mRnrGr7/ql2e7uxE7dKugO0X7TR/vWL47+CvtmlOQmAN85PS20YHZ06yX2SRZalWbxay2Sgy4bQ nKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A write to /proc/scsi/BusLogic/<n> resets the statistics and returns 0.
Writers that use stdio, echo for example, take that as no progress and
retry forever. Return the number of bytes that were written.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/BusLogic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 27b446c0c5d0..7ad814f549ae 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3328,7 +3328,7 @@ static int blogic_write_info(struct Scsi_Host *shost, char *procbuf,
 	adapter->ext_resets = 0;
 	adapter->adapter_intern_errors = 0;
 	memset(tgt_stats, 0, BLOGIC_MAXDEV * sizeof(struct blogic_tgt_stats));
-	return 0;
+	return bytes_avail;
 }
 
 static int blogic_show_info(struct seq_file *m, struct Scsi_Host *shost)

-- 
2.53.0


