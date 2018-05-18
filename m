Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nTCK4lMQzF2B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 23:14:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc: Detect the presence of big-core with
 interleaved threads
In-Reply-To: <20180516043516.GA14826@in.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
 <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com>
 <1526268071.30369.20.camel@neuling.org> <20180516043516.GA14826@in.ibm.com>
Date: Fri, 18 May 2018 23:14:04 +1000
Message-ID: <87k1s1xg0z.fsf@concordia.ellerman.id.au>
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

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
...
>> > @@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
>> >  	vdso_data->processorCount = num_present_cpus();
>> >  #endif /* CONFIG_PPC64 */
>> >  
>> > -        /* Initialize CPU <=> thread mapping/
>> > +	dn = of_find_node_by_type(NULL, "cpu");
>> > +	if (dn) {
>> > +		if (check_for_interleaved_big_core(dn)) {
>> > +			has_interleaved_big_core = true;
>> > +			pr_info("Detected interleaved big-cores\n");
>> 
>> Is there a runtime way to check this also?  If the dmesg buffer overflows, we
>> lose this.
>
> Where do you suggest we put this ? Should it be a part of
> /proc/cpuinfo ?

Hmm, it'd be nice not to pollute it with more junk.

Can you just look at the pir files in sysfs?

eg. on a normal system:

  # cd /sys/devices/system/cpu
  # grep . cpu[0-7]/pir
  cpu0/pir:20
  cpu1/pir:21
  cpu2/pir:22
  cpu3/pir:23
  cpu4/pir:24
  cpu5/pir:25
  cpu6/pir:26
  cpu7/pir:27


cheers
