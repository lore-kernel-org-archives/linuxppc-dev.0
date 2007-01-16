Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 90B4CDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 15:28:36 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 16 Jan 2007 05:28:29 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] atomic_dec_if_positive sign extension fix
Message-ID: <20070116042829.GA24654@iram.es>
References: <20070114225502.GA21471@austin.ibm.com>
	<17834.47158.581922.62728@cargo.ozlabs.ibm.com>
	<20070115085557.GA4943@iram.es>
	<4391e3fc8335446ddeedecb5670d4a00@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4391e3fc8335446ddeedecb5670d4a00@kernel.crashing.org>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 15, 2007 at 05:01:12PM +0100, Segher Boessenkool wrote:
> >It also avoids clobbering the carry, you don't know whether a future
> >version of GCC will require explicit clobbers for the carry. For now
> >they are useless: you can specify "xer" in the clobber list AFAIR but
> >no pattern can be split between setters and users of the carry in the
> >machine description.
> 
> You can specify "cc" in the clobber list already, don't use
> "xer" unless you're clobbering something else in the XER.
> 

Hmm, I believed "cc" was an alias for cr0.

[Looking at gcc sources]

Ths snippet of gcc/config/rs6000.h confirms this:

  {"cr0",  68}, {"cr1",  69}, {"cr2",  70}, {"cr3",  71},       \
  {"cr4",  72}, {"cr5",  73}, {"cr6",  74}, {"cr7",  75},       \
  {"cc",   68}, {"sp",    1}, {"toc",   2} }

In this file, xer has number 76. So "cc" does not indicate a carry
clobber. There is currently no way to specify a carry clobber, but 
also gcc will never insert an inline asm between settings and uses
of the carry. 

The following comment:

/* PSImode is used for the XER register.  The XER register
   is not used for anything; perhaps it should be deleted,
   except that that would change register numbers.  */
PARTIAL_INT_MODE (SI);

in gcc/config/rs6000-modes.def is actually a bit misleading since the
XER is often clobbered by instructions. But the XER is actually never
exposed to the instruction scheduler: all the patterns that set and use 
the carry are simple lists of machine instructions which will be put in
the final object without modifications (only register number and possibly
immediate value substitution).

	Gabriel
