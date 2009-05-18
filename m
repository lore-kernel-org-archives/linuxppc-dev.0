Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74652DDFB6
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 11:13:17 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org, benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Make the NR_CPUS max 8192
Date: Mon, 18 May 2009 11:13:16 +1000
Message-ID: <17087.1242609196@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We can compile and boot with NR_CPUS=8192, so make this the max.  1024
was an arbitrary decision anyway.

Signed-off-by: Michael Neuling <mikey@neuling.org>
--
No, I've not actually booted on a 8192 way machine, although if wishing
made it so.... 

 arch/powerpc/platforms/Kconfig.cputype |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-2.6-ozlabs/arch/powerpc/platforms/Kconfig.cputype
@@ -262,8 +262,8 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-1024)"
-	range 2 1024
+	int "Maximum number of CPUs (2-8192)"
+	range 2 8192
 	depends on SMP
 	default "32" if PPC64
 	default "4"
