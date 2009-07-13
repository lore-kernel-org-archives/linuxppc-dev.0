Return-Path: <Matteo.Canella@mta.it>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D4829B707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 00:33:41 +1000 (EST)
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20575DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 00:33:39 +1000 (EST)
Received: from mailserver.mta.int (mail.mta.it [89.96.171.250])
	by rly08a.srv.mailcontrol.com (MailControl) with ESMTP id
	n6DEXV27009485
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2009 15:33:32 +0100
From: Canella Matteo <Matteo.Canella@mta.it>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Mon, 13 Jul 2009 16:33:23 +0200
Subject: SPI driver on mpc5121
Message-ID: <BD9F3F3F5A6CCF4BA032B9FED4DD312E5D09531D27@mta-digimail.MTA.INT>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
I'm on a mpc5121 platform, kernel 2.6.24.6, and I'm using the mpc512x_psc_s=
pi driver to communicate =A0with a touch screen controller.
I'm sending commands and reading data from the controller using 24-bit pack=
et (3 bytes).
The speed of the SPI is set to 640 KHz.
I thought that I would need 8/640K =3D 12,5 us each byte I send, but this i=
s not true.
I'm verifying the time needed by mpc512x_psc_spi_transfer_rxtx function in =
order to send one byte toggling a digital output when it sets the TX/RX fla=
gs (after it copies data in the transmission buffer) and toggling the outpu=
t again when the empty buffer interrupt is triggered.
I see that the actual 12,5us data transfer is preceded by a 20us delay and =
followed by another 15,6us delay. So the transfer is done in almost 50 us.

Is this a normal behavior? Does the PSC controller need this overhead in th=
e transfer time?
DSCKI and DTL delays are set to zero.

Another doubt I have:

In mpc512x_psc_spi_transfer_rxtx, Mode Register 2 of the PSC is set to zero=
. This is done (as manual says) by access to MR1 (by a read) and then write=
 a zero on the same address.:

in_8(&psc->mode);
mdelay(1);
out_8(&psc->mode, 0x0);
mdelay(1);

I don't understand why a 1ms delay is needed. The manual doesn't say anythi=
ng about this.
I tried to comment out these delays and anyway it seems to work correctly.

Best regards,
Matteo Canella
