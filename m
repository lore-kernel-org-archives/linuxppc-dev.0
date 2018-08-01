Return-Path: <yangbo.lu@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30046.outbound.protection.outlook.com [40.107.3.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gLD72tSDzF1PT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 14:38:47 +1000 (AEST)
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Date: Wed, 1 Aug 2018 04:38:41 +0000
Message-ID: <DB6PR0401MB2536D7611DEB88210C5AEFEFF82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730.092545.225621578249887012.davem@davemloft.net>
In-Reply-To: <20180730.092545.225621578249887012.davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Tuesday, July 31, 2018 12:26 AM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; richardcochran@gmail.com; robh+dt@kernel.org;
> shawnguo@kernel.org; devicetree@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
> initialization
>=20
> From: Yangbo Lu <yangbo.lu@nxp.com>
> Date: Mon, 30 Jul 2018 18:01:54 +0800
>=20
> > +static unsigned int cksel =3D DEFAULT_CKSEL; module_param(cksel, uint,
> > +0644); MODULE_PARM_DESC(cksel, "Select reference clock");
> > +
> > +static unsigned int clk_src;
> > +module_param(clk_src, uint, 0644);
> > +MODULE_PARM_DESC(clk_src, "Reference clock frequency (if clocks
> > +property not provided in dts)");
> > +
> > +static unsigned int tmr_prsc =3D 2;
> > +module_param(tmr_prsc, uint, 0644);
> > +MODULE_PARM_DESC(tmr_prsc, "Output clock division/prescale factor");
> > +
> > +static unsigned int tmr_fiper1 =3D 1000000000; module_param(tmr_fiper1=
,
> > +uint, 0644); MODULE_PARM_DESC(tmr_fiper1, "Desired fixed interval
> > +pulse period (ns)");
> > +
> > +static unsigned int tmr_fiper2 =3D 100000; module_param(tmr_fiper2,
> > +uint, 0644); MODULE_PARM_DESC(tmr_fiper2, "Desired fixed interval
> > +pulse period (ns)");
>=20
> Sorry, there is no way I am every applying something like this.  Module
> parameters are to be avoided at all costs.
>=20
> And you don't need it here, you have DTS, please use it.
>=20
> You are required to support the existing DTS cases, in order to avoid bre=
aking
> things, anyways.
[Y.b. Lu] I get your point. Will drop module_param method.
Thanks a lot for your suggestion.
