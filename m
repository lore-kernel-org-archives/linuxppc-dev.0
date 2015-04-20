Return-Path: <ulrich.weigand@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BAC21A0BD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 22:32:30 +1000 (AEST)
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 21798140291
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 22:32:28 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ulrich.weigand@de.ibm.com>;
 Mon, 20 Apr 2015 13:32:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id E6F501B08061
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 13:32:58 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3KCWMjd54394978
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 12:32:22 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3KCWJEY015075
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 06:32:22 -0600
In-Reply-To: <552B82F9.3080108@linux.vnet.ibm.com>
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <54947C64.4030206@linux.vnet.ibm.com> <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>
 <1422419289.9646.20.camel@neuling.org>
 <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
 <1424667110.16027.6.camel@neuling.org>
 <OF5DE08D4B.0B79C501-ONC1257E0C.0044F80B-C1257E0C.0046DC8F@de.ibm.com>
 <1426718702.4866.2.camel@neuling.org> <1426719027.4866.4.camel@neuling.org>
 <550FEC36.8080803@linux.vnet.ibm.com>
 <OF91038A37.65C405E5-ONC1257E21.0061938F-C1257E21.00620A03@de.ibm.com>
 <1428534695.4682.18.camel@neuling.org> <55267595.90
 <5527938B.1030901@linux.vnet.ibm.com> <552B82F9.3080108@linux.vnet.ibm.com>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Message-ID: <OF939465E0.3429202B-ONC1257E2D.0043E1D3-C1257E2D.004479F6@de.ibm.com>
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Mon, 20 Apr 2015 14:27:56 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: shuahkh@osg.samsung.com, Michael Neuling <mikey@neuling.org>,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 peterz@infradead.org, palves@redhat.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 kirjanov@gmail.com, tglx@linutronix.de, oleg@redhat.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote on 13.04.2015
10:48:57:
> On 04/10/2015 04:03 PM, Ulrich Weigand wrote:
> > - You provide checkpointed FPR and VMX registers, but there doesn't
seem
> >   to be any way to get at the checkpointed *VSX* registers (i.e. the
part
> >   that is neither covered by FPR or VMX, corresponding to NT_PPC_VSX).
>
> Will change vsr_get, vsr_set functions as we have done for fpr_get and
fpr_set
> functions. Also will add one more ELF core note NT_PPC_TM_CVSX to fetch
the
> check pointed state of VSX register while inside the transaction.

OK.

> >   I would much prefer three separate regsets (e.g. NT_PPC_DSCR,
NT_PPC_PPR,
> >   and NT_PPC_TAR), each of which is available and valid if and only if
the
> >   current processor actually has the register in question.
>
> Thats like adding one ELF core note for every single register
> because we cannot
> put them in any category. Then as Michael Ellerman had pointed out to
include
> a lot more registers in this MISC category (which we are not doing right
now
> in the interest of having minimum support available before we look at the
full
> possible list of MISC registers), we should add one ELF core note section
for
> each of those individual registers ? I am not sure.

This confuses me a bit.  My understanding was that ptrace regsets, once
defined, should never change in the future.  (GDB will only check whether
or not a regset is supported; if it is, it will expect the contents to be
as it expects them to be.)  "Including a lot more registers" would
therefore
seem to require adding new regsets anyway, which is one of the reasons why
I disagree a "MISC" regset is particularly useful.

> > - Similarly, the NT_PPC_TM_SPR regset as currently defined mixes and
> > matches
> >   registers with different "lifetimes".  The transactional memory
registers
> >   (TFHAR, TEXASR, TFIAR) are available *always* on machines that
support
> >   transactions.  But the other registers in that regset are
checkpointed
> >   versions that are only available/valid within a transaction.  I think
a
> >   better way to faithfully represent this would be to have the
> > NT_PPC_TM_SPR
> >   regset only contain the transcational memory registers, and use
separate
> >   regsets for the checkpointed registers -- those should parallel the
non-
> >   checkpointed register regset.
>
> Right now, we support NT_PPC_TM_SPR only inside the transaction, so we
dont
> have the problem with different "lifetimes" registers accessed together.
But
> yes, I get your point.

Since the transactional SPRs are accessible from user space outside of a
transaction, it would make sense for them to accessible from ptrace as
well.
If the current patch set doesn't do that, I guess it would be better to
change that.

> > - Particularly confusing to me is the "checkpointed original MSR" which
> >   currently also resides in NT_PPC_TM_SPR.  What exactly is this?  How
> >   does that differ from the MSR slot in the NT_PPC_TM_CGPR regset?
>
> I believed it stores the check pointed MSR value which was in the
register
> before the transaction started. But then how it is different from the
> ckpt_regs.msr, I am not sure. Mikey or Michael should be able to clarify
> more on this. I can see "orig_msr" getting used in many places to hold
the
> check pointed value of MSR.

Your other mail states that the orig_mst may be irrelevant for ptrace
anyway ... that would be OK with me as well.

> >   In any case, it seems the ptrace set-register case currently allows
user
> >   space to restore *any* arbitrary value into the checkpointed MSR,
which
> >   would presumably get restored into the real MSR at some point, unless
I'm
> >   missing something here.  Do we not need a check that only safe bits
are
> >   modified, just like with ptrace access to the real MSR?
>
> Where and which safe bits do we check before writing any value into the
MSR
> register from ptrace interface ? May be I am missing something here.

All ptrace accesses to *set* the regular msr go via this routine:

static int set_user_msr(struct task_struct *task, unsigned long msr)
{
        task->thread.regs->msr &= ~MSR_DEBUGCHANGE;
        task->thread.regs->msr |= msr & MSR_DEBUGCHANGE;
        return 0;
}

I think we'd need to do the equivalent whenever changing the checkpointed
MSR.

Bye,
Ulrich
