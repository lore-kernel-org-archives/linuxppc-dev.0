Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 709381A089E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 03:08:49 +1100 (AEDT)
Date: Thu, 27 Nov 2014 10:08:29 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Peter Bergner <bergner@vnet.ibm.com>
Subject: Re: [PATCH] powerpc: 32 bit getcpu VDSO function uses 64 bit
 instructions
Message-ID: <20141127160829.GA26139@gate.crashing.org>
References: <1417036288-22079-1-git-send-email-anton@samba.org>
 <1417041497.12952.2.camel@concordia> <1417045827.16862.32.camel@otta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417045827.16862.32.camel@otta>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 05:50:27PM -0600, Peter Bergner wrote:
> On Thu, 2014-11-27 at 09:38 +1100, Michael Ellerman wrote:
> > On Thu, 2014-11-27 at 08:11 +1100, Anton Blanchard wrote:
> > > I used some 64 bit instructions when adding the 32 bit getcpu VDSO
> > > function. Fix it.
> > 
> > Ouch. The symptom is a SIGILL I presume?
> 
> Nope, you don't get a SIGILL when executing 64-bit instructions in
> 32-bit mode, so it'll happily just execute the instruction, doing
> a full 64-bit compare.  I'm guessing that the upper 32-bits of both
> r3 and r4 contain zeros, so we're probably just getting lucky.

You will get a SIGILL if you run on 32-bit hardware.

> > Could we catch this by forcing -m32 in the CFLAGS for vdso32 ?
> 
> As Segher mentioned, GCC passing -many down to the assembler means
> -m32 won't help.  It was due to Anton disabling that gcc "feature",
> that this was caught.

There are extremely many complex failure cases without the -many.
Feel free to work on removing it, I won't :-)


Segher
