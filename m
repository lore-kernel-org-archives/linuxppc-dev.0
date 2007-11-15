Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 706BCDDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 05:56:46 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAFIuOhI030507
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:56:24 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAFIuOXw112722
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:56:24 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAFIuN1E003610
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:56:23 -0500
Date: Thu, 15 Nov 2007 12:56:23 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3 v2] powerpc: EEH: work with device endpoint, always
Message-ID: <20071115185623.GA24772@austin.ibm.com>
References: <20071115185420.GF18745@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071115185420.GF18745@austin.ibm.com>
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
version 2: I still can't get whitespace right the first time ...

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
+	dn = find_device_pe(dn);
 	pdn = PCI_DN(dn);
 
 	/* Access to IO BARs might get this far and still not want checking. */
