Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hellhawk.shadowen.org",
	Issuer "hellhawk.shadowen.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 68B6268820
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 06:18:56 +1100 (EST)
Message-ID: <438B5523.40903@shadowen.org>
Date: Mon, 28 Nov 2005 19:06:11 +0000
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>
Content-Type: multipart/mixed; boundary="------------010908080408010006080302"
Cc: linuxppc-dev@ozlabs.org
Subject: PPC32 memory models
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010908080408010006080302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

It seems that there is some confusion over what we should be supporting
memory model wise for PPC32 under powerpc architecture.  The current
Kconfig limits you to only SPARSEMEM which isn't parameterised for PPC32
at all.  Are we expecting to be able to support PPC32 as yet in this
architecture?  If so it seems we have a couple of issues with the Kconfig.

Attached is a patch to enable FLATMEM and disable SPARSEMEM for PPC32
which seems to be the working combinations.  It may well not be what is
intended.  But I offer it to start discussions.

Comments.

-apw

--------------010908080408010006080302
Content-Type: text/plain;
 name="sparsemem-powerpc-allow-flatmem-on-32bit"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="sparsemem-powerpc-allow-flatmem-on-32bit"

powerpc: ppc32 clean up available memory models

Clean up the currently available memory models for ppc32.  It seems
that we do need FLATMEM for ppc32 on non-NUMA.  It also seems that
SPARSEMEM is not parameterised yet so disable that.

Signed-off-by: Andy Whitcroft <apw@shadwen.org>
---
diff -upN reference/arch/powerpc/Kconfig current/arch/powerpc/Kconfig
--- reference/arch/powerpc/Kconfig
+++ current/arch/powerpc/Kconfig
@@ -584,14 +584,15 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config ARCH_FLATMEM_ENABLE
        def_bool y
-       depends on PPC64 && !NUMA
+       depends on !NUMA
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
+	depends on PPC64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on SMP && PPC_PSERIES
+	depends on SMP && PPC_PSERIES && NUMA
 
 source "mm/Kconfig"
 

--------------010908080408010006080302--
