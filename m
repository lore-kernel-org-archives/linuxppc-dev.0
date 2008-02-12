Return-Path: <ahuja@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 493B0DDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 18:21:40 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1C7LbSJ019608
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 02:21:37 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1C7Lbm71072478
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 02:21:37 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1C7Lbsi008554
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 02:21:37 -0500
Message-ID: <47B148FF.2000900@austin.ibm.com>
Date: Tue, 12 Feb 2008 01:21:35 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH 8/8] pseries: phyp dump: config file
References: <4782B985.2090508@austin.ibm.com> <47B13D2E.1070001@austin.ibm.com>
In-Reply-To: <47B13D2E.1070001@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
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

Index: 2.6.24-rc5/arch/powerpc/Kconfig
===================================================================
--- 2.6.24-rc5.orig/arch/powerpc/Kconfig	2008-02-12 06:12:08.000000000 -0600
+++ 2.6.24-rc5/arch/powerpc/Kconfig	2008-02-12 06:13:24.000000000 -0600
@@ -266,6 +266,17 @@ config CRASH_DUMP
 
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
