Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id A4135DE78D
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 04:47:34 +1000 (EST)
Date: Mon, 18 Aug 2008 14:47:32 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <48A9AFA7.8080508@freescale.com>
Message-ID: <alpine.DEB.1.10.0808181445160.796@gandalf.stny.rr.com>
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
> 
> Should use a "b" constraint for %2, or you could get r0.  Or, use an "m"
> constraint with %U2%X2 after the lwz/stw. 

What syntax to do that with?

  lwz %1,0(%U2)
  stu %3, 0(%X2)

I'm new to those. (and the above does not compile)

> Why stwu with an offset of zero,

How else to do it?  stwu %3, (%2) does not compile for me.

-- Steve
