Return-Path: <DaveLiu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: atomic operations in user space
Date: Wed, 30 Aug 2006 10:17:05 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BB47@zch01exm21.fsl.freescale.net>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>, <linuxppc-embedded@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]
> I surely know all the theories you mentioned clearly.  But=20
> please do look at the case I gave.  Correct me if I missed=20
> anything.  Thanks
>=20
> All the lwarx and stwcx operate on the same address.
>=20
> > Task A		Task B
> > lwarx			=09
> // Get RESERVATION
> > 			......
> > 			lwarx
> > 			stwcx
>=20
> // RESERVATION cleared
> >
> > 			.....
> > 			.....
> > 			lwarx
>=20
> // Get RESERVATION again
> > stwcx			=09
>=20
> //Note here: RESERVATION is valid, address is the same.
> So the result is commited, no retry for task A
>=20
> > .....
> > 			stwcx
> //RESERVATION is cleared, retry atomic op for task B
>=20
> Please be noted that reservation is only identified by=20
> reservation bit and address operated on.  So different=20
> lwarx's on the same address, may be considered as the same=20
> reservation.

Is this your reason we cannot do atomic operation in user space?

How about the kernel space? You can image it.
The context switching as above also happen in kernel space,
Why we can do atomic operation in kernel space, not do in user space?

You are assuming the context switching cause the reservation broken.
but we can do atomic operation in kernel space.  The context switching
really is the execption of processor, If we can clear the wrong
RESERVATION
before exception return, I think we can solve this problem. We can dummy
stwcx. before exception return or the processor automaticly clear the
reservation in exception.=20

Are you missing these important things?

-DAve
