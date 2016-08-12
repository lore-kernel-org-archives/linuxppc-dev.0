Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9jkx4315zDr1l
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 21:46:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH] powerpc/prom: Fix sub-processor option passed to ibm,
 client-architecture-support
Date: Fri, 12 Aug 2016 21:45:52 +1000
Message-Id: <1471002352-19094-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When booting from an OpenFirmware which supports it, we use the
"ibm,client-architecture-support" firmware call to communicate
our capabilities to firmware.

The format of the structure we pass to firmware is specified in
PAPR (Power Architecture Platform Requirements), or the public version
LoPAPR (Linux on Power Architecture Platform Reference).

Referring to table 244 in LoPAPR v1.1, option vector 5 contains a 4 byte
field at bytes 17-20 for the "Platform Facilities Enable". This is
followed by a 1 byte field at byte 21 for "Sub-Processor Represenation
Level".

Comparing to the code, there we have the Platform Facilities
options (OV5_PFO_*) at byte 17, but we fail to pad that field out to its
full width of 4 bytes. This means the OV5_SUB_PROCESSORS option is
incorrectly placed at byte 18.

Fix it by adding zero bytes for bytes 18, 19, 20, and comment the bytes
to hopefully make it clearer in future.

As far as I'm aware nothing actually consumes this value at this time,
so the effect of this bug is nil in practice.

It does mean we've been incorrectly setting bit 15 of the "Platform
Facilities Enable" option for the past ~3 1/2 years, so we should avoid
allocating that bit to anything else in future.

Fixes: df77c7992029 ("powerpc/pseries: Update ibm,architecture.vec for PAPR 2.7/POWER8")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6ee4b72cda42..e97925ffa6c7 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -695,7 +695,7 @@ unsigned char ibm_architecture_vec[] = {
 	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
 
 	/* option vector 5: PAPR/OF options */
-	VECTOR_LENGTH(18),		/* length */
+	VECTOR_LENGTH(21),		/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
 	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
@@ -726,8 +726,11 @@ unsigned char ibm_architecture_vec[] = {
 	0,
 	0,
 	OV5_FEAT(OV5_PFO_HW_RNG) | OV5_FEAT(OV5_PFO_HW_ENCR) |
-	OV5_FEAT(OV5_PFO_HW_842),
-	OV5_FEAT(OV5_SUB_PROCESSORS),
+	OV5_FEAT(OV5_PFO_HW_842),				/* Byte 17 */
+	0,							/* Byte 18 */
+	0,							/* Byte 19 */
+	0,							/* Byte 20 */
+	OV5_FEAT(OV5_SUB_PROCESSORS),				/* Byte 21 */
 
 	/* option vector 6: IBM PAPR hints */
 	VECTOR_LENGTH(3),		/* length */
-- 
2.7.4
