Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A6FEDDE18
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 08:40:17 +1000 (EST)
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18554.33417.542066.185326@cargo.ozlabs.ibm.com>
References: <200807071952.27427.srinivasa@in.ibm.com>
	<18554.33417.542066.185326@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 14 Jul 2008 08:40:03 +1000
Message-Id: <1215988803.7549.214.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Srinivasa D S <srinivasa@in.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-14 at 08:32 +1000, Paul Mackerras wrote:
> Srinivasa D S writes:
> 
> >  task_pt_regs() macro defines pt_regs for the given task,  this macro is  
> > currently not defined for powerpc arch. We need this macro for 
> > upcoming utrace features. 
> >  Below attached patch  defines this macro for powerpc arch. Please let 
> > me know your comments on this.
> 
> > +#define task_pt_regs(tsk)	((struct pt_regs *)(tsk)->thread.regs)
> 
> The cast is unnecessary since tsk->thread.regs is already a struct
> pt_regs *.  Also note that tsk->thread.regs will be NULL for a kernel
> thread.

Hrm.. I stuck that one in powerpc master, but not yet in next. Wonder if
I should back it out, sounds like a minor issue.

Ben.
