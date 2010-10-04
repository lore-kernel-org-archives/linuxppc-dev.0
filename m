Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0F9A5B70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 02:49:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: Serial RapidIO Maintaintance read causes lock up
Date: Mon, 4 Oct 2010 08:49:20 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: <bastiaan.nijkamp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bastiaan,

Are you trying board-to-board connection?
I am not familiar with WRS SBC8548 board - which type of connector they
use for SRIO?

Assuming that all configuration is correct,
I would recommend first to try setting up x1 link mode at the lowest
link speed.
The x4 mode may present challenges in some cases.

For quick test you may just add port width override into fsl_rio.c
like shown below (ugly but sometimes it helps ;) ):

@@ -1461,10 +1461,16 @@ int fsl_rio_setup(struct platform_device *dev)
 	rio_register_mport(port);
=20
 	priv->regs_win =3D ioremap(regs.start, regs.end - regs.start + 1);
 	rio_regs_win =3D priv->regs_win;
=20
+dev_info(&dev->dev, "Overriding RIO_PORT setting to single lane 0\n");
+out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
0x800000);
+out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
0x2000000);
+out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) &
~0x800000);
+msleep(100);
+
 	/* Probe the master port phy type */
 	ccsr =3D in_be32(priv->regs_win + RIO_CCSR);
 	port->phy_type =3D (ccsr & 1) ? RIO_PHY_SERIAL : RIO_PHY_PARALLEL;
 	dev_info(&dev->dev, "RapidIO PHY type: %s\n",
 			(port->phy_type =3D=3D RIO_PHY_PARALLEL) ?
"parallel" :


Let me know what happens.
Please keep me in the CC: list next time when posting RapidIO questions
to the linuxppc-dev or kernel mailing lists.

Regards,

Alex.
=20
