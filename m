Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKwdL3dvCzDsxJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:24:54 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIBNsHd140379
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:24:52 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26swu38n50-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:24:52 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 21:24:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 576E62BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:24:47 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAIBOlGk50856034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:24:47 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAIBOkpJ013436
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:24:47 +1100
Date: Fri, 18 Nov 2016 16:54:43 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/4] powerpc: kprobe: add arch specific blacklist
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <e34af1637b3c190cc0f2e41131f2524e75720ed3.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <87y40hgwz2.fsf@concordia.ellerman.id.au>
 <20161118160427.c1fa43473cd96e0bcc3b35a6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161118160427.c1fa43473cd96e0bcc3b35a6@kernel.org>
Message-Id: <20161118112443.GF4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Masami,

On 2016/11/18 04:04PM, Masami Hiramatsu wrote:
> On Fri, 18 Nov 2016 16:48:01 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> > 
> > > Add symbol to mark end of entry_*.S and use the same to blacklist all
> > > addresses from kernel start (_stext) to entry code from kprobes. Much of
> > > this code is early exception handling where we can't really take a trap.
> > 
> > I'm not sure about this. entry_*.S is actually a bit of jumble,
> > especially the 64bit version. I've been wanting to split it up for a
> > long time.
> > 
> > It doesn't actually contain any early exception handling. It does
> > contain the common syscall handler, and the exception return paths, some
> > of which should be black listed. And lots of other junk.
> > 
> > Also I'm not sure if it's guaranteed that there won't be other code
> > between _stext and the end of entry, it's not handled explicitly in the
> > linker script, it just tends to get linked early because it's in head-y.
> > 
> > So I think it would be better if we had a clearer picture of exactly
> > what in this file we want to blacklist.
> 
> Fair enough.
> 
> OK, the purpose of the kprobe blacklist is to avoid crashing kernel
> by putting kprobes in some critical area (critical for kprobes,
> not what usually "critical region" means).
> 
> Since kprobes is using breakpoint(trap) exception, if there is another
> kprobes(trap) on the path until kprobe_handler() handle it, the kernel
> kicks same exception handler and fall into the recursive fault.
> So the blacklist is used in kprobe to prohibit putting kprobes on such
> functions for avoiding it.
> 
> So, we might be carefully choose the function for the blacklist.

Agreed, though in this case, I'm trying to blacklist early exception 
code to begin with :)

> 
> BTW, Naveen, as far as I can see the kprobe implementation on ppc,
> it still depends on exceptions_notify to handle trap. It is no more
> recommended becuase notifier_call_chain involves too many unrelated
> functions. I recommend you to callback kprobe_handler and
> kprobe_post_handler directly from the trap handler as same as x86.

Ah, thanks for the tip. Patch to follow.


- Naveen
