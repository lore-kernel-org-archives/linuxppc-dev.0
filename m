Return-Path: <linuxppc-dev+bounces-24765-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26907C531CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 03:33:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5tqz3jLcz2ybR;
	Fri, 24 Jul 2026 13:33:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784859472;
	cv=none; b=BNUGvkVpC4ia0ZbjaqI/stC53/bIbYD2B7O6mmv3JRQHhy9SnHE6FBZL+OhJBqvg3E3Ot7eMISeTXKIAvUJea8QmZ1EANXA1knssDCXNHCcy1bOjTzjSUDKiqwp8y0QwSHF/K9F92mS9N1nfrHU7D7YqmbvlDxps8r3z+VEKxu+N4Tux7A/4gVhu/O1nDWg1N32zgBoraEnEjUg6WW7+YcV8FmEDdzdYmfeYUDfy/dc5ZP5m2CdevsO4+4UT9f5l9MpfA6E6wzs8CBufx7opOhxsG8hq+mlVKgGuUz01nVLEvEXymyvbnD5W2SYoSLJ2stQJDHNPTK4X29lAdaV5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784859472; c=relaxed/relaxed;
	bh=L/SZp0vPqZ6bgIHdMlwc9563CUsJkyQzIo7rI6wG1fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmSujzLCrjd5L71RSDbI1gIxpQY5qb/ilwVoUzvP1Jmv9rvwLPrwadauU7ZWQLDFQojD92Wo9EikBiRX9huvtyNBR3nZ5ChREhb8zndcmNB0yhIeuGLd1bqcaupwvwjwxo5C/usIDvUB2ImWgUfd0zSbQ6qeeNnxWmkaLTD2nO8/+B4N9bHXi67h7Gja/34CvV3qmB2TE/cUGIdKOduGc5p625dwvG36VM3LAfXv46Y0qYC9yMBmm3rVaHLAp6Z8mEh+5Et9M5r+4fy+AHR9HqtdhbhqCaulrBSuuImwcmtGnTegJXKriVpep7M9veaXrX1BPli86dSxahrO+WDEbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=126.com; dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ipar9103; dkim-atps=neutral; spf=pass (client-ip=117.135.210.9; helo=m16.mail.126.com; envelope-from=chensong_2000@126.com; receiver=lists.ozlabs.org) smtp.mailfrom=126.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ipar9103;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=126.com (client-ip=117.135.210.9; helo=m16.mail.126.com; envelope-from=chensong_2000@126.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 176 seconds by postgrey-1.37 at boromir; Fri, 24 Jul 2026 12:17:48 AEST
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5s8X1VMtz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:17:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=L/
	SZp0vPqZ6bgIHdMlwc9563CUsJkyQzIo7rI6wG1fs=; b=ipar9103VugBwa7uzk
	RoqjOghrHfRoqDl2bzaHe0YPIkBrqYCLgiYNa1/ES/GRQ8WHq2GbajVuBN2uMDbr
	+3gkFYU0bsk813V33HstJUih1FcKIA7lBelM4qVniwAowoHQCdo0vuE4VHpsY6gY
	n6ZDAiMe/dnXvn4gK6jlV0i+Y=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnr+wRymJqH7z4DA--.34972S3;
	Fri, 24 Jul 2026 10:12:39 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	agordeev@linux.ibm.com,
	svens@linux.ibm.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [RFC PATCH v2 1/3] error-injection: Introduce EI_ETYPE_FALSE for fail_function
Date: Fri, 24 Jul 2026 10:12:27 +0800
Message-ID: <20260724021229.47302-2-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724021229.47302-1-chensong_2000@126.com>
References: <20260724021229.47302-1-chensong_2000@126.com>
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
X-CM-TRANSID:PSkvCgDnr+wRymJqH7z4DA--.34972S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrtr4DJw4kKF1xCrWkZFW8JFb_yoW8JF1DpF
	1q9r9rury8K348Cry8AFZ2yr1F9rsrGrZxKasxWws7Zw17tF4kt39FgrWUXrykGrW8uayj
	va9rWFZ0yr45AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRwvttUUUUU=
X-Originating-IP: [221.238.56.48]
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsxfqampiyhdNyQAA31

Introduce EI_ETYPE_FALSE for functions which need false as return
value in their error-injections, like btrfs_data_csum_ok.

EI_ETYPE_NULL can return 0 too but its readability is not good
enough.

Signed-off-by: Song Chen <chensong_2000@126.com>
---
 include/asm-generic/error-injection.h | 1 +
 kernel/fail_function.c                | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index b05253f68eaa..6c399121ab7a 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -8,6 +8,7 @@ enum {
 	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
 	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
 	EI_ETYPE_TRUE,		/* Return true if failure */
+	EI_ETYPE_FALSE,		/* Return false if failure */
 };
 
 struct error_injection_entry {
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 2eaf55005f49..90cdad0412cd 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -48,6 +48,8 @@ static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
 		break;
 	case EI_ETYPE_TRUE:
 		return 1;
+	case EI_ETYPE_FALSE:
+		return 0;
 	}
 
 	return retv;
-- 
2.43.0


