Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQvsl6ptKzDqjr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 04:07:07 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh@kernel.org>
Cc: Scott Wood <scott.wood@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Zhao Qiang <qiang.zhao@freescale.com>, Russell King <linux@arm.linux.org.uk>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Kumar Gala <galak@codeaurora.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yang-Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v6,
 5/5] mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
Date: Thu, 17 Mar 2016 18:06:09 +0100
Message-ID: <3706958.XeRFmKM0K5@wuerfel>
In-Reply-To: <20160317170101.GA21009@rob-hp-laptop>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <DB5PR0401MB19286B2D23D07F5C60DB799D91880@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <20160317170101.GA21009@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 17 March 2016 12:01:01 Rob Herring wrote:
> On Mon, Mar 14, 2016 at 05:45:43PM +0000, Scott Wood wrote:

> > >> This makes the driver non-portable. Better identify the specific=

> > >> workarounds based on the compatible string for this device, or a=
dd a
> > >> boolean DT property for the quirk.
> > >>
> > >>    Arnd
> > >=20
> > > [Lu Yangbo-B47093] Hi Arnd, we did have a discussion about using =
DTS in v1 before.
> > > https://patchwork.kernel.org/patch/6834221/
> > >=20
> > > We don=E2=80=99t have a separate DTS file for each revision of an=
 SOC and if we did, we'd constantly have people using the wrong one.
> > > In addition, the device tree is stable ABI and errata are often d=
iscovered after device tree are deployed.
> > > See the link for details.
> > >=20
> > > So we decide to read SVR from the device-config/guts MMIO block o=
ther than using DTS.
> > > Thanks.
> >=20
> > Also note that this driver is already only for fsl-specific hardwar=
e,
> > and it will still work even if fsl_guts doesn't find anything to bi=
nd to
> > -- it just wouldn't be able to detect errata based on SVR in that c=
ase.
>=20
> IIRC, it is the same IP block as i.MX and Arnd's point is this won't=20=

> even compile on !PPC. It is things like this that prevent sharing the=
=20
> driver.

I think the first four patches take care of building for ARM,
but the problem remains if you want to enable COMPILE_TEST as
we need for certain automated checking.

> Dealing with Si revs is a common problem. We should have a=20
> common solution. There is soc_device for this purpose.

Exactly. The last time this came up, I think we agreed to implement a
helper using glob_match() on the soc_device strings. Unfortunately
this hasn't happened then, but I'd still prefer that over yet another
vendor-specific way of dealing with the generic issue.

=09Arnd
