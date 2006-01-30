Return-Path: <nzeitler@osii.com>
Received: from osiemail.osii.com (mail.osii.com [207.67.97.196])
	by ozlabs.org (Postfix) with ESMTP id 7816868A5E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 09:34:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Re: MPC5200 - Problem with PSC mode
Date: Mon, 30 Jan 2006 16:34:27 -0600
Message-ID: <7492B3D3325B424399725C8A03926A3E2592C7@osiemail.osii.com>
From: "Zeitler, Nathan" <nzeitler@osii.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Allann,

Hmm, yes.  In addition, these lines looks suspect:

> val32 =3D in_be32(&gpio->port_config);
> val32 &=3D ~0x700;
> val32 |=3D 0x600;
> out_be32(&gpio->port_config, val32);

I don't have the register's header file in front of me, but I'm
pretty sure this refers to MBAR+0xb00.  If that's the case,=20
you seem to be configuring the port to be in CODEC mode=20
and not UART mode.  Try this instead:

val32 =3D in_be32(&gpio->port_config);
val32 &=3D ~0xf00;
val32 |=3D 0x400;
out_be32(&gpio->port_config, val32);

You may want to refer to the MPC5200 manual.  Page 15-43
has a nice sequence you can go through to configure a port
to be a UART.

Open Systems International, Inc.=20
Nathan Zeitler
Hardware Engineer
3600 Holly Lane North, Suite 40
Minneapolis, MN 55447-1286
Phone: 763 551 0559
Fax: 763 551 0750
E-mail: nzeitler@osii.com
