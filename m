Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f208.google.com (mail-gx0-f208.google.com
	[209.85.217.208])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 4901FB7B6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 15:49:08 +1000 (EST)
Received: by gxk4 with SMTP id 4so2467359gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 07 Aug 2009 22:49:06 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <24979490.1248785451446.JavaMail.ngmail@webmail10.arcor-online.net>
References: <24979490.1248785451446.JavaMail.ngmail@webmail10.arcor-online.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 7 Aug 2009 23:48:46 -0600
Message-ID: <fa686aa40908072248n22324ec6p17e21c5dcea6812e@mail.gmail.com>
Subject: Re: [5200] ATA and (BAD) interrupts question
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 28, 2009 at 6:50 AM, Albrecht Dre=DF<albrecht.dress@arcor.de> w=
rote:
> Hi all,
>
> I run linux 2.6.29.1 from kernel.org on a custom Freescale MPC5200B based=
 board, which has a CF card attached to the 5200's ATA. =A0The CF seems to =
run nicely, but I am somewhat confused by the interrupts reproted by the ke=
rnel.
>
> Immediately after the boot, /proc/interrupts reports (inter alia)
>
> 135: =A0 =A0 =A0 =A0 =A08 =A0MPC52xx Peripherals Edge =A0 =A0 =A0mpc52xx_=
ata
> 194: =A0 =A0 =A0 =A0 =A00 =A0MPC52xx SDMA Edge =A0 =A0 =A0ATA task
> BAD: =A0 =A0 =A0 =A0 44
>
> Then I say 'mount -t vfat -o noatime /dev/sda1 /mnt/cf0', and I get
>
> 135: =A0 =A0 =A0 =A0 41 =A0MPC52xx Peripherals Edge =A0 =A0 =A0mpc52xx_at=
a
> 194: =A0 =A0 =A0 =A0 =A00 =A0MPC52xx SDMA Edge =A0 =A0 =A0ATA task
> BAD: =A0 =A0 =A0 =A0 44
>
> Then, I recursively copy a folder to the CF card:
>
> 135: =A0 =A0 125111 =A0MPC52xx Peripherals Edge =A0 =A0 =A0mpc52xx_ata
> 194: =A0 =A0 =A0 =A0 =A00 =A0MPC52xx SDMA Edge =A0 =A0 =A0ATA task
> BAD: =A0 =A0 121863
>
> Is it correct that the "ATA task" interrupts are still 0, and that I get =
such a high number of BAD ones? =A0Is there a way to detect which source ac=
tually triggered the BAD interrupts?

No, not really, but I'd spend some time looking at the DMA portion of
the IRQ handler.  Either edge IRQs are not getting acked correctly, or
the interrupt controller driver is not reading the pending IRQs
correctly.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
