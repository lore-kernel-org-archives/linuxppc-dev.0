Return-Path: <linuxppc-dev+bounces-21000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70CBCD37AC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 05:39:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJ8s51Y3qz2xfB;
	Sun, 17 May 2026 15:39:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=64.20.38.29 arc.chain=mailbaby.net
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778991611;
	cv=pass; b=FyZuFTdm8KGYkxz7+E3zgYt6GYshou6I5Mz4xi498Y40q7J/EE7o2Wi3am+tVWw5iok6QPzYijVM5aIVoBmuPFTZP9UkwdankbUNYifI7E6q/4+yH0cgGwCfnE91fymPWrV4nS/+z0aZWMzzOLhT+oWiZxysW7F0LqgCIYCkjbe1csUFLpqxK1HGuEYah5+fUgIbxMAeo1DUd57irOTL0Y9iix7mr5DTNXWYq+jOfnAdbZe8kuKxogq84i3GdXSvHtgW7DrrtT36g+o74WfsH3+GwVI0WyqOU3mmnAVcB9ojsbEo1L9XXiNh4ADkMgBP+zHwniJEhuheyr/t0KQAZw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778991611; c=relaxed/relaxed;
	bh=CMpxxoP6tGGCSoO2ozwaWLs5TM/6Nz1E1MpIvDUouLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jD8GGKOhmQFXKOSOHU/WLYlHiOZKAK7AEQG+Rr1u4hVNpRXnnk8oUY/xrJiRU8obnW9+dazKE4NeCZzDFPzRnN/VUu0RiyjvM77/sr/0VMmxmQyTQsR4z8/kRauiTQL5T/5ufhRdAmheHp9OCxL6jc6RNJYDeYU6UovFZ05pECsT6dYHDYZhZgZio5LblaxuQPTTVTjGcfiawmkz00Zvf6mhyrz7BtCWyeAddIJlYl+HB8H9sy/arMmxhm6N2f6wGLEPW43ZvwfdC9V9BDr0AtIOsc1kLkXKKftsi0rriLMV4/9xwkIRuOepSwfqNB7owA4QPg+Knj2OD62382hSCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io; dkim=pass (1024-bit key; unprotected) header.d=mailbaby.net header.i=@mailbaby.net header.a=rsa-sha256 header.s=bambino header.b=karcMPL8; dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=NOVEVCXT; dkim-atps=neutral; spf=pass (client-ip=64.20.38.29; helo=relay0-i.mailbaby.net; envelope-from=jeffbai@aosc.io; receiver=lists.ozlabs.org) smtp.mailfrom=aosc.io
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mailbaby.net header.i=@mailbaby.net header.a=rsa-sha256 header.s=bambino header.b=karcMPL8;
	dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=NOVEVCXT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aosc.io (client-ip=64.20.38.29; helo=relay0-i.mailbaby.net; envelope-from=jeffbai@aosc.io; receiver=lists.ozlabs.org)
