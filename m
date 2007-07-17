Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 5E208DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 22:59:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
Date: Tue, 17 Jul 2007 14:06:03 +0200
References: <469B33F9.2080604@windriver.com> <200707170302.07469.arnd@arndb.de>
	<1184647742.10499.34.camel@mark>
In-Reply-To: <1184647742.10499.34.camel@mark>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707171406.03455.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 17 July 2007, Mark Zhan wrote:
> On Tue, 2007-07-17 at 03:02 +0200, Arnd Bergmann wrote:
> > On Monday 16 July 2007, Mark Zhan wrote:
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpm_uart_data.uart_clk =3D ppc_proc_fre=
q;
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strstr(model, "SMC")) {
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpm_uart_dev =3D platfo=
rm_device_register_simple("fsl-cpm-smc:uart",
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, &r[0], 3);
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (strstr(model, "SCC")) {
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpm_uart_dev =3D platfo=
rm_device_register_simple("fsl-cpm-scc:uart",
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, &r[0], 3);
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > You should probably use of_device_is_compatible() to check
> > if a given device can be used by a particular driver.
>
> I think, the function of_find_compatible_node(), which is called in the
> for loop, has already done that. So definitely, no need to call
> of_device_is_compatible() any more.

It's a little more complicated than that. The "compatible" property should
indicate the exact interface of that device, so the "model" does not really
matter here. I don't know the difference between smc and scc, but if you
need to register them as different pplatform devices, they should
normally also have different names in "compatible", possibly in addition
to the existing one.

If the compatible property contains "fsl,cpm-smc\0cpm_uart", you can scan f=
or
either of them. The loop will iterate over all cpm_uart compatible devices,
while the later test will look for an fsl,cpm-smc compatible device.

	Arnd <><
