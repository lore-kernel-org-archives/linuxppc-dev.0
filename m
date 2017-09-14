Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtDDB05y0zDrCb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 19:45:29 +1000 (AEST)
Date: Thu, 14 Sep 2017 02:45:27 -0700
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Kamalesh Babulal
 <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] powerpc/kprobes: Do not suppress instruction
 emulation if a single run failed
Message-Id: <20170914024527.c5e52b918372e00061371014@kernel.org>
In-Reply-To: <20170914063807.6cmvisfiwfeluuv3@naverao1-tp.localdomain>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <a3a2ddbd004f0410943edb998011cfd31b97384e.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170913165359.475cb23ca0f76f88c3626d31@kernel.org>
 <20170914063807.6cmvisfiwfeluuv3@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Sep 2017 12:08:07 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/09/13 04:53PM, Masami Hiramatsu wrote:
> > On Thu, 14 Sep 2017 02:50:33 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > Currently, we disable instruction emulation if emulate_step() fails for
> > > any reason. However, such failures could be transient and specific to a
> > > particular run. Instead, only disable instruction emulation if we have
> > > never been able to emulate this. If we had emulated this instruction
> > > successfully at least once, then we single step only this probe hit and
> > > continue to try emulating the instruction in subsequent probe hits.
> > 
> > Hmm, would this mean that the instruction is emulatable or not depends
> > on context? What kind of situation is considerable?
> 
> Yes, as an example, a load/store instruction can cause exceptions 
> depending on the address. In some of those cases, we will have to single 
> step the instruction, but we will be able to emulate in most scenarios.

OK, I got it.
Could you add this example as comment in the code so that readers can
easily understand?

Thank you,

> 
> Thanks for the review!
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
