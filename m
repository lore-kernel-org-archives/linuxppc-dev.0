Return-Path: <ahuja@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82DAEDE1BF
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 10:50:55 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2LNqsGu022011
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 19:52:54 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2LNoqJG249922
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 19:50:52 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2LNophX009315
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 19:50:52 -0400
Message-ID: <47E449DA.8050906@austin.ibm.com>
Date: Fri, 21 Mar 2008 18:50:50 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH 8/8] pseries: phyp dump: config file
References: <47E439C3.6050904@austin.ibm.com>
In-Reply-To: <47E439C3.6050904@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add hypervisor-assisted dump to kernel config

Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
---
 arch/powerpc/Kconfig |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: 2.6.25-rc1/arch/powerpc/Kconfig
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/Kconfig	2008-03-20 20:53:33.000000000 -0500
+++ 2.6.25-rc1/arch/powerpc/Kconfig	2008-03-20 21:06:29.000000000 -0500
@@ -306,6 +306,16 @@ config CRASH_DUMP
 
 	  Don't change this unless you know what you are doing.
 
+config PHYP_DUMP
+	bool "Hypervisor-assisted dump (EXPERIMENTAL)"
+	depends on PPC_PSERIES && EXPERIMENTAL
+	help
+	  Hypervisor-assisted dump is meant to be a kdump replacement
+	  offering robustness and speed not possible without system
+	  hypervisor assistence.
+
+	  If unsure, say "N"
+
 config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
 	default y if PPC_PREP
