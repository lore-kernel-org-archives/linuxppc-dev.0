Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0094.outbound.protection.outlook.com [157.55.234.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D774F1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 19:53:00 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Priyanka.Jain@freescale.com" <Priyanka.Jain@freescale.com>,
 "oss@buserror.net" <oss@buserror.net>
Subject: RE: [PATCH 3/6] QE: Add uqe_serial document to bindings
Date: Mon, 11 Jan 2016 08:19:10 +0000
Message-ID: <AM3PR04MB11854D17FFE6F43B19B4EDCE91C90@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
 <1452219494-31947-3-git-send-email-qiang.zhao@nxp.com>
 <20160108201225.GA9813@rob-hp-laptop>
In-Reply-To: <20160108201225.GA9813@rob-hp-laptop>
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

On Fri, Jan 09, 2016 at 04:12AM, Rob Herring <robh@kernel.org> wrote:
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Saturday, January 09, 2016 4:12 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Priyanka.Jain@freescale.com; oss@buserror.net
> Subject: Re: [PATCH 3/6] QE: Add uqe_serial document to bindings
>=20
> On Fri, Jan 08, 2016 at 10:18:11AM +0800, Zhao Qiang wrote:
> > Add uqe_serial document to
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> >  .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt       | 20
> ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> > new file mode 100644
> > index 0000000..e677599
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.
> > +++ txt
> > @@ -0,0 +1,20 @@
> > +* Serial
> > +
> > +Currently defined compatibles:
> > +- ucc_uart
> > +
> > +Properties for ucc_uart:
> > +device_type : which type the device is
>=20
> Drop this please.

Yes, I will drop it in next version.

>=20
> > +port-number : port number of UCC-UART
>=20
> Use aliases instead.

I don't understand, can you explain more?

>=20
> > +rx-clock-name : which clock QE use for RX tx-clock-name : which clock
> > +QE use for TX
>=20
> These should use the clock binding.

This property means which clock source the UCC use,=20
the QE just use this property to route UCC clock to clock source.
The clock source maybe either internal or outside(from clock input pin).
So clock binding is not apply in this case.

>=20
> > +
> > +Example:
> > +
> > +	serial: ucc@2200 {
> > +		device_type =3D "serial";
> > +		compatible =3D "ucc_uart";
> > +		port-number =3D <1>;
> > +		rx-clock-name =3D "brg2";
> > +		tx-clock-name =3D "brg2";
> > +	};
> > --
> > 2.1.0.27.g96db324
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
Best Regards
Zhao Qiang
