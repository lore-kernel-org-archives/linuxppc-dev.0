Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 8 Apr 2005 20:44:42 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050408184442.GA13709@iram.es>
References: <20050408082635.GB4992@iram.es>
	<8fc7723059937dc9876c5c14fdcd92ae@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <8fc7723059937dc9876c5c14fdcd92ae@freescale.com>
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

On Fri, Apr 08, 2005 at 09:08:28AM -0500, Kumar Gala wrote:
> 
> On Apr 8, 2005, at 3:26 AM, Gabriel Paubert wrote:
> 
> >On Wed, Apr 06, 2005 at 04:33:14PM -0500, Kumar Gala wrote:
> > > Here is a version that works if CONFIG_PTE_64BIT is defined.  If we
> >> like this, I can simplify the pte_update so we dont need the 
> >(unsigned
> >> long)(p+1) - 4) trick anymore.  Let me know.
> > >
> >> - kumar
> > >
> >> #ifdef CONFIG_PTE_64BIT
> >> static inline unsigned long long pte_update(pte_t *p, unsigned long 
> >clr,
> > >                                        unsigned long set)
> > > {
> > >         unsigned long long old;
> > >         unsigned long tmp;
> > >
> >>         __asm__ __volatile__("\
> > > 1:      lwarx   %L0,0,%4\n\
> > >         lwzx    %0,0,%3\n\
> > >         andc    %1,%L0,%5\n\
> >>         or      %1,%1,%6\n\
> > >         stwcx.  %1,0,%4\n\
> > >         bne-    1b"
> > >         : "=&r" (old), "=&r" (tmp), "=m" (*p)
> >>         : "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" 
> >(set),
> >> "m" (*p)
> >
> >Are you sure of your pointer arithmetic? I believe that
> > you'd rather want to use (unsigned char)(p)+4. Or even better:
> 
> Realize that I'm converting the pointer to an int, so its not exactly 
> normal pointer math.  Was stick with the pre-existing stye.

Wow, my brain saw a "*" before the closing parenthesis. 
> 
> >
> >:"r" (p), "b" (4), "r" (clr), "r" (set)
> >
> >and change the first line to:  lwarx %L0,%4,%3.
> >
> >Even more devious, you don't need the %4 parameter:
> >
> >        li %L0,4
> >         lwarx %L0,%L0,%3
> >
> >since %L0 cannot be r0. This saves one register.
> 
> Actually the compiler effective does this for me.  If you look at the 
> generated asm, the only additional instruction is an 'addi' and some 
> 'mr' to handle getting things in the correct registers for the return.  
> Not really sure if there is much else to do to optimize this.

Now that I read it carefully, I realize that I was wrong. But there 
is still some room for optimization; the parameter that you don't 
need is %3: simply replace lwzx %0,0,%3 by lwz %0,-4(%4).

But I'm not sure that OOO cannot play tricks on you, what guarantees
that the lwz is done after lwarx?

	Regards,
	Gabriel
