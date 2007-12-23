Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0F1EDDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 10:01:34 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBNN1Sss030068
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 18:01:28 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBNN1SXT501422
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 18:01:28 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBNN1RCG005718
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 18:01:28 -0500
Date: Mon, 24 Dec 2007 04:11:58 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, gregkh@suse.de
Subject: Build breakage on powerpc with 2.6.24-rc6-mm1
Message-ID: <20071223224158.GA7975@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I see the following error with the iseries_veth driver in 2.6.24-rc6-mm1

drivers/net/iseries_veth.c: In function ‘veth_init_connection’:
drivers/net/iseries_veth.c:818: warning: unused variable ‘rc’
drivers/net/iseries_veth.c: In function ‘veth_probe_one’:
drivers/net/iseries_veth.c:1086: error: ‘veth_port_ktypeq’ undeclared
(first use in this function)
drivers/net/iseries_veth.c:1086: error: (Each undeclared identifier is
reported only once
drivers/net/iseries_veth.c:1086: error: for each function it appears
in.)
make[2]: *** [drivers/net/iseries_veth.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Here's a patch, compile tested to fix the compilation problem


Remove unused variable rc and fix a typo, veth_port_type was called
veth_port_typeq

Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>
---

 drivers/net/iseries_veth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/net/iseries_veth.c~fix-iseries-veth-driver drivers/net/iseries_veth.c
--- linux-2.6.24-rc6/drivers/net/iseries_veth.c~fix-iseries-veth-driver	2007-12-24 03:59:35.000000000 +0530
+++ linux-2.6.24-rc6-balbir/drivers/net/iseries_veth.c	2007-12-24 04:02:31.000000000 +0530
@@ -815,7 +815,7 @@ static int veth_init_connection(u8 rlp)
 {
 	struct veth_lpar_connection *cnx;
 	struct veth_msg *msgs;
-	int i, rc;
+	int i;
 
 	if ( (rlp == this_lp)
 	     || ! HvLpConfig_doLpsCommunicateOnVirtualLan(this_lp, rlp) )
@@ -1083,7 +1083,7 @@ static struct net_device * __init veth_p
 		return NULL;
 	}
 
-	kobject_init(&port->kobject, &veth_port_ktypeq);
+	kobject_init(&port->kobject, &veth_port_ktype);
 	if (0 != kobject_add(&port->kobject, &dev->dev.kobj, "veth_port"))
 		veth_error("Failed adding port for %s to sysfs.\n", dev->name);
 
_

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
