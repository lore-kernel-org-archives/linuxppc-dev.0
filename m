Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C21C0DDF3E
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 20:00:33 +1000 (EST)
Subject: RE: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Dave-r63238 <DaveLiu@freescale.com>
In-Reply-To: <995B09A8299C2C44B59866F6391D263595EF6C@zch01exm21.fsl.freescale.net>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
	<1179831375.3827.4.camel@localhost.localdomain>
	<1179873742.32247.864.camel@localhost.localdomain>
	<1179887929.3656.2.camel@localhost.localdomain>
	<1179889736.32247.893.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D263595EF5F@zch01exm21.fsl.freescale.net>
	<1180344249.19517.74.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D263595EF6C@zch01exm21.fsl.freescale.net>
Content-Type: text/plain
Date: Mon, 28 May 2007 20:00:21 +1000
Message-Id: <1180346421.19517.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-28 at 17:37 +0800, Liu Dave-r63238 wrote:
> 
> BTW, if the x86 processor support the broadcast tlb operation to
> system?
> If it can,  why we adopt the IPI mechanism for x86? what is the
> concern?

I don't think it supports them but then, I don't know for sure.

Part of the problem is what your workload is. if you have a lot of small
and short lived processes, such as CGI's on a web server, they are
fairly unlikely to exist on more than one processor, maybe two, during
their lifetime (there is a strong optimisation to only do a local
invalidate when the process only ever existed on one processor).

If you have a massively threaded workload, that is, a given process is
likely to exist on all processors, then it's also fairly unlikely that
you start doing a lot of fork()'s or to have that processes be short
lived... so it's less of an issue unless you start abusing mmap/munmap
or mprotect.

Also, when you have a large number of processors, having broadcast tlb
invalidations on the bus might become a bottleneck if, at the end of the
day, you really only want to invalidate one or two siblings. In that
case, targetted IPIs are probably a better option.

In the end, it's very difficult to "guess" what is better. If you add
all the above, plus the race between tlb invalidations and SW TLB
reload, it makes sense to start with IPIs and try to optimize that code
path as much as you can to avoid hitting more CPUs than necessary for
example).

Ben.
