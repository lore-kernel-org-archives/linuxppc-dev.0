Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11807606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMfRwzGS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVs3P4f8Nz2xL1;
	Fri, 20 Nov 2026 08:26:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795123585;
	cv=none; b=GKMm4+wqU8T9YnQeRn7md+NPX6XFOQ+B0FTKbW2OeXmciHjrE9LqZ9+29qHG4szd2hO/b0J5MXPHCgRkv7NkYqDO9VzvKa5iGzk+iJhjOUn1cTebbkNptoTuZ0vJ5LBX6uAdTZc8KENatY+lNUxPPIuwG+KKIQ+h5dAsFQSeGmUN0a4o9drfQ9+Mfhs0YKRY5kS+s4WVL2kvtqMdI8PxHx/4XmKQ2dMaC0FsKyf3plUEoiPS3my5uwccaaW91cKUubXBT1qSsDNnwaIYLRXjhpi+ciXneSG7oThbyQXN8iQRraUg0WBlGih+dFNpk2yiQF7TtzYfXrypVviiMUgpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795123585; c=relaxed/relaxed;
	bh=KfBNfnFRlW0IKp4bUq9gvtWzsefFYniRlVGGHjtlLxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FDme0XmMsakYrPmfDcJYFWP8h1lVvm2KmBSdLghLlrOxgoSOkxMJ0gU6FErdVOzrxRG5/HQJGdKQoaYM0fa6XQuDF105pqZRGfs0vNzxGh0KIJgUECnuOG8+K+0Y7PPhnGb26aQ/9Ms04dht2ZQA7W8Pr+EXnUq3XCoyO5Jhww9Tog26Gk0ylvdyIiN5M4dQPBpHCefk8VRnPQ5spthn/uQLuavzthvzBqOt0IdYegvDenGfj84dy/lYFCcy4Tluep9ssVNMdnyjIxJhvEBDm6x/Npn2E1cxieDHRVMkF6tfD/KZL83GMamdCJ5vFhGbYx6AsKP5uioaSIpOPr8oDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMfRwzGS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMfRwzGS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVs3N1ZKRz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 08:26:23 +1100 (AEDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-8b4c2da74c0so1597847b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 13:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795123581; x=1795728381; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KfBNfnFRlW0IKp4bUq9gvtWzsefFYniRlVGGHjtlLxs=;
        b=XMfRwzGSGgV1DSCAl+23JPMV+WhFoz0LITIoMfE3z1I76X336Rl44a+zEbmDCKVv0T
         Fkdn3OwsKaTbMBYfSfFlTLnnrNZbl2yV/yXP1LtngIZI6hUHP/0OAml2tE5lfMN+iPxR
         5m8k3DdyOnJjSJM1uyNh/C+rj/8i78D4UemXJ96RH/8ZZAthspUs+CFqHlA74HxFC5Gd
         uyoCiBF6+KOLvsi5E/z47FpXo4sL9p+Ux5o1WEhPQDokw/23KXBsBIlQQtoLS5z5MKnf
         PqpL9LMWMV2c0HR5FTo4+cRoYagVL9NdWX8BnS1lP54ZIB9yzUHV7PWnOZimlkj1kocg
         S7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795123581; x=1795728381;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KfBNfnFRlW0IKp4bUq9gvtWzsefFYniRlVGGHjtlLxs=;
        b=kwFpKqWqEEB2xa3TuDMSGHGSLijci94rRDJoTS4jmBZK4U42urNmmgDKGKUtMRwipc
         wOfw+Cxqbd8OUGFtO6US84ka93sVcNooGSrMA45v4LgngW9Kf2wYUhTZeB4p90tu2sqW
         uqgOGsGy4FwvMJNpf2xc8Inv0Qona6z95Ioi80PfEzYfc/tMoJwDD8L2CPUc5I4Emnxi
         EsLMLKpeZHk4vqnaO1cMb91s4jDAZjlCkfeLxQHbZ0BzSFavlLPXC6hSJKThspGCtJGr
         nHr/hlSvPaZKyItQ6D05b/8ox7KNa0bBuplEfEPGGK9lzxksWwJDbl8wpeacGg555Iqg
         UTqg==
X-Gm-Message-State: APuU4Z9hMyFdIkT/VeMW4Sx/SVQuwzYgHk/9xKQl31WaF5JU976upAQJ
	zjfumx8mEGaWEQozaNSf3YKvRNlLlUA2YHI8rVS2ZgenVH1ia1Un910W
X-Gm-Gg: AZFdTZdrAI6FLu4yJLsQIbAx2re6woSc7wu0LKHt0dW129O2ooyQRzrmjuqna5EAxhn
	yy9fOWctqbIwYIn6odDfI8eQi5OfwfjPk6BhSrn4xbBYuDe3c/kfXAT9G6nEHz5ax3qPE63zQHv
	oS/NcalQK9vxHFxRSUTu2348QlElnBB1dQvJdx/I2UhGz1h3g+9jM8CRC4JP2APZSItN7GDjlGc
	05yyWAKsZPZ2oYGgPecTVUNa2sTNAeUapdq8m6pIpg5kYpcz2qkWLpTdttq5eOxZLm6kXYlP4Vi
	oQqERke5RUXg79aPY36SdVdK7UDZ8f2XZfFKnjyQwcwSbMaZsKT1ohBmEyLN3YYi70JyF4Le46e
	OYP+unjjFc7oFoAwiz01nqKpiMzBcQUkFP8VNH8j7cZoyPy8lZNQ3dXG+X3JE0wgp5oeQpV5Z4G
	+9sK6i9jAgSHl3SvZVsNMo6c3HE1/kpnfi10oQMwh3Zw8Y+W0pg7T6CpDgsr7B2+JFJ0KGKbut3
	1x4uWRQW1c6kWNaPyhdiaDWLiUI9C9iQnGexGh+VE5On9gGWkjEHpV+NYTAEVG6CHQuExsSikdY
	cwWlRREn18UjUiCqvJZxj7GOBMA+OkqmQqJ6QQ1wcLsFi6tdjuIIiVmng+gmrq1zXRiepDV9jDU
	UXbyaNYX9kml8SQLkWexZNPigcjtQMOdT+Fo7ZFbNQA==
X-Received: by 2002:a05:690c:c96:b0:8b3:4b5d:b26c with SMTP id 00721157ae682-8b520435e51mr4129817b3.13.1795123580686;
        Thu, 19 Nov 2026 13:26:20 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202b09c6sm5666497b3.17.2026.11.19.13.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:26:19 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 19 Nov 2026 16:26:19 -0500
Subject: [PATCH] powerpc/powermac: Fix low_sleep_handler with
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
Message-Id: <20261119-pmac-sleep-strict-rwx-v1-1-9068dc16d59e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDQAxG4atI1gY6wrTUq4iLIf62gVaHRFQQ7
 +7g8lu8d5DDFE5tdZBhVdd5Kgh1RfJN0wesQzE1j+YZQnhz/idh/wGZfTGVhW3bOb4QB0kCxEi
 lzYZR9/vb9ed5ASatSPFnAAAA
X-Change-ID: 20261119-pmac-sleep-strict-rwx-57e5dcacee55
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2986; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Q0CzZdeU2vkAR4nODbf7p/H7xmXUgc9AR1aEaT9HdiA=;
 b=kA0DAAoWrOspdAyaTpcByyZiAGr/aXqhqp6cUbqLQJ165TbD7zeKepwOULbcoRc18QEQBXNZY
 YjxBAAWCgCZFiEEXq8hBJqGuKVMyxv6rOspdAyaTpcFAmr/aXobFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9wZW5wZ3AuZmlmdGhob3J
 zZW1hbi5uZXQ1RUFGMjEwNDlBODZCOEE1NENDQjFCRkFBQ0VCMjk3NDBDOUE0RTk3AAoJEKzrKX
 QMmk6X30AA/3Crq6iZh84Q8w3MQ3STHGZ+mYNZX3vjSIGrqMotwpN1AQDqNf2wDYEnXG2z9/p54
 h4k+i4fhHxxKenLFWfHz0QpDQ==
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
 arch/powerpc/platforms/powermac/sleep.S | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/sleep.S b/arch/powerpc/platforms/powermac/sleep.S
index 822ed70cdcbf..750cb0160b4c 100644
--- a/arch/powerpc/platforms/powermac/sleep.S
+++ b/arch/powerpc/platforms/powermac/sleep.S
@@ -184,19 +184,31 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
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
+
+	/* With STRICT_KERNEL_RWX, the kernel mapping of page 0 is
+	 * read-only. Write the vectors with data relocation off.
+	 */
+	mfmsr	r7
+	rlwinm	r8,r7,0,~MSR_DR
+	sync
+	mtmsr	r8
+	isync
+	li	r4,0
+	stw	r5,0(r4)
+	stw	r6,4(r4)
+	/* Setup stuffs at 0x80-0x84 for Core99 */
 	stw	r3,0x80(r4)
 	stw	r5,0x84(r4)
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


