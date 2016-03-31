Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0080.outbound.protection.outlook.com [157.55.234.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb74Q639nzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 12:59:49 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>, "davem@davemloft.net"
 <davem@davemloft.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaobo Xie
 <xiaobo.xie@nxp.com>, "oss@buserror.net" <oss@buserror.net>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH 4/5] fsl/qe: Add QE TDM lib
Date: Thu, 31 Mar 2016 01:25:11 +0000
Message-ID: <AM3PR04MB11852B1F60CE58F0A877969291990@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1459327830-19829-1-git-send-email-qiang.zhao@nxp.com>
 <1459327830-19829-4-git-send-email-qiang.zhao@nxp.com>
 <1459338701.3538.17.camel@infinera.com>
In-Reply-To: <1459338701.3538.17.camel@infinera.com>
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

On Wed, 2016-03-30 at 07:50PM, Joakim Tjernlund wrote:
> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> Sent: Wednesday, March 30, 2016 7:50 PM
> To: davem@davemloft.net; Qiang Zhao <qiang.zhao@nxp.com>
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xiaobo X=
ie
> <xiaobo.xie@nxp.com>; oss@buserror.net; gregkh@linuxfoundation.org;
> akpm@linux-foundation.org; netdev@vger.kernel.org
> Subject: Re: [PATCH 4/5] fsl/qe: Add QE TDM lib
>=20
> On Wed, 2016-03-30 at 16:50 +0800, Zhao Qiang wrote:
> > QE has module to support TDM, some other protocols supported by QE are
> > based on TDM.
> > add a qe-tdm lib, this lib provides functions to the protocols using
> > TDM to configurate QE-TDM.
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > +	utdm->siram_entry_id =3D val;
> > +
> > +	set_si_param(utdm, ut_info);
> > +
> > +	np2 =3D of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-si");
>=20
> fsl,t1040-qe-si only? What about mpc83xx?
> I recall QE is a little bit different compared to T1040 or will this work=
(including
> the hdlc driver) on 83xx as well?

The " fsl,t1040-qe-si " is new added to dts and bindings, it is required to=
 have SoC specific compatible strings.
mpc83xx will not use qe-si node. If there will be other soc useing qe-si, "=
 fsl,t1040-qe-si " will follow the soc specific compatible,
like :=20
                si1: si@700 {
                        compatible =3D "fsl,ls1043-qe-si", "fsl,t1040-qe-si=
";
                        reg =3D <0x700 0x80>;
                };

Best Regards
Zhao Qiang
