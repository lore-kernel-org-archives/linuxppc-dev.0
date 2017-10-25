Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMRwt4tZYzDqY9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 21:59:42 +1100 (AEDT)
Message-ID: <1508929182.27418.19.camel@neuling.org>
Subject: Re: [PATCH] powernv: Avoid checkstop on HMI and MCE
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 anton@ozlabs.org,  Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Vipin K
 Parashar <vipin@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 21:59:42 +1100
In-Reply-To: <871slr1qip.fsf@concordia.ellerman.id.au>
References: <20171024092005.3861-1-mikey@neuling.org>
 <871slr1qip.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-25 at 12:16 +0200, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
>=20
> > On an unrecoverable HMI or MCE only generate an checkstop (via
> > PLATFORM ERROR opal reboot call) when panic_on_oops is set.
> >=20
> > We currently generate an checkstop as an attempt for the FSP to grab a
> > dump and then reboot us. Unfortunately this never works and no one
>=20
> Never? WT#.

Well no one I've talked but I'm posting this so someone will stand up and s=
ay
they want it.

> > I've talked to has ever seen a resulting dump, let alone got useful
> > information from it.
> >=20
> > Even worse, the checkstop gets in the way of debugging real
> > problems. If we hit a software bug that results in this, we get no
> > opportunity to debug it live. Similarly if the bug is due to hardware
> > that is not in the dump (say PCI or NVLINK GPU), we get no information
> > in the dump about that hardware.
> >=20
> > So let's remove it unless someone sets panic_on_oops.
>=20
> Nick just rewrote pnv_platform_error_reboot(), so please talk to him to
> make sure you're not stepping on each other.

OK, will do.

> > diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c
> > b/arch/powerpc/platforms/powernv/opal-hmi.c
> > index c9e1a4ff29..23780970d0 100644
> > --- a/arch/powerpc/platforms/powernv/opal-hmi.c
> > +++ b/arch/powerpc/platforms/powernv/opal-hmi.c
> > @@ -284,6 +285,11 @@ static void hmi_event_handler(struct work_struct *=
work)
> >  			print_hmi_event_info(hmi_evt);
> >  		}
> > =20
> > +		if (!panic_on_oops) {
> > +			die("Unrecoverable HMI exception", NULL, SIGBUS);
> > +			return;
>=20
> I don't think we should return.
>=20
> Otherwise we risk persisting corrupt data to disk and so on.

ok

> If we're getting unrecoverable HMI/MCEs that are not actually indicative
> of something bad happening then we need to filter those out somewhere.

We hit this with some new HMIs for NVLINK and the Vector Load one, so we ne=
ed to
handle them, and we have code that does (or is coming).

In the mean while, it's very hard to debug them once we xstop.

Mikey
