Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTFmH5dwszDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 13:40:47 +1000 (AEST)
Message-ID: <1465875647.31436.0.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] perf annotate: add powerpc support
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Anton
 Blanchard <anton@ozlabs.org>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>, He Kuang <hekuang@huawei.com>
Date: Tue, 14 Jun 2016 13:40:47 +1000
In-Reply-To: <20160610143822.GT18654@naverao1-tp.localdomain>
References: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
 <21173b25482dd19f85416f02bc8050324fe5eb76.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
 <20160610133644.GB3826@kernel.org>
 <20160610143822.GT18654@naverao1-tp.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-10 at 20:08 +0530, Naveen N. Rao wrote:
> On 2016/06/10 10:36AM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jun 10, 2016 at 06:32:51PM +0530, Naveen N. Rao escreveu:
> > > Convert ins__find() to a __weak function for generic functionality,
> > > while adding a powerpc-specific variant. We look at the function name
> > > for branch instructions and classify the instructions to one among a
> > > branch, a function call (branch with LR update) or a function return
> > > (branch to LR).
> > 
> > How would this allow one to get a perf.data collected on a powerpc
> > system, transfer it to a x86-64 (or aarch64, to mention another
> > workstation wannabe chip) system and then try annotating it?
> > 
> > There was a previous discussion about this, and it involved having all
> > yout ppc tables available as well as other arches tables, and then
> > choosing which one to use based on:
> > 
> > 	normalize_arch(thread->mg->machine->env->arch)
> > 
> > just like was done for support cross unwinding, see recent patch kit by
> > He Kuang, CCed.
> 
> Nice. This would be good to have. I will look at adding powerpc support 
> for cross-architecture unwind.
> 
> However, for cross-architecture annotation, I think there will be a lot 
> more dependencies since perf currently uses objdump to obtain the 
> disassembly. In addition, the actual binaries will also be needed.

It's possible to build a multi-arch objdump, I don't know if it's packaged on
all distros, or if perf wants to depend on it.

cheers
