Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B9E3DDE48
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:09:16 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0ML9DRh010136
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 16:09:13 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0ML9DZv165008
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 16:09:13 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0ML9CBb031592
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 16:09:13 -0500
Message-ID: <47965B76.9030900@austin.ibm.com>
Date: Tue, 22 Jan 2008 15:09:10 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
Subject: [PATCH 8/8] pseries: phyp dump: config file
References: <4796401D.5010907@austin.ibm.com>
In-Reply-To: <4796401D.5010907@austin.ibm.com>
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

To: linuxppc-dev@ozlabs.org


Add hypervisor-assisted dump to kernel config

Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>

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
