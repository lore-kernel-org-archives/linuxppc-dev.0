Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6891B2C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 04:20:17 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 04:02:18 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E8B652CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 04:19:43 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r84I3KcT46792948
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 04:03:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r84IJhTu028301
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 04:19:43 +1000
Date: Wed, 4 Sep 2013 23:49:36 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: default arch idle could cede processor on pseries
Message-ID: <20130904181936.GA22956@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Idle routines on pseries were rearranged so that cpuidle can do
an optimized idle state selection.  However, until cpuidle takes
over during boot, the idle loop spins for a short while.  This
actually affected bootup time since spinning idle sibling threads
slows down master cpu that executes bootup code.

The following patch enables pseries system to yield to hypervisor and
stop spinning by calling cede_processor() until cpuidle can take over
and do optimal idle state selection.

Bootup time can be reduced to half on small guest where most of the
time is spend before device init.

--Vaidy


    powerpc: default arch idle should cede processor on pseries

    On IBM POWER platform (pseries), use cede_processor()
    in arch idle to save cycles until cpuidle takes over.

    This helps speedup boot by having SMT threads stop and yield to
    master thread rather than spinning until cpuidle in initialized.

    Reported-by: Paul Mackerras <paulus@samba.org>
    Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
    Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index c11c823..fd4f995 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -362,10 +362,22 @@ static void pSeries_idle(void)
 	if (cpuidle_idle_call()) {
 		/* On error, execute default handler
 		 * to go into low thread priority and possibly
-		 * low power mode.
+		 * low power mode by ceding processor to hypervisor
 		 */
-		HMT_low();
-		HMT_very_low();
+
+		/* Indicate to hypervisor that we are idle. */
+		get_lppaca()->idle = 1;
+
+		/*
+		 * Yield the processor to the hypervisor.  We return if
+		 * an external interrupt occurs (which are driven prior
+		 * to returning here) or if a prod occurs from another
+		 * processor. When returning here, external interrupts
+		 * are enabled.
+		 */
+		cede_processor();
+
+		get_lppaca()->idle = 0;
 	}
 }
 
