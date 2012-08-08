Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40C3E2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 16:13:41 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 8 Aug 2012 16:12:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q786DXRn21692512
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2012 16:13:34 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q786DWoZ028653
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2012 16:13:33 +1000
Message-ID: <50220382.4010405@linux.vnet.ibm.com>
Date: Wed, 08 Aug 2012 11:43:22 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/4] cpu: export cpu hotplug disable/enable functions
 as global functions
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
 <1344329006-10645-3-git-send-email-chenhui.zhao@freescale.com>
 <B4FC7F5E-EA8F-4FCA-B206-353FE4481DCE@kernel.crashing.org>
In-Reply-To: <B4FC7F5E-EA8F-4FCA-B206-353FE4481DCE@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: rjw@sisk.pl,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui <chenhui.zhao@freescale.com>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2012 11:21 PM, Kumar Gala wrote:
> 
> On Aug 7, 2012, at 3:43 AM, Zhao Chenhui wrote:
> 
>> The cpufreq driver of mpc85xx will disable/enable cpu hotplug temporarily.
>> Therefore, the related functions should be exported.
>>
>> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
>> ---
>> include/linux/cpu.h |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
> 
> Rafael, Srivatsa,
> 
> Wanted to get your ack on export these functions for direct calling by arch code.
>

Why not just use get_online_cpus()/put_online_cpus()?

In the case of suspend/resume/hibernation, we had introduced these CPU hotplug disable
functions because we would end up doing CPU hotplug ourselves, further down the path.
So if we did a get_online_cpus(), we would end up deadlocking ourselves. Whereas, the
patch 4/4 looks like a straightforward case of wanting to simply disable CPU hotplug..
I don't see where you are doing CPU hotplug yourself in the path. So IMO, just
get/put_online_cpus() should do.

Regards,
Srivatsa S. Bhat

> 
>>
>> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
>> index ce7a074..df8f73d 100644
>> --- a/include/linux/cpu.h
>> +++ b/include/linux/cpu.h
>> @@ -146,6 +146,8 @@ void notify_cpu_starting(unsigned int cpu);
>> extern void cpu_maps_update_begin(void);
>> extern void cpu_maps_update_done(void);
>>
>> +extern void cpu_hotplug_disable_before_freeze(void);
>> +extern void cpu_hotplug_enable_after_thaw(void);
>> #else	/* CONFIG_SMP */
>>
>> #define cpu_notifier(fn, pri)	do { (void)(fn); } while (0)
>> @@ -167,6 +169,8 @@ static inline void cpu_maps_update_done(void)
>> {
>> }
>>
>> +static inline void cpu_hotplug_disable_before_freeze(void)	{}
>> +static inline void cpu_hotplug_enable_after_thaw(void)	{}
>> #endif /* CONFIG_SMP */
>> extern struct bus_type cpu_subsys;
>>
>> -- 
>> 1.6.4.1
>>
> 
