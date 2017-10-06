Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7m8M4HRwzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 21:29:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Subject: Re: [PATCH 2/3] powerpc/tm: P9 disabled suspend mode workaround
In-Reply-To: <1507277413.25065.145.camel@kernel.crashing.org>
References: <20171006074643.25269-1-cyrilbur@gmail.com>
 <20171006074643.25269-2-cyrilbur@gmail.com>
 <1507277413.25065.145.camel@kernel.crashing.org>
Date: Fri, 06 Oct 2017 21:29:06 +1100
Message-ID: <87r2ug4ljh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Fri, 2017-10-06 at 18:46 +1100, Cyril Bur wrote:
...
>> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
>> index 760872916013..2cb01b48123a 100644
>> --- a/arch/powerpc/kernel/cputable.c
>> +++ b/arch/powerpc/kernel/cputable.c
>> @@ -2301,6 +2302,17 @@ void __init identify_cpu_name(unsigned int pvr)
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> +bool tm_suspend_supported(void)
>> +{
>> +	if (cpu_has_feature(CPU_FTR_TM)) {
>> +		if (pvr_version_is(PVR_POWER9) && ppc_tm_state != TM_STATE_NO_SUSPEND)
>> +			return false;
>> +		return true;
>> +	}
>
> Hrm... so if state is "NO SUSPEND" you return "true" ? Isn't this
> backward ? Or I don't understand what this is about...

Yeah it's a bit confuzzled.

I literally wrote it for you on a post-it Cyril! >:D

tm_suspend_supported() should be called tm_no_suspend_mode(). Where "no
suspend mode" is the new "mode" we're adding where suspend is not supported.

Then tm_no_suspend_mode() should be:

+	if (pvr_version_is(PVR_POWER9) && ppc_tm_state == TM_STATE_NO_SUSPEND)
+			return true;
+	return false;
  
And then all the extra checks and warnings in patch 3 just use it like:

	WARN_ON(tm_no_suspend_mode());

Because they're in paths where we shouldn't get to if suspend is
disabled.

I don't think we need to check CPU_FTR_TM because it's only called from
TM paths anyway. But we could add that to be paranoid. Or probably
better, when TM is forced off (below) we set ppc_tm_state to off.

>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>> index e37c26d2e54b..227ac600a1b7 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -265,11 +267,13 @@ early_param("ppc_tm", parse_ppc_tm);
>>  
>>  static void check_disable_tm(void)
>>  {
>> -	if (cpu_has_feature(CPU_FTR_TM) && ppc_tm_state == TM_STATE_OFF) {
>> -		printk(KERN_NOTICE "Disabling hardware transactional memory (HTM)\n");
>> -		cur_cpu_spec->cpu_user_features2 &=
>> -			~(PPC_FEATURE2_HTM_NOSC | PPC_FEATURE2_HTM);
>> -		cur_cpu_spec->cpu_features &= ~CPU_FTR_TM;
>> +	if (cpu_has_feature(CPU_FTR_TM)) {
>> +		if (ppc_tm_state == TM_STATE_OFF || (!tm_suspend_supported())) {
>> +			printk(KERN_NOTICE "Disabling hardware transactional memory (HTM)\n");
>> +			cur_cpu_spec->cpu_user_features2 &=
>> +				~(PPC_FEATURE2_HTM_NOSC | PPC_FEATURE2_HTM);
>> +			cur_cpu_spec->cpu_features &= ~CPU_FTR_TM;
>> +		}
>
> So that code translates to if TM is off or doesn't support suspend,
> disable TM. Are we sure that's really what we meant here ?

It should be:

+	if (!cpu_has_feature(CPU_FTR_TM))
+		return;
+
+	if (ppc_tm_state == TM_STATE_OFF || \
+	    (pvr_version_is(PVR_POWER9) && ppc_tm_state != TM_STATE_NO_SUSPEND)) {
+		printk(KERN_NOTICE "Disabling hardware transactional memory (HTM)\n");
+		cur_cpu_spec->cpu_user_features2 &= ~(PPC_FEATURE2_HTM_NOSC | PPC_FEATURE2_HTM);
+		cur_cpu_spec->cpu_features &= ~CPU_FTR_TM;
+	}

And as I mentioned above perhaps we should also do:
+		ppc_tm_state = TM_STATE_OFF;

cheers
