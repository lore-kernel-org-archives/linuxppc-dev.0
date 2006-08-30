Return-Path: <LeoLi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: atomic operations in user space
Date: Wed, 30 Aug 2006 10:40:00 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC82D@zch01exm20.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D263511BB4D@zch01exm21.fsl.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>, <linuxppc-embedded@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Liu Dave-r63238
> Sent: Wednesday, August 30, 2006 10:27 AM
> To: Liu Dave-r63238; Li Yang-r58472; linuxppc-embedded@ozlabs.org;
> linuxppc-dev@ozlabs.org
> Subject: RE: atomic operations in user space
>=20
> > [snip]
> > > I surely know all the theories you mentioned clearly.  But
> > please do
> > > look at the case I gave.  Correct me if I missed anything.  Thanks
> > >
> > > All the lwarx and stwcx operate on the same address.
> > >
> > > > Task A		Task B
> > > > lwarx
> > > // Get RESERVATION
> > > > 			......
> > > > 			lwarx
> > > > 			stwcx
> > >
> > > // RESERVATION cleared
> > > >
> > > > 			.....
> > > > 			.....
> > > > 			lwarx
> > >
> > > // Get RESERVATION again
> > > > stwcx
> > >
> > > //Note here: RESERVATION is valid, address is the same.
> > > So the result is commited, no retry for task A
> > >
> > > > .....
> > > > 			stwcx
> > > //RESERVATION is cleared, retry atomic op for task B
> > >
> > > Please be noted that reservation is only identified by
> > reservation bit
> > > and address operated on.  So different lwarx's on the same
address,
> > > may be considered as the same reservation.
> >
> > Is this your reason we cannot do atomic operation in user space?
> >
> > How about the kernel space? You can image it.
> > The context switching as above also happen in kernel space,
> > Why we can do atomic operation in kernel space, not do in user
space?
> >
> > You are assuming the context switching cause the reservation broken.
> > but we can do atomic operation in kernel space.  The context
> > switching really is the execption of processor, If we can
> > clear the wrong RESERVATION before exception return, I think
> > we can solve this problem. We can dummy stwcx. before
> > exception return or the processor automaticly clear the
> > reservation in exception.
> >
> > Are you missing these important things?
> >
> > -DAve
>=20
> I got it. I noticed that all of execption return in kernel did stwcx.
> to clear the wrong reserved bit. See the source code.
>=20
>         .globl  ret_from_except_full
> ret_from_except_full:
>         REST_NVGPRS(r1)
>         /* fall through */
>=20
>         .globl  ret_from_except
> ret_from_except:
>            ......
>=20
> restore:
>         lwz     r0,GPR0(r1)
>         lwz     r2,GPR2(r1)
>         REST_4GPRS(3, r1)
>         REST_2GPRS(7, r1)
>=20
>         lwz     r10,_XER(r1)
>         lwz     r11,_CTR(r1)
>         mtspr   SPRN_XER,r10
>         mtctr   r11
>=20
>         PPC405_ERR77(0,r1)
>         stwcx.  r0,0,r1                 /* to clear the reservation */

Ya, you found the point.  There is no problem for me about this
question.

- Leo
