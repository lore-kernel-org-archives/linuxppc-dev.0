Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id C45E02C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 03:03:21 +1000 (EST)
Date: Wed, 15 Aug 2012 18:59:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120815165931.GA10059@redhat.com>
References: <20120726051902.GA29466@in.ibm.com>
 <20120726052029.GB29466@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120726052029.GB29466@in.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/26, Ananth N Mavinakayanahalli wrote:
>
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
>
> This is the port of uprobes to powerpc. Usage is similar to x86.

I am just curious why this series was ignored by powerpc maintainers...

Of course I can not review this code, I know nothing about powerpc,
but the patches look simple/straightforward.

Paul, Benjamin?





Just one question... Shouldn't arch_uprobe_pre_xol() forbid to probe
UPROBE_SWBP_INSN (at least) ?

(I assume that emulate_step() can't handle this case but of course I
 do not understand arch/powerpc/lib/sstep.c)

Note that uprobe_pre_sstep_notifier() sets utask->state = UTASK_BP_HIT
without any checks. This doesn't look right if it was UTASK_SSTEP...

But again, I do not know what powepc will actually do if we try to
single-step over UPROBE_SWBP_INSN.

Oleg.
