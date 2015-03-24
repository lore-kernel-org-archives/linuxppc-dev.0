Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AC771A0171
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 13:02:49 +1100 (AEDT)
Message-ID: <1427162568.28572.2.camel@ellerman.id.au>
Subject: Re: [PATCH 3/3] selftests/powerpc: Add transactional syscall test
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue, 24 Mar 2015 13:02:48 +1100
In-Reply-To: <5510C352.9060302@au1.ibm.com>
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
 <b4a4ea23b20098512cf350b97ce98e0d1ea58531.1426740212.git.sam.bobroff@au1.ibm.com>
 <550BE795.4070200@linux.vnet.ibm.com> <5510C352.9060302@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, matt@ozlabs.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-24 at 12:52 +1100, Sam Bobroff wrote:
> On 20/03/15 20:25, Anshuman Khandual wrote:
> > On 03/19/2015 10:13 AM, Sam Bobroff wrote:
> >> Check that a syscall made during an active transaction will fail with
> >> the correct failure code and that one made during a suspended
> >> transaction will succeed.
> >>
> >> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > 
> > The test works.
> 
> Great :-)
> 
> >> +
> >> +int tm_syscall(void)
> >> +{
> >> +	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
> >> +	setbuf(stdout, 0);
> >> +	FAIL_IF(!t_active_getppid_test());
> >> +	printf("%d active transactions correctly aborted.\n", TM_TEST_RUNS);
> >> +	FAIL_IF(!t_suspended_getppid_test());
> >> +	printf("%d suspended transactions succeeded.\n", TM_TEST_RUNS);
> >> +	return 0;
> >> +}
> >> +
> >> +int main(void)
> >> +{
> >> +	return test_harness(tm_syscall, "tm_syscall");
> >> +}
> >> +
> > 
> > There is an extra blank line at the end of this file. Interchanging return
> > codes of 0 and 1 for various functions make it very confusing along with
> > negative FAIL_IF checks in the primary test function. Control flow structures
> > like these can use some in-code documentation for readability.
> > 
> > +	for (i = 0; i < TM_RETRIES; i++) {
> > +		if (__builtin_tbegin(0)) {
> > +			getppid();
> > +			__builtin_tend(0);
> > +			return 1;
> > +		}
> > +		if (t_failure_persistent())
> > +			return 0;
> > 
> > or
> > 
> > +		if (__builtin_tbegin(0)) {
> > +			__builtin_tsuspend();
> > +			getppid();
> > +			__builtin_tresume();
> > +			__builtin_tend(0);
> > +			return 1;
> > +		}
> > +		if (t_failure_persistent())
> > +			return 0;
> > 
> 
> Good points. I'll remove the blank line and comment the code.
> 
> I'm not sure I can do any better with the FAIL_IF() macro: I wanted it
> to read "fail if the test failed", but I can see what you mean about a
> double negative. Maybe it would be better to introduce a different
> macro, more like a standard assert: TEST(XXX) which fails if XXX is
> false. However, I think "TEST" would be too generic a name and I'm not
> should what would be better. Any comments/suggestions?

FAIL_IF() is designed for things that return 0 for OK and !0 for failure. Like
most things in C.

So I think it would be improved if you inverted your return codes in your test
routines.

Even better to return ESOMETHING in the error cases, and zero otherwise.

cheers
