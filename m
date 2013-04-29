Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35C622C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 06:29:55 +1000 (EST)
Date: Mon, 29 Apr 2013 15:29:44 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to fix
 PCIe erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <1366684776-10946-2-git-send-email-hongtao.jia@freescale.com>
 <CA5B8197-1A55-4E6E-AE0C-CD015D97EC83@kernel.crashing.org>
 <1366909096.30341.3@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C4C76D@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C4C76D@039-SN1MPN1-002.039d.mgd.msft.net>
 (from B38951@freescale.com on Fri Apr 26 21:26:26 2013)
Message-ID: <1367267384.32182.14@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/26/2013 09:26:26 PM, Jia Hongtao-B38951 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, April 26, 2013 12:58 AM
> > To: Segher Boessenkool
> > Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> > galak@kernel.crashing.org; Wood Scott-B07421
> > Subject: Re: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler =20
> to
> > fix PCIe erratum on mpc85xx
> >
> > On 04/25/2013 10:31:51 AM, Segher Boessenkool wrote:
> > >> * Remove A variant of load instruction emulation
> > >
> > > Why is this?  You handle all other simple load insns, there is =20
> nothing
> > > special about LHA.  (I reviewed the V4 email thread, no reason =20
> for the
> > > chance is given there).
> >
> > The LHA implementation in V5 was incorrect (didn't sign-extend).
> >
> > -Scott
>=20
> In former email you doubt whether we need A variant or not.
> Any particular reason for that?
> If not should I emulate all the A ARX AU AUX and AX variant?

I was just noting that the variants you left out from the earlier =20
revisions (e.g. BRX) were much more likely to be used for I/O than some =20
of the ones you included (e.g. "A").  Implementing all the normal =20
load/store instructions would be better, if they're done correctly.

-Scott=
