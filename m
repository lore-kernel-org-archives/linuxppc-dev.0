Return-Path: <DaveLiu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RE: atomic operations in user space
Date: Wed, 30 Aug 2006 10:55:39 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BB62@zch01exm21.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC836@zch01exm20.fsl.freescale.net>
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

> > [snip]
> > > >
> > > > Is this your reason we cannot do atomic operation in user space?
> > > >
> > > > How about the kernel space? You can image it.
> > > > The context switching as above also happen in kernel space,
> > > Why we can
> > > > do atomic operation in kernel space, not do in user space?
> > > >
> > >
> > > There are substantial different between kernel and user control=20
> > > path.  First, interrupt can't be interrupted by user process. =20
> > > Second, context switch can be explicitly controlled in=20
> kernel, but=20
> > > not in user space.
> >=20
> > I agree this, but from the processor's view, the context=20
> switch is the=20
> > same to user space and kernel space. The exception control=20
> flow only=20
> > happen at exception interrupt.
> > What is different you point ?
>=20
> Exception is special and tiny part of the kernel, which=20
> should be programmed carefully not to break any thing. =20
> Anyway, as you found, clear reservation in exception do solve=20
> all the problems.

Can we do atomic operation in user space as kernel space?

> > > > You are assuming the context switching cause the=20
> reservation broken.
> > > > but we can do atomic operation in kernel space.  The
> > > context switching
> > > > really is the execption of processor, If we can clear the wrong=20
> > > > RESERVATION before exception return, I think we can solve this=20
> > > > problem. We can dummy stwcx. before exception return or the
> > > processor
> > > > automaticly clear the reservation in exception.
> > >
> > > I assume stwcx is a costing instruction, and I don't see=20
> such code=20
> > > indeed.
