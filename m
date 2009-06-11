Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C1822B7234
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 14:32:24 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21B09DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 14:32:23 +1000 (EST)
Message-Id: <8AFD68DF-26DE-4A68-88AC-C73A076B23AF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Fredrik Arnerup <fredrik.arnerup@edgeware.tv>
In-Reply-To: <738D541FBC1741A18DB4F3CB466DF78A@edgeware.tv>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: MPC85xx erratum "I2C1 - I2C controller is unable to generate
	clocks when SDA is low coming out of reset"
Date: Wed, 10 Jun 2009 23:32:13 -0500
References: <738D541FBC1741A18DB4F3CB466DF78A@edgeware.tv>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 26, 2009, at 3:22 AM, Fredrik Arnerup wrote:

> We've had some trouble with I2C not working after a soft reboot,
> which we think is due to the the erratum "I2C1" which is present in
> at least the mpc8540 and the mpc8560. Since there is no good  
> workaround,
> the only choice seems to be to avoid resetting the CPU while the I2C  
> bus is
> busy.
>
> The problem seems to be that the i2c-mpc driver leaves I2C in a busy  
> state
> when
> it receives a signal (e.g. upon shutdown).
> The code below is not meant as a patch, just me thinking aloud.
> Thoughts?
>
> /Fredrik Arnerup
> fredrik.arnerup@edgeware.tv
>
> Index: drivers/i2c/busses/i2c-mpc.c
> ===================================================================
> --- drivers/i2c/busses/i2c-mpc.c        (revision 6933)
> +++ drivers/i2c/busses/i2c-mpc.c        (working copy)
> @@ -262,12 +262,14 @@
>        /* Allow bus up to 1s to become not busy */
>        while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
>                if (signal_pending(current)) {
> -                       pr_debug("I2C: Interrupted\n");
> -                       writeccr(i2c, 0);
> +                       printk(KERN_WARNING "I2C: Interrupted\n");
> +                       if (readb(i2c->base + MPC_I2C_SR) ==
> +                           (CSR_MCF | CSR_MBB | CSR_RXAK))
> +                               mpc_i2c_fixup(i2c);
>                        return -EINTR;
>                }
>                if (time_after(jiffies, orig_jiffies + HZ)) {
> -                       pr_debug("I2C: timeout\n");
> +                       printk(KERN_WARNING "I2C: mpc_xfer() timeout 
> \n");
>                        if (readb(i2c->base + MPC_I2C_SR) ==
>                            (CSR_MCF | CSR_MBB | CSR_RXAK))
>                                mpc_i2c_fixup(i2c);


I don't think we should have the printk's.  Its possible that we hit  
the interrupted condition while using the i2c from user space.

- k
