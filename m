Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 7EEBCDDE29
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 15:07:23 +1100 (EST)
Message-ID: <47B66179.9010501@pikatech.com>
Date: Fri, 15 Feb 2008 23:07:21 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/2] i2c-ibm_iic driver
References: <4784FED1.2040206@pikatech.com><47A14E23.50807@pikatech.com>
	<20080214094516.1b958ae4@hyperion.delvare>
In-Reply-To: <20080214094516.1b958ae4@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare wrote:
> Please split your patch into logical parts:
> * Whitespace and coding-style cleanups
> * Other cleanups (e.g. changing the log levels)
> * Add OF support
>   
Here is the first patch with everything except the OF support. Really 
all I did was change the log levels based on feedback from linxppc-dev.

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 7c7eb0c..a981a17 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -650,7 +650,7 @@ static inline u8 iic_clckdiv(unsigned int opb)
 	opb /= 1000000;
 
 	if (opb < 20 || opb > 150){
-		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
+		printk(KERN_WARNING "ibm-iic: invalid OPB clock frequency %u MHz\n",
 			opb);
 		opb = opb < 20 ? 20 : 150;
 	}
@@ -672,7 +672,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 			ocp->def->index);
 
 	if (!(dev = kzalloc(sizeof(*dev), GFP_KERNEL))) {
-		printk(KERN_CRIT "ibm-iic%d: failed to allocate device data\n",
+		printk(KERN_ERR "ibm-iic%d: failed to allocate device data\n",
 			ocp->def->index);
 		return -ENOMEM;
 	}
@@ -687,7 +687,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 	}
 
 	if (!(dev->vaddr = ioremap(ocp->def->paddr, sizeof(struct iic_regs)))){
-		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
+		printk(KERN_ERR "ibm-iic%d: failed to ioremap device registers\n",
 			dev->idx);
 		ret = -ENXIO;
 		goto fail2;
@@ -745,7 +745,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 	adap->nr = dev->idx >= 0 ? dev->idx : 0;
 
 	if ((ret = i2c_add_numbered_adapter(adap)) < 0) {
-		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
+		printk(KERN_ERR "ibm-iic%d: failed to register i2c adapter\n",
 			dev->idx);
 		goto fail;
 	}
@@ -778,7 +778,7 @@ static void __devexit iic_remove(struct ocp_device *ocp)
 	struct ibm_iic_private* dev = (struct ibm_iic_private*)ocp_get_drvdata(ocp);
 	BUG_ON(dev == NULL);
 	if (i2c_del_adapter(&dev->adap)){
-		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
+		printk(KERN_ERR "ibm-iic%d: failed to delete i2c adapter :(\n",
 			dev->idx);
 		/* That's *very* bad, just shutdown IRQ ... */
 		if (dev->irq >= 0){
