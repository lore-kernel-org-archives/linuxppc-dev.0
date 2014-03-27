Return-Path: <Jason.Jin@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7399F140084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 14:57:19 +1100 (EST)
From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH 2/2] video/fsl: Fix the sleep function for FSL DIU module
Date: Thu, 27 Mar 2014 03:57:05 +0000
Message-ID: <489377bf2ab5439bb40271e09df54083@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <1395855704-19908-2-git-send-email-Jason.Jin@freescale.com>
 <53332168.5050805@tabi.org>
 <e3e45edb388c482eb53474e18575f227@BLUPR03MB373.namprd03.prod.outlook.com>
 <53339F03.7010004@tabi.org>
In-Reply-To: <53339F03.7010004@tabi.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Jason.Jin@freescale.com wrote:
> > [Jason Jin-R64188] It's not hackish, we can provide the pixel clock
> register in the DIU node, I did not provide the dts update as this is
> only tested on T1040 platform. For other platforms such as p1022 and 8610=
,
> we still can use the pixel clock setting function in the platform.
> >
> > The dts node update for T1040 is:
> > display:display@180000 {
> >          compatible =3D "fsl,t1040-diu", "fsl,diu";
> > -       reg =3D <0x180000 1000>;
> > +       reg =3D <0x180000 1000 0xfc028 4>;
> >          interrupts =3D <74 2 0 0>;
> > };
>=20
> This is hackish because you're specifying a single register that you want
> to preserve in the DTS file, instead of a platform function which is
> where it's supposed to be.
>=20
[Jason Jin-R64188] The pixel clock register is actually part of the DIU reg=
isters although it is not implemented in the diu module. Actually we can us=
e it to set pixel clock in the driver not just saving it in suspend. We can=
 provide the patch for discussion.=20

> I will think about this some more.  I think you are trying too hard to
> avoid a platform file, which is why some of this code is hackish to me.
[Jason Jin-R64188] Thanks. Could you please share you thinking for how to s=
etup the platform file then?
