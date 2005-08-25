Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1EBBB68135
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 17:42:46 +1000 (EST)
Date: Thu, 25 Aug 2005 00:42:43 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050825074243.GA23774@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: disable IBM405_ERR77 and IBM405_ERR51 workarounds
	for 405EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Disable IBM405_ERR77 and IBM405_ERR51 errata workarounds for 405EP. 
This chip has these problems fixed.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -152,13 +152,13 @@ config IBM440EP_ERR42
 # All 405-based cores up until the 405GPR and 405EP have this errata.
 config IBM405_ERR77
 	bool
-	depends on 40x && !403GCX && !405GPR
+	depends on 40x && !403GCX && !405GPR && !405EP
 	default y
 
 # All 40x-based cores, up until the 405GPR and 405EP have this errata.
 config IBM405_ERR51
 	bool
-	depends on 40x && !405GPR
+	depends on 40x && !405GPR && !405EP
 	default y
 
 config BOOKE
