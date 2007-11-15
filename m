Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2393DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 05:55:02 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAFIsu5a012450
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:54:56 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lAFIsn2N069300
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 11:54:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAFIsmkj015397
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 11:54:49 -0700
Date: Thu, 15 Nov 2007 12:54:20 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] powerpc: EEH: work with device endpoint, always
Message-ID: <20071115185420.GF18745@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: munsone@us.ibm.com, linuxppc-dev@ozlabs.org,
	Sandra Rhodes <sdrhodes@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Perform all error checking at the "partitonable endpoint" 
of the device.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
----
 arch/powerpc/platforms/pseries/eeh.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/platforms/pseries/eeh.c	2007-11-09 16:54:04.000000000 -0600
+++ linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh.c	2007-11-09 16:56:39.000000000 -0600
@@ -482,6 +482,7 @@ int eeh_dn_check_failure(struct device_n
 		no_dn++;
 		return 0;
 	}
+	dn = find_device_pe (dn);
 	pdn = PCI_DN(dn);
 
 	/* Access to IO BARs might get this far and still not want checking. */
