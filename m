Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 3E5E2DDE2C
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 19:56:09 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 15 Jan 2007 09:55:57 +0100
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] atomic_dec_if_positive sign extension fix
Message-ID: <20070115085557.GA4943@iram.es>
References: <20070114225502.GA21471@austin.ibm.com>
	<17834.47158.581922.62728@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17834.47158.581922.62728@cargo.ozlabs.ibm.com>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 15, 2007 at 10:09:42AM +1100, Paul Mackerras wrote:
> Robert Jennings writes:
> 
> > Please apply for 2.6.20.  If an atomic counter is explicitly set to a
> > negative value the atomic_dec_if_positive function will decrement and
> > store the next smallest value in the atomic counter contrary to it's
> > intended operation.  
> 
> [snip]
> 
> >  	__asm__ __volatile__(
> >  	LWSYNC_ON_SMP
> >  "1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
> > +	extsw	%0,%0\n\
> >  	addic.	%0,%0,-1\n\
> >  	blt-	2f\n"
> >  	PPC405_ERR77(0,%1)
> 
> NAK: Good fix for 64-bit, but it will break 32-bit.  I think a better
> fix would be to use a cmpwi after the lwarx, and use addi rather than
> addic..
> 

Indeed, this will also fix the bug that 0x8000000 is considered 
positive since the test was done after the decrement, at the cost
of one additional instrucction in 32 bit mode.

It also avoids clobbering the carry, you don't know whether a future
version of GCC will require explicit clobbers for the carry. For now
they are useless: you can specify "xer" in the clobber list AFAIR but 
no pattern can be split between setters and users of the carry in the
machine description.

	Gabriel
