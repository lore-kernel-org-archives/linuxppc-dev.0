Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 73BE1679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 18:54:20 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7TADGG6006626 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 04:13:16 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7T8sF3J004824
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 03:54:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: atomic operations in user space
Date: Tue, 29 Aug 2006 16:54:46 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC774@zch01exm20.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0608290946230.9162@frodo.shire>
From: "Li Yang-r58472" <LeoLi@freescale.com>
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

> -----Original Message-----
> From: Esben Nielsen [mailto:nielsen.esben@gogglemail.com]
> Sent: Tuesday, August 29, 2006 4:33 PM
> To: Li Yang-r58472
> Cc: Xupei Liang; linuxppc-embedded@ozlabs.org
> Subject: RE: atomic operations in user space
>=20
>=20
>=20
> On Tue, 29 Aug 2006, Li Yang-r58472 wrote:
>=20
> >> -----Original Message-----
> >> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> >> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org]
On
> > Behalf Of
> >> Xupei Liang
> >> Sent: Tuesday, August 29, 2006 8:44 AM
> >> To: linuxppc-embedded@ozlabs.org
> >> Subject: RE: atomic operations in user space
> >>
> >> I think it is less expensive using atomic operation
> >> sometimes in the user space, e.g. when updating a
> >
> > Atomic operations are working under strict restrictions.  Generally
they
> > won't work for user space.  Your best bet is to use semaphore
instead.
> >
>=20
> Wrong.
> 1) Semaphores give priority inversions. Use a mutex with priority
> inheritance instead. This comes in 2.6.18.
> 2) These mutexes are based on futexes which requires atomic operations
in
> userspace. These are available on most architectures. Look at the
glibc code
> in nptl/sysdeps/unix/sysv/linux/powerpc/lowlevellock.h forinstance.
> Use that and your PPC manual to implement your atomic operations.

No matter semaphore or futex, it uses system calls to kernel.  And the
true atomic operation is in kernel not user space.  Maybe it's feasible
for other architectures to do atomic operations directly in user space.
IMHO, not for powerpc.

>=20
> Esben
>=20
> >> counter. If this counter is to be updated by a lot of
> >> processes, using semaphore can potentially cause a lot
> >> of task switching.
> >>
> >> Regards,
> >>
> >> Terry Liang
> >>
> >>
> >>> -----Original Message-----
> >>> From: Brent Cook [mailto:bcook at bpointsys.com]
> >>> Sent: Thursday, August 24, 2006 10:18 PM
> >>> To: linuxppc-embedded at ozlabs.org
> >>> Cc: Li Yang-r58472; Terry Liang
> >>> Subject: Re: atomic operations in user space
> >>>
> >>> On Thursday 24 August 2006 05:39, Li Yang-r58472
> >> wrote:
> >>>
> >>>> Why do you need atomic operations in user land?
> >> IPC will be
> >> sufficient
> >>>
> >>>> to deal with race conditions between processes.
> >>>
> >>>>
> >>>
> >>>> Best Regards,
> >>>
> >>>> Leo
> >>>
> >>> What about multiple threads within a process
> >> updating a counter?
> >>
> >> Is there anything preventing semaphore to be used in
> >> threads?
> >>>
> >>> Of course, if you look at these functions in the
> >> kernel header,
> >> they're just 2 or
> >>> 3 inline assembly calls - you could easily rewrite
> >> them. Google for
> >> 'PowerPC atomic
> >>> increment' and grab one of the unencumbered
> >> implementations if you
> >> need to use it
> >>> in a non-GPL program.
> >>>
> >>> On the other hand, I see no license at the top of my
> >> /usr/include/asm-i386/atomic.h
> >>> file at all, same for PowerPC - are Linux header
> >> files actually GPL or
> >> are they
> >>> more like the glibc headers, with exceptions made
> >> for userspace
> >> programs?
> >>>
> >>> The atomic operations on x86 were accidentally
> >> exported early on, so
> >> they have to
> >>> hang around apparently for compatibility (there are
> >> some mailing list
> >> threads out
> >>> there to this effect.) Currently, you just have to
> >> assume in Linux
> >> that if you
> >>> include something from /usr/include/linux or asm
> >> that it will not
> >> necessarily be
> >>> cross-version or cross-architecture compatible. Not
> >> every arch in
> >> Linux even has
> >>> atomic operations of this nature, which I guess is
> >> the main reason why
> >> they are
> >>> not exported in general.
> >>>
> >>> - Brent
> >>
> >>
> >>
> >> __________________________________________________
> >> Do You Yahoo!?
> >> Tired of spam?  Yahoo! Mail has the best spam protection around
> >> http://mail.yahoo.com
> >> _______________________________________________
> >> Linuxppc-embedded mailing list
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
