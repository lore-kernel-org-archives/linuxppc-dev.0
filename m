Return-Path: <moilanen@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A47A67CD0
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 07:16:22 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA8KGJfE009359
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 15:16:19 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA8KGJNp261124
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 15:16:19 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA8KGFWV014578
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 15:16:16 -0500
Subject: Re: [RFC/PATCH 5/7] RTAS MSI implementation
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20061107072126.2EE7167CC6@ozlabs.org>
References: <20061107072126.2EE7167CC6@ozlabs.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 14:16:00 -0600
Message-Id: <1163016960.9913.276.camel@goblue>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-07 at 18:21 +1100, Michael Ellerman wrote:
> Powerpc MSI support via RTAS. Based on Jake's code.
> 

Missing the CAS flags to indicate to firmware that we support MSI.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

Index: git/arch/powerpc/kernel/prom_init.c
===================================================================
--- git.orig/arch/powerpc/kernel/prom_init.c
+++ git/arch/powerpc/kernel/prom_init.c
@@ -634,6 +634,12 @@ static void __init early_cmdline_parse(v
 /* ibm,dynamic-reconfiguration-memory property supported */
 #define OV5_DRCONF_MEMORY	0x20
 #define OV5_LARGE_PAGES		0x10	/* large pages supported */
+/* PCIe/MSI support. Without MSI full PCIe is not supported */
+#ifdef CONFIG_PCI_MSI
+#define OV5_MSI			0x01	/* PCIe/MSI supported */
+#else
+#define OV5_MSI			0x00
+#endif
 
 /*
  * The architecture vector has an array of PVR mask/value pairs,
@@ -677,7 +683,7 @@ static unsigned char ibm_architecture_ve
 	/* option vector 5: PAPR/OF options */
 	3 - 1,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES,
+	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_MSI,
 };
 
 /* Old method - ELF header with PT_NOTE sections */
