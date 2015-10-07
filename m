Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 884B81A0176
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 18:19:24 +1100 (AEDT)
Date: Wed, 7 Oct 2015 02:19:11 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Laura Abbott <labbott@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Missing operand for tlbie instruction on Power7
Message-ID: <20151007071911.GA31002@gate.crashing.org>
References: <560EA623.1040300@redhat.com>
 <1444102518.16909.3.camel@ellerman.id.au> <56141237.2040403@redhat.com>
 <1444197649.6794.7.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444197649.6794.7.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 07, 2015 at 05:00:49PM +1100, Michael Ellerman wrote:
> > It's also worth noting that the __flush_power7 uses tlbiel instead of tlbie.
> 
> Yeah that's a good point. It's not clear if the swsusp code wants to a local or
> a global invalidate.

If I read the code right, this is called on the boot CPU when all the
non-boot CPUs are still (potentially) down, so if you would do a global
invalidate the non-boot CPUs might not even notice, so those need to do
a (local) invalidate after being brought up anyway?  Or they probably
need it before being brought down at all?  You figure it out, it makes
my brain hurt :-)

> As an alternative, can you try adding a .machine push / .machine "power4" /
> .machine pop, around the tlbie. That should tell the assembler to drop back to
> power4 mode for that instruction, which should then do the right thing. There
> are some examples in that file.

That will get the assembler to not complain, but it will assemble the wrong
instruction: the power7 instruction has the same opcode (but different
semantics).  So if you assemble a "tlbie r4" in power4 mode, a newer CPU
will see it as a "tlbie r4,r0" and do the wrong thing.


Segher
