Return-Path: <micha.nelissen@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by ozlabs.org (Postfix) with ESMTP id A1B642C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2012 20:48:07 +1100 (EST)
From: Micha Nelissen <micha.nelissen@Prodrive.nl>
To: 'Scott Wood' <scottwood@freescale.com>, Martijn de Gouw
 <martijn.de.gouw@prodrive.nl>
Subject: RE: powerpc: Don't silently handle machine checks from userspace
Date: Tue, 6 Nov 2012 09:21:37 +0000
Message-ID: <39F93B8F6D09AC4DA45E2F19603FA69C324EEDCD@exc02.bk.prodrive.nl>
References: <5093B318.9040305@prodrive.nl> <1351874164.5089.1@snotra>
In-Reply-To: <1351874164.5089.1@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood [mailto:scottwood@freescale.com]
> > Therefore I request to put this check back, and even to put the
> > removed code at the top of the machine check handler because there is
> > no point in trying to recover from a user space bus error anyway.
>=20
> Why is there no point trying to recover?  For example, see MCSR_ICPERR
> and MCSR_DCPERR_MC in machine_check_e500mc.  The machine check is just
> letting us know that there was an error and the read-only cache got
> dumped (i.e. it was a correctable error).

Oh I overlooked those cases; those correctable errors shouldn't be bus erro=
rs for the user space process?

Hmm I guess there is no simple solution then, since the "recover" function =
also prints the kernel messages about the machine check being in kernel mod=
e without having checked whether it really was in kernel mode. In the past =
the user mode check was in between.

Micha
