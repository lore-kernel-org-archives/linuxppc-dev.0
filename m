Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3B25B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 04:13:12 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jkenisto@linux.vnet.ibm.com>;
 Wed, 6 Jun 2012 14:13:02 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id BBAA36E8063
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 14:08:31 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q56I8GmR27918548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 14:08:16 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q56I86WS031206
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 14:08:07 -0400
Subject: Re: [PATCH 2/2] [POWERPC] uprobes: powerpc port
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: ananth@in.ibm.com
In-Reply-To: <20120606093541.GA29580@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <20120606092150.GC6745@in.ibm.com> <1338974822.2749.89.camel@twins>
 <20120606093541.GA29580@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Jun 2012 11:08:04 -0700
Message-ID: <1339006084.3458.25.camel@localhost>
Mime-Version: 1.0
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-06 at 15:05 +0530, Ananth N Mavinakayanahalli wrote:
> On Wed, Jun 06, 2012 at 11:27:02AM +0200, Peter Zijlstra wrote:
> > On Wed, 2012-06-06 at 14:51 +0530, Ananth N Mavinakayanahalli wrote:
> > > One TODO in this port compared to x86 is the uprobe abort_xol() logic.
> > > x86 depends on the thread_struct.trap_nr (absent in powerpc) to determine
> > > if a signal was caused when the uprobed instruction was single-stepped/
> > > emulated, in which case, we reset the instruction pointer to the probed
> > > address and retry the probe again. 
> > 
> > Another curious difference is that x86 uses an instruction decoder and
> > contains massive tables to validate we can probe a particular
> > instruction.

Part of that difference is because the x86 instruction set is a lot more
complex.  Another part is due to the lack, back when the x86 code was
created, of robust handling by uprobes of traps by probed instructions.
So we refused to probe instructions that we knew (or strongly suspected)
would generate traps in user mode -- e.g., privileged instructions,
illegal instructions.  A couple of times we had to "legalize"
instructions or prefixes that we didn't originally expect to encounter.

> > 
> > Can we probe all possible PPC instructions?
> 
> For the kernel, the only ones that are off limits are rfi (return from
> interrupt), mtmsr (move to msr). All other instructions can be probed.
> 
> Both those instructions are supervisor level, so we won't see them in
> userspace at all; so we should be able to probe all user level
> instructions.

Presumably rfi or mtmsr could show up in the instruction stream via an
erroneous or mischievous asm statement.  It'd be good to verify that you
handle that gracefully.

> 
> I am not aware of specific caveats for vector/altivec instructions;
> maybe Paul or Ben are more suitable to comment on that.
> 
> Ananth
> 

Jim
