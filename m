Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 8 Apr 2005 10:26:35 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050408082635.GB4992@iram.es>
References: <5b292a628bb78373928a0e1626086707@freescale.com>
	<05453aab0716da8fcade8f835418d680@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <05453aab0716da8fcade8f835418d680@freescale.com>
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

On Wed, Apr 06, 2005 at 04:33:14PM -0500, Kumar Gala wrote:
> Here is a version that works if CONFIG_PTE_64BIT is defined.  If we 
> like this, I can simplify the pte_update so we dont need the (unsigned 
> long)(p+1) - 4) trick anymore.  Let me know.
> 
> - kumar
> 
> #ifdef CONFIG_PTE_64BIT
> static inline unsigned long long pte_update(pte_t *p, unsigned long clr,
>                                        unsigned long set)
> {
>         unsigned long long old;
>         unsigned long tmp;
> 
>         __asm__ __volatile__("\
> 1:      lwarx   %L0,0,%4\n\
>         lwzx    %0,0,%3\n\
>         andc    %1,%L0,%5\n\
>         or      %1,%1,%6\n\
>         stwcx.  %1,0,%4\n\
>         bne-    1b"
>         : "=&r" (old), "=&r" (tmp), "=m" (*p)
>         : "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), 
> "m" (*p)

Are you sure of your pointer arithmetic? I believe that
you'd rather want to use (unsigned char)(p)+4. Or even better:

:"r" (p), "b" (4), "r" (clr), "r" (set)

and change the first line to:  lwarx %L0,%4,%3.

Even more devious, you don't need the %4 parameter:

	li %L0,4
	lwarx %L0,%L0,%3

since %L0 cannot be r0. This saves one register.

>         : "cc" );

On PPC, I always prefer saying cr0 over cc. Maybe it's just
me, but it's the canonical register name in the architecture.

	Gabriel
