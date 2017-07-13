Return-Path: <hejianet@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7RRW2GPjzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 16:55:51 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id c24so6104680pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 23:55:51 -0700 (PDT)
Subject: Re: [PATCH] powerpc/time: use get_tb instead of get_vtb in
 running_clock
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 fweisbec@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
 John Stultz <john.stultz@linaro.org>, Stanislaw Gruszka
 <sgruszka@redhat.com>, Ivan Mikhaylov <ivan@de.ibm.com>, cyrilbur@gmail.com
References: <1499871670-24671-1-git-send-email-hejianet@gmail.com>
 <1499899504.2865.44.camel@kernel.crashing.org>
From: hejianet <hejianet@gmail.com>
Message-ID: <946976cd-ca8b-7d26-d316-aeaab44beb04@gmail.com>
Date: Thu, 13 Jul 2017 14:55:34 +0800
MIME-Version: 1.0
In-Reply-To: <1499899504.2865.44.camel@kernel.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben
I add some printk logs in watchdog_timer_fn in the guest
[   16.025222] get_vtb=8236291881, get_tb=13756711357, get_timestamp=4
[   20.025624] get_vtb=9745285807, get_tb=15804711283, get_timestamp=7
[   24.025042] get_vtb=11518119641, get_tb=17852711085, get_timestamp=10
[   28.024074] get_vtb=13192704319, get_tb=19900711071, get_timestamp=13
[   32.024086] get_vtb=14856516982, get_tb=21948711066, get_timestamp=16
[   36.024075] get_vtb=16569127618, get_tb=23996711078, get_timestamp=20
[   40.024138] get_vtb=17008865823, get_tb=26044718418, get_timestamp=20
[   44.023993] get_vtb=17020637241, get_tb=28092716383, get_timestamp=20
[   48.023996] get_vtb=17022857170, get_tb=30140718472, get_timestamp=20
[   52.023996] get_vtb=17024268541, get_tb=32188718432, get_timestamp=20
[   56.023996] get_vtb=17036577783, get_tb=34236718077, get_timestamp=20
[   60.023996] get_vtb=17037829743, get_tb=36284718437, get_timestamp=20
[   64.023992] get_vtb=17039846747, get_tb=38332716609, get_timestamp=20
[   68.023991] get_vtb=17041448345, get_tb=40380715903, get_timestamp=20

The get_timestamp(use get_vtb(),unit is second) is slower down compared
with printk time. You also can obviously watch the get_vtb increment is
slowly less than get_tb increment.

Without this patch, I thought there might be some softlockup warnings
missed in guest.

-Jia

On 13/07/2017 6:45 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2017-07-12 at 23:01 +0800, Jia He wrote:
>> Virtual time base(vtb) is a register which increases only in guest.
>> Any exit from guest to host will stop the vtb(saved and restored by kvm).
>> But if there is an IO causes guest exits to host, the guest's watchdog
>> (watchdog_timer_fn -> is_softlockup -> get_timestamp -> running_clock)
>> needs to also include the time elapsed in host. get_vtb is not correct in
>> this case.
>>
>> Also, the TB_OFFSET is well saved and restored by qemu after commit [1].
>> So we can use get_tb here.
> 
> That completely defeats the purpose here... This was done specifically
> to exploit the VTB which doesn't count in hypervisor mode.
> 
>>
>> [1] http://git.qemu.org/?p=qemu.git;a=commit;h=42043e4f1
>>
>> Signed-off-by: Jia He <hejianet@gmail.com>
>> ---
>>   arch/powerpc/kernel/time.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index fe6f3a2..c542dd3 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -695,16 +695,15 @@ notrace unsigned long long sched_clock(void)
>>   unsigned long long running_clock(void)
>>   {
>>   	/*
>> -	 * Don't read the VTB as a host since KVM does not switch in host
>> -	 * timebase into the VTB when it takes a guest off the CPU, reading the
>> -	 * VTB would result in reading 'last switched out' guest VTB.
>> +	 * Use get_tb instead of get_vtb for guest since the TB_OFFSET has been
>> +	 * well saved/restored when qemu does suspend/resume.
>>   	 *
>>   	 * Host kernels are often compiled with CONFIG_PPC_PSERIES checked, it
>>   	 * would be unsafe to rely only on the #ifdef above.
>>   	 */
>>   	if (firmware_has_feature(FW_FEATURE_LPAR) &&
>>   	    cpu_has_feature(CPU_FTR_ARCH_207S))
>> -		return mulhdu(get_vtb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
>> +		return mulhdu(get_tb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
>>   
>>   	/*
>>   	 * This is a next best approximation without a VTB.
> 
