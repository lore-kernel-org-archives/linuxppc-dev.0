Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0260A260E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHMwcPsw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL0qV6KZ1z2xSV;
	Thu, 05 Nov 2026 22:45:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793879126;
	cv=none; b=UShWLlVwlJxNbxxTUvoX7eMIbrljlNfHdklPakyWQ/b5Q1ZaszeCDPlWSlt/JL9T2l2dS2ouPuICyRlY2d14FqyINxkiHGqWLUu4N9g0g+CEOWhLojcaf5Vpt7ry59rw4lJJHQNFjlGvCMsZXcOv6/ZeGhpxutLaE8evoKvMVcwCXTDZ/ygyZWiyHT98RkpVPPY9NQP6Ht0oU3+hUC5LjRPK7cxm0q8BapVOivNSEauTVxi86jLQY/NwtN+n1uQBSjL1/X5TUyK1IElAz/Hmovi5lAFCrrbj6GcRO46Deb4VU4wYx88SG7y4ObHm/itg9OgGCiMY2++HGPfsDM1DnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793879126; c=relaxed/relaxed;
	bh=iW3Qq8amtb6uyWQtI6Qd2QiOD931Nk0J48voU0GEX/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuUOTMihHQ75P+1u3+xHtCL7j7oYYqNDcEcbXO2N2UWjxOMIERWL1EFVyJ71YSSDnIt48ZbCSdUHXIxR6O06H1f8VA1/DWRVKxUYXJd/GwSYhP8QR6oqOSOiuknySY1uX6bOWhLpoplhbadfK7tbBkfQEktMDjtpZr8j+MZ5ZTr+0I4SkDKJn9Oflw3iz1gQHa0wB0CCkKBJR9QVjfFd/0mLzAKWHO5cAarQcZVwC1Vc971528tGBiCiXg6OoKIP36P3RF4r5uBef4rzi1BLCVTvoQ5mH9dIc7T2frfvouaN2nSv/GcVWL2INtoJTD7vv6eZGArS0Uq6GpZ6fHmE9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHMwcPsw; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHMwcPsw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL0qV1lz9z2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 22:45:26 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7647A6111E;
	Thu,  5 Nov 2026 11:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FC71F00A16;
	Thu,  5 Nov 2026 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879123;
	bh=iW3Qq8amtb6uyWQtI6Qd2QiOD931Nk0J48voU0GEX/I=;
	h=From:To:Cc:Subject:Date;
	b=hHMwcPswq0J48GG2CKpW6w3jza2IUAqrYwuIr9qkgDef6ErAO+yqDUjU1xRybeSr7
	 sHwuNU4auztGjgOsnM819Re2H13PnztJJucwgxYpAhNngppeDrafnSt5t0i+WrEPVm
	 0FkJJIrjGn4elBhwGQOXmBl+lxO1+bFGGtKcslPWK0N9MH/S7Rylh6ZxSLB48y30X4
	 nnPnJpktaAPexaIubq1mBGCXRAq5dgS9B+0XGnjOBUum5CbOz2p8TPMmyVsVg2QW7m
	 70MlTJHhvE/kXPxoldlz5JI0zjVEzXkscmno4xCcozvHEm3zgh8uY5U3sW0ZT/KtGH
	 jTW3z6kHQekNg==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Geoff Levand <geoff@infradead.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/boot: Add missing __noreturn annotations
Date: Thu,  5 Nov 2026 12:44:45 +0100
Message-ID: <20261105114447.305789-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=blum@kernel.org; h=from:subject; bh=aG04TDJXN+wUfE2YzSPwyxFhBdzD5LvnNHljxF22+CM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlvcvSbnqz6cLX37qS2HrcXHx/eqwpSeWkdqDbhMpPgB n4RFtVfHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRD/cYGa7uSIsMcIz+fX/X W7mPi8xemq9rds6XFEhz3zP12G37O3GMDF/+bWjdxeN3JO3ceQn79Sv2rzvBt2/nfJf1+zf2Reb y1vICAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark start(), exit(), ps3_exit(), and the PS3 platform_init() as
__noreturn to document that they never return and to potentially improve
compiler optimizations.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Update patch subject and description
- Mark start() and platform_init() as __noreturn
- v1: https://lore.kernel.org/r/20260807152353.306889-2-thorsten.blum@linux.dev/

 arch/powerpc/boot/ops.h | 4 ++--
 arch/powerpc/boot/ps3.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index a40c2162a4e9..42b2721dbe61 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -80,7 +80,7 @@ struct loader_info {
 };
 extern struct loader_info loader_info;
 
-void start(void);
+void __noreturn start(void);
 void fdt_init(void *blob);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
@@ -217,7 +217,7 @@ static inline void free(void *ptr)
 		platform_ops.free(ptr);
 }
 
-static inline void exit(void)
+static inline void __noreturn exit(void)
 {
 	if (platform_ops.exit)
 		platform_ops.exit();
diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index 89ff46b8b225..f94d3818815a 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -45,7 +45,7 @@ static void ps3_console_write(const char *buf, int len)
 {
 }
 
-static void ps3_exit(void)
+static void __noreturn ps3_exit(void)
 {
 	printf("ps3_exit\n");
 
@@ -100,7 +100,7 @@ void ps3_copy_vectors(void)
 	flush_cache((void *)0x100, 512);
 }
 
-void platform_init(void)
+void __noreturn platform_init(void)
 {
 	const u32 heapsize = 0x1000000 - (u32)_end; /* 16MiB */
 	void *chosen;

