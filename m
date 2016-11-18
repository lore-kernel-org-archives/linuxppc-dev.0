Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKwZY34qszDvtk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:22:28 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIBJZhk059071
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:22:26 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26sy13cqww-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:22:26 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 21:22:22 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 232A22CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:22:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAIBMJTu56098988
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:22:19 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAIBMJmR014631
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:22:19 +1100
Date: Fri, 18 Nov 2016 16:52:16 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 2/4] powerpc: kprobe: add arch specific blacklist
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <e34af1637b3c190cc0f2e41131f2524e75720ed3.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <87y40hgwz2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y40hgwz2.fsf@concordia.ellerman.id.au>
Message-Id: <20161118112216.GE4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/18 04:48PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > Add symbol to mark end of entry_*.S and use the same to blacklist all
> > addresses from kernel start (_stext) to entry code from kprobes. Much of
> > this code is early exception handling where we can't really take a trap.
> 
> I'm not sure about this. entry_*.S is actually a bit of jumble,
> especially the 64bit version. I've been wanting to split it up for a
> long time.

Ok. Let me take a stab at that.

> 
> It doesn't actually contain any early exception handling. It does
> contain the common syscall handler, and the exception return paths, some
> of which should be black listed. And lots of other junk.
> 
> Also I'm not sure if it's guaranteed that there won't be other code
> between _stext and the end of entry, it's not handled explicitly in the
> linker script, it just tends to get linked early because it's in head-y.

I actually considered that. One of the issues in trying to get entry_* 
linked in early has to do with the exception common handlers - they 
start at 0x7000 or 0x8000 and are placed in .text *and* I think they 
need to be within 64k from the exception vectors. As such, placing 
entry_* in a separate section and linking it after HEAD_TEXT resulted in 
moving down the common exception handlers.

Regardless of the kprobe blacklist, does it make sense to put the common 
exception handlers into a separate section so as to separate them out 
from the rest of the code?

> 
> So I think it would be better if we had a clearer picture of exactly
> what in this file we want to blacklist.

Agreed. As a first step, I wanted to get a coarser blacklist in place 
and fine tune it later. But, I can see why entry_* needs a smaller 
blacklist. I'll get back on this.


- Naveen
