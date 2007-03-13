Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F136FDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 20:32:30 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2D9WQPq029270
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 02:32:27 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2D9WPXl010400
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 04:32:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Add irq host and hwirq pair fields to output whenshowing
	interrupts.
Date: Tue, 13 Mar 2007 17:32:21 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C131E7F@zch01exm26.fsl.freescale.net>
In-Reply-To: <1173770092.24454.69.camel@localhost.localdomain>
References: <1173755968459-git-send-email-wei.zhang@freescale.com>
	<1173770092.24454.69.camel@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Wang Haiying-r54964 <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Tue, 2007-03-13 at 11:19 +0800, Zhang Wei wrote:
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > ---
> >  arch/powerpc/kernel/irq.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index 919fbf5..2a30ffd 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -194,7 +194,7 @@ #else
> >  		seq_printf(p, "%10u ", kstat_irqs(i));
> >  #endif /* CONFIG_SMP */
> >  		if (desc->chip)
> > -			seq_printf(p, " %s ", desc->chip->typename);
> > +			seq_printf(p, " (%3d) @%s ",=20
> (irq_map[i].host->revmap_type =3D=3D IRQ_HOST_MAP_LEGACY) ? i :=20
> virq_to_hw(i), desc->chip->typename);
> >  		else
> >  			seq_puts(p, "  None      ");
> >  		seq_printf(p, "%s", (desc->status & IRQ_LEVEL)=20
> ? "Level " : "Edge  ");
>=20
> Well, first, we shouldn't modify the output of=20
> /proc/interrupts as this
> will likely break all sort of userland tools displaying it (well, I
> think).
>=20
> Now, regarding the patch itself, printing the hw irq is not=20
> that useful
> without some indication of which host it belongs to. Best is to add a
> name() or something like that to the host ops.
>=20

Sure, can I use the PIC controller node full name from of_tree as the
host name?

Do you prefer debugfs instead of /proc/interrupts?

Thanks!
Zhang Wei
