Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id B1070679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 22:36:44 +1000 (EST)
MIME-Version: 1.0
Subject: RE: atomic operations in user space
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 29 Aug 2006 07:36:30 -0500
Message-ID: <383EF70E894C52438F955558754247FD0112C662@mail.securitytestsystems.com>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC7A3@zch01exm20.fsl.freescale.net>
From: "Brent Cook" <bcook@bpointsys.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
	"Esben Nielsen" <nielsen.esben@gogglemail.com>,
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
> From:=20
> linuxppc-embedded-bounces+bcook=3Dbpointsys.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+bcook=3Dbpointsys.com@ozlabs.o
rg] On Behalf Of Li Yang-r58472
> Sent: Tuesday, August 29, 2006 5:53 AM
> To: Esben Nielsen; Liu Dave-r63238
> Cc: Xupei Liang; linuxppc-embedded@ozlabs.org
> Subject: RE: atomic operations in user space
>=20
> > It is available for PowerPC, but not in POWER and POWER2
> instructionsets
> > according to=20
> http://www.nersc.gov/vendor_docs/ibm/asm/lwarx.htm#idx607
> > It is the same in the ARM world: Atomic instructions was=20
> introduced in
> > ARMv6 I believe. Older ARM processors don't have them.
>=20
> Yes, I do know there are lwarx and stwrx instructions.  But=20
> there is only one reservation per CPU and reservation can be=20
> re-established with no difference.
> So there are possibilities reservation is broken and reserved=20
> again in one atomic block.
>=20
> Task A			Task B
> lwarx
> 				......
> 				lwarx
> 				stwrx
>=20
> 				.....
> 				.....
> 				lwarx
> stwrx
> .....
> 				stwrx
>=20
> The addresses of above operations are the same.
>=20
> In this case Thread A thinks that it is atomic as it holds=20
> the same reservation, but it is actually broken.  Such=20
> control flow can't be prevented in user space.
>=20

This is exactly how it is supposed to work! That's why there is a loop
in the atomic increment - you check if you still had the reservation
after the transaction by checking the result from the stwcx, and if not,
retry. This works perfectly well no matter if it is from userspace or
the kernel - it is a CPU function. It even works between CPUs on some
later PowerPCs - I've had it working perfectly from userspace on a dual
7448 setup.

PowerPC atomic instructions are not atomic in the sense that they _lock_
anything. The only thing these instructions give you is a way to see if
another thread used the instructions while your thread was using them,
and if you see a conflict, you retry until your code finishes
uninterrupted. This makes it fine for short transactions, like atomic
increment. You probably would not want to use these instructions for
protecting longer transactions of more than a few instructions.

If you look at how, for instance, futexes work in Linux, they rely on
being able to do atomic increment and decrement from _userspace_.

Read this article to understand how it works:
http://www-128.ibm.com/developerworks/library/pa-atom/

 - Brent
