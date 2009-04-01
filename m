Return-Path: <sachinp@in.ibm.com>
Message-ID: <49D3419E.7000005@in.ibm.com>
Date: Wed, 01 Apr 2009 15:57:42 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [Patch next] powerpc: pseries/dtl.c should include asm/firmware.h
References: <20090401164450.f8192631.sfr@canb.auug.org.au>
In-Reply-To: <20090401164450.f8192631.sfr@canb.auug.org.au>
Content-Type: multipart/mixed; boundary="------------050404090408000502010008"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050404090408000502010008
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

randconfig build on powerpc failed with :


arch/powerpc/platforms/pseries/dtl.c: In function ‘dtl_init’:
arch/powerpc/platforms/pseries/dtl.c:238: error: implicit declaration of function ‘firmware_has_feature’
arch/powerpc/platforms/pseries/dtl.c:238: error: ‘FW_FEATURE_SPLPAR’ undeclared (first use in this function)
arch/powerpc/platforms/pseries/dtl.c:238: error: (Each undeclared identifier is reported only once
arch/powerpc/platforms/pseries/dtl.c:238: error: for each function it appears in.)

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---



--------------050404090408000502010008
Content-Type: text/x-patch;
 name="fix-dtl-build-break.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="fix-dtl-build-break.patch"

* Fixes the following build error
*
* arch/powerpc/platforms/pseries/dtl.c: In function â€˜dtl_initâ€™:
* arch/powerpc/platforms/pseries/dtl.c:238:
*       error: implicit declaration of function â€˜firmware_has_featureâ€™
* arch/powerpc/platforms/pseries/dtl.c:238:
*       error: â€˜FW_FEATURE_SPLPARâ€™ undeclared (first use in this function)
* arch/powerpc/platforms/pseries/dtl.c:238:
*        error: (Each undeclared identifier is reported only once
* arch/powerpc/platforms/pseries/dtl.c:238: 
*        error: for each function it appears in.)

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
--- a/arch/powerpc/platforms/pseries/dtl.c	2009-04-01 15:46:59.000000000 +0530
+++ b/arch/powerpc/platforms/pseries/dtl.c	2009-04-01 15:47:58.000000000 +0530
@@ -25,6 +25,7 @@
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/firmware.h>
 
 #include "plpar_wrappers.h"
 

--------------050404090408000502010008--
