Return-Path: <anton@ozlabs.org>
Date: Tue, 4 Jan 2005 09:58:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Message-ID: <20050103225822.GC7335@krispykreme.ozlabs.ibm.com>
References: <41D9CD19.50207@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41D9CD19.50207@nortelnetworks.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: dcbz not used on ppc64?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi,

> I ran into some issues with the use of the dcbz instruction in the 
> kernel for ppc32.  I'm now looking at porting our work to ppc64, and 
> when I looked around a bit, I found that the dcbz instruction doesn't 
> appear to be used in ppc64.
> 
> This leads me to ask:
> 
> 1) Is it in fact true that ppc64 does not use dcbz in the kernel?
> 2) If so, why not?  Presumably it would be a win in some cases, 
> otherwise they wouldn't be using it in ppc32.  Is there some other 
> factore in play for ppc64?

include/asm-ppc64/page.h:clear_page() uses it:

static __inline__ void clear_page(void *addr)
{
        unsigned long lines, line_size;

        line_size = systemcfg->dCacheL1LineSize;
        lines = naca->dCacheL1LinesPerPage;

        __asm__ __volatile__(
        "mtctr          %1      # clear_page\n\
1:      dcbz    0,%0\n\
        add     %0,%0,%3\n\
        bdnz+   1b"
        : "=r" (addr)
        : "r" (lines), "0" (addr), "r" (line_size)
        : "ctr", "memory");
}

Anton
