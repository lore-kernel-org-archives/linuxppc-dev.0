Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BFB06DDF9F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:56:47 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l2JJt3Dp025297
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:55:03 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJuiCc059178
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:56:44 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJuiXh029063
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:56:44 -0600
Date: Mon, 19 Mar 2007 14:56:43 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/11] ppc64: EEH: handle reset state high
Message-ID: <20070319195643.GG11532@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319194349.GT5151@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Subject: [PATCH 7/11] ppc64: EEH: handle reset state high

Some firmware versions will return a slot reset state of "1"
when a slot is EEH frozen. Recognize this as a state that can be
handled.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:21.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:43.000000000 -0500
@@ -386,7 +386,7 @@ int eeh_dn_check_failure(struct device_n
 	}
 
 	/* If not the kind of error we know about, punt. */
-	if (rets[0] != 2 && rets[0] != 4 && rets[0] != 5) {
+	if (rets[0] != 1 && rets[0] != 2 && rets[0] != 4 && rets[0] != 5) {
 		false_positives++;
 		rc = 0;
 		goto dn_unlock;
@@ -401,7 +401,7 @@ int eeh_dn_check_failure(struct device_n
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 
 	state = pci_channel_io_normal;
-	if ((rets[0] == 2) || (rets[0] == 4))
+	if ((rets[0] == 1) || (rets[0] == 2) || (rets[0] == 4))
 		state = pci_channel_io_frozen;
 	if (rets[0] == 5)
 		state = pci_channel_io_perm_failure;
@@ -410,7 +410,7 @@ int eeh_dn_check_failure(struct device_n
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out. */
-	if (rets[0] != 5) dump_stack();
+	dump_stack();
 	return 1;
 
 dn_unlock:
