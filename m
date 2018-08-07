Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lD4d1y6lzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 22:15:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
 huntbag@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/3] New device-tree format and Opal based idle
 save-restore
In-Reply-To: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
Date: Tue, 07 Aug 2018 22:15:37 +1000
Message-ID: <87zhxybceu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:

> Previously if a older kernel runs on a newer firmware, it may enable
> all available states irrespective of its capability of handling it.
> New device tree format adds a compatible flag, so that only kernel
> which has the capability to handle the version of stop state will enable
> it.
>
> Older kernel will still see stop0 and stop0_lite in older format and we
> will depricate it after some time.
>
> 1) Idea is to bump up the version string in firmware if we find a bug or
> regression in stop states. A fix will be provided in linux which would
> now know about the bumped up version of stop states, where as kernel
> without fixes would ignore the states.
>
> 2) Slowly deprecate cpuidle/cpuhotplug threshold which is hard-coded
> into cpuidle-powernv driver. Instead use compatible strings to indicate
> if idle state is suitable for cpuidle and hotplug.
>
> New idle state device tree format :
>        power-mgt {
>             ...
>          ibm,enabled-stop-levels = <0xec000000>;
>          ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
>          ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
>          ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
>          ibm,cpu-idle-state-flags = <0x100000 0x101000>;
>          ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
>          ibm,idle-states {
>                      stop4 {
>                          flags = <0x207000>;
>                          compatible = "ibm,state-v1",
> 				      "cpuidle",
> 				      "opal-supported";
>                          psscr-mask = <0x0 0x3003ff>;
>                          handle = <0x102>;
>                          latency-ns = <0x186a0>;
>                          residency-ns = <0x989680>;
>                          psscr = <0x0 0x300374>;
>                   };
>                     ...
>                     stop11 {
>                      ...
>                          compatible = "ibm,state-v1",
> 				      "cpuoffline",
> 				      "opal-supported";
>                          ...
>                   };
>              };
>
> Skiboot patch-set for device-tree is posted here :
> https://patchwork.ozlabs.org/project/skiboot/list/?series=58934

I don't see a device tree binding documented anywhere?

There is an existing binding defined for ARM chips, presumably it
doesn't do everything we need. But are there good reasons why we are not
using it as a base?

See: Documentation/devicetree/bindings/arm/idle-states.txt


The way you're using compatible is not really consistent with its
traditional meaning.

eg, you have multiple states with:

                compatible = "ibm,state-v1",
                            "cpuoffline",
                            "opal-supported";


This would typically mean that all those state are all "compatible" with
some semantics defined by the name "ibm,state-v1". What you're trying to
say (I think) is that each state is "version 1" of *that state*. And
only kernels that understand version 1 should use the state.

And "cpuoffline" and "opal-supported" definitely don't belong in
compatible AFAICS, they should simply be boolean properties of the node.

cheers
