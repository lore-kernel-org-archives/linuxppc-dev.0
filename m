Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3CA8E2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 15:26:05 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 12 Jan 2014 21:26:03 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B580CC90058
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jan 2014 23:25:57 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0D4Pxo71638752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 04:26:00 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0D4PxSt029150
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jan 2014 23:25:59 -0500
Message-ID: <52D369FF.4010807@linux.vnet.ibm.com>
Date: Mon, 13 Jan 2014 09:52:23 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH] pseries/cpuidle: Remove redundant call to
 ppc64_runlatch_off() in cpu idle routines
References: <20140109050519.11532.6044.stgit@preeti.in.ibm.com>
 <52D3640F.2060805@linux.vnet.ibm.com>
In-Reply-To: <52D3640F.2060805@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Deepthi,

On 01/13/2014 09:27 AM, Deepthi Dharwar wrote:
> On 01/09/2014 10:35 AM, Preeti U Murthy wrote:
>> Commit fbd7740fdfdf9475f switched pseries cpu idle handling from complete idle
>> loops to ppc_md.powersave functions. Earlier to this switch,
>> ppc64_runlatch_off() had to be called in each of the idle routines. But after
>> the switch this call is handled in arch_cpu_idle(),just before the call
>> to ppc_md.powersave, where platform specific idle routines are called.
>>
>> As a consequence, the call to ppc64_runlatch_off() got duplicated in the
>> arch_cpu_idle() routine as well as in the some of the idle routines in
>> pseries and commit fbd7740fdfdf9475f missed to get rid of these redundant
>> calls. These calls were carried over subsequent enhancements to the pseries
>> cpuidle routines. This patch takes care of eliminating this redundancy.
>>
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> ---
> 
> Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> 
> Preeti, I will include this patch as part of the pseries cpuidle driver
> clean-ups series which I have undertaken.

Yes that would be great, thanks!

Regards
Preeti U Murthy
> 
> Regards,
> Deepthi
> 
>>  arch/powerpc/platforms/pseries/processor_idle.c |    3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
>> index a166e38..09e4f56 100644
>> --- a/arch/powerpc/platforms/pseries/processor_idle.c
>> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
>> @@ -17,7 +17,6 @@
>>  #include <asm/reg.h>
>>  #include <asm/machdep.h>
>>  #include <asm/firmware.h>
>> -#include <asm/runlatch.h>
>>  #include <asm/plpar_wrappers.h>
>>
>>  struct cpuidle_driver pseries_idle_driver = {
>> @@ -63,7 +62,6 @@ static int snooze_loop(struct cpuidle_device *dev,
>>  	set_thread_flag(TIF_POLLING_NRFLAG);
>>
>>  	while ((!need_resched()) && cpu_online(cpu)) {
>> -		ppc64_runlatch_off();
>>  		HMT_low();
>>  		HMT_very_low();
>>  	}
>> @@ -103,7 +101,6 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
>>  	idle_loop_prolog(&in_purr);
>>  	get_lppaca()->donate_dedicated_cpu = 1;
>>
>> -	ppc64_runlatch_off();
>>  	HMT_medium();
>>  	check_and_cede_processor();
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> 
