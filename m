Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABE41679FF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 19:00:22 +1000 (EST)
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FF2@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF2@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 19:00:04 +1000
Message-Id: <1151744404.27137.26.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Fri, 2006-06-30 at 18:27 +0800, Li Yang-r58472 wrote:
> > -----Original Message-----
> > From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> > Sent: Thursday, June 29, 2006 12:59 AM
> > To: Li Yang-r58472
> > Cc: 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips Kim-R1AAHA; Chu
> > hanjin-r52514; Yin Olivia-r63875; 'linux-kernel@vger.kernel.org'
> > Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> > 
> > On Wed, 28 Jun 2006 22:23:03 +0800
> > Li Yang-r58472 <LeoLi@freescale.com> wrote:
> > 
> [snip]
> > 
> > >
> > >  config MPC834x
> > > @@ -24,4 +31,10 @@ config MPC834x
> > >  	select PPC_INDIRECT_PCI
> > >  	default y if MPC834x_SYS
> > >
> > > +config MPC836x
> > > +	bool
> > > +	select PPC_UDBG_16550
> > 
> > debug option made default?
> 
> I'm afraid this is needed to boot.  83xx family platforms need it to initialize early console.  And it does appear in several defconfigs of other platforms.

How so ? Why would having a serial console be mandatory ? Embedded might
want to boot without a console and use the serial port for other things.
This should be left as a config option (though you are welcome to put it
in the defconfig for your platform)
 
> > > +	select PPC_INDIRECT_PCI
> > > +	default y if MPC8360E_PB
> > > +
> > >  endmenu
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
