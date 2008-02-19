Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 3688CDDF69
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 02:09:16 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so2184866anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 07:09:15 -0800 (PST)
Message-ID: <fa686aa40802190709l7bf6735ak124651ad54789c14@mail.gmail.com>
Date: Tue, 19 Feb 2008 08:09:15 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: EricDuj <eric.dujardin@sagem.com>
Subject: Re: [PATCH] fix 2.6.25-rc2 compilation with CONFIG_SPI_MPC52xx_PSC
In-Reply-To: <15560559.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <15560559.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org, Rigby John-R61273 <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 19, 2008 7:46 AM, EricDuj <eric.dujardin@sagem.com> wrote:
>
> Hi all,
>
> I am trying to cross compile the vanilla 2.6.25-rc2 kernel with the Denx 4.1
> toolchain (gcc-4.0.0 based).
> The build fails with the following error when CONFIG_SPI_MPC52xx_PSC is set:
>
>   CC      drivers/spi/spi.o
>   LD      drivers/spi/built-in.o
>   CC [M]  drivers/spi/mpc52xx_psc_spi.o
> drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_transfer_rxtx':
> drivers/spi/mpc52xx_psc_spi.c:193: error: 'struct mpc52xx_psc' has no member
> named 'rfalarm'
> drivers/spi/mpc52xx_psc_spi.c:197: error: 'struct mpc52xx_psc' has no member
> named 'rfnum'
> drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_port_config':
> drivers/spi/mpc52xx_psc_spi.c:349: error: 'struct mpc52xx_psc' has no member
> named 'rfcntl'
> make[2]: *** [drivers/spi/mpc52xx_psc_spi.o] Erreur 1
> make[1]: *** [drivers/spi] Erreur 2
> make: *** [drivers] Erreur 2
>
>
> A quick look at the code shows  a mismatch between mpc52xx_psc.c and
> mpc52xx_psc_spi.c.
> Assuming mpc52xx_psc.c is right, here's my take at a patch (not tested on
> real hardware,
> needs review !). At least it fixes the build.

Yes, your right.  There were changes made to the psc structures to
support the 5121 but as you've discovered they didn't get propagated
to the spi driver.  Your patch is close, but I need to look at it a
bit deeper today to decide if it is the correct fix.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
