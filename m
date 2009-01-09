Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 3486547506
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 01:42:34 +1100 (EST)
Date: Fri, 9 Jan 2009 15:42:25 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: mal_probe crash
In-Reply-To: <1231368610.2142.27.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0901091533000.13230@vixen.sonytel.be>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<20090108204634.GB2337@yoda.jdub.homelinux.org>
	<1231368610.2142.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 Jan 2009, Benjamin Herrenschmidt wrote:
> On Thu, 2009-01-08 at 15:46 -0500, Josh Boyer wrote:
> > On Wed, Jan 07, 2009 at 03:44:34PM -0500, Sean MacLennan wrote:
> > >With Linus' latest git, mal_probe crashes. It calls netif_napi_add with
> > >the first parameter NULL. This was ok since the parameter, a net
> > >device, was only used if CONFIG_NETPOLL was set.
> > >
> > >Now it is always de-referenced. A quick check shows that ibm_newemac is
> > >the only driver that passed NULL as the first parameter to this call in
> > >2.6.28.
> > >
> > >I don't really follow ibm_newemac changes, so the patch may be waiting
> > >to be applied. This is really just a heads up.
> > 
> > I haven't heard of that, so I doubt there's a patch pending.  *Sigh*
> 
> There isn't that I know of. The EMAC code creates a single NAPI instance
> for all EMACs and I think used to completely disconnect things. The old
> code created a fake netdev just for NAPI, that became unnecessary with
> the new NAPI stuff.... but it looks like the way we do things now
> displeases some changes in the network stack. I'll have to dig.

Verified on my Sequoia (which now lost its network :-(

The regression/problem (requiring a valid net_device in netif_napi_add(), even
if CONFIG_NETPOLL=n) seems to be introduced by commit
d565b0a1a9b6ee7dff46e1f68b26b526ac11ae50 ("net: Add Generic Receive Offload
infrastructure").

However, it was broken before, in case CONFIG_NETPOLL=y.

So mal_probe() (triggered by mal_init()) needs to know about the net_device
before it has been allocated by emac_probe() (triggered by
of_register_platform_driver(&emac_driver)):

| static int __init emac_init(void)
| {
| 	int rc;
| 
| 	printk(KERN_INFO DRV_DESC ", version " DRV_VERSION "\n");
| 
| 	/* Init debug stuff */
| 	emac_init_debug();
| 
| 	/* Build EMAC boot list */
| 	emac_make_bootlist();
| 
| 	/* Init submodules */
| 	rc = mal_init();
| 	if (rc)
| 		goto err;
| 	rc = zmii_init();
| 	if (rc)
| 		goto err_mal;
| 	rc = rgmii_init();
| 	if (rc)
| 		goto err_zmii;
| 	rc = tah_init();
| 	if (rc)
| 		goto err_rgmii;
| 	rc = of_register_platform_driver(&emac_driver);
| 	if (rc)
| 		goto err_tah;
| 
| 	return 0;
| 
|  err_tah:
| 	tah_exit();
|  err_rgmii:
| 	rgmii_exit();
|  err_zmii:
| 	zmii_exit();
|  err_mal:
| 	mal_exit();
|  err:
| 	return rc;
| }

Can the order of mal_init() and of_register_platform_driver(&emac_driver) be
reversed? If yes, there still has some link to be made between the mal and the
emac devices.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
