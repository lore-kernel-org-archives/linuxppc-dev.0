Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 5217BDDDFA
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 21:57:36 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 5 May 2008 13:57:29 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Message-ID: <20080505115729.GB16128@iram.es>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<1209628423.18023.286.camel@pasglop>
	<CF55CEE2-CAF5-4728-947E-C1C37E262EDB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CF55CEE2-CAF5-4728-947E-C1C37E262EDB@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 01, 2008 at 08:22:08AM -0500, Kumar Gala wrote:
> >>So we have 4 actual exceptions:
> >>* CriticalInput (some external device signaled this.  There are two
> >>concepts of critical.  One is error the other is high priority)
> >>However this would have the same caveats as any ExternalInput  
> >>handler.
> >
> >No, it's worse. It can interrupt code that normally has
> >local_irq_disabled() and thus doesn't expect to be interrupted. That
> >means that everything becomes unsafe including locks etc....
> 
> Fair.  Should local_irq_disable() clear MSR_SE & MSR_BE on classic  
> parts?
> 
> >Note that driver that want to make active use of that probably want  
> >some
> >explicit local_crit_irq_disable/enable functions to be able to  
> >implement
> >some sort of synchronization.
> 
> Or we could just have local_irq_disable -- clear MSR_EE and MSR_CE
> 
> >>* Watchdog - pretty severe if this fires.
> >>
> >>* Debug - user space debug is pretty straight forward.  However we
> >>have features like kprobes that require kernel level support.
> >
> >Which means we have to be extra careful, in fact, I consider it a  
> >design
> >bug of BookE to have made debug be a critical interrupt...
> 
> I consider the whole BookE debug arch a design bug :)

Why only the debug part? :-)

	Gabriel
