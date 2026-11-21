Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D11606A320
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huMTSE1W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jX1GD3pGfz2y97;
	Sun, 22 Nov 2026 05:39:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795286388;
	cv=none; b=ZDW4XkVY6Rbrvxsy48DahPNmC2+S72iOnKmMNZu0q02gHXzbzO5Yl5XOv0dsQpB5WDb1aUpqVkjERiqx3DQJCawkzl7Xzbd+HGI+xV3MjLA5RNTRG9RFD9sVIDBjl4PcYjUrjJBxwJxjsPM0+ih9VEHiFIAxwgsx3MYRYS65XaAQ0oMP3a2zsSAgBuqLi/fu7QGf1NAjWsm6Dt3wXyzO/BOFVAIRz2zr64LFh0YlOp0YEaEwdzXLD8WdSalv5B0KhDYIjkPpzjaXxRxzAYW2kUdVwPoHaXRpXdFiCfalsz7S85wZ7zb/DYBh7G7BVRw5Casoc4LHsSpDYnOuKhS4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795286388; c=relaxed/relaxed;
	bh=Li0K14aBP17JLe2Y1C42W5hcrD0haa0NfoV2Pa2ZuCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ex1ptF/zCAKgd0WNq/r6k/uDJOVcgj+O6PZTYPMVGHXWP+b73WN7JqvBP260KozBsNv4K3JFJuUTrnMZfcWxDDgBxa3OA5lUnd4rXc0SEcogoUtrupTSyWto2JgsIv9X9eES6mktRa6GXQ768ChJj19MmJ9hdt7WOx/ClDWLsl2A+Nubq47GaBpV4fN02Alfgbl1w1oIhwFzehpTx5zItb+I7HWe+FG32qHmNdEXB3why5a9tTZ9zjeZBIRls9XyftUvOEOa2s9phdpX/tFcarV3dwaUhOyilhIKo5TXEiLndzwNNfTtYo032Pyu4BSd/2Yku4CciP071oXs0xFv5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huMTSE1W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huMTSE1W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com [IPv6:2607:f8b0:4864:20::b12b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jX1GB4Nlyz2y96
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 05:39:45 +1100 (AEDT)
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-67da7d18f2fso2244251d50.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 10:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795286382; x=1795891182; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Li0K14aBP17JLe2Y1C42W5hcrD0haa0NfoV2Pa2ZuCU=;
        b=huMTSE1WK5Uo7e9tgFbA9wFNQOmgAKFl6lSg0ONDYltBVdlFj7km9uG0frid96UB/z
         sCnII6KO6eTih9/qtiGMfYkSsMBFngKNUkDStU0QN3jnav9EenH32qNNVB7x+pVbgRxv
         WyxMPBh6Xi7YK9L7fN0XlQQUw5Tg8LEgK4oizw0T/cAS2bupUDgza7DH5mRL1BMM36Wi
         h60wgh6hatOhPyNzxx6oZqV4t8nyR+eAv6UsPJz9uF5ETh0iE8lndaGGIHe0hkiLZNgV
         uL9Jn6wIay24tzXLmG5g13XSyAX9Ag+mpZwrHUOHt/zOUsY1gOPsUOsEFUcSWEoKBo+V
         k0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795286382; x=1795891182;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Li0K14aBP17JLe2Y1C42W5hcrD0haa0NfoV2Pa2ZuCU=;
        b=AmZR51H0TlpKvz1ZM+vtezEJzJyKjEgHGdAPL6GzgekTQqSRJGUhuRq4NUW1exYyFt
         AiE6dGHAUVmag19E0Xa5/JP54tpcddrApMZ5zRruRvUR/5SVc5+JpP7Ofaz9onNEk/9L
         LtDityh6N5gCG7ieuQ7dBl021wtisQUxkNhFBh4zLNPAEl0JrrVfocBcRMDq+FzbznHk
         eIdMkgFKW5+PNhiN0n4EPrYqWnqCIFUbNkG1wyrIAvL1+vABRXmzu0SueoKqHQgMI1uD
         PnR3dwwBVQsY5Kln8ViI+QHcOFCR8km4Myl3rFGP9799rhX6yfk9UXjd3HFLS5gb6tA3
         56iQ==
X-Gm-Message-State: APuU4Z/J+Ktx4Z0mXfGx+fUTo7TjS/59PSnQMdc5G+UsAPJvTnnBG/4X
	4Hd5CMu55pEssaFQJUaI3HPZVncGQRruqGHyAL++iWU8uU3CgjSF8h8M
X-Gm-Gg: AZFdTZfWTkA4x5hHurc66xFLxTtgopef2a09S+9PmBd3KHOoXUBm64B/icWxSX4IAwR
	H2nrDF6PxEkeSHlg5ZSWhr/VDaiOGU/1iSfTbSJqcJsiY1UxD/AiQPmIcoA+IFvf4AeAAr/2eiZ
	eM57jPD1aIU+cvGSY944kmrU+0orx6SVYm5llz3J2fkYL9aFy/WXiQDOCBbgP9v42ZGbzGBPaLI
	ySzEB5WdnJvfxYT4iCclvZbhOtbuJqJ/JUqlo63u4saARo8YxwhUuPXaSv2WO2P9TDLzqDdu9KT
	+2jDutpLGY+iemFuaLIhYLKqeyPDItYRiAVpl7O3oiE2z8/Dvwe7TcSitEUppt5mvCJ1UQNih7F
	vLTBdowVG1sdCEaqdpuDNZmGhDTfSHkXQnpr7ANsC8lIkA+5zT01gSmWjpa+MCqEwCOzcRank3n
	ujUMwhIj41soX1BkMB5ysifKEsxbxRDi1aeWokK6kXXdVfdz0tidq/Qv2TWUY3MJ5GZz4NN/sA2
	YjKadQDpBi58UX9VSUgzSFXu2TblGJx5MYQzsmQaWmXgWl6vlRj1/bbbtvPCWuM9cej81ozhWlU
	WxpHRBiNtwE9J65qp4sMtB6A7OUwkVZC8rkUF2MBAl++ARQxVLZpRF04AYmaxYYD0aSQwX+89lV
	fk9E7CIpBn7Nf24hWjbjfuTwUSIlDmC+BO5TOE7vx3w==
X-Received: by 2002:a05:690e:150f:b0:67d:b4d7:6344 with SMTP id 956f58d0204a3-67df443315cmr2178339d50.20.1795286381962;
        Sat, 21 Nov 2026 10:39:41 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33b498asm3268639d50.19.2026.11.21.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:39:40 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 21 Nov 2026 13:39:40 -0500
Subject: [PATCH v2] powerpc/powermac: Fix low_sleep_handler with
 STRICT_KERNEL_RWX
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-pmac-sleep-strict-rwx-v2-1-dc03dccb0045@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDQAxG4atI1g04A2OxVxEXQ/xrA2qHRFpBv
 HuHLr/Feyc5TOH0aE4yfNT1vVXEW0PyytsM1qmaYhu7EELPZc3CvgCFfTeVne17cLojTZIFSIl
 qWwxPPf7fYbyuH9U0Qy1nAAAA
X-Change-ID: 20261119-pmac-sleep-strict-rwx-57e5dcacee55
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gabriel Paubert <paubert@iram.es>, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3204; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=dru942EETpYgT2DGF8jvCsbcN9eYuk0lD7XxZnYn8pA=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIZn2a/vTXn6hyhtEUOx0wtQzaeP67vpXSy2EdT7umsq
 5eiHflTOj6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaaZymMDF3b7pzVl/
 niEXYo0MC9Z7pS7pf2pY2XuCtPrfS3b/vyPoqR4flfll12OXHHBN7evZYR9T7TtFrI4M/RrPmXr
 lqZvrhhzwQA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Before sleeping, low_sleep_handler() stores the ROM wakeup vectors and
the 'Lars' magic at physical addresses 0x0-0x84. It does so through the
kernel linear mapping at KERNELBASE with data relocation on. With
CONFIG_STRICT_KERNEL_RWX, that page is the start of kernel text and is
mapped read-only, so the first store takes a DSI and PMU sleep oopses
with interrupts disabled, leaving the machine hung:

  NIP [c0033018] low_sleep_handler+0x198/0x1b4
  LR [c0032ff4] low_sleep_handler+0x174/0x1b4
  DAR: c0000000 DSISR: 0a000000
  [f2169d20] [c086df18] powerbook_sleep+0x86c/0xbe4 (unreliable)
  [f2169db0] [c00b1178] suspend_devices_and_enter+0x680/0x700
  [f2169e00] [c00b1428] pm_suspend+0x230/0x25c
  [f2169e20] [c00af7dc] state_store+0x74/0xd0

Turn off MSR[DR] around the stores and write to physical address 0
directly, as flush_disable_75x() and flush_disable_745x() already do
for their cache flushes. The ROM reads these locations with the MMU
off, so physical address 0 is where they belong anyway.

The stores stay ahead of the low_cpu_offline_self entry point, so the
CPU hotplug path is unchanged. pmac32-cpufreq also calls
low_sleep_handler() and gets the same fix.

The Linux PTE for page 0 has been read-only since STRICT_KERNEL_RWX was
first enabled for PPC32, and the BATs since commit 63b2bc619565
("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX").

Tested with suspend to RAM on an iMac G4 (PowerMac6,1, 7448). Not
tested on Grackle machines or with pmac32-cpufreq.

Fixes: 95902e6c8864 ("powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v2:
- Drop the li r4,0 and address the stores with RA=0 (Gabriel Paubert)
- Link to v1: https://lore.kernel.org/r/20261119-pmac-sleep-strict-rwx-v1-1-9068dc16d59e@gmail.com
---
 arch/powerpc/platforms/powermac/sleep.S | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/sleep.S b/arch/powerpc/platforms/powermac/sleep.S
index 822ed70cdcbf..27901db0313b 100644
--- a/arch/powerpc/platforms/powermac/sleep.S
+++ b/arch/powerpc/platforms/powermac/sleep.S
@@ -184,19 +184,30 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	addi	r5,r5,grackle_wake_up@l
 	tophys(r5,r5)
 	stw	r5,SL_PC(r11)
-	lis	r4,KERNELBASE@h
 	tophys(r5,r11)
 	addi	r5,r5,SL_PC
 	lis	r6,MAGIC@ha
 	addi	r6,r6,MAGIC@l
-	stw	r5,0(r4)
-	stw	r6,4(r4)
-	/* Setup stuffs at 0x80-0x84 for Core99 */
 	lis	r3,core99_wake_up@ha
 	addi	r3,r3,core99_wake_up@l
 	tophys(r3,r3)
-	stw	r3,0x80(r4)
-	stw	r5,0x84(r4)
+
+	/* With STRICT_KERNEL_RWX, the kernel mapping of page 0 is
+	 * read-only. Write the vectors with data relocation off.
+	 */
+	mfmsr	r7
+	rlwinm	r8,r7,0,~MSR_DR
+	sync
+	mtmsr	r8
+	isync
+	stw	r5,0(0)
+	stw	r6,4(0)
+	/* Setup stuffs at 0x80-0x84 for Core99 */
+	stw	r3,0x80(0)
+	stw	r5,0x84(0)
+	sync
+	mtmsr	r7
+	isync
 
 	.globl	low_cpu_offline_self
 low_cpu_offline_self:

---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-pmac-sleep-strict-rwx-57e5dcacee55

Best regards,
--  
Matt Turner <mattst88@gmail.com>


