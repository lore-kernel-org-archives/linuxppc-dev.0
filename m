Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id A50FFDDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 23:29:48 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Jan Kratochvil <jan.kratochvil@redhat.com>
Subject: Re: PPC upstream kernel ignored DABR bug
Date: Wed, 28 Nov 2007 13:28:48 +0100
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711272335.36981.arnd@arndb.de>
	<20071128085907.GA19651@host0.dyn.jankratochvil.net>
In-Reply-To: <20071128085907.GA19651@host0.dyn.jankratochvil.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711281328.50386.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 28 November 2007, Jan Kratochvil wrote:
> Please be aware DABR works fine if the same code runs just 1 (always) or
> 2 (sometimes) threads. =C2=A0It starts failing with too many threads runn=
ing:
>=20
> $ ./dabr-lost
> TID 32725: DABR 0x1001279f NIP 0xfecf41c
> TID 32726: DABR 0x1001279f NIP 0xfecf41c
> TID 32725: hitting the variable
> variable found =3D -1, caught TID =3D 32725
> TID 32726: hitting the variable
> variable found =3D -1, caught TID =3D 32726
> The kernel bug did not get reproduced - increase THREADS.
>=20
> As I did not find any code in that kernel touching DABRX its value should=
 not
> be dependent on the number of threads running.
>=20

Right, this is a different problem from the one reported by Uli.
=46rom what I can tell, your problem is that you set the DABR only
in one thread, so the other threads don't see it. DABR is saved
in the thread_struct, so setting it in one thread doesn't have
an impact on any other thread.

	Arnd <><
