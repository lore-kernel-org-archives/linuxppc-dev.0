Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 38CAE67C7E
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 13:28:06 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k9V2S05O012348
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 19:28:00 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9V2RtEd005076
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 20:27:56 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
Date: Tue, 31 Oct 2006 10:28:41 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D2632BC@zch01exm20.fsl.freescale.net>
In-Reply-To: <3C52C167-8CD5-4731-9F66-D8651E712DDD@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, October 31, 2006 6:16 AM
> To: Li Yang-r58472
> Cc: Paul Mackerras; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
>=20
>=20
> On Oct 30, 2006, at 12:22 AM, Li Yang-r58472 wrote:
>=20
> >> -----Original Message-----
> >> From: Paul Mackerras [mailto:paulus@samba.org]
> >> Sent: Monday, October 30, 2006 11:22 AM
> >> To: Li Yang-r58472
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
> >>
> >> Li Yang writes:
> >>
> >>> Remove private physical address mapping routine in qe_lib.  Users
> >>> of qe_lib should use generic functions like iopa().
> >>> The change also addresses a bug found by Timur Tabi that cmd_input
> >>> got mapped in qe_issue_cmd().  It should be written to CECDR
> >>> unmodified.
> >>
> >> Do you mean that the argument to qe_issue_cmd is a physical
address?
> >> It seems to me that the bug fix you mention is the main thing the
> >> patch does, and the removal of immrvar_virt_to_phys is a cleanup on
> >> the side that is made possible by the bugfix.
> >
> > The argument cmd_input should be offset to the MURAM base.  The
> > cleanup
> > is inspired by the bugfix but not result of the bugfix.  There are
> > still
> > other users of the immrbar_virt_to_phy() which can be replaced.  The
> > bugfix can be covered by the work of removing all users of the
> > routine.
> > Or the removal will be depending on the bugfix to complete its
> > work.  Do
> > you suggest us to separate the patches?
>=20
> I'm confused, if there are other users of immrbar_virt_to_phy() how
> can you get ride of it completely?

Other users will change to use iopa() instead.  There was some bug to
use iopa() with io_block_mapping area, but it is ok to use it now.

- Leo
