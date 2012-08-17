Return-Path: <ananth@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D732A2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 15:14:50 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 16 Aug 2012 23:14:47 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AA0FEC40002
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 23:13:50 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7H5DOiq039952
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 23:13:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7H5D8wi032621
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 23:13:09 -0600
Date: Fri, 17 Aug 2012 10:43:07 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120817051307.GA4782@in.ibm.com>
References: <20120726051902.GA29466@in.ibm.com>
 <20120726052029.GB29466@in.ibm.com> <20120815165931.GA10059@redhat.com>
 <1345066913.11751.4.camel@pasglop> <20120816050030.GA12060@in.ibm.com>
 <20120816152112.GA8874@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120816152112.GA8874@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 16, 2012 at 05:21:12PM +0200, Oleg Nesterov wrote:

...

> > So, the arch agnostic code itself
> > takes care of this case...
> 
> Yes. I forgot about install_breakpoint()->is_swbp_insn() check which
> returns -ENOTSUPP, somehow I thought arch_uprobe_analyze_insn() does
> this.
> 
> > or am I missing something?
> 
> No, it is me.
> 
> > However, I see that we need a powerpc specific is_swbp_insn()
> > implementation since we will have to take care of all the trap variants.
> 
> Hmm, I am not sure. is_swbp_insn(insn), as it is used in the arch agnostic
> code, should only return true if insn == UPROBE_SWBP_INSN (just in case,
> this logic needs more fixes but this is offtopic).

I think it does...

> If powerpc has another insn(s) which can trigger powerpc's do_int3()
> counterpart, they should be rejected by arch_uprobe_analyze_insn().
> I think.

The insn that gets passed to arch_uprobe_analyze_insn() is copy_insn()'s
version, which is the file copy of the instruction. We should also take
care of the in-memory copy, in case gdb had inserted a breakpoint at the
same location, right? Updating is_swbp_insn() per-arch where needed will
take care of both the cases, 'cos it gets called before
arch_analyze_uprobe_insn() too.

> > I will need to update the patches based on changes being made by Oleg
> > and Sebastien for the single-step issues.
> 
> Perhaps you can do this in a separate change?
> 
> We need some (simple) changes in the arch agnostic code first, they
> should not break poweppc. These changes are still under discussion.
> Once we have "__weak  arch_uprobe_step*" you can reimplement these
> hooks and fix the problems with single-stepping.

OK. Agreed.

Ananth
