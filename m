Return-Path: <rjwysocki@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FCB31A0601
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 08:28:27 +1000 (AEST)
Received: by wibdq8 with SMTP id dq8so59439052wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 15:28:23 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <B790257D-E96F-43CA-8461-158B82270682@ellerman.id.au>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
 <1700583.a34yOllUuC@vostro.rjw.lan>
 <B790257D-E96F-43CA-8461-158B82270682@ellerman.id.au>
Date: Thu, 25 Jun 2015 00:28:23 +0200
Message-ID: <CAJZ5v0iR_gOXahW5WtgecaTnb6g6RRMaa=4kOiHR2tBghfo++A@mail.gmail.com>
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, mpe@ellerman.id.au,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 shreyas@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 25, 2015 at 12:10 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
>
>
> On 24 June 2015 23:50:40 GMT+10:00, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>>On Wednesday, June 24, 2015 01:48:01 AM Preeti U Murthy wrote:
>>> On some archs, the local clockevent device stops in deep cpuidle
>>states.
>>> The broadcast framework is used to wakeup cpus in these idle states,
>>in
>>> which either an external clockevent device is used to send wakeup
>>ipis
>>> or the hrtimer broadcast framework kicks in in the absence of such a
>>> device. One cpu is nominated as the broadcast cpu and this cpu sends
>>> wakeup ipis to sleeping cpus at the appropriate time. This is the
>>> implementation in the oneshot mode of broadcast.
>>>
>>> In periodic mode of broadcast however, the presence of such cpuidle
>>> states results in the cpuidle driver calling tick_broadcast_enable()
>>> which shuts down the local clockevent devices of all the cpus and
>>> appoints the tick broadcast device as the clockevent device for each
>>of
>>> them. This works on those archs where the tick broadcast device is a
>>> real clockevent device.  But on archs which depend on the hrtimer
>>mode
>>> of broadcast, the tick broadcast device hapens to be a pseudo device.
>>> The consequence is that the local clockevent devices of all cpus are
>>> shutdown and the kernel hangs at boot time in periodic mode.
>>>
>>> Let us thus not register the cpuidle states which have
>>> CPUIDLE_FLAG_TIMER_STOP flag set, on archs which depend on the
>>hrtimer
>>> mode of broadcast in periodic mode. This patch takes care of doing
>>this
>>> on powerpc. The cpus would not have entered into such deep cpuidle
>>> states in periodic mode on powerpc anyway. So there is no loss here.
>>>
>>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>
>>4.2 material I suppose?
>
> Yes please, in fact it should be marked for stable too.

That can be done.  Which -stable series should it go into?

Rafael
