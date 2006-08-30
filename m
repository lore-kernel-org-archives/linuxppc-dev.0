Return-Path: <DaveLiu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: atomic operations in user space
Date: Wed, 30 Aug 2006 10:27:25 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BB4D@zch01exm21.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D263511BB47@zch01exm21.fsl.freescale.net>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>,
	"Li Yang-r58472" <LeoLi@freescale.com>, <linuxppc-embedded@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> [snip]
> > I surely know all the theories you mentioned clearly.  But=20
> please do=20
> > look at the case I gave.  Correct me if I missed anything.  Thanks
> >=20
> > All the lwarx and stwcx operate on the same address.
> >=20
> > > Task A		Task B
> > > lwarx			=09
> > // Get RESERVATION
> > > 			......
> > > 			lwarx
> > > 			stwcx
> >=20
> > // RESERVATION cleared
> > >
> > > 			.....
> > > 			.....
> > > 			lwarx
> >=20
> > // Get RESERVATION again
> > > stwcx			=09
> >=20
> > //Note here: RESERVATION is valid, address is the same.
> > So the result is commited, no retry for task A
> >=20
> > > .....
> > > 			stwcx
> > //RESERVATION is cleared, retry atomic op for task B
> >=20
> > Please be noted that reservation is only identified by=20
> reservation bit=20
> > and address operated on.  So different lwarx's on the same address,=20
> > may be considered as the same reservation.
>=20
> Is this your reason we cannot do atomic operation in user space?
>=20
> How about the kernel space? You can image it.
> The context switching as above also happen in kernel space,=20
> Why we can do atomic operation in kernel space, not do in user space?
>=20
> You are assuming the context switching cause the reservation broken.
> but we can do atomic operation in kernel space.  The context=20
> switching really is the execption of processor, If we can=20
> clear the wrong RESERVATION before exception return, I think=20
> we can solve this problem. We can dummy stwcx. before=20
> exception return or the processor automaticly clear the=20
> reservation in exception.=20
>=20
> Are you missing these important things?
>=20
> -DAve

I got it. I noticed that all of execption return in kernel did stwcx.
to clear the wrong reserved bit. See the source code.

        .globl  ret_from_except_full
ret_from_except_full:
        REST_NVGPRS(r1)
        /* fall through */

        .globl  ret_from_except
ret_from_except:
           ......

restore:
        lwz     r0,GPR0(r1)
        lwz     r2,GPR2(r1)
        REST_4GPRS(3, r1)
        REST_2GPRS(7, r1)

        lwz     r10,_XER(r1)
        lwz     r11,_CTR(r1)
        mtspr   SPRN_XER,r10
        mtctr   r11

        PPC405_ERR77(0,r1)
        stwcx.  r0,0,r1                 /* to clear the reservation */

          ......

         rfi

-DAve

 =20
