Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lgl74ZH3zDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 16:02:11 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w785sKF0045760
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2018 02:02:08 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kqnw892v8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 02:02:08 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 8 Aug 2018 00:02:07 -0600
Date: Wed, 8 Aug 2018 11:32:00 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
 huntbag@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 0/3] New device-tree format  and Opal based idle
 save-restore
Reply-To: ego@linux.vnet.ibm.com
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
 <87zhxybceu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zhxybceu.fsf@concordia.ellerman.id.au>
Message-Id: <20180808060200.GA17634@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On Tue, Aug 07, 2018 at 10:15:37PM +1000, Michael Ellerman wrote:
> > Skiboot patch-set for device-tree is posted here :
> > https://patchwork.ozlabs.org/project/skiboot/list/?series=58934
> 
> I don't see a device tree binding documented anywhere?
> 
> There is an existing binding defined for ARM chips, presumably it
> doesn't do everything we need. But are there good reasons why we are not
> using it as a base?
> 
> See: Documentation/devicetree/bindings/arm/idle-states.txt
>

In case of ARM, the idle-states node is a child of cpus node. Each
child of the idle-states node is a node describing that particular
idle state.

	idle-states {
		entry-method = "psci";

		CPU_RETENTION_0_0: cpu-retention-0-0 {
			compatible = "arm,idle-state";
			arm,psci-suspend-param = <0x0010000>;
			entry-latency-us = <20>;
			exit-latency-us = <40>;
			min-residency-us = <80>;
			status = "disabled"
		};


		CPU_SLEEP_0_0: cpu-sleep-0-0 {
			compatible = "arm,idle-state";
			local-timer-stop;
			arm,psci-suspend-param = <0x0010000>;
			entry-latency-us = <250>;
			exit-latency-us = <500>;
			min-residency-us = <950>;
			status = "okay"
		};

		.
		.
		.
	}


Furthermore, each CPU can have a different set of cpu-idle states
due to the asymmetric nature of the processors units on the board.
Thus, there is an additional property for each cpu called
cpu-idle-states which points to the containers of the idle states
themselves.


cpus {
	#size-cells = <0>;
	#address-cells = <2>;

	CPU0: cpu@0 {
		device_type = "cpu";
		compatible = "arm,cortex-a57";
		reg = <0x0 0x0>;
		enable-method = "psci";
		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
	};

	. . .
	. . .
	. . .
	. . .

	CPU8: cpu@100000000 {
		device_type = "cpu";
		compatible = "arm,cortex-a53";
		reg = <0x1 0x0>;
		enable-method = "psci";
		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
	};


In our case, we already have an "ibm,opal/power-mgt/" node in the
device tree where we have defined the idle state so far. This was the
reason to stick the new device tree format under this existing node
that has been specially earmarked for power management related bits,
instead of defining the new format under the cpus node.

Also, in our case, since all the CPU nodes are symmetric they will
have the same set of idle states. Hence, we wouldn't need the
"cpu-idle-states" property for each CPU.

As for the properties of idle states themselves, the only common
things between the ARM idle-states and our case are the compatible,
exit-latency-us, min-residency-us. In addition to this we need the
flags which indicate the nature of the resource loss (Hypervisors
state loss, Timebase loss, etc..) , the psscr_val and the psscr_mask
corresponding to the stop states which the ARM device-tree doesn't
provide.

For this reason we have opted for a new bindings since the overlap
between these two platforms is minimal.

> 
> The way you're using compatible is not really consistent with its
> traditional meaning.
> 
> eg, you have multiple states with:
> 
>                 compatible = "ibm,state-v1",
>                             "cpuoffline",
>                             "opal-supported";
> 
> 
> This would typically mean that all those state are all "compatible" with
> some semantics defined by the name "ibm,state-v1". What you're trying to
> say (I think) is that each state is "version 1" of *that state*. And
> only kernels that understand version 1 should use the state.

Ok, I see what you mean here. Perhaps, we should have had something
like "ibm,stop0-v1" , "ibm,stop1-v2", "ibm,stop2-v2" etc, where
version1, version2 etc, pertains to the versions of those specific
states.

Thus a kernel that knows about "version 1" of stop0 and stop2 and
"version 2" of stop1 will end up using only stop0 and stop1 since it
doesn't know "version 2" of stop2. 

In such a case, kernel should fallback to OPAL for stop2. Does this
make sense ?

> 
> And "cpuoffline" and "opal-supported" definitely don't belong in
> compatible AFAICS, they should simply be boolean properties of the
> node.

I agree. These should be flags.

> 
> cheers
> 
