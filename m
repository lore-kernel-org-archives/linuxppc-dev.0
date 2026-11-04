Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28749606A333
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuEE//0p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXzK6Q4sz2yWK;
	Thu, 05 Nov 2026 04:50:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814637;
	cv=none; b=Dl28KJF9+Yh24Ys1G+bZ5DVT+PH1uJE3E91our0txJCGtCr/meWqPEW9QlMCBhm0DLfI+TX2DlFBNk1i87x286xyKGdc6Uj0O/DJDXdCjPz8dKU0vAM/EZDhzdJuF1GX8lVweYNLs7TWM/WKZWX20J+XJl6tZRDt7A2tc3/5f5Mzn0Ra9Ml+Nfjt+HXOBn4ghXNAGI3Me83vHD1dlbI305HPWT0A8AcOPF968tuGcQCNNTgPtre3EfVhM6Xgjnerhk64tOgdcJEv3xL0G2Ds4NF5+sWiOI8ZYFfqXGFIJju5X0HrHWuvucT1hHEloPUkuzkCWVKGgKPdCIsiyPuvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814637; c=relaxed/relaxed;
	bh=p9+kMzHwjVYuWJQ2+obB/IGMwn7xV7y09JcSQ7GHv6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K38riTfC6KntZZuoDknEPCUnZyo7uFFAX70buDiLRLB0vV4Zu7N9DVNFXkSBDnY667efFrmC71v0mkt7rdxR2Azdx6tD7UTqP6jKSOPitugSFFfPnFBo3B29Nyic8MYyz9bR+UlHBc3S6uJV2QadTSBMlp+txmw+80moa9B2eN5xnErueDNlOgTESusKBS2JJBRrZb8nli+b/U3e1dajefiJiCHCmIoVWa5qz5BB0mLlFoF53jCSuRjk8rrLk6+aBVf4DpLgu9ksaoYyJCM8sLUdGBazvHX/d7JV9epMP6oIyESohNNjNuqpai0yzBQSe1xcpRkKBTqJrTQasBRRNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuEE//0p; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuEE//0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXzK0D8Cz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:50:37 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 16565410CB;
	Wed,  4 Nov 2026 17:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1105D1F000C1;
	Wed,  4 Nov 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814635;
	bh=p9+kMzHwjVYuWJQ2+obB/IGMwn7xV7y09JcSQ7GHv6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuEE//0pTMjiN4EAckF29THCaCp8OShYg92gOVf7lMyKvCn0dVCXPo4XEmIgwbvrF
	 mgNMx/eNkGPYY7G6H0/+5Z2vYWnryKoGvrqXmpNUIJXHh7VRJoCJ9vZOSJMA/OjJoT
	 8z6LvY6TdWjfMQKBqFRTF1g7G5I/em9dQz+ebu6Y4iFujPyG6kD5aM4cOhxD5zLdkS
	 0mLt2so9jaXkBdOELDLBFZJsYTghdzOgcrQCBh4fJ1VVmpw1xBKRg75vKt5bYd5IUj
	 +CjnJztBrPQd0ybc2en6qZmMR8GIuV6NMVYOONgqhfspT52PI5BFxqfGvNedHL80U/
	 rS6/W8sLjdi2Q==
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
Subject: [PATCH v2 21/51] powerpc/rtasd: zero the error log buffer
Date: Wed,  4 Nov 2026 18:47:07 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-21-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=brauner@kernel.org; h=from:subject:message-id; bh=mkSbMC6ZDV5f4P2v+qDezcMlza9tkw/MXVPMWZSeje8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zrvxY+J+keMVs7edupnp1Ff4+Ah738HHuRv3nhU1l bJwbb3Q0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARpRsM/8P+v+y8bZx29NuN hw/PunmnX07Un1++7juvb051byL7qQCG/6n83y77TZpU+sZ0i3q+d/jTxn/VP3mKFCceKbEpuaT 1nAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rtas_log_read() hands out a whole slot of the error log but
pSeries_log_error() only fills in the sequence number and the event,
which is usually a lot shorter. The rest of the slot is whatever
vmalloc() left there. Use vzalloc().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/rtasd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index fd40864bdb70..dd0df5e164a3 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -523,7 +523,7 @@ static int __init rtas_event_scan_init(void)
 	rtas_error_log_max = rtas_get_error_log_max();
 	rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
 
-	rtas_log_buf = vmalloc(array_size(LOG_NUMBER,
+	rtas_log_buf = vzalloc(array_size(LOG_NUMBER,
 					  rtas_error_log_buffer_max));
 	if (!rtas_log_buf) {
 		printk(KERN_ERR "rtasd: no memory\n");

-- 
2.53.0


