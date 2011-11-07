Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1ABD7100D8A
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2011 20:56:34 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by e28smtp03.in.ibm.com (8.14.4/8.13.1) with ESMTP id pA79uWVr023704
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:26:32 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA79uVBX815268
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:26:31 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA79uVgI004530
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 20:56:31 +1100
Subject: [RFC PATCH v4 10/10] fadump: Introduce config option for firmware
 assisted dump feature
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 07 Nov 2011 15:26:30 +0530
Message-ID: <20111107095630.1997.54984.stgit@mars.in.ibm.com>
In-Reply-To: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
References: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Amerigo Wang <amwang@redhat.com>, Milton Miller <miltonm@bga.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch introduces a new config option CONFIG_FA_DUMP for firmware
assisted dump feature on Powerpc (ppc64) architecture.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6926b61..7ce773c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -379,6 +379,19 @@ config PHYP_DUMP
 
 	  If unsure, say "N"
 
+config FA_DUMP
+	bool "Firmware-assisted dump"
+	depends on PPC64 && PPC_RTAS && CRASH_DUMP
+	help
+	  A robust mechanism to get reliable kernel crash dump with
+	  assistance from firmware. This approach does not use kexec,
+	  instead firmware assists in booting the kdump kernel
+	  while preserving memory contents. Firmware-assisted dump
+	  is meant to be a kdump replacement offering robustness and
+	  speed not possible without system firmware assistance.
+
+	  If unsure, say "N"
+
 config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
 	default y if PPC_PREP
