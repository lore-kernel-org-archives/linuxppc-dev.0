Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 9DD36B6FF8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 05:17:27 +1000 (EST)
Date: Wed, 13 Jun 2012 21:15:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120613191519.GA14246@redhat.com>
References: <20120608093257.GG13409@in.ibm.com>
 <20120611161215.GA12116@redhat.com>
 <20120612165404.GB30555@linux.vnet.ibm.com>
 <20120612174305.GA16349@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120612174305.GA16349@redhat.com>
Cc: peterz@infradead.org, antonb@thinktux.localdomain,
 lkml <linux-kernel@vger.kernel.org>, Jim Keniston <jkenisto@us.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12, Oleg Nesterov wrote:
>
> On 06/12, Srikar Dronamraju wrote:
> > >
> > > Note also that we should move this !UPROBE_COPY_INSN from
> > > install_breakpoint() to somewhere near alloc_uprobe(). This code
> > > is called only once, it looks a bit strange to use the "random" mm
> > > (the first mm vma_prio_tree_foreach() finds) and its mapping to
> > > verify the insn. In fact this is simply not correct and should be
> > > fixed, note that on x86 arch_uprobe_analyze_insn() checks
> >
> > The reason we "delay" the copy_insn to the first insert is because
> > we have to get access to mm. For archs like x86, we want to know if the
> > executable is 32 bit or not
>
> Yes. And this is wrong afaics.
>
> Once again. This !UPROBE_COPY_INSN code is called only once, and it
> uses the "random" mm. After that install_breakpoint() just calls
> set_swbp(another_mm) while the insn can be invalid because
> another_mm->ia32_compat != mm->ia32_compat.
>
> > So in effect, if we get access to
> > struct file corresponding to the inode and if the inode corresponds to
> > 32 bit executable file or 64 bit executable file during register, then
> > we can move it around alloc_uprobe().
>
> I don't think this can work. I have another simple fix in mind, I'll
> write another email later.

For example. Suppose there is some instruction in /lib64/libc.so which
is valid for 64-bit, but not for 32-bit.

Suppose that a 32-bit application does mmap("/lib64/libc.so", PROT_EXEC).

Now. If vma_prio_tree_foreach() finds this 32-bit mm first, uprobe_register()
fails even if there are other 64-bit applications which could be traced.

Or. uprobe_register() succeeds because it finds a 64-bit mm first, and
then that 32-bit application actually executes the invalid insn.

We can move arch_uprobe_analyze_insn() outside of !UPROBE_COPY_INSN block.

Or, perhaps, validate_insn_bits() should call both
validate_insn_32bits() and validate_insn_64bits(), and set the
UPROBE_VALID_IF_32 / UPROBE_VALID_IF_64 flags. install_breakpoint()
should do the additinal check before set_swbp() and verify that
.ia32_compat matches UPROBE_VALID_IF_*.

What do you think?

Oleg.
