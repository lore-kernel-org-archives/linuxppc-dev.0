Return-Path: <B16395@freescale.com>
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 3/4] powerpc/mpic: Move internal interrupt source vector
 allocation to a separate function.
Date: Wed, 4 Apr 2012 19:09:33 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0B77F9@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1332850586-23610-1-git-send-email-Varun.Sethi@freescale.com>
 <84A55A49-747D-4C87-9E5C-E5C63C0CEDA7@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D0B11BA@039-SN2MPN1-013.039d.mgd.msft.net>
 <BA2352CD-6C54-4D33-86DB-F55DBDBA6E5F@kernel.crashing.org>
In-Reply-To: <BA2352CD-6C54-4D33-86DB-F55DBDBA6E5F@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, March 27, 2012 7:32 PM
> To: Sethi Varun-B16395
> Cc: Linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/4] powerpc/mpic: Move internal interrupt source
> vector allocation to a separate function.
>=20
>=20
> On Mar 27, 2012, at 8:52 AM, Sethi Varun-B16395 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Tuesday, March 27, 2012 6:55 PM
> >> To: Sethi Varun-B16395
> >> Cc: Linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: [PATCH 3/4] powerpc/mpic: Move internal interrupt source
> >> vector allocation to a separate function.
> >>
> >>
> >> On Mar 27, 2012, at 7:16 AM, Varun Sethi wrote:
> >>
> >>> Allocate vector numbers for MPIC internal interrupt sources (IPIs
> >>> and
> >>> Timers) in a separate function.
> >>>
> >>
> >> Explain why you are making this change.
> >
> >
> > [Sethi Varun-B16395] With the current code it becomes fairly difficult
> > to add new internal interrupt sources. In my case I had to add 32
> > additional interrupt sources corresponding to the MPIC error
> > interrupts. It's more convenient doing the internal interrupt source
> allocation using a loop.
>=20
> I think that is more due to how you added the MPIC error interrupts and
> issues w/that code.  If you are treating the MPIC error interrupts as a
> cascade than they should have a distinct linux IRQ space from the
> standard MPIC interrupts.  This is how the MSIs work (as an example).
In case of error interrupts we are depending on the mpic_host_maps
for mapping and interrupt specifier translations. There is no separate
initialization as in case of MSIs. That's the reason I am treating
error interrupts as mpic internal interrupt sources.

-Varun
