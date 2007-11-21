Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB8F0DDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 09:39:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALMdLjF010076
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 17:39:21 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALMdLlv062798
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:39:21 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALMdKsr018082
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:39:21 -0700
Date: Wed, 21 Nov 2007 16:39:20 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC 2/6]: phyp dump: config file
Message-ID: <20071121223920.GB26122@austin.ibm.com>
References: <20071121223639.GB4374@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071121223639.GB4374@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: mahuja@us.ibm.com, lkessler@us.ibm.com, strosake@us.ibm.com,
	mahuja@austin.ibm.com
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
