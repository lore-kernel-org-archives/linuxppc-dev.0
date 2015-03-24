Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D4831A0281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:53:22 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 24 Mar 2015 11:53:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5B0742BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:53:16 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2O1r7aa45613110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:53:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2O1qg6Z022213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:52:42 +1100
Message-ID: <5510C352.9060302@au1.ibm.com>
Date: Tue, 24 Mar 2015 12:52:18 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Subject: Re: [PATCH 3/3] selftests/powerpc: Add transactional syscall test
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
 <b4a4ea23b20098512cf350b97ce98e0d1ea58531.1426740212.git.sam.bobroff@au1.ibm.com>
 <550BE795.4070200@linux.vnet.ibm.com>
In-Reply-To: <550BE795.4070200@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/03/15 20:25, Anshuman Khandual wrote:
> On 03/19/2015 10:13 AM, Sam Bobroff wrote:
>> Check that a syscall made during an active transaction will fail with
>> the correct failure code and that one made during a suspended
>> transaction will succeed.
>>
>> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> 
> The test works.

Great :-)

>> +
>> +int tm_syscall(void)
>> +{
>> +	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
>> +	setbuf(stdout, 0);
>> +	FAIL_IF(!t_active_getppid_test());
>> +	printf("%d active transactions correctly aborted.\n", TM_TEST_RUNS);
>> +	FAIL_IF(!t_suspended_getppid_test());
>> +	printf("%d suspended transactions succeeded.\n", TM_TEST_RUNS);
>> +	return 0;
>> +}
>> +
>> +int main(void)
>> +{
>> +	return test_harness(tm_syscall, "tm_syscall");
>> +}
>> +
> 
> There is an extra blank line at the end of this file. Interchanging return
> codes of 0 and 1 for various functions make it very confusing along with
> negative FAIL_IF checks in the primary test function. Control flow structures
> like these can use some in-code documentation for readability.
> 
> +	for (i = 0; i < TM_RETRIES; i++) {
> +		if (__builtin_tbegin(0)) {
> +			getppid();
> +			__builtin_tend(0);
> +			return 1;
> +		}
> +		if (t_failure_persistent())
> +			return 0;
> 
> or
> 
> +		if (__builtin_tbegin(0)) {
> +			__builtin_tsuspend();
> +			getppid();
> +			__builtin_tresume();
> +			__builtin_tend(0);
> +			return 1;
> +		}
> +		if (t_failure_persistent())
> +			return 0;
> 

Good points. I'll remove the blank line and comment the code.

I'm not sure I can do any better with the FAIL_IF() macro: I wanted it
to read "fail if the test failed", but I can see what you mean about a
double negative. Maybe it would be better to introduce a different
macro, more like a standard assert: TEST(XXX) which fails if XXX is
false. However, I think "TEST" would be too generic a name and I'm not
should what would be better. Any comments/suggestions?

Thanks for the review!

Cheers,
Sam.
