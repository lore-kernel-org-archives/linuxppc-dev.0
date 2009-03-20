Return-Path: <ananth@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5BA49DDDA9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 18:34:01 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2K7OmfE013546
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 03:24:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2K7Xtft177780
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 03:33:55 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2K7WSHY005602
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 03:32:29 -0400
Date: Fri, 20 Mar 2009 13:03:34 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH -tip 4/9] power: add kernel_trap_sp()
Message-ID: <20090320073334.GA10519@in.ibm.com>
References: <49C2B4BF.4080904@redhat.com> <1237527760.25062.567.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1237527760.25062.567.camel@pasglop>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org, systemtap-ml <systemtap@sources.redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2009 at 04:42:40PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2009-03-19 at 17:10 -0400, Masami Hiramatsu wrote:
> > Add kernel_trap_sp() on powerpc, based on systemtap's runtime/regs.h.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
> 
> I haven't looked at the usage of it, but it's weird to have something
> call "kernel_trap_sp" that returns the -user- stack pointer... is
> this really what's expected here ?

In the current usage scenario, this gets called only with a pt_regs
snapshot from in kernel. user_stack_pointer() is a misnomer though;
all this macro needs is to return the stack pointer from the given
pt_regs.

Ananth
