Return-Path: <ahuja@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2523DDDE38
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 16:45:51 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1I5jmmM027182
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 00:45:49 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1I5jmBA218618
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 22:45:48 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1I5jmRH003406
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 22:45:48 -0700
Message-ID: <47B91B8B.3020004@austin.ibm.com>
Date: Sun, 17 Feb 2008 23:45:47 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>,
	Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 8/8] pseries: phyp dump: config file
References: <47B90F55.2080606@austin.ibm.com>
In-Reply-To: <47B90F55.2080606@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com
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

-----
 arch/powerpc/Kconfig |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: 2.6.25-rc1/arch/powerpc/Kconfig
===================================================================
--- 2.6.25-rc1.orig/arch/powerpc/Kconfig	2008-02-18 03:22:06.000000000 -0600
+++ 2.6.25-rc1/arch/powerpc/Kconfig	2008-02-18 03:22:45.000000000 -0600
@@ -306,6 +306,17 @@ config CRASH_DUMP
 
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