X-Greylist: delayed 308 seconds by postgrey-1.37 at boromir; Sun, 17 May 2026 14:20:07 AEST
Received: from relay0-i.mailbaby.net (relay0-i.mailbaby.net [64.20.38.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJ7536Mrnz2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 14:20:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=CMpxxoP6tGGCSoO2ozwaWLs5TM/6Nz1E1MpIvDUouLo=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:feedback-id;
 b=karcMPL85culuptY3G+rQRT8B13lCXKiM39d1DxsojXGCpzDzUj9JFAF6eR37RlWvG80d7GWZ
 6ndTB0U4Ppt2HI6C/OsNUiDnuZwLsCFlZDFXQJxqKJt+XGEH+PYwT4LztpKyb2TvzFxXh+w3+yQ
 sJmsvyADRoO4BhmtEaoFNvo=
Received: from mb-nj-kvm1.internal (mb-nj-kvm1.internal [10.10.2.10])
 (Authenticated sender: mb86144)
 by relay0-i.mailbaby.net (MailBabyMTA) with ESMTPSA id 19e3424d5880002a59.001
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 17 May 2026 04:14:49 +0000
X-Zone-Loop: cf9a2dc1a8bad81368f5f71ae1f763ac9667e667241e
ARC-Authentication-Results: i=1;	rspamd-cluster22.mailbaby.net;	auth=pass
 smtp.auth=mb86144 smtp.mailfrom=jeffbai@aosc.io
ARC-Seal: i=1; a=rsa-sha256; d=mailbaby.net; s=detka; cv=none;
 t=1778991291;
	b=YaTfLGMeOUIXK3SKaFquPHJ15EYtfok7i1y9j0BDQapKVsZv/1HsAfHNGAzKVAFbaFSq/f
	jgARhl4MQSWOEl9oa129UpHnZHytgmjVaszGy6VHC4/gbYLJdZ0tEbSp+P0kdZ7YQDq79y
	xCM5a/tU3zib1vcs9fvJwUspmq8VWv5b4TX8rNqi7r+zWnN0YMPSObcU5yU0+VRSUrUq/k
	gWuodDkSaJqV1Xq6klyS12KDYdBJoEbG+Xxxea0BRupfmJhWOHtTXlv5WMU2j1juAmQi0a
	LS4/QaAaoLDrnOJlxTpHrDVN8n0slIIWbmKUcvwvE6WxEELwF5xwh/z1TR9NeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;	s=detka; t=1778991291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=CMpxxoP6tGGCSoO2ozwaWLs5TM/6Nz1E1MpIvDUouLo=;
	b=w3uJmDZ9Zn0HQ7XMZUre+jylPLwW7irAA7Yz/1wWY2W0puqcP7i/41G3t5RnZ0K3g6lWA2
	Mny2rqQzit4CatSQ3XomPA6mBNuOfClew0GqUkYxwv/hUo35PEk8q6RfrD77RE3b15RNOU
	J12PXM+veCV7UFE6SeU5P1ppoBwxm8n5akOPaIsU7BIhqcYHXauM1tzqSNcai8sG/pgBGH
	gs72qJ40JvmIxvFR9diJGhAPATi45bVfhpoJZhoz43ev0p3Jfj9LH4v5ERIGw5hMefuXm5
	GHJ+eSAHMEGRP0nNvH8pqktbixUoRwfz0W1atv1UDAFLQEhg3k6X3oj5bwZpyQ==
X-MB-ID: mb86144
X-SPF: pass
Feedback-ID: mb86144:19e342:587f4d465843594778405947455d:mbaby
X-MAILBABY-ORIGIN: PASS
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id C9A1E20061
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 04:14:43 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 175413EAB5;
	Sun, 17 May 2026 04:14:38 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 281AF40073;
	Sun, 17 May 2026 04:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1778991276; bh=HGkumJWNS9Ej6U7iitanw5ybQDQ/Vb3NEvzDetFF/Z0=;
	h=From:To:Cc:Subject:Date:From;
	b=NOVEVCXTSliONS2cYFmcJ/jhdQJURvY6pr3J1IjBKZqbgikpMT61/8kHEtaLK5J/O
	 lgtMIpecF94u1qzxdY/gG+fEDvJtkk/N1QjM0yziwtdy+pDdx89wiyfV7EW3h27Qyf
	 jfynIDkShyp+gsE8b9woomuVNE89XHcwHwJJ34YI=
Received: from JellyFocals.localdomain (flh2-133-200-255-32.tky.mesh.ad.jp [133.200.255.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id D2345405F3;
	Sun, 17 May 2026 04:14:30 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: linux-kernel@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for math-emu
Date: Sun, 17 May 2026 12:14:21 +0800
Message-ID: <20260517041423.71243-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.52.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 281AF40073
X-Spamd-Result: default: False [0.70 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.10)[+mx];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[xry111.site,aosc.io,vger.kernel.org,intel.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+]
X-Rspamd-Action: no action
X-Rspamd-Server: nf2.mymailcheap.com

Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"),
define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
warnings:

  ./include/math-emu/double.h:59:21: error: ‘__BIG_ENDIAN’ is not defined, evaluates to ‘0’ [-Werror=undef]
     59 | #if __BYTE_ORDER == __BIG_ENDIAN
        |

Cc: stable@vger.kernel.org
Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507301656.7FEX6J5W-lkp@intel.com/
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 arch/powerpc/include/asm/sfp-machine.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index 8b957aabb826d..db8525605c026 100644
--- a/arch/powerpc/include/asm/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -319,10 +319,12 @@
 #define abort()								\
 	return 0
 
-#ifdef __BIG_ENDIAN
+#ifdef __BIG_ENDIAN__
 #define __BYTE_ORDER __BIG_ENDIAN
+#define __LITTLE_ENDIAN 0
 #else
 #define __BYTE_ORDER __LITTLE_ENDIAN
+#define __BIG_ENDIAN 0
 #endif
 
 /* Exception flags. */
-- 
2.52.0


