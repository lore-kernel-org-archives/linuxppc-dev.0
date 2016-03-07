Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0064.outbound.protection.outlook.com [157.55.234.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CA871A005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 13:50:49 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "oss@buserror.net" <oss@buserror.net>, Yang-Leo Li <leoyang.li@nxp.com>,
 Xiaobo Xie <xiaobo.xie@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v3 3/7] QE: Add uqe_serial document to bindings
Date: Mon, 7 Mar 2016 02:35:28 +0000
Message-ID: <AM3PR04MB11852B62A075A980A246D2D091B10@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
 <1456816183-22340-3-git-send-email-qiang.zhao@nxp.com>
 <20160305042536.GD13525@rob-hp-laptop>
In-Reply-To: <20160305042536.GD13525@rob-hp-laptop>
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

On Tue, Mar 05, 2016 at 12:26PM, Rob Herring wrote:
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Saturday, March 05, 2016 12:26 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; Yang-Leo Li <leoyang.li@nxp.com>; Xiaobo Xie
> <xiaobo.xie@nxp.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH v3 3/7] QE: Add uqe_serial document to bindings
>=20
> On Tue, Mar 01, 2016 at 03:09:39PM +0800, Zhao Qiang wrote:
> > Add uqe_serial document to
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> > Changes for v2
> > 	- modify tx/rx-clock-name specification Changes for v2
> > 	- NA
> >
> >  .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt        | 19
> +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> > new file mode 100644
> > index 0000000..436c71c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.
> > +++ txt
> > @@ -0,0 +1,19 @@
> > +* Serial
> > +
> > +Currently defined compatibles:
> > +- ucc_uart
>=20
> I guess this is in use already and okay. However, looking at the driver t=
here
> really should be SoC specific compatible strings here since the driver is=
 looking
> up the SoC compatible string and composing the firmware filename from tha=
t.

Ok, I will changed both driver and this compatible.

>=20
> > +
> > +Properties for ucc_uart:
> > +port-number : port number of UCC-UART tx/rx-clock-name : should be
> > +"brg1"-"brg16" for internal clock source,
> > +		   should be "clk1"-"clk28" for external clock source.
> > +
> > +Example:
> > +
> > +	ucc_serial: ucc@2200 {
> > +		device_type =3D "serial";
>=20
> Drop device_type. It should only be used in a few legacy cases.
>=20
> Looks like the driver is matching on this. Please drop it from the driver=
 too. I'd
> leave dts files for now, but they should be updated too later.

Ok, Thank you for your Reviewing, I will drop it

>=20
> > +		compatible =3D "ucc_uart";
> > +		port-number =3D <1>;
> > +		rx-clock-name =3D "brg2";
> > +		tx-clock-name =3D "brg2";
> > +	};
> > --
> > 2.1.0.27.g96db324
> >
