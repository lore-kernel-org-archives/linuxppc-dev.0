Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.3.52]) by ozlabs.org (Postfix) with ESMTP id B54BE679FE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 17:27:47 +1000 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j4G7RdKE004500
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 May 2005 09:27:42 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <0.20050516_092837.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Date: Mon, 16 May 2005 08:24:29 +0200 (CEST)
Cc: Sylvain Munaut <tnt@246tNt.com>, Asier Llano Palacios <a.llano@usyscom.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] i2c: Race fix for i2c-mpc.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

i2c: Race fix for i2c-mpc.c

The problem was that the clock speed and driver data is
initialized after the i2c adapter was added. This caused
the i2c bus to start working at a wrong speed. (Mostly
noticable on the second bus on mpc5200)

With this patch we've tried to keep the i2c adapter
working perfectly all the time it is included in the system.
Initialize before added, Remove garbage after deleleted. 


Submitted-by: Asier Llano Palacios
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
--- linux-2.6/drivers/i2c/busses/i2c-mpc.c	2005-05-16 09:08:02.000000000 +0200
+++ linux-2.6/drivers/i2c/busses/i2c-mpc.c	2005-05-16 09:09:51.000000000 +0200
@@ -333,6 +333,9 @@
 	} else
 		i2c->irq = 0;
 
+	mpc_i2c_setclock(i2c);
+	ocp_set_drvdata(ocp, i2c);
+
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 
@@ -341,8 +344,6 @@
 		goto fail_add;
 	}
 
-	mpc_i2c_setclock(i2c);
-	ocp_set_drvdata(ocp, i2c);
 	return result;
 
       fail_add:
@@ -358,8 +359,8 @@
 static void __devexit mpc_i2c_remove(struct ocp_device *ocp)
 {
 	struct mpc_i2c *i2c = ocp_get_drvdata(ocp);
-	ocp_set_drvdata(ocp, NULL);
 	i2c_del_adapter(&i2c->adap);
+	ocp_set_drvdata(ocp, NULL);
 
 	if (ocp->def->irq != OCP_IRQ_NA)
 		free_irq(i2c->irq, i2c);
