Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AA64DDF91
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:55:14 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JJtw32007199
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:55:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJtA5Q309804
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:55:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJtAMo004904
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:55:10 -0400
Date: Mon, 19 Mar 2007 14:55:10 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/11] ppc64: EEH: hotplug recovery bugfix
Message-ID: <20070319195510.GE11532@austin.ibm.com>
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



If a device driver does not have native PCI error recovery,
a hotplug error recovery will be attemped. In this case,
the device driver will not report back whether its healthy 
or not; simply assume that it is.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:19:28.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:21:06.000000000 -0500
@@ -438,7 +438,8 @@ struct pci_dn * handle_eeh_events (struc
 	}
 
 	/* All devices should claim they have recovered by now. */
-	if (result != PCI_ERS_RESULT_RECOVERED) {
+	if ((result != PCI_ERS_RESULT_RECOVERED) &&
+	    (result != PCI_ERS_RESULT_NONE)) {
 		printk(KERN_WARNING "EEH: Not recovered\n");
 		goto hard_fail;
 	}
