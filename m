Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id C4491DDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 08:20:56 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so176980anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 15:20:54 -0700 (PDT)
Message-ID: <fa686aa40805151520jfde372csa0c57195d03dbd5e@mail.gmail.com>
Date: Thu, 15 May 2008 16:20:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: gary.jennejohn@freenet.de
Subject: Re: 440EPx - SPI and IIC1 conflict
In-Reply-To: <20080515210221.2cd19762@peedub.jennejohn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080515210221.2cd19762@peedub.jennejohn.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 15, 2008 at 1:02 PM, Gary Jennejohn <garyj@denx.de> wrote:
> Hello,
>
> I've developed a driver for the SPI controller in the 440EPx, which should
> also work for e.g. the 460EX, and maybe other AMCC processors.
>
> According to the UM bit 14 in SDR0_PFC1 controls whether certain signals
> are for IIC1 or SPI.  My driver assures that this bit is set to 0.  Note
> that I haven't been able to find any code in the Linux tree which
> manipulates this register except for my driver, so IIC1 isn't actually
> enabled for the 440EPx or the 460EX.
>
<snip>
>
> Basically I'm wondering whether anyone on this list has any brilliant
> idea for handling this problem or whether my present solution is really
> just OK.

Yes, this is an easy issue to solve.  The way to do it is to *not* let
your device drivers fiddle with board level configuration stuff (like
the register that selects between SPI and I2C mode).  Instead, that
register should ideally setup by the bootloader, or if that is not
possible, then by the platform code (the board specific stuff in
arch/ppc/platforms/*).  Then your driver can test that bit if it likes
to see if the pins are connected; (or even better, disable the device
entirely by not listing it in the device tree).

In fact, if it doesn't hurt anything to have the device enabled when
the bit is set against it, then the driver shouldn't care.  That makes
the driver more portable to other SoCs, and you should be relying on
the device tree anyway to bind devices to drivers.

For an example, you can look at the MPC5200 support code.  There is a
system level configuration register called "port_config" that controls
pin routing.  In most cases, u-boot sets the right value in
port_config so that Linux code never needs to touch it.  In cases
where we cannot trust u-boot to set things up correctly, like on the
lite5200 board, then the platform code fixes things up.  None of the
mpc5200 device drivers ever touch port_config.  (See
arch/powerpc/platforms/52xx/lite5200.c)

Cheers,
g.

>
> ---
> Gary Jennejohn
> *********************************************************************
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
> *********************************************************************
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
