Return-Path: <j.beisert@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id EE333DDE45
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 20:24:12 +1000 (EST)
From: Juergen Beisert <j.beisert@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Powerpc and ioremap
Date: Thu, 7 Aug 2008 12:23:11 +0200
References: <319b0ac50808070254x27606b48sb15fb4ee6105c6c6@mail.gmail.com>
In-Reply-To: <319b0ac50808070254x27606b48sb15fb4ee6105c6c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808071223.11156.j.beisert@pengutronix.de>
Cc: =?iso-8859-15?q?S=E9bastien?= =?iso-8859-15?q?_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Donnerstag, 7. August 2008 11:54 schrieb S=E9bastien Chr=E9tien:
> Hello,
>
> I am trying to port linux on my Powerpc Board. I have used Linux 2.6.26 a=
nd
> gcc 3.4.5.
> I have used Uboot 1.2.
> Linux seems running from _start to udbg_early_init(). That's why I
> develloped a udbg_driver.
> It must write in a register which is located at 0x2001b044. So I wrote :
>
> void __iomem *p;
> p=3Dioremap(0x2001b044,4);
> iowrite32('O',p);
> iowrite32('K',p);

try

p=3Dioremap(0x2001b000, 0x1000);
iowrite32('O',p + 0x44);
iowrite32('K',p + 0x44);

instead.

jbe
=2D-=20
 Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-7 |  Fax: +49-5121-206917-9
