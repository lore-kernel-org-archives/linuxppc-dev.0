Return-Path: <rcjenn@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 356E8DE3F1
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 01:36:54 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7IFa4cU024666
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 11:36:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7IFYlD52023532
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 11:34:47 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7IFYkGg009430
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 09:34:46 -0600
Date: Mon, 18 Aug 2008 10:34:46 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Improve message for vio bus entitlement panic
Message-ID: <20080818153446.GB27342@austin.ibm.com>
References: <20080815191205.GE20629@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080815191205.GE20629@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add information regarding the available and required entitlement amounts
to the message displayed for the panic when insufficient entitlement is
provided at boot.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
I had typed "Submitted-by" instead of "Signed-off-by" previously.
---
 arch/powerpc/kernel/vio.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/arch/powerpc/kernel/vio.c
===================================================================
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -899,7 +899,9 @@ static void vio_cmo_bus_init(void)
 	if (vio_cmo.reserve.size > vio_cmo.entitled) {
 		printk(KERN_ERR "%s: insufficient system entitlement\n",
 		       __func__);
-		panic("%s: Insufficient system entitlement", __func__);
+		panic("%s: Insufficient system entitlement. Available: %lu "
+		      "Required: %lu", __func__, vio_cmo.entitled,
+		      vio_cmo.reserve.size);
 	}

 	/* Set the remaining accounting variables */
