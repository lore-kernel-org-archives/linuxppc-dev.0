Return-Path: <stevedeiters@basler.com>
Received: from tethra.basler.com (tethra.basler.com [206.107.254.19])
	by ozlabs.org (Postfix) with ESMTP id 52090B6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 00:38:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
Date: Thu, 8 Jul 2010 09:38:22 -0500
Message-ID: <181804936ABC2349BE503168465576460F3D3E66@exchserver.basler.com>
In-Reply-To: <AANLkTilNssNdEW3wBKfoUMbSQMFLywfFgGMb0F9XwKeG@mail.gmail.com>
References: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
	<1278565845.28659.75.camel@pasglop>
	<AANLkTilNssNdEW3wBKfoUMbSQMFLywfFgGMb0F9XwKeG@mail.gmail.com>
From: "Steve Deiters" <SteveDeiters@BASLER.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Thursday, July 08, 2010 12:38 AM
> To: Benjamin Herrenschmidt
> Cc: Steve Deiters; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use=20
> alternate memcpy for MPC512x and MPC52xx
>=20
> On Wed, Jul 7, 2010 at 11:10 PM, Benjamin Herrenschmidt=20
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2010-06-29 at 11:04 -0500, Steve Deiters wrote:
> >> These processors will corrupt data if accessing the local bus with=20
> >> unaligned addresses. This version fixes the typical case=20
> of copying=20
> >> from Flash on the local bus by keeping the source address always=20
> >> aligned.
> >
> > Shouldn't this be solved by using memcpy_to/fromio ?
>=20
> Maybe.  plain memcpy() access to anything localbus-attached=20
> on the mpc5xxx is the wrong thing to do.  memcpy_to/fromio=20
> might do the right thing; but the caller must understand the=20
> limitations of the localplus bus.  The byte-wise alignment=20
> that memcpy_to/fromio() does may not work (depending on=20
> configuration).
>=20
> Steve, what code is doing a memcpy from flash?
>=20
> g.

This was done in the JFFS2 code, in fs/jffs2/scan.c.  At least in one
function, in jffs2_scan_dirent_node it was using memcpy on a localbus
mapped structure.  I was getting JFFS2 filesystem corruption because of
this.  In fact I first tried changing this to memcpy_fromio and it fixed
that particular problem.  I was concerned though that other places I was
not aware of might be using memcpy from the localbus in a similar manner
so I decided to just tweak the memcpy routine.

Just out of curiousity, what configuration might cause a byte-wise
alignment not to work?
