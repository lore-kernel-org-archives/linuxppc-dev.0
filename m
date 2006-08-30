Return-Path: <LeoLi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: RE: atomic operations in user space
Date: Wed, 30 Aug 2006 10:52:08 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC836@zch01exm20.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D263511BB58@zch01exm21.fsl.freescale.net>
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
> Sent: Wednesday, August 30, 2006 10:43 AM
> To: Li Yang-r58472; 'linuxppc-embedded@ozlabs.org';
'linuxppc-dev@ozlabs.org'
> Subject: RE: RE: atomic operations in user space
>=20
> [snip]
> > >
> > > Is this your reason we cannot do atomic operation in user space?
> > >
> > > How about the kernel space? You can image it.
> > > The context switching as above also happen in kernel space,
> > Why we can
> > > do atomic operation in kernel space, not do in user space?
> > >
> >
> > There are substantial different between kernel and user
> > control path.  First, interrupt can't be interrupted by user
> > process.  Second, context switch can be explicitly controlled
> > in kernel, but not in user space.
>=20
> I agree this, but from the processor's view, the context switch
> is the same to user space and kernel space. The exception
> control flow only happen at exception interrupt.

Exception is special and tiny part of the kernel, which should be
programmed carefully not to break any thing.  Anyway, as you found,
clear reservation in exception do solve all the problems.

>=20
> What is different you point ?
>=20
> > > You are assuming the context switching cause the reservation
broken.
> > > but we can do atomic operation in kernel space.  The
> > context switching
> > > really is the execption of processor, If we can clear the wrong
> > > RESERVATION before exception return, I think we can solve this
> > > problem. We can dummy stwcx. before exception return or the
> > processor
> > > automaticly clear the reservation in exception.
> >
> > I assume stwcx is a costing instruction, and I don't see such
> > code indeed.
