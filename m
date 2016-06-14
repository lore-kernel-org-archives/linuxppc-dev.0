Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTTtF6XVjzDqdh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 22:46:45 +1000 (AEST)
Date: Tue, 14 Jun 2016 09:46:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@ozlabs.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 He Kuang <hekuang@huawei.com>
Subject: Re: [PATCH 2/2] perf annotate: add powerpc support
Message-ID: <20160614124639.GB3978@kernel.org>
References: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
 <21173b25482dd19f85416f02bc8050324fe5eb76.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
 <20160610133644.GB3826@kernel.org>
 <20160610143822.GT18654@naverao1-tp.localdomain>
 <1465875647.31436.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465875647.31436.0.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Jun 14, 2016 at 01:40:47PM +1000, Michael Ellerman escreveu:
> On Fri, 2016-06-10 at 20:08 +0530, Naveen N. Rao wrote:
> > On 2016/06/10 10:36AM, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Jun 10, 2016 at 06:32:51PM +0530, Naveen N. Rao escreveu:
> > > > Convert ins__find() to a __weak function for generic functionality,
> > > > while adding a powerpc-specific variant. We look at the function name
> > > > for branch instructions and classify the instructions to one among a
> > > > branch, a function call (branch with LR update) or a function return
> > > > (branch to LR).

> > > How would this allow one to get a perf.data collected on a powerpc
> > > system, transfer it to a x86-64 (or aarch64, to mention another
> > > workstation wannabe chip) system and then try annotating it?

> > > There was a previous discussion about this, and it involved having all
> > > yout ppc tables available as well as other arches tables, and then
> > > choosing which one to use based on:

> > > 	normalize_arch(thread->mg->machine->env->arch)

> > > just like was done for support cross unwinding, see recent patch kit by
> > > He Kuang, CCed.

> > Nice. This would be good to have. I will look at adding powerpc support 
> > for cross-architecture unwind.

> > However, for cross-architecture annotation, I think there will be a lot 
> > more dependencies since perf currently uses objdump to obtain the 
> > disassembly. In addition, the actual binaries will also be needed.
 
> It's possible to build a multi-arch objdump, I don't know if it's packaged on
> all distros, or if perf wants to depend on it.

Somebody noticed that we can specify a different objdump binary, from a
cross toolchain package.

We need to at least check if the objdump being used supports the
architecture where the perf.data file was generated, refusing to process
the file for which there is no support, providing a clear message to
users trying to process such files.

I.e. checking if normalize_arch(thread->mg->machine->env->arch) is one of:

[acme@jouet linux]$ objdump -m 2>&1|grep 'objdump: supported' 
objdump: supported targets: elf64-x86-64 elf32-i386 elf32-x86-64 a.out-i386-linux pei-i386 pei-x86-64 elf64-l1om elf64-k1om elf64-little elf64-big elf32-little elf32-big plugin srec symbolsrec verilog tekhex binary ihex
objdump: supported architectures: i386 i386:x86-64 i386:x64-32 i8086 i386:intel i386:x86-64:intel i386:x64-32:intel i386:nacl i386:x86-64:nacl i386:x64-32:nacl l1om l1om:intel k1om k1om:intel plugin
[acme@jouet linux]$

- Arnaldo
