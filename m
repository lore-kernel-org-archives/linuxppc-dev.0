Return-Path: <bauerman@br.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5A0251007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 06:02:14 +1100 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bauerman@br.ibm.com>;
 Wed, 7 Dec 2011 17:02:05 -0200
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB7IxMas3170406
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Dec 2011 15:59:22 -0300
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB7J1nCc019509
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Dec 2011 17:01:49 -0200
Message-ID: <1323284517.10808.7.camel@hactar>
Subject: Re: [PATCH 1/2] [hw-breakpoint] Use generic hw-breakpoint
 interfaces for new PPC ptrace flags
From: Thiago Jung Bauermann <bauerman@br.ibm.com>
To: prasad@linux.vnet.ibm.com
Date: Wed, 07 Dec 2011 17:01:57 -0200
In-Reply-To: <20111201102000.GB2632@in.ibm.com>
References: <20110819074527.GA21817@in.ibm.com>
 <20110819075136.GB21817@in.ibm.com>
 <20110823050850.GS30097@yookeroo.fritz.box>
 <20110823092513.GA2962@in.ibm.com>
 <20110824035939.GB30097@yookeroo.fritz.box>
 <20110826093552.GA2301@in.ibm.com> <20110916072710.GA28060@in.ibm.com>
 <20111012033359.GR4849@truffala.fritz.box>
 <20111012173948.GA4340@in.ibm.com>
 <20111128031111.GC3508@truffala.fritz.box>
 <20111201102000.GB2632@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 15:50 +0530, K.Prasad wrote:
> On Mon, Nov 28, 2011 at 02:11:11PM +1100, David Gibson wrote:
> > [snip]
> > On Wed, Oct 12, 2011 at 11:09:48PM +0530, K.Prasad wrote:
> > > diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
> > > index f4a5499..f2a7a39 100644
> > > --- a/Documentation/powerpc/ptrace.txt
> > > +++ b/Documentation/powerpc/ptrace.txt
> > > @@ -127,6 +127,22 @@ Some examples of using the structure to:
> > >    p.addr2           = (uint64_t) end_range;
> > >    p.condition_value = 0;
> > >  
> > > +- set a watchpoint in server processors (BookS)
> > > +
> > > +  p.version         = 1;
> > > +  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_RW;
> > > +  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
> > > +  or
> > > +  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
> > > +
> > > +  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
> > > +  p.addr            = (uint64_t) begin_range;
> > 
> > You should probably document the alignment constraint on the address
> > here, too.
> > 
> 
> Alignment constraints will be learnt by the user-space during runtime.
> We provide that as part of 'struct ppc_debug_info' in
> 'data_bp_alignment' field.
> 
> While the alignment is always 8-bytes for BookS, I think userspace
> should be left to learn it through PTRACE_PPC_GETHWDEBUGINFO.

Right. In particular, BookE doesn't have alignment constraints.

> > > +		attr.bp_len = len;
> > > +		ret =  modify_user_hw_breakpoint(bp, &attr);
> > > +		if (ret) {
> > > +			ptrace_put_breakpoints(child);
> > > +			return ret;
> > > +		}
> > 
> > If a bp already exists, you're modifying it.  I thought the semantics
> > of the new interface meant that you shoul return ENOSPC in this case,
> > and a DEL would be necessary before adding another breakpoint.
> > 
> 
> I'm not too sure what would be the desired behaviour for this interface,
> either way is fine with me. I'd like to hear from the GDB folks (copied
> in this email) to know what would please them.

ENOSPC should be returned. The interface doesn't have provisions for
modifying breakpoints. The client should delete/create instead of trying
to modify.

Since PTRACE_PPC_GETHWDEBUGINFO returns the number of available
breakpoint registers, the client shouldn't (and GDB doesn't) try to set
more breakpoints than possible.
 
> > > @@ -1426,10 +1488,24 @@ static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
> > >  #else
> > >  	if (data != 1)
> > >  		return -EINVAL;
> > > +
> > > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > > +	if (ptrace_get_breakpoints(child) < 0)
> > > +		return -ESRCH;
> > > +
> > > +	bp = thread->ptrace_bps[0];
> > > +	if (bp) {
> > > +		unregister_hw_breakpoint(bp);
> > > +		thread->ptrace_bps[0] = NULL;
> > > +	}
> > > +	ptrace_put_breakpoints(child);
> > > +	return 0;
> > 
> > Shouldn't DEL return an error if there is no existing bp.
> >
> 
> Same comment as above. We'd like to know what behaviour would help the
> GDB use this interface better as there's no right or wrong way here.

GDB expects DEL to return ENOENT is there's no existing bp.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
