Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050408184442.GA13709@iram.es>
References: <20050408184442.GA13709@iram.es>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <8497276598d775128a73efb06803a9ba@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 8 Apr 2005 14:01:13 -0500
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


On Apr 8, 2005, at 1:44 PM, Gabriel Paubert wrote:

> On Fri, Apr 08, 2005 at 09:08:28AM -0500, Kumar Gala wrote:
>  >
> > On Apr 8, 2005, at 3:26 AM, Gabriel Paubert wrote:
> >
> > >On Wed, Apr 06, 2005 at 04:33:14PM -0500, Kumar Gala wrote:
>  > > > Here is a version that works if CONFIG_PTE_64BIT is defined.=A0=20=

> If we
>  > >> like this, I can simplify the pte_update so we dont need the
> > >(unsigned
>  > >> long)(p+1) - 4) trick anymore.=A0 Let me know.
>  > > >
>  > >> - kumar
>  > > >
>  > >> #ifdef CONFIG_PTE_64BIT
> > >> static inline unsigned long long pte_update(pte_t *p, unsigned=20
> long
> > >clr,
>  > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long set)
>  > > > {
>  > > >=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long long old;
>  > > >=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long tmp;
>  > > >
>  > >>=A0=A0=A0=A0=A0=A0=A0=A0 __asm__ __volatile__("\
>  > > > 1:=A0=A0=A0=A0=A0 lwarx=A0=A0 %L0,0,%4\n\
>  > > >=A0=A0=A0=A0=A0=A0=A0=A0 lwzx=A0=A0=A0 %0,0,%3\n\
>  > > >=A0=A0=A0=A0=A0=A0=A0=A0 andc=A0=A0=A0 %1,%L0,%5\n\
> > >>=A0=A0=A0=A0=A0=A0=A0=A0 or=A0=A0=A0=A0=A0 %1,%1,%6\n\
>  > > >=A0=A0=A0=A0=A0=A0=A0=A0 stwcx.=A0 %1,0,%4\n\
>  > > >=A0=A0=A0=A0=A0=A0=A0=A0 bne-=A0=A0=A0 1b"
>  > > >=A0=A0=A0=A0=A0=A0=A0=A0 : "=3D&r" (old), "=3D&r" (tmp), "=3Dm" =
(*p)
>  > >>=A0=A0=A0=A0=A0=A0=A0=A0 : "r" (p), "r" ((unsigned long)(p) + 4), =
"r" (clr), "r"
> > >(set),
>  > >> "m" (*p)
>  > >
>  > >Are you sure of your pointer arithmetic? I believe that
>  > > you'd rather want to use (unsigned char)(p)+4. Or even better:
>  >
> > Realize that I'm converting the pointer to an int, so its not =
exactly
> > normal pointer math.=A0 Was stick with the pre-existing stye.
>
> Wow, my brain saw a "*" before the closing parenthesis.
> >
> > >
>  > >:"r" (p), "b" (4), "r" (clr), "r" (set)
>  > >
>  > >and change the first line to:=A0 lwarx %L0,%4,%3.
>  > >
>  > >Even more devious, you don't need the %4 parameter:
> > >
>  > >=A0=A0=A0=A0=A0=A0=A0 li %L0,4
>  > > =A0=A0=A0=A0=A0=A0=A0 lwarx %L0,%L0,%3
>  > >
>  > >since %L0 cannot be r0. This saves one register.
>  >
> > Actually the compiler effective does this for me.=A0 If you look at =
the
>  > generated asm, the only additional instruction is an 'addi' and =
some
> > 'mr' to handle getting things in the correct registers for the=20
> return.=A0
> > Not really sure if there is much else to do to optimize this.
>
> Now that I read it carefully, I realize that I was wrong. But there
> is still some room for optimization; the parameter that you don't
> need is %3: simply replace lwzx %0,0,%3 by lwz %0,-4(%4).

Doesn't help, realize that we are going to have "r3" with a pointer to=20=

pte.  There is no way w/o an add to get to the next word for the lwarx.

> But I'm not sure that OOO cannot play tricks on you, what guarantees
>  that the lwz is done after lwarx?

I'm assuming since its a single asm block, gcc is not allowed to=20
reorder it.

- kumar
