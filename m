Return-Path: <B16395@freescale.com>
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/4] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for
 FSL MPIC.
Date: Tue, 27 Mar 2012 13:59:33 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0B121C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1332850557-23557-1-git-send-email-Varun.Sethi@freescale.com>
 <295B3D3A-F038-4176-90EF-423A6BB84F62@kernel.crashing.org>
In-Reply-To: <295B3D3A-F038-4176-90EF-423A6BB84F62@kernel.crashing.org>
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
> Sent: Tuesday, March 27, 2012 7:01 PM
> To: Sethi Varun-B16395
> Cc: Linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 2/4] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag
> for FSL MPIC.
>=20
>=20
> On Mar 27, 2012, at 7:15 AM, Varun Sethi wrote:
>=20
> > FSL MPIC supports 16 bit vectors so our vector number space isn't
> > restricted to 256 vectors. We should use the MPIC_LARG_VECTORS flag
> > while intializing the MPIC. This also prevents us from eating in to
> > hardware vector number space (MSIs) while setting up internal sources.
>=20
> What is driving this change?  The commit message isn't quite correct as
> MPIC_LARGE_VECTORS is about the # of IRQs, not the fact that vector field
> is 16-bits.
>=20
[Sethi Varun-B16395] We derive the internal interrupt source vector numbers=
 from the
number of supported hardware interrupt sources. With the current value of 2=
56
we end up using vector numbers (for internal sources) corresponding to actu=
al hardware
interrupts. With the MPIC_LARGE_VECTORS flag we can avoid eating in to hard=
ware vector
number space.

-Varun
