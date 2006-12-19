Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6C76DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 06:02:18 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBJJ2Ecq006204
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 14:02:14 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBJJ2EeF277076
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 14:02:14 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBJJ2DMB007845
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 14:02:13 -0500
Date: Tue, 19 Dec 2006 13:02:10 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc export rtas_set_slot_reset()
Message-ID: <20061219190210.GE5506@austin.ibm.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Brian King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Paul,
A patch that provides an export for a bug being worked on the
IPR evice driver.

--linas

Export the symbol for the PCI slot reset function; this
will allow it to be called from a module. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.19-git7.orig/arch/powerpc/platforms/pseries/eeh.c	2006-12-14 14:41:48.000000000 -0600
+++ linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh.c	2006-12-15 12:01:28.000000000 -0600
@@ -626,6 +626,7 @@ int rtas_set_slot_reset(struct pci_dn *p
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(rtas_set_slot_reset);
 
 /* ------------------------------------------------------- */
 /** Save and restore of PCI BARs
