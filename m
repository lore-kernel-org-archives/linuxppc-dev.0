Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AAFA1A0279
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 20:33:51 +1100 (AEDT)
Message-ID: <1447666430.2191.5.camel@ellerman.id.au>
Subject: Re: [PATCH 4/5] powerpc/tm: Check for already reclaimed tasks
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sam.bobroff@au1.ibm.com
Date: Mon, 16 Nov 2015 20:33:50 +1100
In-Reply-To: <1447665799.17316.2.camel@neuling.org>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
 <1447390652-28355-4-git-send-email-mikey@neuling.org>
 <564983E6.6000307@linux.vnet.ibm.com>
 <1447665799.17316.2.camel@neuling.org>
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

On Mon, 2015-11-16 at 20:23 +1100, Michael Neuling wrote:
> On Mon, 2015-11-16 at 12:51 +0530, Anshuman Khandual wrote:
> > On 11/13/2015 10:27 AM, Michael Neuling wrote:
> > > Currently we can hit a scenario where we'll tm_reclaim() twice. 
> > >  This
> > > results in a TM bad thing exception because the second reclaim
> > > occurs
> > > when not in suspend mode.
> > > 
> > > The scenario in which this can happen is the following.  We attempt
> > > to
> > > deliver a signal to userspace.  To do this we need obtain the stack
> > > pointer to write the signal context.  To get this stack pointer we
> > > must tm_reclaim() in case we need to use the checkpointed stack
> > > pointer (see get_tm_stackpointer()).  Normally we'd then return
> > > directly to userspace to deliver the signal without going through
> > > __switch_to().
> > > 
> > > Unfortunatley, if at this point we get an error (such as a bad
> > > userspace stack pointer), we need to exit the process.  The exit
> > > will
> > > result in a __switch_to().  __switch_to() will attempt to save the
> > > process state which results in another tm_reclaim().  This
> > > tm_reclaim() now causes a TM Bad Thing exception as this state has
> > > already been saved and the processor is no longer in TM suspend
> > > mode.
> > > Whee!
> > > 
> > > This patch checks the state of the MSR to ensure we are TM
> > > suspended
> > > before we attempt the tm_reclaim().  If we've already saved the
> > > state
> > > away, we should no longer be in TM suspend mode.  This has the
> > > additional advantage of checking for a potential TM Bad Thing
> > > exception.
> > 
> > Can this situation be created using a test and verified that with
> > this new change, the kernel can handle it successfully. I guess
> > the self test in the series does not cover this scenario.
> 
> No it doesn't.  The syscall fuzzer I have does hit it but I don't have
> permission to post that.

And we don't really want a fuzzer as a selftest, because it might call unlink
or something else bad.

But having found the bug with the fuzzer, can't you write a test that triggers
the bad case?

>From your description it sounds like if you had a child spinning with a bad r1,
and then a parent sent it a signal that would trip it?

cheers
