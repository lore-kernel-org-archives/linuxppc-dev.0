Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 2863F679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Oct 2006 01:07:25 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id DA220CC1CF
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Oct 2006 16:49:35 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 7915DCC0E1
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Oct 2006 16:49:35 +0200 (CEST)
Received: from kah.ulm.sysgo.com (kah.sysgo.com [172.40.1.2])
	by donald.sysgo.com (Postfix) with ESMTP id 0A03326E556
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Oct 2006 16:49:21 +0200 (CEST)
Received: from gja.ulm.sysgo.com (gja.ulm.sysgo.com [172.40.1.130])
	by kah.ulm.sysgo.com (8.9.3/8.8.8) with ESMTP id RAA22161
	for <linuxppc-embedded@ozlabs.org>; Mon, 9 Oct 2006 17:14:28 +0200
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem with OPB access on 440GX and Linux 2.6.15
Date: Mon, 9 Oct 2006 16:49:14 +0200
References: <452A52B4.1010303@googlemail.com>
In-Reply-To: <452A52B4.1010303@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200610091649.14853.g.jaeger@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 09 October 2006 15:46, powerpc440 wrote:
> Hi everybody,
>=20
> I'm having a PPC440GX based board, based on Ocotea.
> On the board is a Xilinx CPLD chip, connected with OPB (On-Chip
> Peripheral Bus).
> Under U-Boot I can communicate =96 reading and writing, without any
> problems, but when the Linux kernel ones is loaded, then I'm getting
> error message: =93Bus error=94. This error message appears on reading or
> writing.
> How I can access the units, which are connected with OPB?
>=20
> There are the source code from the driver, that I use :
>=20
> static void io_addr =3D ioremap(0x48300000, 0x100000); /* allocate 1MB
> adress space */
> long value =3D readl(io_addr + 0x7000);
>=20
[SNIPSNAP]

Hi,

are you sure the address is correct?
This looks to me like the Ocotea FPGA address minus 0x100000000...
In that case use ioremap64().

HTH
Gerhard

=2D-=20
Gerhard Jaeger <gjaeger@sysgo.com>           =20
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de=20
