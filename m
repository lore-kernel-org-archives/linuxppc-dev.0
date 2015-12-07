Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3BE51A0D8C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 21:30:47 +1100 (AEDT)
In-Reply-To: <20151112054442.GD22330@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, kvm-ppc@vger.kernel.org
Subject: Re: powerpc/64: Include KVM guest test in all interrupt vectors
Message-Id: <20151207103047.BF8561402DE@ozlabs.org>
Date: Mon,  7 Dec 2015 21:30:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-12-11 at 05:44:42 UTC, Paul Mackerras wrote:
> Currently, if HV KVM is configured but PR KVM isn't, we don't include
> a test to see whether we were interrupted in KVM guest context for the
> set of interrupts which get delivered directly to the guest by hardware
> if they occur in the guest.  This includes things like program
> interrupts.
> 
> However, the recent bug where userspace could set the MSR for a VCPU
> to have an illegal value in the TS field, and thus cause a TM Bad Thing
> type of program interrupt on the hrfid that enters the guest, showed that
> we can never be completely sure that these interrupts can never occur
> in the guest entry/exit code.  If one of these interrupts does happen
> and we have HV KVM configured but not PR KVM, then we end up trying to
> run the handler in the host with the MMU set to the guest MMU context,
> which generally ends badly.
> 
> Thus, for robustness it is better to have the test in every interrupt
> vector, so that if some way is found to trigger some interrupt in the
> guest entry/exit path, we can handle it without immediately crashing
> the host.
> 
> This means that the distinction between KVMTEST and KVMTEST_PR goes
> away.  Thus we delete KVMTEST_PR and associated macros and use KVMTEST
> everywhere that we previously used either KVMTEST_PR or KVMTEST.  It
> also means that SOFTEN_TEST_HV_201 becomes the same as SOFTEN_TEST_PR,
> so we deleted SOFTEN_TEST_HV_201 and use SOFTEN_TEST_PR instead.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/31a40e2b052c0f2b80df7b56

cheers
