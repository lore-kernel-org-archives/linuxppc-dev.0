Return-Path: <markn@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A298DB7D30
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 May 2010 17:36:26 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4R7X1iB010399
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 17:33:01 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R7aPK41798176
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 17:36:25 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R7aPLP010035
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 17:36:25 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o4R7aPPn010028
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 17:36:25 +1000
Received: from ubrain.localnet (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id 43ED473673
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 May 2010 17:36:25 +1000 (EST)
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Rename RAS_VECTOR_OFFSET to
	RTAS_VECTOR_EXTERNAL_INTERRUPT and move to rtas.h
Date: Thu, 27 May 2010 17:40:39 +1000
MIME-Version: 1.0
Message-Id: <201005271740.39993.markn@au1.ibm.com>
Content-Type: Text/Plain;
  charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RAS code has a #define, RAS_VECTOR_OFFSET, that's used in the
check-exception RTAS call for the vector offset of the exception.

We'll be using this same vector offset for the upcoming IO Event interrupts
code (0x500) so let's move it to include/asm/rtas.h and call it
RTAS_VECTOR_EXTERNAL_INTERRUPT.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/include/asm/rtas.h      |    3 +++
 arch/powerpc/platforms/pseries/ras.c |    5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: upstream/arch/powerpc/include/asm/rtas.h
===================================================================
--- upstream.orig/arch/powerpc/include/asm/rtas.h
+++ upstream/arch/powerpc/include/asm/rtas.h
@@ -137,6 +137,9 @@ struct rtas_t {
 #define RTAS_TYPE_PMGM_CONFIG_CHANGE	0x70
 #define RTAS_TYPE_PMGM_SERVICE_PROC	0x71
 
+/* RTAS check-exception vector offset */
+#define RTAS_VECTOR_EXTERNAL_INTERRUPT	0x500
+
 struct rtas_error_log {
 	unsigned long version:8;		/* Architectural version */
 	unsigned long severity:3;		/* Severity level of error */
Index: upstream/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/ras.c
+++ upstream/arch/powerpc/platforms/pseries/ras.c
@@ -61,7 +61,6 @@ static int ras_check_exception_token;
 
 #define EPOW_SENSOR_TOKEN	9
 #define EPOW_SENSOR_INDEX	0
-#define RAS_VECTOR_OFFSET	0x500
 
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
@@ -121,7 +120,7 @@ static irqreturn_t ras_epow_interrupt(in
 	spin_lock(&ras_log_buf_lock);
 
 	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
-			   RAS_VECTOR_OFFSET,
+			   RTAS_VECTOR_EXTERNAL_INTERRUPT,
 			   irq_map[irq].hwirq,
 			   RTAS_EPOW_WARNING | RTAS_POWERMGM_EVENTS,
 			   critical, __pa(&ras_log_buf),
@@ -156,7 +155,7 @@ static irqreturn_t ras_error_interrupt(i
 	spin_lock(&ras_log_buf_lock);
 
 	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
-			   RAS_VECTOR_OFFSET,
+			   RTAS_VECTOR_EXTERNAL_INTERRUPT,
 			   irq_map[irq].hwirq,
 			   RTAS_INTERNAL_ERROR, 1 /*Time Critical */,
 			   __pa(&ras_log_buf),
