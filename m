Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id CCEE1DDF27
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 20:23:36 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 28 May 2007 12:23:27 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fsl booke MM vs. SMP questions
Message-ID: <20070528102327.GA9675@iram.es>
References: <1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
	<1179831375.3827.4.camel@localhost.localdomain>
	<1179873742.32247.864.camel@localhost.localdomain>
	<1179887929.3656.2.camel@localhost.localdomain>
	<1179889736.32247.893.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D263595EF5F@zch01exm21.fsl.freescale.net>
	<1180344249.19517.74.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D263595EF6C@zch01exm21.fsl.freescale.net>
	<1180346421.19517.79.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180346421.19517.79.camel@localhost.localdomain>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Liu Dave-r63238 <DaveLiu@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 28, 2007 at 08:00:21PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-05-28 at 17:37 +0800, Liu Dave-r63238 wrote:
> > 
> > BTW, if the x86 processor support the broadcast tlb operation to
> > system?
> > If it can,  why we adopt the IPI mechanism for x86? what is the
> > concern?
> 
> I don't think it supports them but then, I don't know for sure.
> 

It does not. However IA64 (aka Itanic) does. Of course on x86 until
recently, the TLB were completely flushed (at least the entries mapping to
user space) on task switches to a different mm, which automatically 
avoids races for single threaded apps.

> Part of the problem is what your workload is. if you have a lot of small
> and short lived processes, such as CGI's on a web server, they are
> fairly unlikely to exist on more than one processor, maybe two, during
> their lifetime (there is a strong optimisation to only do a local
> invalidate when the process only ever existed on one processor).
> 
> If you have a massively threaded workload, that is, a given process is
> likely to exist on all processors, then it's also fairly unlikely that
> you start doing a lot of fork()'s or to have that processes be short
> lived... so it's less of an issue unless you start abusing mmap/munmap
> or mprotect.
> 
> Also, when you have a large number of processors, having broadcast tlb
> invalidations on the bus might become a bottleneck if, at the end of the
> day, you really only want to invalidate one or two siblings. In that
> case, targetted IPIs are probably a better option.

On SMP with single die and integrated memory controllers (PASemi), 
I'd bet that tlb invalidation broadcast is typically much cheaper 
since no external signals are involved (from a hardware point of view
it's not very different from a store to a shared cache line that has 
to be invalidated in the cache of the other processors).

	Gabriel
