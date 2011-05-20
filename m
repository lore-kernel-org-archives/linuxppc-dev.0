Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 33656B6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 22:19:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/2][v3] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
Date: Fri, 20 May 2011 05:14:46 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201D20C69@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <6CBDFAB4-F884-4B33-8A77-0AE2CF2D2ED4@kernel.crashing.org>
References: <1290063473-20950-1-git-send-email-b21989@freescale.com><0CE8B6BE3C4AD74AB97D9D29BD24E552015F5E40@CORPEXCH1.na.ads.idt.com><267A3B246C22C34A8E574051858E077002E834@039-SN1MPN1-003.039d.mgd.msft.net><0CE8B6BE3C4AD74AB97D9D29BD24E5520162CA22@CORPEXCH1.na.ads.idt.com>
	<6CBDFAB4-F884-4B33-8A77-0AE2CF2D2ED4@kernel.crashing.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Li Yang-R58472 <r58472@freescale.com>,
	Xie Shaohui-B21989 <B21989@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar,

Are you planning to release support for dual-port SRIO controller?
If yes, it may be just merged into it (unless dual-port implementation
already has it).

Alex.

> -----Original Message-----
> From: =
linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org
> [mailto:linuxppc-dev-
> bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org] On Behalf Of =
Kumar
> Gala
> Sent: Friday, May 20, 2011 12:29 AM
> To: Bounine, Alexandre
> Cc: Li Yang-R58472; Xie Shaohui-B21989; Zang Roy-R61911; akpm@linux-
> foundation.org; linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780
> Subject: Re: [PATCH 2/2][v3] rapidio,powerpc/85xx: Error interrupt
> handler for sRIO.
>=20
> Alex,
>=20
> What are we doing with this patch?
>=20
> - k
>=20
> On Dec 3, 2010, at 12:04 PM, Bounine, Alexandre wrote:
>=20
> > I think they should follow the previous two that are in Kumar's
tree.
> > Probably Kumar may give you a better timeline estimate for this.
> >
> > Alex.
> >
> > From:
linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org
> [mailto:linuxppc-dev-
> bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org] On Behalf Of Xie
> Shaohui-B21989
> > Sent: Thursday, December 02, 2010 10:29 PM
> > To: Bounine, Alexandre; linuxppc-dev@lists.ozlabs.org
> > Cc: akpm@linux-foundation.org; Gala Kumar-B11780; Li Yang-R58472;
> Zang Roy-R61911
> > Subject: RE: [PATCH 2/2][v3] rapidio,powerpc/85xx: Error interrupt
> handler for sRIO.
> >
> > Hi Alex,
> >
> > May I ask when would these patches be applied to mainline?
> >
> >
> > Best Regards,
> > Shaohui Xie
> >
> > From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]
> > Sent: Wednesday, December 01, 2010 4:49 AM
> > To: Xie Shaohui-B21989; linuxppc-dev@lists.ozlabs.org
> > Cc: akpm@linux-foundation.org; Li Yang-R58472; Gala Kumar-B11780;
> Zang Roy-R61911
> > Subject: RE: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error interrupt
> handler for sRIO.
> >
> > Applies correctly now. Lab tested on 8548/RIO setup.
> >
> > Alex.
> >
> >> -----Original Message-----
> >> From: Shaohui Xie [mailto:b21989@freescale.com]
> >> Sent: Thursday, November 18, 2010 1:58 AM
> >> To: linuxppc-dev@lists.ozlabs.org
> >> Cc: akpm@linux-foundation.org; Shaohui Xie; Li Yang; Kumar Gala;
Roy
> > Zang; Bounine, Alexandre
> >> Subject: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error interrupt
> > handler for sRIO.
> >>
> >> The sRIO controller reports errors to the core with one signal, it
> > uses
> >> register EPWISR to provides the core quick access to where the
error
> > occurred.
> >> The EPWISR indicates that there are 4 interrupts sources, port1,
> > port2, message
> >> unit and port write receive, but the sRIO driver does not support
> > port2
> >> for now, still the handler takes care of port2.
> >> Currently the handler only clear error status without any recovery.
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
