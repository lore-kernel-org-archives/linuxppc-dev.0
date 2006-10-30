Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A8AF767CB5
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 17:21:51 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9U7gk4v007629
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 00:42:46 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k9U6LhGK011328
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 00:21:44 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
Date: Mon, 30 Oct 2006 14:22:29 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D2631CD@zch01exm20.fsl.freescale.net>
In-Reply-To: <17733.28614.62353.822225@cargo.ozlabs.ibm.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Paul Mackerras [mailto:paulus@samba.org]
> Sent: Monday, October 30, 2006 11:22 AM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
>=20
> Li Yang writes:
>=20
> > Remove private physical address mapping routine in qe_lib.  Users
> > of qe_lib should use generic functions like iopa().
> > The change also addresses a bug found by Timur Tabi that cmd_input
> > got mapped in qe_issue_cmd().  It should be written to CECDR
> > unmodified.
>=20
> Do you mean that the argument to qe_issue_cmd is a physical address?
> It seems to me that the bug fix you mention is the main thing the
> patch does, and the removal of immrvar_virt_to_phys is a cleanup on
> the side that is made possible by the bugfix.

The argument cmd_input should be offset to the MURAM base.  The cleanup
is inspired by the bugfix but not result of the bugfix.  There are still
other users of the immrbar_virt_to_phy() which can be replaced.  The
bugfix can be covered by the work of removing all users of the routine.
Or the removal will be depending on the bugfix to complete its work.  Do
you suggest us to separate the patches?

- Leo
