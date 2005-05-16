Return-Path: <tnt@246tNt.com>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.3.234]) by ozlabs.org (Postfix) with ESMTP id 73E1F679F3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 02:05:29 +1000 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j4GG5NvN010562
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 May 2005 18:05:24 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4288C4FD.8080104@246tNt.com>
Date: Mon, 16 May 2005 18:06:21 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <0.20050516_092837.tnt@patchsend.246tNt.com>
	<5fe12cfac05d60b8af016382594e50db@freescale.com>
In-Reply-To: <5fe12cfac05d60b8af016382594e50db@freescale.com>
Content-Type: multipart/mixed; boundary="------------070109070302080201010104"
Cc: Asier Llano Palacios <a.llano@usyscom.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] i2c: Race fix for i2c-mpc.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070109070302080201010104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:
> Sylvain,
> 
> Are you really still using the OCP side of the driver?  Do we need a 
> similar fix for the platform driver side?

/me hits himself with a hammer

Damn I included the wrong diff ... Sorry about that, the good one is
in attachment.


No I don't use the OCP side but I changed both to stay coherent. I don't 
experience the problem myself, it's Asier who reported it and it 
apparently mostly shows up on the second i2c bus (where I have nothing 
on my hardware and anyway my bootloader init I2C beforehand ...).

But the patch looks correct, when a bus is added, it should be ready to 
be used.


	Sylvain


---
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

--------------070109070302080201010104
Content-Type: text/x-patch;
 name="i2c-mpc-racefix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-mpc-racefix.diff"

--- linux-2.6/drivers/i2c/busses/i2c-mpc.c	2005-05-16 09:47:10.000000000 +0200
+++ linux-2.6-mpc52xx/drivers/i2c/busses/i2c-mpc.c	2005-05-16 17:50:18.000000000 +0200
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
@@ -430,6 +431,9 @@
 			goto fail_irq;
 		}
 
+	mpc_i2c_setclock(i2c);
+	dev_set_drvdata(device, i2c);
+
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
@@ -438,8 +442,6 @@
 		goto fail_add;
 	}
 
-	mpc_i2c_setclock(i2c);
-	dev_set_drvdata(device, i2c);
 	return result;
 
       fail_add:
@@ -456,8 +458,8 @@
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(device);
 
-	dev_set_drvdata(device, NULL);
 	i2c_del_adapter(&i2c->adap);
+	dev_set_drvdata(device, NULL);
 
 	if (i2c->irq != 0)
 		free_irq(i2c->irq, i2c);

--------------070109070302080201010104--
