Return-Path: <phdm@macqel.be>
Received: from smtp2.macqel.be (smtp2.macqel.be [194.78.208.39])
 by ozlabs.org (Postfix) with ESMTP id 4E2E82C0394
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 20:59:13 +1100 (EST)
Date: Thu, 7 Mar 2013 10:59:07 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: 3.9-rc1 powerpc ptrace.c: 'brk.len' is used uninitialized
Message-ID: <20130307095907.GA16489@frolo.macqel>
References: <20130306060058.GA3106@frolo.macqel>
 <21084.1362607788@ale.ozlabs.ibm.com> <20130306223645.GA15484@frolo.macqel>
 <31862.1362611670@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <31862.1362611670@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mikey,

On Thu, Mar 07, 2013 at 10:14:30AM +1100, Michael Neuling wrote:
> Philippe De Muyter <phdm@macqel.be> wrote:
> 
> > On Thu, Mar 07, 2013 at 09:09:48AM +1100, Michael Neuling wrote:
> > > > bisect tells me that since your commit 9422de3e953d0e60eb95f5430a9dd803eec1c6d7 
> > > > "powerpc: Hardware breakpoints rewrite to handle non DABR breakpoint registers",
> > > > compiling linux fails with :
> > > > 
> > > >   cc1: warnings being treated as errors
> > > >   arch/powerpc/kernel/ptrace.c: In function 'arch_ptrace':
> > > >   arch/powerpc/kernel/ptrace.c:1450: warning: 'brk.len' is used uninitialized in this function
> > > >   arch/powerpc/kernel/ptrace.c:1352: note: 'brk.len' was declared here
> > > > 
> > > > could you look at that ?
> > > 
> > > Sure. 
> > 
> > I use gcc-4.2.2, and my .config follows.
> 
> I'm a bit lost.  
> 
> I don't have 4.2.2 (which is ancient BTW) and I can't hit this on
> 4.3,4.5 or 4.6 with your config.  It compiles fine.
> 
> Also:
> 
> >   arch/powerpc/kernel/ptrace.c:1450: warning: 'brk.len' is used uninitialized in this function
> >   arch/powerpc/kernel/ptrace.c:1352: note: 'brk.len' was declared here
> 
> These line numbers make no sense at all WRT v3.9-rc1.  brk.len is neither
> declared or used in those lines:

those were the line numbers just after your commit

In 3.9-rc1 they are :

cc1: warnings being treated as errors
arch/powerpc/kernel/ptrace.c: In function 'arch_ptrace':
arch/powerpc/kernel/ptrace.c:1479: warning: 'brk.len' is used uninitialized in this function
arch/powerpc/kernel/ptrace.c:1381: note: 'brk.len' was declared here

		if (child->thread.hw_brk.address)
			return -ENOSPC;

1479:		child->thread.hw_brk = brk;

		return 1;
	#endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */

Philippe
