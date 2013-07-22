Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8415B2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 16:28:11 +1000 (EST)
Message-ID: <51ECD0BF.8080605@asianux.com>
Date: Mon, 22 Jul 2013 14:27:11 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: kernel: remove useless code which related with
 'max_cpus'
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com>
In-Reply-To: <51ECCEA8.5040406@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: chenhui.zhao@freescale.com, "paulus@samba.org" <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2013 02:18 PM, Srivatsa S. Bhat wrote:
> On 07/22/2013 11:28 AM, Chen Gang wrote:
>> > Since not need 'max_cpus' after the related commit, the related code
>> > are useless too, need be removed.
>> > 
>> > The related commit:
>> > 
>> >   c1aa687 powerpc: Clean up obsolete code relating to decrementer and timebase
>> > 
>> > The related warning:
>> > 
>> >   arch/powerpc/kernel/smp.c:323:43: warning: parameter �max_cpus� set but not used [-Wunused-but-set-parameter]
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  arch/powerpc/kernel/smp.c |    8 --------
>> >  1 files changed, 0 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> > index 38b0ba6..8c2bae4 100644
>> > --- a/arch/powerpc/kernel/smp.c
>> > +++ b/arch/powerpc/kernel/smp.c
>> > @@ -345,14 +345,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>> > 
>> >  	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
>> >  	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
>> > -
>> > -	if (smp_ops)
>> > -		if (smp_ops->probe)
>> > -			max_cpus = smp_ops->probe();
> No, you can't just remove the call to ->probe(). Its essential.
> For example, one such ->probe() routine, xics_smp_probe() does some
> pretty important stuff, such as populating the ->cause_ipi function
> pointer etc, see below:
> 
> 143 int __init xics_smp_probe(void)
> 144 {
> 145         /* Setup cause_ipi callback  based on which ICP is used */
> 146         smp_ops->cause_ipi = icp_ops->cause_ipi;
> 147 
> 148         /* Register all the IPIs */
> 149         xics_request_ipi();
> 150 
> 151         return cpumask_weight(cpu_possible_mask);
> 152 }
> 

OK, thanks.

>> > -		else
>> > -			max_cpus = NR_CPUS;
>> > -	else
>> > -		max_cpus = 1;
>> >  }
>> >
> Yes, max_cpus is unused, but you have to be careful while removing
> code.

I should send patch v2, soon.  :-)

> Regards,
> Srivatsa S. Bhat
> 
> 
> 

Thanks.
-- 
Chen Gang
