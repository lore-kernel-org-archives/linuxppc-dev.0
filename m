Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 9811EDDFF0
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 00:42:40 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
Subject: Re: AZFS file system proposal
Date: Tue, 8 Jul 2008 16:42:18 +0200
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de>
	<20080707173923.17dc6c05@mercedes-benz.boeblingen.de.ibm.com>
In-Reply-To: <20080707173923.17dc6c05@mercedes-benz.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807081642.19507.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-fsdevel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Maxim Shchetynin wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=
 (copy_to_user(target, (void*) pin, size)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D -EFAULT;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > Question to the powerpc folks: is copy_to_user safe for an __iomem sour=
ce?
> > Should there be two copies (memcpy_fromio and copy_to_user) instead?
>=20
> I leave this question open.
>=20

Cc:'ing some more people that might have more of a clue on this question.
_memcpy_fromio does a "sync" at the start and an "eieio" at the end.
IFAICT, neither are needed here because the source is always memory.

It also handles unaligned memory accesses, which copy_to_user should
also do correctly, so it *looks* like it should work with just a
copy_to_user, but it still feels wrong to use an __iomem pointer
as the source for a copy_to_user.

Any ideas?

	Arnd <><
