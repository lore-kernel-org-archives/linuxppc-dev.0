Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6596367CD3
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 17:00:16 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k6470Dv9021749
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Jul 2006 00:00:13 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k6470BqV009922
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Jul 2006 02:00:12 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E05003@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Date: Tue, 4 Jul 2006 15:00:04 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Cc: Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, 'Paul Mackerras' <paulus@samba.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Saturday, July 01, 2006 5:00 PM
> To: Li Yang-r58472
> Cc: 'Vitaly Bordug'; 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips
> Kim-R1AAHA; Chu hanjin-r52514; Yin Olivia-r63875;
> 'linux-kernel@vger.kernel.org'
> Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> 
> On Fri, 2006-06-30 at 18:27 +0800, Li Yang-r58472 wrote:
> > > -----Original Message-----
> > > From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> > > Sent: Thursday, June 29, 2006 12:59 AM
> > > To: Li Yang-r58472
> > > Cc: 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips Kim-R1AAHA; Chu
> > > hanjin-r52514; Yin Olivia-r63875; 'linux-kernel@vger.kernel.org'
> > > Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> > >
> > > On Wed, 28 Jun 2006 22:23:03 +0800
> > > Li Yang-r58472 <LeoLi@freescale.com> wrote:
> > >
> > [snip]
> > >
> > > >
> > > >  config MPC834x
> > > > @@ -24,4 +31,10 @@ config MPC834x
> > > >  	select PPC_INDIRECT_PCI
> > > >  	default y if MPC834x_SYS
> > > >
> > > > +config MPC836x
> > > > +	bool
> > > > +	select PPC_UDBG_16550
> > >
> > > debug option made default?
> >
> > I'm afraid this is needed to boot.  83xx family platforms need it to
> initialize early console.  And it does appear in several defconfigs of other
> platforms.
> 
> How so ? Why would having a serial console be mandatory ? Embedded might
> want to boot without a console and use the serial port for other things.
> This should be left as a config option (though you are welcome to put it
> in the defconfig for your platform)

The problem is that we don't have this PPC_UBDG_16550 option configurable now, and it is only made by default for several boards including pseries, chrp, prep, cell, and all 83xx and 85xx platforms.  If we need to change the whole thing, how should we do it?
> 
> > > > +	select PPC_INDIRECT_PCI
> > > > +	default y if MPC8360E_PB
> > > > +
> > > >  endmenu
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
