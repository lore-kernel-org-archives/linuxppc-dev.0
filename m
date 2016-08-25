Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKmGx1BsczDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 00:08:09 +1000 (AEST)
Received: by mail-wm0-x229.google.com with SMTP id i5so73961087wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 07:08:09 -0700 (PDT)
Subject: Re: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at start
To: Balbir Singh <bsingharora@gmail.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
 <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
 <57BDB2D8.4080507@linaro.org>
 <fe9a9667-cbbb-8fa2-5db0-2edd3220ca7b@gmail.com>
 <57BDB7F7.3090502@linaro.org>
 <adaebfb8-239c-8a0b-21b4-47150e6f2035@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <57BEFBBE.8050601@linaro.org>
Date: Thu, 25 Aug 2016 16:07:58 +0200
MIME-Version: 1.0
In-Reply-To: <adaebfb8-239c-8a0b-21b4-47150e6f2035@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/25/2016 03:46 PM, Balbir Singh wrote:
> 
> 
> On 25/08/16 01:06, Daniel Lezcano wrote:
>> On 08/24/2016 04:48 PM, Balbir Singh wrote:
>>>
>>>
>>> On 25/08/16 00:44, Daniel Lezcano wrote:
>>>> On 08/19/2016 12:26 AM, Gautham R. Shenoy wrote:
>>>>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>>>>
>>>>> Currently all the idle states registered by a cpu-idle driver are
>>>>> enabled by default. This patch adds a mechanism which allows the
>>>>> driver to hint if an idle-state should start in a disabled state. The
>>>>> cpu-idle core will use this hint to appropriately initialize the
>>>>> usage->disable knob of the CPU device idle state.
>>>>
>>>> Why do you need to do that ?
>>>>
>>>
>>> I think patch 2/2 explains the reason as it uses this infrastructure
>>
>> Ok, let me elaborate the question, I was not clear.
>>
>> Why the userspace can't setup the system environment at boot time by
>> disabling the state instead of adding extra code to disable it at boot
>> time in the kernel and then re-enable it from userspace ?
> 
> Gautham's patches don't want to have those states enabled by default.
> They are unlikely to be what production systems need, but likely
> what a knowledgeable person can look into selectively enable for
> experimentation.

Why not invert the logic ?

A knowledgeable person can look into selectively disable for production.

In addition, a kernel command line option to specify which state to
disable would be appropriate and beneficial for all existing drivers.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
