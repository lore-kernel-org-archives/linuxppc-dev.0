Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id CD211DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 09:36:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: PPC upstream kernel ignored DABR bug
Date: Tue, 27 Nov 2007 23:35:36 +0100
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
In-Reply-To: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
MIME-Version: 1.0
Message-Id: <200711272335.36981.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Paul Mackerras <paulus@samba.org>,
	Jan Kratochvil <jan.kratochvil@redhat.com>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 26 November 2007, Jan Kratochvil wrote:
> Hi,
>=20
> this testcase:
> =A0=A0=A0=A0=A0=A0=A0=A0http://people.redhat.com/jkratoch/dabr-lost.c
>=20
> reproduces a PPC DABR kernel bug. =A0The variable `variable' should not g=
et
> modified as the thread modifying it should be caught by its DABR:
>=20
> $ ./dabr-lost
> TID 30914: DABR 0x10012a77 NIP 0x80f6ebb318
> TID 30915: DABR 0x10012a77 NIP 0x80f6ebb318
> TID 30916: DABR 0x10012a77 NIP 0x80f6ebb318
> TID 30914: hitting the variable
> TID 30915: hitting the variable
> TID 30916: hitting the variable
> variable found =3D 30916, caught TID =3D 30914
> TID 30916: DABR 0x10012a77
> Variable got modified by a thread which has DABR still set!
>=20

This sounds like a bug recently reported by Uli Weigand. BenH
said he'd take a look, but it probably fell under the table.
The problem found by Uli is that on certain processors (Cell/B.E.
in his case), the DABRX register needs to be set in order for
the DABR to take effect.

	Arnd <><
