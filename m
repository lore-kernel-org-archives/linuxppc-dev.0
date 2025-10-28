Return-Path: <linuxppc-dev+bounces-13394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9083BCCF9E5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Oct 2025 00:50:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwWt22phDz3fQW;
	Tue, 28 Oct 2025 11:47:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761612426;
	cv=none; b=XacdIr7IwBE5T3yAe/i2N6DXf+u0yPOTcFmFPXLr0/rrQ7pHtrqltcE+BmpEcdHLxea4KaCJHm6e1O1H+lr6Mrb9Y7qCmwjyeKioNfW8bSqWXNO9sYWGIn23QkJDOvUw+1JCo1tYkU4kwk+JYJ3PGBmm3jq1+1c4KcLnX79X6Z67GqkkJelJaOF+CRGeyPzvv28n15eV023zbqwVhcLcbRQD5ScvcK+9jyB/vEzhThe87ztD0YHg4+opuB5LDxxE3g67VicOwbAq1bmGWK+iIsfjeXZDxm3sOeP46ek1gAh48rb60SB62OyCuUZyGnkMDykn/5UPrwDKNnMWIaaJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761612426; c=relaxed/relaxed;
	bh=bjABcLkX96mDLYP3tAGhqk752u5vTsDaNzggixdicbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZELN9KC8FMBU5TmYIQ0czeZhJ6Px+mLdfI9YNXpYDzJmxPuojDvTdDaENexKFDhYvVla0Xwn4H4XWe9I11ca0F5Sr3QiDj1YfpAgf3jp9q/6Qg5lvPMdRRKHzciUYzGP3F/wzTlwR9Sto88Qde45hnYO+27GBufrsX8E2foT1GQJpu2ghvHxOmdmkR5MZehZMAo+REjyyS0MOJCk1zfW+AnD4XnwRWuK0UkcRcSptMKmZZbAW/m2Vg3P7z/z9PWTQ9lN5KAB7fm0lDGTiKk++g0IJLMsSknV2DqPW/gjClC8LKh1Z++FgcvZOLhZpRpySbtP8Ml2opFbr/hNebAi7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=sUSJOybj; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=sUSJOybj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwWt150Fcz3fMn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2025 11:47:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bjABcLkX96mDLYP3tAGhqk752u5vTsDaNzggixdicbg=; b=sUSJOybjZSquw0aIdYKAiSQYOT
	GwWqmw+Le174gLr73NQueXN2zWXOWWYpJuOr7pVusWkGejLfCcDDWvCrGglGAiNXfdzzbSeDjILoj
	zFRVRH8p1ZsLKxvYHkU11NtWicY0w2uqaju6nFXGfdwQGvBR33ugm/dqNWf5uMvgAeAnaXjAooiZB
	KpCavnvH0eyGf1E2z0O/JSi8s76OMdZEax3TS9Jbi1emAT0LyUjHed1GDLDsBkfSWw1EKZCPamRwt
	n20m9Gkn5bSWkiFE0H/ieHG9jNW4qTx0No/FD3nYrH/hPfoo57ueM9EcNY87ZYzl8MXPkl+bkre79
	0pReYUJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqw-00000001eq3-00Tt;
	Tue, 28 Oct 2025 00:46:22 +0000
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
Subject: [PATCH v2 49/50] kill securityfs_recursive_remove()
Date: Tue, 28 Oct 2025 00:46:08 +0000
Message-ID: <20251028004614.393374-50-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
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


