Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD2C0B6F77
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 11:05:33 +1000 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Christoph Fritz <chf.fritz@googlemail.com>, Li Yang-R58472
 <r58472@freescale.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] usb: fsl_udc: errata - postpone freeing current dTD
Date: Mon, 21 May 2012 01:05:24 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter> <20120514042142.GD9750@kroah.com>
 <20120520231724.GA7941@mars>
In-Reply-To: <20120520231724.GA7941@mars>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Ido Shayevitz <idos@codeaurora.org>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Estevam Fabio-R49496 <r49496@freescale.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Daniel Mack <daniel@caiaq.de>, Christian Hemp <c.hemp@phytec.de>,
 Russell King <linux@arm.linux.org.uk>, Neil Zhang <zhangwm@marvell.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



=20
>=20
> USB controller may access a wrong address for the dTD (endpoint transfer
> descriptor) and then hang. This happens a lot when doing tests with
> g_ether module and iperf, a tool for measuring maximum TCP and UDP
> bandwidth.
>=20
> This hardware bug is explained in detail by errata number 2858 for i.MX23=
:
> http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
>=20

Does this patch fix your problem?
=20
> +#if defined CONFIG_ARCH_MX51 || defined CONFIG_SOC_IMX35
> +#define POSTPONE_FREE_LAST_DTD
> +#else
> +#undef POSTPONE_FREE_LAST_DTD
> +#endif
> +
All i.mx SoC has this problem, if PowerPC also has this problem, you can=20
delete #if defined. Else, you can define it for all i.mx SoC=20
(CONFIG_ARCH_MXC | CONFIG_ARCH_MXS)

>  /* ### define USB registers here
>   */
>  #define USB_MAX_CTRL_PAYLOAD		64
> --
> 1.7.2.5
>=20
>=20
