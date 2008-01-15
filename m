Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 8EA89DDE28
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 01:51:48 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1370891anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 06:51:47 -0800 (PST)
Message-ID: <fa686aa40801150651s213a745dwa4d595de5a9d191b@mail.gmail.com>
Date: Tue, 15 Jan 2008 07:51:47 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "S. Fricke" <silvio.fricke@gmail.com>
Subject: Re: psc and spi
In-Reply-To: <20080115135306.GE14333@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080115135306.GE14333@sfrouter>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/15/08, S. Fricke <silvio.fricke@googlemail.com> wrote:
> Hello friends,
>
> I have on the psc3 the spi-interface of a fpga connected.
>
>    psc3-0 - MOSI
>    psc3-1 - MISO
>    psc3-2 - CLK
>    psc3-3 - SlaveSelect
>    psc3-4 - CS-FPGA
>    psc3-5 - CS Another device
>    psc3-6 - SPI-SEL0
>    psc3-7 - SPI-SEL1
>    psc3-8/9 - Not connected
>
> Can I use the mpc52xx_psc_spi-driver? And if yes, how I have to use this
> driver?  Or must I write a own spi-master/slave thing? Can anyone point me
> to a good start-position?

Yes, you should be able to use the mpc52xx_psc_spi driver.  You'' need
to add the activate_cs and deactivate_cs hooks in your platform code
to activate your SPI CS lines.  You'll also need to set port_config to
have the PSC3 pins in "CODEC3" mode.

Cheers,
g.

>
> Best regards,
> Silvio Fricke
>
> --
> -- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
>    Diplom-Informatiker (FH)
>    Linux-Entwicklung
> ----------------------------------------------------------------------------
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
