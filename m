Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id A55212C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 01:36:12 +1000 (EST)
Date: Thu, 23 Aug 2012 11:02:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120823090209.GA4630@redhat.com>
References: <20120822082205.GA29216@in.ibm.com>
 <20120822082708.GB29216@in.ibm.com> <1345696100.3338.21.camel@concordia>
 <20120823053234.GE25338@linux.vnet.ibm.com>
 <1345716378.29170.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345716378.29170.4.camel@pasglop>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 ppcdev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23, Benjamin Herrenschmidt wrote:
>
> On Thu, 2012-08-23 at 11:02 +0530, Srikar Dronamraju wrote:
> > >
> >
> > insn is updated/accessed in the arch independent code. Size of
> > uprobe_opcode_t could be different for different archs.
> > uprobe_opcode_t
> > represents the size of the smallest breakpoint instruction for an
> > arch.
> >
> > Hence u8 works out the best. I know we could still use uprobe_opcode_t
> > and achieve the same. In which case, we would have to interpret
> > MAX_UINSN_BYTES differently. Do you see any advantages of using
> > uprobe_opcode_t instead of u8 across archs?
>
> But don't you actively rely on the fact that on powerpc, unlike x86, you
> -can- atomically replace an instruction with a single 32-bit store ?

I must have missed something...

But powerpc does not replace an instruction, the arch independent code
does this and it assumes that uprobe->arch.insn is u8[MAX_UINSN_BYTES].

Perhaps you meant that on powerpc it is "safe" to replace the insn
even if this can race with some CPU executing this code? But uprobes
has to replace the original page anyway, we should not write to
->vm_file.

I agree that memcpy() in arch_uprobe_analyze_insn() and
arch_uprobe_skip_sstep() looks a bit strange. May be powerpc can do

	struct arch_uprobe {
		union {
			u8		insn[MAX_UINSN_BYTES];
			u32		ainsn;
		};
	};

and use auprobe->ainsn directly, I dunno.

But probably I misunderstood you.

Oleg.
