Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 419A8DDFAD
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 04:27:17 +1000 (EST)
Date: Mon, 18 Aug 2008 14:27:14 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <48A9AFA7.8080508@freescale.com>
Message-ID: <alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eran Liberty <liberty@extricom.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 18 Aug 2008, Scott Wood wrote:

> Mathieu Desnoyers wrote:
> >         asm volatile (
> >                 "1: lwz         %1, 0(%2)\n"
> >                 "   cmpw        %1, %5\n"
> >                 "   bne         2f\n"
> >                 "   stwu        %3, 0(%2)\n"
> >                 "2:\n"
> >                 ".section .fixup, \"ax\"\n"
> >                 "3:     li %0, 1\n"
> >                 "       b 2b\n"
> >                 ".previous\n"
> >                 ".section __ex_table,\"a\"\n"
> >                 _ASM_ALIGN "\n"
> >                 _ASM_PTR "1b, 3b\n"
> >                 ".previous"
> >                 : "=r"(faulted), "=r"(replaced)
> >                 : "r"(ip), "r"(new),
> >                   "0"(faulted), "r"(old)
> >                 : "memory");
> 
> Some (most likely unrelated) nits in the above inline asm:

Thanks,

> 
> Should use a "b" constraint for %2, or you could get r0. 

I will make an updated patch.

> Or, use an "m"
> constraint with %U2%X2 after the lwz/stw. 

The 'b' seems easier ;-)

> Why stwu with an offset of zero,
> BTW?

Because it worked :-)  Really, it has been a while since I did any PPC 
assembly, and I didn't break out the old reference manuals to do this.
I simply looked at other asm code, and followed suit. I compiled and 
tested it, and it worked.  I did make a disclaimer about my rusty PPC
knowledge when I posted the code.

> 
> %1 also needs to be an early clobber.

Not exactly sure what you mean by the above.

-- Steve
