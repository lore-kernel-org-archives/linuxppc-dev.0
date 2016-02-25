Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0053.outbound.protection.outlook.com [157.56.112.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A75491A0359
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 16:11:26 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "oss@buserror.net" <oss@buserror.net>, Yang-Leo Li <leoyang.li@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 2/7] QE: Add ucc hdlc document to bindings
Date: Thu, 25 Feb 2016 04:37:55 +0000
Message-ID: <AM3PR04MB11854D515522ECD59E53513891A60@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
 <1455757572-44955-2-git-send-email-qiang.zhao@nxp.com>
 <20160223202151.GA5326@rob-hp-laptop>
In-Reply-To: <20160223202151.GA5326@rob-hp-laptop>
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

On Wen, Feb 24, 2016 at 04:22AM, Rob Herring wrote:
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, February 24, 2016 4:22 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; Yang-Leo Li <leoyang.li@nxp.com>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH v2 2/7] QE: Add ucc hdlc document to bindings
>=20
> On Thu, Feb 18, 2016 at 09:06:07AM +0800, Zhao Qiang wrote:
> > Add ucc hdlc document to
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
>=20
> Not a very useful description.

Could you give a example for me?

>=20
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> > Changes for v2
> > 	- use ucc-hdlc instead of ucc_hdlc
> > 	- add more information to properties.
> >
> >  .../bindings/powerpc/fsl/cpm_qe/network.txt        | 93
> ++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
> > index 29b28b8..936158c 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
> > +++
> b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
> > @@ -41,3 +41,96 @@ Example:
> >  		fsl,mdio-pin =3D <12>;
> >  		fsl,mdc-pin =3D <13>;
> >  	};
> > +
> > +* HDLC
> > +
> > +Currently defined compatibles:
> > +- fsl,ucc-hdlc
> > +
> > +Properties for fsl,ucc-hdlc:
> > +- rx-clock-name
> > +- tx-clock-name
> > +	Usage: required
> > +	Value type: <string>
> > +	Definition : should be "brg1"-"brg16" for internal clock source,
> > +		     should be "clk1"-"clk28" for external clock source.
> > +
> > +- fsl,rx-sync-clock
> > +	Usage: required
> > +	Value type: <string>
> > +	Definition : should be "none" when using internal clock source,
> > +		     should be "rsync_pin" when using external clock source.
>=20
> Why not a boolean property here?

fsl,rx-sync-clock should have other values.
But now we just use rsync_pin and none.

> > +
> > +- fsl,tx-timeslot
> > +- fsl,rx-timeslot
>=20
> Perhaps append "-mask"

Agree, I will modify in next version.

>=20
> > +	Usage: required
> > +	Value type: <u32>
> > +	Definition : time slot for TDM operation. Indicates which time slots
> > +		     used for transmitting and receiving.
> > +
> > +- fsl,tdm-framer-type
> > +	Usage: required
> > +	Value type: <string>
> > +	Definition : "e1" or "t1"
>=20
> Boolean?

We just support e1 and t1, in fact, there are more TDM framer types.

>=20
> > +
> > +- fsl,tdm-mode
> > +	Usage: required
> > +	Value type: <string>
> > +	Definition : "normal" or "internal-loopback"
>=20
> Boolean?

It can be Boolean.

BR
-Zhao
