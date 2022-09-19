Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7A4ECAAA1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Sep 2022 17:02:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MWWFp2bpYz3cFm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Sep 2022 03:02:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MWWF622Lhz3c2j
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2022 03:02:17 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4MWWDp1d0hz9sjY;
	Mon, 19 Sep 2022 19:02:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GP5zmJrWTyU9; Mon, 19 Sep 2022 19:02:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4MWWDn14Npz9sjb;
	Mon, 19 Sep 2022 19:02:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 130548B764;
	Mon, 19 Sep 2022 19:02:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xS2G4RrYv_If; Mon, 19 Sep 2022 19:02:01 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.8])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E15238B76D;
	Mon, 19 Sep 2022 19:02:00 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28JH1pWP1549576
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Sep 2022 19:01:51 +0200
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28JH1pZ51549575;
	Mon, 19 Sep 2022 19:01:51 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 02/19] powerpc/64e: Tie PPC_BOOK3E_64 to PPC_E500MC
Date: Mon, 19 Sep 2022 19:01:26 +0200
Message-Id: <ae5d8b8b3ccc346e61d2ec729767f92766273f0b.1663606875.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663606898; l=1675; s=20211009; h=from:subject:message-id; bh=RrsFnR0h94T+Rw2K7V67BTuqYkwQnp0REkkOdUyqJwQ=; b=hDNJK14aPDeIEhX+3oLHFoWOypsHSZ0WH0wNQ0WBVZz7lHex84CiqGYMmMBr0jtXiR1t2czPfWK/ 5S8SRkzyCM7f8RHx9dZY9qcANRx2W9wRF4UvsHQRUgnf3OiSinyn
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The only 64-bit Book3E CPUs we support require the selection
of CONFIG_PPC_E500MC.

However our Kconfig allows configurating a kernel that has 64-bit
Book3E support, but without CONFIG_PPC_E500MC enabled. Such a kernel
would never boot, it doesn't know about any CPUs.

To fix this, force CONFIG_PPC_E500MC to be selected whenever we are
building a 64-bit Book3E kernel.

And add a test to detect future situations where cpu_specs is empty.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Replaced e500mc by CONFIG_PPC_E500MC in commit description.
---
 arch/powerpc/kernel/cputable.c         | 2 ++
 arch/powerpc/platforms/Kconfig.cputype | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index d8e42ef750f1..2829ea537277 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2018,6 +2018,8 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 	struct cpu_spec *s = cpu_specs;
 	int i;
 
+	BUILD_BUG_ON(!ARRAY_SIZE(cpu_specs));
+
 	s = PTRRELOC(s);
 
 	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++) {
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5185d942b455..19fd95a06352 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -108,6 +108,8 @@ config PPC_BOOK3S_64
 config PPC_BOOK3E_64
 	bool "Embedded processors"
 	select PPC_FSL_BOOK3E
+	select E500
+	select PPC_E500MC
 	select PPC_FPU # Make it a choice ?
 	select PPC_SMP_MUXED_IPI
 	select PPC_DOORBELL
-- 
2.37.1

