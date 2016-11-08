Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCm6l2VF9zDvHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 21:40:30 +1100 (AEDT)
Received: by mail-yw0-x244.google.com with SMTP id s68so6504699ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 02:40:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161108085757.GA22024@vireshk-i7>
References: <1478594159-27719-1-git-send-email-kda@linux-powerpc.org>
 <20161108085757.GA22024@vireshk-i7>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Tue, 8 Nov 2016 13:40:27 +0300
Message-ID: <CAOJe8K0NKN5Y-E=EKrbb8RnYxS+8Kn=MkCK=Wkva6CWSWJCw_Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq, powernv: Disable preemption while checking CPU
 throttling state throttling state
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, shilpa.bhat@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/8/16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> +some more folks from IBM.
>
> On 08-11-16, 03:35, Denis Kirjanov wrote:
>>     [   67.700897] BUG: using smp_processor_id() in preemptible [00000000]
>> code: cat/7343
>>     [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
>>     [   67.700998] CPU: 13 PID: 7343 Comm: cat Not tainted 4.8.0-rc5-dirty
>> #1
>>     [   67.701038] Call Trace:
>>     [   67.701066] [c0000007d25b75b0] [c000000000971378]
>> .dump_stack+0xe4/0x150 (unreliable)
>>     [   67.701153] [c0000007d25b7640] [c0000000005162e4]
>> .check_preemption_disabled+0x134/0x150
>>     [   67.701238] [c0000007d25b76e0] [c0000000007b63ac]
>> .powernv_cpufreq_throttle_check+0x2c/0x710
>>     [   67.701322] [c0000007d25b7790] [c0000000007b6d18]
>> .powernv_cpufreq_target_index+0x288/0x360
>>     [   67.701407] [c0000007d25b7870] [c0000000007acee4]
>> .__cpufreq_driver_target+0x394/0x8c0
>>     [   67.701491] [c0000007d25b7920] [c0000000007b22ac]
>> .cpufreq_set+0x7c/0xd0
>>     [   67.701565] [c0000007d25b79b0] [c0000000007adf50]
>> .store_scaling_setspeed+0x80/0xc0
>>     [   67.701650] [c0000007d25b7a40] [c0000000007ae270]
>> .store+0xa0/0x100
>>     [   67.701723] [c0000007d25b7ae0] [c0000000003566e8]
>> .sysfs_kf_write+0x88/0xb0
>>     [   67.701796] [c0000007d25b7b70] [c0000000003553b8]
>> .kernfs_fop_write+0x178/0x260
>>     [   67.701881] [c0000007d25b7c10] [c0000000002ac3cc]
>> .__vfs_write+0x3c/0x1c0
>>     [   67.701954] [c0000007d25b7cf0] [c0000000002ad584]
>> .vfs_write+0xc4/0x230
>>     [   67.702027] [c0000007d25b7d90] [c0000000002aeef8]
>> .SyS_write+0x58/0x100
>>     [   67.702101] [c0000007d25b7e30] [c00000000000bfec]
>> system_call+0x38/0xfc
>>
>
> We expect some description of the problem here, not just the OPPs
> dump.
>

Original link is here: https://patchwork.ozlabs.org/patch/691239/
