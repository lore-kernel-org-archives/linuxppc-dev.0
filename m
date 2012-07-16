Return-Path: <B08248@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 964CF2C0113
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 07:20:29 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc: set stack limit properly in
 crit_transfer_to_handler
Date: Mon, 16 Jul 2012 21:20:08 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15033AE3D1@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1342465608-20596-1-git-send-email-stuart.yoder@freescale.com>
 <544C2283-0681-496A-B2CE-444505CD17DE@kernel.crashing.org>
In-Reply-To: <544C2283-0681-496A-B2CE-444505CD17DE@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "agraf@suse.de" <agraf@suse.de>, "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, July 16, 2012 3:36 PM
> To: Yoder Stuart-B08248
> Cc: benh@kernel.crashing.org; sfr@canb.auug.org.au; paulus@samba.org; lin=
uxppc-dev@lists.ozlabs.org;
> agraf@suse.de
> Subject: Re: [PATCH] powerpc: set stack limit properly in crit_transfer_t=
o_handler
>=20
>=20
> On Jul 16, 2012, at 2:06 PM, Stuart Yoder wrote:
>=20
> > From: Stuart Yoder <stuart.yoder@freescale.com>
> >
> > without setting the stack limit like this there is the possibility
> > of stack overflow which corrupts the thread info but
> > is not detected by stack overflow detection
> >
> > Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> > ---
> > arch/powerpc/kernel/entry_32.S |   12 ++++++++++--
> > 1 files changed, 10 insertions(+), 2 deletions(-)
>=20
> Do we need this for debug & mcheck ?

Maybe... I don't know the history of this code
and why this is only done in the critical exception
handlers.

But, this particular patch is to undo/fix something I
introduced in:
powerpc: Use CURRENT_THREAD_INFO instead of open coded assembly

Stuart
