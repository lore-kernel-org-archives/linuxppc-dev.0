Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48DFADDF0E
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 20:05:47 +1000 (EST)
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Srinivasa D S <srinivasa@in.ibm.com>
In-Reply-To: <200807141401.26917.srinivasa@in.ibm.com>
References: <200807071952.27427.srinivasa@in.ibm.com>
	<18554.33417.542066.185326@cargo.ozlabs.ibm.com>
	<200807141401.26917.srinivasa@in.ibm.com>
Content-Type: text/plain
Date: Mon, 14 Jul 2008 19:06:57 +1000
Message-Id: <1216026417.7549.270.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-14 at 14:01 +0530, Srinivasa D S wrote:
> On Monday 14 July 2008 04:02:41 am Paul Mackerras wrote:
> > >  Below attached patch  defines this macro for powerpc arch. Please let
> > > me know your comments on this.
> > >
> > > +#define task_pt_regs(tsk)	((struct pt_regs *)(tsk)->thread.regs)
> >
> > The cast is unnecessary since tsk->thread.regs is already a struct
> > pt_regs *. 
> 
> True.
> 
> > Also note that tsk->thread.regs will be NULL for a kernel 
> > thread.
> 
> Yes, users of task_pt_regs will verify for NULL.  Updated patch attached 
> below.
> 
> Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>

Can you send a cleanup patch against powerpc.git instead ?

Thanks !

Ben
