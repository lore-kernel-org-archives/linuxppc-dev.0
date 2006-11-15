Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 2F6E067C18
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 09:04:28 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/16] hypervisor functions for Celleb
Date: Wed, 15 Nov 2006 23:04:45 +0100
References: <200611150937.kAF9b305001499@toshiba.co.jp>
	<20061115183746.GC21633@lst.de>
In-Reply-To: <20061115183746.GC21633@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611152304.45243.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 15 November 2006 19:37, Christoph Hellwig wrote:
> > +static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t
> > __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t* __out1) {
> > +=A0=A0=A0=A0=A0register uint64_t __reg0 __asm__("r3");
> > +=A0=A0=A0=A0=A0register uint64_t __reg1 __asm__("r4");
> > +=A0=A0=A0=A0=A0register uint64_t __reg2 __asm__("r5");
> > +=A0=A0=A0=A0=A0register uint64_t __reg3 __asm__("r6");
> > +=A0=A0=A0=A0=A0register uint64_t __sn __asm__("r11") =3D (0UL);
>
> No point in declaring this a register variable, gcc ignores the
> specifier. =A0

Actually, this is the one place where gcc forces you to use the
'register' keyword, the '__asm__("r3")' specifier does not work
for variables declared without it.

> Is there any chance to not duplicate the inline assembly=20
> for every single hypercall but have generic call with n arguments
> helper, as for the phyp hvcalls?

It's not easy to do it the way phyp does, because the assembly
needs to pass the call number in %r11, which is not one of the
argument registers.

I'd like to unify the hcall mechanism at least between celleb
and ps3, since they are very similar. I need to forward-port
the patch I had for this.

	Arnd <><
