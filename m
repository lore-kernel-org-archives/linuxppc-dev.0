Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88002DE0B7
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 04:43:40 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l9BIhZe8030920
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 13:43:36 -0500
Date: Thu, 11 Oct 2007 13:43:02 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Adjust TASK_SIZE on ppc32 systems to 3GB that are
	capable
Message-ID: <Pine.LNX.4.64.0710111342380.27045@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All ppc32 systems except PReP and 8xx are capable of handling 3G of user
address space.  Old legacy had set this to 2GB and no one has bothered to
fix it.

8xx could be bumped up to 3GB if its SW TLB miss handlers were fixed up
to properly determine kernel/user addresses.

---
 arch/powerpc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3180457..037664d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -599,7 +599,8 @@ config TASK_SIZE_BOOL

 config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
-	default "0x80000000"
+	default "0x80000000" if PPC_PREP || PPC_8xx
+	default "0xc0000000"

 config CONSISTENT_START_BOOL
 	bool "Set custom consistent memory pool address"
-- 
1.5.2.4
