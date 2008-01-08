Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DBC37DDE9B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:16:13 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m080GAB4024863
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:16:10 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m080GA0H134244
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:16:10 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m080G9Lm000699
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 19:16:10 -0500
Message-ID: <4782C0C8.2050702@austin.ibm.com>
Date: Mon, 07 Jan 2008 18:16:08 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/8] pseries: phyp dump: config file
References: <4782B985.2090508@austin.ibm.com>
In-Reply-To: <4782B985.2090508@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com, lkessler@us.ibm.com,
	strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add hypervisor-assisted dump to kernel config

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

-----
 arch/powerpc/Kconfig |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6.24-rc2-git4/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.24-rc2-git4.orig/arch/powerpc/Kconfig	2007-11-14 16:39:20.000000000 -0600
+++ linux-2.6.24-rc2-git4/arch/powerpc/Kconfig	2007-11-15 14:27:33.000000000 -0600
@@ -261,6 +261,17 @@ config CRASH_DUMP
 
 	  Don't change this unless you know what you are doing.
 
+config PHYP_DUMP
+	bool "Hypervisor-assisted dump (EXPERIMENTAL)"
+	depends on PPC_PSERIES && EXPERIMENTAL
+	default y
+	help
+	  Hypervisor-assisted dump is meant to be a kdump replacement
+	  offering robustness and speed not possible without system
+	  hypervisor assistence.
+
+	  If unsure, say "Y"
+
 config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
 	default y if PPC_PREP
