Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E92EC2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 23:14:25 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 26 Jul 2013 18:36:12 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3574E1258062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 18:43:38 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6QDE4vi46727242
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 18:44:04 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6QDE1og000731
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 23:14:06 +1000
Message-ID: <51F2758A.1060108@linux.vnet.ibm.com>
Date: Fri, 26 Jul 2013 18:41:38 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [RFC PATCH 0/5] cpuidle/ppc: Timer offload framework to support
 deep idle states
References: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
 <94F013E7935FF44C83EBE7784D62AD3F097AD1D5@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F097AD1D5@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "fweisbec@gmail.com" <fweisbec@gmail.com>,
 "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "shangw@linux.vnet.ibm.com" <shangw@linux.vnet.ibm.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>, "rjw@sisk.pl" <rjw@sisk.pl>,
 "john.stultz@linaro.org" <john.stultz@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "deepthi@linux.vnet.ibm.com" <deepthi@linux.vnet.ibm.com>,
 "geoff@infradead.org" <geoff@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "srivatsa.bhat@linux.vnet.ibm.com" <srivatsa.bhat@linux.vnet.ibm.com>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Li,

On 07/26/2013 03:35 PM, Li Yang-R58472 wrote:
> 
> 
>> -----Original Message-----
>> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>> owner@vger.kernel.org] On Behalf Of Preeti U Murthy
>> Sent: Thursday, July 25, 2013 5:03 PM
>> To: benh@kernel.crashing.org; paul.gortmaker@windriver.com;
>> paulus@samba.org; shangw@linux.vnet.ibm.com; galak@kernel.crashing.org;
>> fweisbec@gmail.com; paulmck@linux.vnet.ibm.com; michael@ellerman.id.au;
>> arnd@arndb.de; linux-pm@vger.kernel.org; rostedt@goodmis.org; rjw@sisk.pl;
>> john.stultz@linaro.org; tglx@linutronix.de; Zhao Chenhui-B35336;
>> deepthi@linux.vnet.ibm.com; geoff@infradead.org; linux-
>> kernel@vger.kernel.org; srivatsa.bhat@linux.vnet.ibm.com;
>> schwidefsky@de.ibm.com; svaidy@linux.vnet.ibm.com; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: [RFC PATCH 0/5] cpuidle/ppc: Timer offload framework to support
>> deep idle states
>>
>> On PowerPC, when CPUs enter deep idle states, their local timers are
>> switched off. The responsibility of waking them up at their next timer
>> event, needs to be handed over to an external device. On PowerPC, we do
>> not have an external device equivalent to HPET, which is currently done
>> on architectures like x86. Instead we assign the local timer of one of
>> the CPUs to do this job.
> 
> I don't know much about the deep idle states.  But is it necessary to turn off the timer in these states?  I mean the extra work needed on the booting CPU and re-syncing Time Base after wakeup might defeat the power consumption benefit of turning off the timer.

The idle state that CPUs should enter into is chosen by the cpuidle
governor. And the target residency and the wakeup latency of the idle
states among others, are the factors considered by the governor before
choosing an idle state for a CPU. So deep idle states which have a
higher target residency and wakeup latency, but that have huge power
savings, are usually targeted by the governors when there are large
periods of idle, i.e. CPUs tend to remain idle for long.

Depending on the workload running, large periods of idle could be rare,
in which case deep idle states are not even entered into. But if the
workload is such that it is woken up occasionally to do work, with large
periods of idle in between, deep idle states are targeted. In such a
scenario, the power savings that such idle states yield is significant
to offset the overhead of the factors that you mention, which will need
to be done occasionally.

Hence for an almost completely idle system, having such deep idle states
fetches enormous power savings.

> 
> Btw, the Open PIC has an internal timer.  Can we use it as the wakeup event?

I am not aware of such a device on PowerPC. Even if there is one, it is
important to investigate what happens to it in deep idle states. If it
is intended to be switched off in one of the deep idle states, again the
idea that this patchset brings in has to be the fall-back solution.

My point is, it is good to have the timer offload framework
implementation because we cannot continue to rely on external devices
being there to aid us in situations when the local timer devices of CPUs
have to be turned off in deep idle states.

> 
> Regards,
> Leo

Regards
Preeti U Murthy
