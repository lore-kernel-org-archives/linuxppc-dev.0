Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A31EAB6F7F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 06:34:07 +1100 (EST)
Subject: Re: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4EB421FD.6010805@freescale.com>
Date: Fri, 4 Nov 2011 14:33:58 -0500
Message-Id: <51CCC521-0A2C-4940-98F0-BA0075D6F122@kernel.crashing.org>
References: <1320409787-14360-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB421FD.6010805@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 4, 2011, at 12:33 PM, Scott Wood wrote:

> On 11/04/2011 07:29 AM, Zhao Chenhui wrote:
>> From: Li Yang <leoli@freescale.com>
>> 
>> The timebase sync is not only necessary when using KEXEC. It should also
>> be used by normal boot up and cpu hotplug. Remove the ifdef added by
>> the KEXEC patch.
> 
> The KEXEC patch didn't just add the ifdef, it also added the initializers:
> 
>> @@ -105,8 +107,64 @@ smp_85xx_setup_cpu(int cpu_nr)
>> 
>> struct smp_ops_t smp_85xx_ops = {
>>        .kick_cpu = smp_85xx_kick_cpu,
>> +#ifdef CONFIG_KEXEC
>> +       .give_timebase  = smp_generic_give_timebase,
>> +       .take_timebase  = smp_generic_take_timebase,
>> +#endif
>> };
> 
> U-Boot synchronizes the timebase on 85xx.  With what chip and U-Boot
> version are you seeing this not happen?
> 
> If you are seeing only a small (around one tick) difference, make sure
> you're running a U-Boot that has this commit:
> 
>> commit 7afc45ad7d9493208d89072cbb78a5bfc8034b59
>> Author: Kumar Gala <galak@kernel.crashing.org>
>> Date:   Sun Mar 13 10:55:53 2011 -0500
>> 
>>    powerpc/85xx: Fix synchronization of timebase on MP boot
>> 
>>    There is a small ordering issue in the master core in that we need to
>>    make sure the disabling of the timebase in the SoC is visible before we
>>    set the value to 0.  We can simply just read back the value to
>>    synchronizatize the write, before we set TB to 0.
>> 
>>    Reported-by: Dan Hettena
>>    Tested-by: Dan Hettena
>>    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Scott,

Aren't we going to need this when a core is woken back up w/o any state?

- k
