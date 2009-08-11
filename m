Return-Path: <bastian@waldi.eu.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2FEACB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 19:50:36 +1000 (EST)
Received: from wavehammer.waldi.eu.org (wavehammer.waldi.eu.org
	[82.139.201.20]) by ozlabs.org (Postfix) with ESMTP id 9A292DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 19:50:35 +1000 (EST)
Date: Tue, 11 Aug 2009 11:39:31 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Disable PowerMac cpufreq on SMP kernels
Message-ID: <20090811093931.GA15940@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The build of a PowerMac 32bit kernel currently fails with

error: #warning "WARNING, CPUFREQ not recommended on SMP kernels"

This patch just disables this driver on SMP kernels, as it is obviously
not supported.

Signed-off-by: Bastian Blank <waldi@debian.org>

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 04a8061..99d3564 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -149,7 +149,7 @@ menu "CPU Frequency drivers"
 
 config CPU_FREQ_PMAC
 	bool "Support for Apple PowerBooks"
-	depends on ADB_PMU && PPC32
+	depends on ADB_PMU && PPC32 && !SMP
 	select CPU_FREQ_TABLE
 	help
 	  This adds support for frequency switching on Apple PowerBooks,
