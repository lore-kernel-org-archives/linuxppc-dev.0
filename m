Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <5b292a628bb78373928a0e1626086707@freescale.com>
References: <5b292a628bb78373928a0e1626086707@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <05453aab0716da8fcade8f835418d680@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 6 Apr 2005 16:33:14 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
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

Here is a version that works if CONFIG_PTE_64BIT is defined.  If we 
like this, I can simplify the pte_update so we dont need the (unsigned 
long)(p+1) - 4) trick anymore.  Let me know.

- kumar

#ifdef CONFIG_PTE_64BIT
static inline unsigned long long pte_update(pte_t *p, unsigned long clr,
                                        unsigned long set)
{
         unsigned long long old;
         unsigned long tmp;

         __asm__ __volatile__("\
1:      lwarx   %L0,0,%4\n\
         lwzx    %0,0,%3\n\
         andc    %1,%L0,%5\n\
         or      %1,%1,%6\n\
         stwcx.  %1,0,%4\n\
         bne-    1b"
         : "=&r" (old), "=&r" (tmp), "=m" (*p)
         : "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), 
"m" (*p)
         : "cc" );
         return old;
}
#else
... code that exists today ...
#endif
