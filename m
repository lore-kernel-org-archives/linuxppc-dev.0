Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0114.outbound.protection.outlook.com [207.46.100.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 996A11A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:02:12 +1000 (AEST)
Date: Fri, 28 Aug 2015 08:47:27 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v2,4/5] PowerPC/mpc85xx: Add hotplug support on E5500
 and E500MC cores
To: Scott Wood <scottwood@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Message-ID: <1440722847.31670.1@remotesmtp.freescale.net>
In-Reply-To: <20150826205554.GB10582@home.buserror.net>
References: <1440590988-25594-1-git-send-email-chenhui.zhao@freescale.com>
 <1440590988-25594-4-git-send-email-chenhui.zhao@freescale.com>
 <20150826205554.GB10582@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thu, Aug 27, 2015 at 4:55 AM, Scott Wood <scottwood@freescale.com> 
wrote:
> On Wed, Aug 26, 2015 at 08:09:47PM +0800, Chenhui Zhao wrote:
>>  +int check_cpu_dead(unsigned int cpu)
>>  +{
>>  +	return per_cpu(cpu_state, cpu) == CPU_DEAD;
>>  +}
> 
> I'm not sure this needs to be a function versus open-coded, but if 
> you do
> want to make it a function, make it more obvious from the caller side 
> by
> changing it to:
> 
> bool is_cpu_dead(unsigned int cpu);
> 
> Otherwise if I see "if (check_cpu_dead(cpu))" I don't know if the
> if-block is executed if the CPU is dead or if it isn't.

OK.

> 
> 
>>  diff --git a/arch/powerpc/platforms/85xx/smp.h 
>> b/arch/powerpc/platforms/85xx/smp.h
>>  index 0b20ae3..8ee19a3 100644
>>  --- a/arch/powerpc/platforms/85xx/smp.h
>>  +++ b/arch/powerpc/platforms/85xx/smp.h
>>  @@ -6,6 +6,7 @@
>>   #ifdef CONFIG_SMP
>>   void __init mpc85xx_smp_init(void);
>>   int __init mpc85xx_setup_pmc(void);
>>  +int __init fsl_rcpm_init(void);
>>   #else
> 
> Why wasn't this added in the patch that added fsl_rcpm_init()?
> 
> -Scott

Will move it to there.

Thanks,
-Chenhui
