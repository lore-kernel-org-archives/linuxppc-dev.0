Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id C44ACDDEE6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 22:44:37 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@jdub.homelinux.org>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Date: Tue, 21 Aug 2007 14:05:58 +0200
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<20070820214730.1b3b6fd6@vader.jdub.homelinux.org>
	<20070821025015.GN15469@localhost.localdomain>
In-Reply-To: <20070821025015.GN15469@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708211405.59226.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 21 August 2007, David Gibson wrote:
>=20
> > > > The point would be to keep the two trees separate, so that one
> > > > doesn't need to worry about breaking arch/ppc when making a change
> > > > to arch/powerpc.
> > >=20
> > > Exactly so. =A0Having to be careful about not breaking arch/ppc when
> > > doing cleanups for arch/powerpc is a pain in the bum.
> >=20
> > How many times has that happened recently? =A0If it's fairly infrequent,
>=20
> It's infrequent because I've shyed away from cleaning up shared files,
> precisely because I'm afraid of breaking arch/ppc.

How about splitting the files on a per-case bases then? There are at least
95 files that would need to be duplicated (again) to make ppc independent
from powerpc, and most of these files are about userland interfaces where
duplication makes no sense at all.

Some files in there (irq.h, ipic.h, dcr.h, i8259.h) already have large
parts hidden in #ifdef CONFIG_PPC_MERGE, so I guess for those it may
actually be interesting to split them in two again.

	Arnd <><
