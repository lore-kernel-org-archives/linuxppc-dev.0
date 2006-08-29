Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 53BEC67A5E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 20:52:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7TB4PjF009997 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 04:04:25 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7TAq5ij015352
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 05:52:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: atomic operations in user space
Date: Tue, 29 Aug 2006 18:52:35 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC7A3@zch01exm20.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0608291136370.12461@frodo.shire>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Esben Nielsen" <nielsen.esben@gogglemail.com>,
	"Liu Dave-r63238" <DaveLiu@freescale.com>
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


> -----Original Message-----
> From: Esben Nielsen [mailto:nielsen.esben@gogglemail.com]
> Sent: Tuesday, August 29, 2006 5:57 PM
> To: Liu Dave-r63238
> Cc: Li Yang-r58472; Esben Nielsen; Xupei Liang;
linuxppc-embedded@ozlabs.org
> Subject: RE: atomic operations in user space
>=20
>=20
>=20
> On Tue, 29 Aug 2006, Liu Dave-r63238 wrote:
>=20
> >>> 2) These mutexes are based on futexes which requires atomic
> >>> operations in userspace. These are available on most
architectures.
> > Look at
> >>> the glibc code in
> >>> nptl/sysdeps/unix/sysv/linux/powerpc/lowlevellock.h for instance.
> >>> Use that and your PPC manual to implement your atomic operations.
> >>
> >> No matter semaphore or futex, it uses system calls to kernel.
>=20
> There is only a system call if there is congestion - that is the whole
idea
> behind the futex.
>=20
> >> And the
> >> true atomic operation is in kernel not user space.
>=20
> "True" atomic operations are available in user space on most
architectures.
>=20
> >> Maybe
> >> it's feasible
> >> for other architectures to do atomic operations directly in
> >> user space.
> >> IMHO, not for powerpc.
>=20
> It is available for PowerPC, but not in POWER and POWER2
instructionsets
> according to http://www.nersc.gov/vendor_docs/ibm/asm/lwarx.htm#idx607
> It is the same in the ARM world: Atomic instructions was introduced in
> ARMv6 I believe. Older ARM processors don't have them.

Yes, I do know there are lwarx and stwrx instructions.  But there is
only one reservation per CPU and reservation can be re-established with
no difference.
So there are possibilities reservation is broken and reserved again in
one atomic block.

Task A			Task B
lwarx
				......
				lwarx
				stwrx

				.....
				.....
				lwarx
stwrx
.....
				stwrx

The addresses of above operations are the same.

In this case Thread A thinks that it is atomic as it holds the same
reservation, but it is actually broken.  Such control flow can't be
prevented in user space.

>=20
> >
> > Are you meaning that we didn't do atomic operations directly in user
> > space
> > on powerpc platform ?
> >
>=20
> Well, that is not the conclusion I get either when reading the glibc
code.
> Try to look at glibc-2.3.5/sysdeps/powerpc/bits/atomic.h.
>=20
> This is by the way probably what the original post in this thread
wanted
> in the first place!
>=20
> Esben
>=20
>=20
> > -DAve
