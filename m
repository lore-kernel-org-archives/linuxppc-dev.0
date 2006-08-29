Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 32D94679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 20:05:34 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7TBOQ7K023008 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 05:24:26 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7TA5Pqo005333
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 05:05:27 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: atomic operations in user space
Date: Tue, 29 Aug 2006 18:05:24 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BAF0@zch01exm21.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0608291136370.12461@frodo.shire>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Esben Nielsen" <nielsen.esben@gogglemail.com>
Cc: Xupei Liang <tliang@yahoo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> >>> 2) These mutexes are based on futexes which requires atomic=20
> >>> operations in userspace. These are available on most=20
> architectures.
> > Look at
> >>> the glibc code in
> >>> nptl/sysdeps/unix/sysv/linux/powerpc/lowlevellock.h for instance.
> >>> Use that and your PPC manual to implement your atomic operations.
> >>
> >> No matter semaphore or futex, it uses system calls to kernel.
>=20
> There is only a system call if there is congestion - that is=20
> the whole idea behind the futex.
>=20
> >> And the
> >> true atomic operation is in kernel not user space.
>=20
> "True" atomic operations are available in user space on most=20
> architectures.
>=20
> >> Maybe
> >> it's feasible
> >> for other architectures to do atomic operations directly in user=20
> >> space.
> >> IMHO, not for powerpc.
>=20
> It is available for PowerPC, but not in POWER and POWER2=20
> instructionsets according to=20
> http://www.nersc.gov/vendor_docs/ibm/asm/lwarx.htm#idx607
> It is the same in the ARM world: Atomic instructions was introduced in
> ARMv6 I believe. Older ARM processors don't have them.
>=20
> >
> > Are you meaning that we didn't do atomic operations directly in user
> > space
> > on powerpc platform ?
> >
>=20
> Well, that is not the conclusion I get either when reading=20
> the glibc code.
> Try to look at glibc-2.3.5/sysdeps/powerpc/bits/atomic.h.
>=20
> This is by the way probably what the original post in this=20
> thread wanted=20
> in the first place!
>=20
> Esben

I totally agree with you and Brant about it. I don't believe we cannot
do the atomic operation in user space on powerpc.

-DAve=20
