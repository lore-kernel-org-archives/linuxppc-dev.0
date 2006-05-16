Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx026.isp.belgacom.be (outmx026.isp.belgacom.be
	[195.238.4.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A2DA679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 01:09:29 +1000 (EST)
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
	by outmx026.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4GF9MK5012266
	for <linuxppc-embedded@ozlabs.org>; Tue, 16 May 2006 17:09:22 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx026.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4GF9C5j012140
	for <linuxppc-embedded@ozlabs.org>; Tue, 16 May 2006 17:09:15 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8248 goes berserk when printing messages on the SMC console
Date: Tue, 16 May 2006 17:09:36 +0200
References: <200605151828.22727.laurent.pinchart@tbox.biz>
In-Reply-To: <200605151828.22727.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605161709.36387.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

after further investigation, I found out that my SMC problem is probably=20
caused by cache issues.

> The SMC console works fine in U-Boot. 115200 8N1, no problem there.
>
> When booting a Linux 2.6.16 kernel, the processor doesn't print anything =
on
> the console and seems to hang. Further analysis with a BDI2000 reveals the
> following.
>
> - The CPU is stuck in cpm_uart_console_write, checking for
>
> while ((bdp->cbd_sc & BD_SC_READY) !=3D 0);
>
>   At that point, most of the external and internal memory read as 0 (SDRA=
M,
> flash, ...). A few memory locations contain values different than 0, and I
> suspect those to come directly from the cache.

The only memory locations that aren't filled with 0 when read from the BDI =
are=20
the ones present in D-cache lines. Accessing unmapped memory doesn't fail a=
nd=20
returns 0.

> - If I break right before setting the BD_SC_READY flag and run using step=
i,
> random characters are sent on the serial port. Measuring the baudrate usi=
ng
> an oscilloscope confirms that it has been correctly configured. Only the
> data is wrong.

=46rom http://www.freescale.com/webapp/sps/utils/SingleFaq.jsp?FAQ-19683.xml

"Note. If the core is in the debug mode then the cache content will not be=
=20
updated by the snooping."

I tried to clear the GBL bit in the SMC TFCR register to disable memory=20
snooping. This solved part of the problem, as the CPU doesn't hang anymore,=
=20
but the data sent on the serial port are garbage. I suppose that's a normal=
=20
behaviour once the D-cache is enabled.

This leads me to believe that I have a cache issue. Has anyone experienced =
the=20
same problem ?

Laurent Pinchart
