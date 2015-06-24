Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 165CC1A0601
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 08:10:41 +1000 (AEST)
In-Reply-To: <1700583.a34yOllUuC@vostro.rjw.lan>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
 <1700583.a34yOllUuC@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jun 2015 08:10:34 +1000
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>
CC: benh@kernel.crashing.org, daniel.lezcano@linaro.org, mark.rutland@arm.com,
 lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, mpe@ellerman.id.au,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, shreyas@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Message-ID: <B790257D-E96F-43CA-8461-158B82270682@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24 June 2015 23:50:40 GMT+10:00, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>On Wednesday, June 24, 2015 01:48:01 AM Preeti U Murthy wrote:
>> On some archs, the local clockevent device stops in deep cpuidle
>states.
>> The broadcast framework is used to wakeup cpus in these idle states,
>in
>> which either an external clockevent device is used to send wakeup
>ipis
>> or the hrtimer broadcast framework kicks in in the absence of such a
>> device. One cpu is nominated as the broadcast cpu and this cpu sends
>> wakeup ipis to sleeping cpus at the appropriate time. This is the
>> implementation in the oneshot mode of broadcast.
>> 
>> In periodic mode of broadcast however, the presence of such cpuidle
>> states results in the cpuidle driver calling tick_broadcast_enable()
>> which shuts down the local clockevent devices of all the cpus and
>> appoints the tick broadcast device as the clockevent device for each
>of
>> them. This works on those archs where the tick broadcast device is a
>> real clockevent device.  But on archs which depend on the hrtimer
>mode
>> of broadcast, the tick broadcast device hapens to be a pseudo device.
>> The consequence is that the local clockevent devices of all cpus are
>> shutdown and the kernel hangs at boot time in periodic mode.
>> 
>> Let us thus not register the cpuidle states which have
>> CPUIDLE_FLAG_TIMER_STOP flag set, on archs which depend on the
>hrtimer
>> mode of broadcast in periodic mode. This patch takes care of doing
>this
>> on powerpc. The cpus would not have entered into such deep cpuidle
>> states in periodic mode on powerpc anyway. So there is no loss here.
>> 
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>
>4.2 material I suppose?

Yes please, in fact it should be marked for stable too.

cheers
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
