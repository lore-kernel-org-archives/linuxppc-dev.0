Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A29541A0143
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 21:21:31 +1100 (AEDT)
Message-ID: <1447669291.17316.10.camel@neuling.org>
Subject: Re: [PATCH 4/5] powerpc/tm: Check for already reclaimed tasks
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sam.bobroff@au1.ibm.com
Date: Mon, 16 Nov 2015 21:21:31 +1100
In-Reply-To: <1447666430.2191.5.camel@ellerman.id.au>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
 <1447390652-28355-4-git-send-email-mikey@neuling.org>
 <564983E6.6000307@linux.vnet.ibm.com>
 <1447665799.17316.2.camel@neuling.org>
 <1447666430.2191.5.camel@ellerman.id.au>
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

On Mon, 2015-11-16 at 20:33 +1100, Michael Ellerman wrote:
> On Mon, 2015-11-16 at 20:23 +1100, Michael Neuling wrote:
> > On Mon, 2015-11-16 at 12:51 +0530, Anshuman Khandual wrote:
> > > On 11/13/2015 10:27 AM, Michael Neuling wrote:
> > > > Currently we can hit a scenario where we'll tm_reclaim() twice.
> > > >  This
> > > > results in a TM bad thing exception because the second reclaim
> > > > occurs
> > > > when not in suspend mode.
> > > >=20
> > > > The scenario in which this can happen is the following.  We
> > > > attempt
> > > > to
> > > > deliver a signal to userspace.  To do this we need obtain the
> > > > stack
> > > > pointer to write the signal context.  To get this stack pointer
> > > > we
> > > > must tm_reclaim() in case we need to use the checkpointed stack
> > > > pointer (see get_tm_stackpointer()).  Normally we'd then return
> > > > directly to userspace to deliver the signal without going
> > > > through
> > > > __switch_to().
> > > >=20
> > > > Unfortunatley, if at this point we get an error (such as a bad
> > > > userspace stack pointer), we need to exit the process.  The
> > > > exit
> > > > will
> > > > result in a __switch_to().  __switch_to() will attempt to save
> > > > the
> > > > process state which results in another tm_reclaim().  This
> > > > tm_reclaim() now causes a TM Bad Thing exception as this state
> > > > has
> > > > already been saved and the processor is no longer in TM suspend
> > > > mode.
> > > > Whee!
> > > >=20
> > > > This patch checks the state of the MSR to ensure we are TM
> > > > suspended
> > > > before we attempt the tm_reclaim().  If we've already saved the
> > > > state
> > > > away, we should no longer be in TM suspend mode.  This has the
> > > > additional advantage of checking for a potential TM Bad Thing
> > > > exception.
> > >=20
> > > Can this situation be created using a test and verified that with
> > > this new change, the kernel can handle it successfully. I guess
> > > the self test in the series does not cover this scenario.
> >=20
> > No it doesn't.  The syscall fuzzer I have does hit it but I don't
> > have
> > permission to post that.
>=20
> And we don't really want a fuzzer as a selftest, because it might
> call unlink
> or something else bad.
>=20
> But having found the bug with the fuzzer, can't you write a test that
> triggers
> the bad case?
>=20
> > From your description it sounds like if you had a child spinning
> > with a bad r1,
> and then a parent sent it a signal that would trip it?

You'd need to turn on TM too, but yeah... I have something like this
working which I'll cleanup and post as a self test:

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

void signal_segv(int signum)
{
	/* This should never actually run since stack is foobar */
	exit(1);
}

int main()
{
	int pid;

	pid =3D fork();
	if (pid < 0)
		exit(1);

	if (pid) {
		// Parent
		wait(NULL);
		printf("PASSED\n");
		return 0;
	}

	if (signal(SIGSEGV, signal_segv) =3D=3D SIG_ERR)
		exit(1);

	asm volatile("li 1, 0 ;"
		     "1:"
		     ".long 0x7C00051D ;" // tbegin
		     "beq 1b ;" // retry for ever
		     ".long 0x7C0005DD ; ;" // tsuspend
		     "ld 2, 0(1) ;" // trigger segv"
		     : : : "memory");

	return 1;
}
