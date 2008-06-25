Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id B010DDDF51
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 02:44:40 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 25 Jun 2008 18:12:55 +0200
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating
	point	registers in thread_struct.
Message-ID: <20080625161255.GA12165@iram.es>
References: <20080625040718.028B470296@localhost.localdomain>
	<F09034D9-1B3C-4087-B6DF-FAB7B3AFA191@kernel.crashing.org>
	<48626588.8050202@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48626588.8050202@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 25, 2008 at 10:34:32AM -0500, Scott Wood wrote:
> Kumar Gala wrote:
> >>+/* Macros to workout the correct index for the FPR in the thread 
> >>struct */
> >>+#define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
> >>+#define FPRHALF(i) (((i) - PT_FPR0) % 2)
> >
> >Have you looked at what the compiler spits out here to make sure we 
> >aren't getting a divide?  Seems like we could use '& 0x1'.
> 
> GCC's not *that* dumb.  However, you may get some unnecessary 
> sign-twiddling if "i" is signed.

Not for modulo 2, it's only an even/odd choice and GCC 
implements that efficiently IIRC. For other powers of 2,
making the left hand side unsigned helps the compiler.

The right shift OTOH might be faster if "i" is unsigned 
since right signed right shifts affect the carry on PPC (I really
don't know if srawi is slower than srwi on some processors,
srwi is a form of rlwinm which is always fast).

	Gabriel
