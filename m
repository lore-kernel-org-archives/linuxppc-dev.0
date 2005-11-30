Return-Path: <dwilson@dslextreme.com>
Received: from mail5.dslextreme.com (mail5.dslextreme.com [66.51.199.81])
	by ozlabs.org (Postfix) with SMTP id 799C468867
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 18:17:06 +1100 (EST)
Message-ID: <200511292318160218.0499BB92@smtp.dslextreme.com>
In-Reply-To: <Pine.LNX.4.44.0511300013110.32230-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0511300013110.32230-100000@gate.crashing.org>
Date: Tue, 29 Nov 2005 23:18:16 -0800
From: "Dan Wilson" <dwilson@dslextreme.com>
To: "Kumar Gala" <galak@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx i2c interface bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/30/2005 at 12:14 AM Kumar Gala wrote:

> Dan,
> 
> Did you see an issue this change fixed?  If so can you provide more 
> details.  Also, can you provide your diff as a unified diff (diff -u) so 
> its easier to see where the changes where.
> 
> I'm trying to figure out if the same issue exists in the 2.6 driver (and 
> if so, why we havent seen it)
> 
> thanks
> 
> - kumar
> 

Yes, there was an issue that this change fixed.  Our I2C bus has a number=
 of devices on it.  The first device is at address 0x2c, and is an Analog=
 Device AD5173BRM50 software programmable 50K ohm resistor.  We connected a=
 logic analyzer to the device and watched the bus activity as linux booted=
 and the i2c bus scan took place.  During this scan, the 8541 attempts to=
 address each device and then read a byte from the device.  With the=
 original code, the 8541 would reply to the byte read by sending a zero as=
 the TXACK bit, which instructed the 5173 to send an additional byte, but=
 the 8541 didn't attempt to retrieve that byte, since it was already moving=
 on, trying to stop the bus and go on to the next device.  The 5173=
 appeared to not be able to see the stop command since it had received a=
 command to transmit the next byte.  The bus didn't seem to ever recover=
 from this: if we allowed linux to complete it's boot and then told it to=
 reboot, the u-boot code was no longer able to identify and configure the=
 SDRAM, since it is also connected to the now non-functional I2C.  With the=
 new code, linux correctly identifies all of the devices on the I2C, boots=
 quickly and cleanly, and after a reboot the u-boot code has no problem=
 coming up again.

Here is the diff -u that you requested:

@@ -299,11 +299,11 @@

        if(pm->flags & I2C_M_RD) {
                /* Change to read mode */
-               priv->write(&regs->i2ccr, 0, MPC_I2CCR_MTX);
+               priv->write(&regs->i2ccr, 0, MPC_I2CCR_MTX |=
 MPC_I2CCR_TXAK);

                /* If there is only one byte, we need to TXAK now */
                if(len =3D=3D 1)
-                       priv->write(&regs->i2ccr, 0, MPC_I2CCR_TXAK);
+                       priv->write(&regs->i2ccr, MPC_I2CCR_TXAK,=
 MPC_I2CCR_TXAK);

                /* Do a dummy read, to initiate the first read */
                priv->read(&regs->i2cdr);
@@ -321,7 +321,7 @@
                        /* If this is the 2nd to last byte, send
                         * the TXAK signal */
                        if(i =3D=3D len - 2) {
-                               priv->write(&regs->i2ccr, 0,=
 MPC_I2CCR_TXAK);
+                               priv->write(&regs->i2ccr, MPC_I2CCR_TXAK,=
 MPC_I2CCR_TXAK);
                        }

                        /* If this is the last byte, send STOP */
@@ -383,7 +383,6 @@
        priv->write(&regs->i2csr, 0, MPC_I2CSR_MIF);

        mpc_i2c_start(priv);
-
        /* Send each message, chaining them together with repeat STARTs */
        for(i =3D 0; i < num && !err; ++i) {
                err =3D mpc_doAddress(priv, &msgs[i]);


Hope this helps,

Dan.
