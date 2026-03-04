Return-Path: <linuxppc-dev+bounces-17669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A8DEDEC1B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 07:49:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQlDW2YcNz3c5c;
	Wed, 04 Mar 2026 18:49:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772610555;
	cv=none; b=dtEHzaKvp9MM3GEmxsGYQRnRMsRv5732E7DpNT/ybrJVeeloKavbcCvR5y4ccRuLIMQ06lVvw31Fg2xa7gV2DRBSABnV7mTvEGIU/neGOQvkIy2tyqlRriRXD470Ics96r6WC6X5PsgNmNI6GI3+ehYMNSMS+hvwW5BsxVWI6tGcP/7cFfeKnIZ55eOH5tYNqbJgf7EvKDiyGv0NEvgykPYuhbU1iWa9wJU4JqAgaFVqWs24TZOd5D8iY198mqqOPqKYG7ePxW1cm5MJ/EgHJh8GH2ccaCiIuCwLl2g2/IklNHBWa6lsD+Unm03e1RfvDRJBD8ryu8riauvH/AwBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772610555; c=relaxed/relaxed;
	bh=RnZKZBmYr4ceBeK3e35WzrNjvlhaTZHtKIQbUEGmOF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XqWfilJjxjEXemfq30BkwgPMZFK9zyV6jBUwbwfXZ/LQo5XmnBxqlnDW8IxZRddYs+dH2Y2PzwTM44dquO6m1gX2B+pMcCWmJAiDWFy34ta/8ifPRcnrMAqijDu5P73vb1E5t8kfZ47SRLO11fZv8e755zPwpDmBsmXnllGTKJdJCelislybn3YW3d1b6sPq3EB3dUq0nS6psDPPZ1bvhtiC9mewjb7RQ/q4tuzNp4Y143I0qdO5VfkKqPebf00Y/wUnvwmB0d6mcu3J0YC7Oa+AlsJvojWE42QUJ3URt7GmR6UIcpXDtf7FMPUARS5V0WZeN3J6NqM1blw9KCxaGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LyzgGUL9; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=59pX2e/f; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LyzgGUL9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=59pX2e/f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQlDV50C6z3bp0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 18:49:14 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772610552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnZKZBmYr4ceBeK3e35WzrNjvlhaTZHtKIQbUEGmOF4=;
	b=LyzgGUL9R9gijctFQpnURyO74FAZPQIhEzpn92rOhi+rqdUMobnwLvA/XJ1lRc7tNVwrGc
	O9r/flvRZM5pE/odEJObleViPiZijuzGQSiMuM2kmE1uinZIXi2dTdlqxC4eH37HzjhtrT
	ZImQZL/XGjfUn2K3NTbMiX2PqsOgAaOKawj6qkFvOddrNqb3mQ7lPuAaTCdnmmZ0WJeDul
	Ds5cZ0Vj8vsUjUr+N/OqJ/Fgb0JT7D43NBzJN3vC0SmtfkH7sDV8DnGQsPqSCjqoIi4uo7
	okJWi1KyT0CV/V8n1KB5tgAnf7R/Z2PTkJjQaMPKqrj+u4je8m+d+B3iuFtQLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772610552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnZKZBmYr4ceBeK3e35WzrNjvlhaTZHtKIQbUEGmOF4=;
	b=59pX2e/fytADAEYLh30rm0MfR5cMXtemqGQCW45I6ECwN6e/dinEpeYSPsqbxOPFO/NJAy
	145MypOmforAFOCQ==
Date: Wed, 04 Mar 2026 08:48:59 +0100
Subject: [PATCH v6 02/14] vdso/datastore: Drop inclusion of
 linux/mmap_lock.h
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-vdso-sparc64-generic-2-v6-2-d8eb3b0e1410@linutronix.de>
References: <20260304-vdso-sparc64-generic-2-v6-0-d8eb3b0e1410@linutronix.de>
In-Reply-To: <20260304-vdso-sparc64-generic-2-v6-0-d8eb3b0e1410@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>, 
 Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772610551; l=813;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uvUMiIWcfXjU7/EzaxsEgKgYSiRCVfCnLWW65nkdgxo=;
 b=XllL5cGs3jsrCqJAmyHwOhy/PXaWdoIqh8MmFM1mAmpXsY4DzkaFM3BSuAw5RE6gFO6VBrtyw
 +TE8wBR025/DIh0UwGva3/uc3S4dPzUGLXgPK0DcBB4JuoymIO41EJM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This header is unnecessary and together with some upcoming changes would
introduce compiler warnings.

Link: https://lore.kernel.org/lkml/20250916-mm-rcuwait-v1-1-39a3beea6ec3@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 lib/vdso/datastore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 2cca4e84e5b5..7377fcb6e1df 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/linkage.h>
-#include <linux/mmap_lock.h>
 #include <linux/mm.h>
 #include <linux/time_namespace.h>
 #include <linux/types.h>

-- 
2.53.0


