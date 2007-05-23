Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79781DDEC1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 00:26:29 +1000 (EST)
Date: Wed, 23 May 2007 09:21:48 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: RE: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
In-Reply-To: <46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
Message-ID: <Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 May 2007, Zhang Wei-r63237 wrote:

> > So I'm taking the boot/dts/mpc8641_hpcn.dts and producing a new
> > mpc8641D_umem.dts with the following addition to the soc.
> >
> > srio@c0000 {
> >                 device_type = "srio";
> >                 compatible = "86xx,85xx";

We really need to think about this, is their really any difference between
srio and prio from a software view point?

> > 		reg = <c0000 20000>;
> > 		law = <400000000 e00000000>;
>
> Please use range = <0 address_start size>

The law should really be removed.

>
> > 		dbells = <0 ffff>;
> > 		mboxs = <0 4>;
>
> The dbells and mboxs can be removed. The default setting in rio is okay.

this could possibly be useful.

>
> >                 interrupt-parent = <&mpic>;
> >                 interrupts = <30 1 31 1 32 1 35 1 36 1 37 1 38 1>;
> >               };
> >
> Do you really use all of this interrupts? In my test, three <32 2 35 2
> 36 2> are okay, and the sense is 2.

I think we need to list all the interrupts possible from RIO, not just the
ones the driver happens to use.

- k
