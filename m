Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18484.60888.981390.893747@cargo.ozlabs.ibm.com>
Date: Thu, 22 May 2008 13:51:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: luisgpm@linux.vnet.ibm.com
Subject: Re: [RFC] 4xx hardware watchpoint support
In-Reply-To: <1211391577.6232.15.camel@gargoyle>
References: <1211391577.6232.15.camel@gargoyle>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Luis Machado writes:

> This is a patch that has been sitting idle for quite some time. I
> decided to move it further because it is something useful. It was
> originally written by Michel Darneille, based off of 2.6.16.
> 
> The original patch, though, was not compatible with the current DABR
> logic. DABR's are used to implement hardware watchpoint support for
> ppc64 processors (i.e. 970, Power5 etc). 4xx's have a different
> debugging register layout and needs to be handled differently (they two
> registers: DAC and DBCR0).

Yes, they are different, but they do essentially the same thing, so I
think we should try and unify the handling of the two.  Maybe you
could rename set_dabr() to set_hw_watchpoint() or something and make
it set DABR on 64-bit and "classic" 32-bit processors, and DAC on
4xx/Book E processors.

Likewise, I don't think we need both a "dabr" field and a "dac" field
in the thread_struct - one should do.  Rename "dabr" to something else
if you feel that the "dabr" name is too ppc64-specific.  And I don't
think we need both __debugger_dabr_match and __debugger_dac_match.

> 5) This is something i'm worried about for future features. We currently
> have a way to support only Hardware Watchpoints, but not Hardware
> Breakpoints (on 64-bit processors that have a IABR register or 32-bit
> processors carrying the IAC register). Looking at the code, we don't
> differentiate a watchpoint from a breakpoint request. A ptrace call has
> currently 3 arguments: REQUEST, ADDR and DATA. We use REQUEST and DATA
> to set a hardware watchpoint. Maybe we could use the ADDR parameter to
> set a hardware breakpoint? Or use it to tell the kernel whether we want
> a hardware watchpoint or hardware breakpoint and then pass the address
> of the instruction/data through the DATA parameter? What do you think?

I would think there would be a different REQUEST value to mean "set a
hardware breakpoint".  Roland McGrath (cc'd) might be able to tell us
what other architectures do.

Paul.
