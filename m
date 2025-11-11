Return-Path: <linuxppc-dev+bounces-14038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715AACCF9E3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Nov 2025 06:56:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d5HNz1vvyz3bfZ;
	Tue, 11 Nov 2025 17:55:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762844147;
	cv=none; b=RuX0dyUi8Jj9GcYJTLLtKVIh0hNtug5isc9wuuULGGwCWbjZEPCvt07800C7vMnvJZ0s7QQFMn10/vfBFqIqlTiSrI+15JbP2I3lClTw1FpBmAP8TwLGeYrkReD5BzJm1AiyqPO3BS7MdOorpzdugutCnIVcml0CDUbKfF6d3UymRYxJmiYnpMaEg6s3WBI9rs/KAy+DynoteAEqoLFRAFfzZoJge3lEUFqNAuqb9Z5ZBfGkRDgFGfxUEWgPpc0Lct7m6iMbhilZNuvjr7lePeCEV3x+PEFfFX44GE/p5O6RRffb7aNqiUGVLiCk1aPB45gG+IFoy0Ew8UhpfaHm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762844147; c=relaxed/relaxed;
	bh=Wj6NtuoUx6rorSoJrKwRjGX8DQ+3LbRm6UPbWp7kXpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adLhBnSUxIlBIH8aajQ2+z7gWZQSxWrzkQN5wuBUJyPz1B+YMdn749z4N0cJ6HaMHU+Tr39OX5FcRPGFbRWh2y6DuLEE3NOQYHRdX3wtGqPVHml8/IQ4JItNtZavFfGYtd4sPsc1IEHp/QxNlj5IxtukPhgTiBUyWvP4KpEr1tucKrlVU1/RqZ7bic0K0/QnB8/mmz7p49SeP3ThssHwOTsGL0RyEaSyDHr0U/p7JBbp9rGmIujsYunQar/uCoxpc3U7nO4GV6kAHskEDc60WRGEiMhjpbM2yR6ap2a7dL+dDQiiWElgh1wtW/ufMFLzA5LkUKJCLnPgmo41/P+V6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=cSIskRnD; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=cSIskRnD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d5HNs15g7z2yw7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2025 17:55:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Wj6NtuoUx6rorSoJrKwRjGX8DQ+3LbRm6UPbWp7kXpM=; b=cSIskRnDj9I5POptPLG9Ky8eus
	Mixrz4PXfoJA4mym6fAA8eR5i4IsHvS6qbvqrYnPJ1csPDlbSa+sMnkpnRzDC9gkmSh2NtFm49jlY
	sAWx40Zc6JkQwYb78IPIqw5K+H2ZOuAVYNP/CBuIKLRe4rRPfwgivkoDxJv5tInuD5dyjZMTCcEiY
	6h3dUXU/D6eNt/05Byng0INiGwdAwDIWBeY4jN6PINY8gCEb7uhek+3CZW75NUSf7oYyPw3jMQiRT
	DoeMVklc6zcDvbYBF3D9uLL8mWt4ryodjJdkLhKdOM2Qe6ieQE0QVMEijYRqlb62e1wiEfp+aPR0E
	y1jDlcfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHt-0000000BxQU-3Vvn;
	Tue, 11 Nov 2025 06:55:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v3 49/50] kill securityfs_recursive_remove()
Date: Tue, 11 Nov 2025 06:55:18 +0000
Message-ID: <20251111065520.2847791-50-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
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
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

it's an unused alias for securityfs_remove()

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/security.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 92ac3f27b973..9e710cfee744 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2258,8 +2258,6 @@ static inline void securityfs_remove(struct dentry *dentry)
 
 #endif
 
-#define securityfs_recursive_remove securityfs_remove
-
 #ifdef CONFIG_BPF_SYSCALL
 union bpf_attr;
 struct bpf_map;
-- 
2.47.3


