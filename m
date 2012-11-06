Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA7B82C008B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2012 03:34:40 +1100 (EST)
Date: Tue, 6 Nov 2012 10:34:15 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc: Don't silently handle machine checks from userspace
To: Micha Nelissen <micha.nelissen@Prodrive.nl>
References: <5093B318.9040305@prodrive.nl> <1351874164.5089.1@snotra>
 <39F93B8F6D09AC4DA45E2F19603FA69C324EEDCD@exc02.bk.prodrive.nl>
In-Reply-To: <39F93B8F6D09AC4DA45E2F19603FA69C324EEDCD@exc02.bk.prodrive.nl>
 (from micha.nelissen@Prodrive.nl on Tue Nov  6 03:21:37 2012)
Message-ID: <1352219655.21833.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Martijn de Gouw <martijn.de.gouw@Prodrive.nl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2012 03:21:37 AM, Micha Nelissen wrote:
> From: Scott Wood [mailto:scottwood@freescale.com]
> > > Therefore I request to put this check back, and even to put the
> > > removed code at the top of the machine check handler because =20
> there is
> > > no point in trying to recover from a user space bus error anyway.
> >
> > Why is there no point trying to recover?  For example, see =20
> MCSR_ICPERR
> > and MCSR_DCPERR_MC in machine_check_e500mc.  The machine check is =20
> just
> > letting us know that there was an error and the read-only cache got
> > dumped (i.e. it was a correctable error).
>=20
> Oh I overlooked those cases; those correctable errors shouldn't be =20
> bus errors for the user space process?
>=20
> Hmm I guess there is no simple solution then, since the "recover" =20
> function also prints the kernel messages about the machine check =20
> being in kernel mode without having checked whether it really was in =20
> kernel mode. In the past the user mode check was in between.

It shouldn't be that difficult to make it say "in user mode" or "in =20
kernel mode" depending on which it was... or just remove that phrase =20
altogether and let the following output indicate whether it was in =20
kernel mode.

-Scott=
