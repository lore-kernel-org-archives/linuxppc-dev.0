Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050408082635.GB4992@iram.es>
References: <20050408082635.GB4992@iram.es>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <8fc7723059937dc9876c5c14fdcd92ae@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 8 Apr 2005 09:08:28 -0500
To: "Gabriel Paubert" <paubert@iram.es>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 8, 2005, at 3:26 AM, Gabriel Paubert wrote:

> On Wed, Apr 06, 2005 at 04:33:14PM -0500, Kumar Gala wrote:
>  > Here is a version that works if CONFIG_PTE_64BIT is defined.=A0 If =
we
> > like this, I can simplify the pte_update so we dont need the=20
> (unsigned
> > long)(p+1) - 4) trick anymore.=A0 Let me know.
>  >
> > - kumar
>  >
> > #ifdef CONFIG_PTE_64BIT
> > static inline unsigned long long pte_update(pte_t *p, unsigned long=20=

> clr,
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long set)
>  > {
>  >=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long long old;
>  >=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long tmp;
>  >
> >=A0=A0=A0=A0=A0=A0=A0=A0 __asm__ __volatile__("\
>  > 1:=A0=A0=A0=A0=A0 lwarx=A0=A0 %L0,0,%4\n\
>  >=A0=A0=A0=A0=A0=A0=A0=A0 lwzx=A0=A0=A0 %0,0,%3\n\
>  >=A0=A0=A0=A0=A0=A0=A0=A0 andc=A0=A0=A0 %1,%L0,%5\n\
> >=A0=A0=A0=A0=A0=A0=A0=A0 or=A0=A0=A0=A0=A0 %1,%1,%6\n\
>  >=A0=A0=A0=A0=A0=A0=A0=A0 stwcx.=A0 %1,0,%4\n\
>  >=A0=A0=A0=A0=A0=A0=A0=A0 bne-=A0=A0=A0 1b"
>  >=A0=A0=A0=A0=A0=A0=A0=A0 : "=3D&r" (old), "=3D&r" (tmp), "=3Dm" (*p)
> >=A0=A0=A0=A0=A0=A0=A0=A0 : "r" (p), "r" ((unsigned long)(p) + 4), "r" =
(clr), "r"=20
> (set),
> > "m" (*p)
>
> Are you sure of your pointer arithmetic? I believe that
>  you'd rather want to use (unsigned char)(p)+4. Or even better:

Realize that I'm converting the pointer to an int, so its not exactly=20
normal pointer math.  Was stick with the pre-existing stye.

>
> :"r" (p), "b" (4), "r" (clr), "r" (set)
>
> and change the first line to:=A0 lwarx %L0,%4,%3.
>
> Even more devious, you don't need the %4 parameter:
>
> =A0=A0=A0=A0=A0=A0=A0 li %L0,4
>  =A0=A0=A0=A0=A0=A0=A0 lwarx %L0,%L0,%3
>
> since %L0 cannot be r0. This saves one register.

Actually the compiler effective does this for me.  If you look at the=20
generated asm, the only additional instruction is an 'addi' and some=20
'mr' to handle getting things in the correct registers for the return. =20=

Not really sure if there is much else to do to optimize this.

>  >=A0=A0=A0=A0=A0=A0=A0=A0 : "cc" );
>
> On PPC, I always prefer saying cr0 over cc. Maybe it's just
>  me, but it's the canonical register name in the architecture.

Was sticking with the style of what already existed, but I agree that=20
cr is more natural to read than cc.

- kumar
