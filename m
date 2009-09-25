Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F17EB7B9B
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 23:31:47 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8PDT46X008338
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 23:29:04 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8PDTaH91712328
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 23:29:36 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8PDViFu012280
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 23:31:45 +1000
Date: Fri, 25 Sep 2009 19:01:43 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: 20090925 - hvc driver build breaks with !HVC_CONSOLE
Message-ID: <20090925133143.GD6831@linux.vnet.ibm.com>
References: <20090925133830.1ba29584.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090925133830.1ba29584.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

	next-20090925 randconfig build breaks on hvcs driver on powerpc,
with HVC_CONSOLE=n.

ERROR: ".hvc_put_chars" [drivers/char/hvcs.ko] undefined!
ERROR: ".hvc_get_chars" [drivers/char/hvcs.ko] undefined!

adding the dependency of HVC_CONSOLE helped

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
 drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a2a0e67..2583231 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -682,7 +682,7 @@ config VIRTIO_CONSOLE
 
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
-	depends on PPC_PSERIES
+	depends on PPC_PSERIES && HVC_CONSOLE
 	help
 	  Partitionable IBM Power5 ppc64 machines allow hosting of
 	  firmware virtual consoles from one Linux partition by
			
			Kamalesh
