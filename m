Return-Path: <mgreer@mvista.com>
Date: Fri, 13 Apr 2007 15:36:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: Add dt_xlate_addr() to bootwrapper
Message-ID: <20070413223654.GA14653@mag.az.mvista.com>
References: <20070413202343.GA552@mag.az.mvista.com>
	<20070413222551.GA8258@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070413222551.GA8258@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 05:25:51PM -0500, Scott Wood wrote:
> On Fri, Apr 13, 2007 at 01:23:43PM -0700, Mark A. Greer wrote:
> > +int dt_xlate(void *node, u32 *buf, int buflen, int res, unsigned long *addr,
> > +		unsigned long *size)
> >  {
> > -	u32 last_addr[MAX_ADDR_CELLS];
> > -	u32 this_addr[MAX_ADDR_CELLS];
> > -	u32 buf[MAX_ADDR_CELLS * MAX_RANGES * 3];
> > +	u32 last_addr[DT_MAX_ADDR_CELLS];
> > +	u32 this_addr[DT_MAX_ADDR_CELLS];
> >  	void *parent;
> 
> This causes it to use the caller-provided buffer to read the ranges
> property, which may not be large enough in the case of dt_xlate_addr().
> Plus, buf being a pointer rather than an array will cause the sizeof(buf)
> that gets passed to getprop() to be only sizeof(u32 *).
> 
> Instead, I'd declare "rangebuf" as a static array, and accept "regbuf" as
> a parameter (with a comment that regbuf can alias rangebuf).  Then,
> dt_xlate_reg() can use rangebuf as regbuf, dt_xlate_addr()'s caller
> doesn't have to worry about its buffer being big enough to hold ranges,
> and we don't have to allocate two 384-byte buffers on the stack.

Okay, I'll look closer this time.  Thanks for checking.

Mark
