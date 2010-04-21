Return-Path: <brking@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0DA5B7CF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 13:15:47 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3L33TO1019577
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 23:03:29 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3L3FhBW1953998
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 23:15:44 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3L3FhG1006466
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 23:15:43 -0400
Message-ID: <4BCE6DDC.4020902@linux.vnet.ibm.com>
Date: Tue, 20 Apr 2010 22:15:40 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/1] powerpc: Ignore IPIs to offline CPUs
References: <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com>
	<12054.1271815478@neuling.org>
In-Reply-To: <12054.1271815478@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2010 09:04 PM, Michael Neuling wrote:
> In message <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com> you wrote:
>>
>> Since there is nothing to stop an IPI from occurring to an
>> offline CPU, rather than printing a warning to the logs,
>> just ignore the IPI. This was seen while stress testing
>> SMT enable/disable.
> 
> This seems like a recipe for disaster.  Do we at least need a
> WARN_ON_ONCE?

Actually we are only seeing it once per offlining of a CPU,
and only once in a while.
 
My guess is that once the CPU is marked offline fewer IPIs
get sent to it since its no longer in the online mask.

Perhaps we should be disabling IPIs to offline CPUs instead?

-Brian


> 
>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>> ---
>>
>>  arch/powerpc/platforms/pseries/xics.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff -puN arch/powerpc/platforms/pseries/xics.c~powerpc_xics_ipi_offline arch
> /powerpc/platforms/pseries/xics.c
>> --- linux-2.6/arch/powerpc/platforms/pseries/xics.c~powerpc_xics_ipi_offline
> 	2010-04-20 20:46:06.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/xics.c	2010-04-20 20:4
> 7:53.000000000 -0500
>> @@ -545,7 +545,8 @@ static irqreturn_t xics_ipi_dispatch(int
>>  {
>>  	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
>>  
>> -	WARN_ON(cpu_is_offline(cpu));
>> +	if (cpu_is_offline(cpu))
>> +		return IRQ_HANDLED;
>>  
>>  	mb();	/* order mmio clearing qirr */
>>  	while (*tgt) {
>> _
> 
> FYI random white space change here.
> 
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> 
> Mikey


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
