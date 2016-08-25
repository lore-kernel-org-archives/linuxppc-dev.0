Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKlp81XrTzDrfj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 23:46:40 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y134so3280581pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 06:46:40 -0700 (PDT)
Subject: Re: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at start
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <adaebfb8-239c-8a0b-21b4-47150e6f2035@gmail.com>
Date: Thu, 25 Aug 2016 23:46:34 +1000
MIME-Version: 1.0
In-Reply-To: <57BDB7F7.3090502@linaro.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/08/16 01:06, Daniel Lezcano wrote:
> On 08/24/2016 04:48 PM, Balbir Singh wrote:
>>
>>
>> On 25/08/16 00:44, Daniel Lezcano wrote:
>>> On 08/19/2016 12:26 AM, Gautham R. Shenoy wrote:
>>>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>>>
>>>> Currently all the idle states registered by a cpu-idle driver are
>>>> enabled by default. This patch adds a mechanism which allows the
>>>> driver to hint if an idle-state should start in a disabled state. The
>>>> cpu-idle core will use this hint to appropriately initialize the
>>>> usage->disable knob of the CPU device idle state.
>>>
>>> Why do you need to do that ?
>>>
>>
>> I think patch 2/2 explains the reason as it uses this infrastructure
> 
> Ok, let me elaborate the question, I was not clear.
> 
> Why the userspace can't setup the system environment at boot time by
> disabling the state instead of adding extra code to disable it at boot
> time in the kernel and then re-enable it from userspace ?

Gautham's patches don't want to have those states enabled by default.
They are unlikely to be what production systems need, but likely
what a knowledgeable person can look into selectively enable for
experimentation.

@Gautham?


Balbir Singh.
