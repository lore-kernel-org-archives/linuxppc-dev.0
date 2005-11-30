Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3846D68850
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 17:17:53 +1100 (EST)
Date: Wed, 30 Nov 2005 00:14:34 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: dwilson@dslextreme.com
In-Reply-To: <23fdca41e44a84e4a32634a.20051129124254.qjvyfba@www.dslextreme.com>
Message-ID: <Pine.LNX.4.44.0511300013110.32230-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Dan,

Did you see an issue this change fixed?  If so can you provide more 
details.  Also, can you provide your diff as a unified diff (diff -u) so 
its easier to see where the changes where.

I'm trying to figure out if the same issue exists in the 2.6 driver (and 
if so, why we havent seen it)

thanks

- kumar

On Tue, 29 Nov 2005 dwilson@dslextreme.com wrote:

> We have found a problem in the i2c-mpc.c file (linux 2.4 kernel).  The
> logic for the i2c transfer termination seems to have been inverted.
> 
> The original function is:
> 
> /* Perform one i2c_msg transfer.  It could be a read, or a write.
>  * This function assumes that the address byte has been sent
>  * already, and only handles the message contents */
> static int mpc_i2c_xfer_bytes(struct mpc_i2c_private* priv, struct
> i2c_msg* pm)
> {
> 	volatile struct mpc_i2c *regs = priv->regs;
> 	char *buf = pm->buf;
> 	int len = pm->len;
> 	int i;
> 	int ret = 0;
> 
> 	if(pm->flags & I2C_M_RD) {
> 		/* Change to read mode */
> 		priv->write(&regs->i2ccr, 0, MPC_I2CCR_MTX);
> 
> 		/* If there is only one byte, we need to TXAK now */
> 		if(len == 1)
> 			priv->write(&regs->i2ccr, 0, MPC_I2CCR_TXAK);
> 
> 		/* Do a dummy read, to initiate the first read */
> 		priv->read(&regs->i2cdr);
> 	}
> 
> 	for(i = 0; i < len; ++i) {
> 		/* If this is a read, read a byte, otherwise, write a byte */
> 		if(pm->flags & I2C_M_RD) {
> 			/* Wait for the previous read to finish */
> 			ret = wait_for_txcomplete(priv);
> 
> 			if (ret)
> 				return ret;
> 
> 			/* If this is the 2nd to last byte, send
> 			 * the TXAK signal */
> 			if(i == len - 2) {
> 				priv->write(&regs->i2ccr, 0, MPC_I2CCR_TXAK);
> 			}
> 
> 			/* If this is the last byte, send STOP */
> 			if (i == len - 1)
> 				mpc_i2c_stop(priv);
> 
> 			buf[i] = priv->read(&regs->i2cdr);
> 
> 		} else {
> 			/* Otherwise, it's a write */
> 			priv->write(&regs->i2cdr, buf[i], MPC_I2C_FULLREG);
> 
> 			/* Wait for the transaction to complete */
> 			ret = wait_for_txcomplete(priv);
> 
> 			if(ret)
> 				return ret;
> 
> 			/* Return error if we didn't get the ack */
> 			if((priv->read(&regs->i2csr) & MPC_I2CSR_RXAK)) {
> 				printk(KERN_DEBUG "NO ACK!\n");
> 				ret = -EREMOTEIO;
> 			}
> 		}
> 
> 		/* If there was an error, abort */
> 		if(ret)
> 			return ret;
> 	}
> 
> 	return ret;
> }
> 
> The problem is that the TXAK bit is set incorrectly: it should be set to a
> zero when acks are to be sent and then set to a 1 just before reading the
> next-to-last byte in the transfer (8555 Processor Reference Manual
> (MPC8555ERM rev1), section 11.3.1.3 and also Figure 11-8).
> 
> Changes to the above code are thus:
> 
> 302c302
> <               priv->write(&regs->i2ccr, 0, MPC_I2CCR_MTX);
> ---
> >               priv->write(&regs->i2ccr, 0, MPC_I2CCR_MTX | MPC_I2CCR_TXAK);
> 306c306
> <                       priv->write(&regs->i2ccr, 0, MPC_I2CCR_TXAK);
> ---
> >                       priv->write(&regs->i2ccr, MPC_I2CCR_TXAK,
> MPC_I2CCR_TXAK);
> 324c324
> <                               priv->write(&regs->i2ccr, 0, MPC_I2CCR_TXAK);
> ---
> >                               priv->write(&regs->i2ccr, MPC_I2CCR_TXAK,
> MPC_I2CCR_TXAK);
> 
> Thanks,
> 
> Dan.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
