Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts13-srv.bellnexxia.net (tomts13.bellnexxia.net
	[209.226.175.34]) by ozlabs.org (Postfix) with ESMTP id 41EDBDDF42
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 10:48:48 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts13-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070207234846.RNXB1773.tomts13-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Feb 2007 18:48:46 -0500
Date: Wed, 7 Feb 2007 18:48:45 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: mporter@kernel.crashing.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] PPC : missing request_dma and free_dma on PPC 405
Message-ID: <20070207234845.GA26092@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

PPC : missing request_dma and free_dma on PPC 405

The solution I have found to correct this linking error for modules
that use DMA is to allow 4xx to select GENERIC_ISA_DMA in arch/ppc/Kconfig.
It applies on 2.6.20.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1188,7 +1188,7 @@ config ISA
=20
 config GENERIC_ISA_DMA
 	bool
-	depends on 6xx && !CPM2
+	depends on 4xx || 6xx && !CPM2
 	default y
=20
 config PPC_I8259
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
