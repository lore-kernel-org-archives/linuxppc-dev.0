Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C2C4B7CEE
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 18:29:02 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2N7PilO006745
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 18:25:44 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2N7N2DZ1659034
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 18:23:03 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2N7T191003269
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 18:29:01 +1100
Date: Tue, 23 Mar 2010 12:58:54 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100323072854.GA3365@in.ibm.com>
References: <20100308181232.GA3406@in.ibm.com>
	<20100308181448.GA5538@in.ibm.com> <20100323053301.GA28676@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100323053301.GA28676@drongo>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 23, 2010 at 04:33:01PM +1100, Paul Mackerras wrote:
> On Mon, Mar 08, 2010 at 11:44:48PM +0530, K.Prasad wrote:
> 
> > @@ -479,6 +483,7 @@ struct task_struct *__switch_to(struct t
> >  		old_thread->accum_tb += (current_tb - start_tb);
> >  		new_thread->start_tb = current_tb;
> >  	}
> > +	flush_ptrace_hw_breakpoint(current);
> >  #endif
> >  
> >  	local_irq_save(flags);
> 
> This line should be in flush_thread(), not __switch_to().  In fact it
> may not be necessary at all given that flush_ptrace_hw_breakpoint()
> gets called in do_exit().
> 
> Paul.

Yes, I did realise it. The unintended movement of
flush_ptrace_hw_breakpoint() from flush_thread() is a result of a
patching error (while forward porting).

A fix for this issue along with those pointed out by BenH will be a part
of the next version of the patch, that I intend to send very soon.

Thanks for reviewing them.

-- K.Prasad
