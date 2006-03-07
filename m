Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 435BA67A3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 05:11:29 +1100 (EST)
Date: Tue, 7 Mar 2006 12:11:24 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: rmcguire@uwbt.com
Subject: Re: GNU and Freescale MPC83xx / e300 core support?
Message-Id: <20060307121124.22cb4410.kim.phillips@freescale.com>
In-Reply-To: <7C2FA1F5-DF91-495E-A2C3-052048E34DFE@kernel.crashing.org>
References: <002b01c641ff$666ccc70$6405a8c0@absolut>
	<7C2FA1F5-DF91-495E-A2C3-052048E34DFE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

according to one of our architects, the 81xx, 82xx, 83xx, 52xx, and 51xx (all G2/e300 based parts) all share the same 603 pipeline:

o dispatch 2 instructions, plus 1 branch per cycle,
o up to 5 instructions in the pipeline at any given time, 
o a maximum of 2 instructions are completed per cycle.

the changes are:

o multiple HID0, HID1, HID3 bits for optimizing system,
o icbt
o PLL options

so, the answer is no, modifying the compiler's scheduler won't do anything for you.  

as Kumar says, the caches and adding icbt to your code does improve performance.

Kim

On Tue, 7 Mar 2006 10:03:53 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Mar 7, 2006, at 9:54 AM, Russell McGuire wrote:
> 
> > Thanks all...
> >
> > The author of that comment humbly apologizes for his ineptitude on  
> > the FPU.
> >
> > It would appear both cores have the same number of execution units,  
> > i.e. 5
> > So David, I guess in all this the only real difference seems to be  
> > the bus
> > architecture, raw clock speed, and perhaps a few new instructions.  
> > I checked
> > both manuals this morning and they do differ in some small ways.
> >
> > * 603e, up to 4 instructions in the pipeline, only 3 being complete  
> > per
> > clock
> > * e300, up to 5 instructions in the pipeline, still only 3 being  
> > completed
> > or start per clock.
> > * Add/compare instructions are now executed in the IU unit instead  
> > of the
> > load/store unit. May be the same, but wasn't specific in earlier 603e
> > manuals.
> > * One more HID0 bit than G2, ability to interrupt based on cache  
> > parity
> > error
> > * new icbt instruction, instruction cache initialization
> >
> > So there is a section inside the 8360E manual that outlines the  
> > specific
> > enhancements. "Features specific to the e300 core not present on  
> > the G2
> > processors follow:" Page  1-5.
> >
> > So I guess my question is back up, does anyone know if an optimized  
> > compiler
> > would offer any noticeable performance enhancements in regards to  
> > these
> > changes? Other than the obvious instruction being added?
> 
> If you are asking about relative performance between the same  
> compiler tuned for a 603 vs e300, the there would most likely be a  
> small improvement.
> 
> However, a few things to note.  The new icbt instruction is really  
> intended for hand written assemble code and its highly unlikely that  
> a compiler will ever generate it.  Second, the other improvements  
> from the base 603e/G2LE in 8280, like doubling of the L1 caches has a  
> significant improvement in performance.
> 
> - kumar
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
