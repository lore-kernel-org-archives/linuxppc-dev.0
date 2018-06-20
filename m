Return-Path: <rdunlap@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419Qc22gKWzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 10:26:10 +1000 (AEST)
Subject: Re: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's
 interrupt to NMI
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Weisbecker <frederic@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Byungchul Park <byungchul.park@lge.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Waiman Long <longman@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 David Rientjes <rientjes@google.com>, iommu@lists.linux-foundation.org
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1806131128570.2280@nanos.tec.linutronix.de>
 <20180615020314.GA11625@voyager>
 <alpine.DEB.2.21.1806151029210.2079@nanos.tec.linutronix.de>
 <20180616005103.GC6659@voyager>
 <alpine.DEB.2.21.1806161517050.1582@nanos.tec.linutronix.de>
 <20180620001535.GA27531@voyager>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c040d4e7-f33b-9c93-6f5a-6bf960943e36@infradead.org>
Date: Tue, 19 Jun 2018 17:25:09 -0700
MIME-Version: 1.0
In-Reply-To: <20180620001535.GA27531@voyager>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2018 05:15 PM, Ricardo Neri wrote:
> On Sat, Jun 16, 2018 at 03:24:49PM +0200, Thomas Gleixner wrote:
>> On Fri, 15 Jun 2018, Ricardo Neri wrote:
>>> On Fri, Jun 15, 2018 at 11:19:09AM +0200, Thomas Gleixner wrote:
>>>> On Thu, 14 Jun 2018, Ricardo Neri wrote:
>>>>> Alternatively, there could be a counter that skips reading the HPET status
>>>>> register (and the detection of hardlockups) for every X NMIs. This would
>>>>> reduce the overall frequency of HPET register reads.
>>>>
>>>> Great plan. So if the watchdog is the only NMI (because perf is off) then
>>>> you delay the watchdog detection by that count.
>>>
>>> OK. This was a bad idea. Then, is it acceptable to have an read to an HPET
>>> register per NMI just to check in the status register if the HPET timer
>>> caused the NMI?
>>
>> The status register is useless in case of MSI. MSI is edge triggered ....
>>
>> The only register which gives you proper information is the counter
>> register itself. That adds an massive overhead to each NMI, because the
>> counter register access is synchronized to the HPET clock with hardware
>> magic. Plus on larger systems, the HPET access is cross node and even
>> slower.
> 
> It starts to sound that the HPET is too slow to drive the hardlockup detector.
> 
> Would it be possible to envision a variant of this implementation? In this
> variant, the HPET only targets a single CPU. The actual hardlockup detector
> is implemented by this single CPU sending interprocessor interrupts to the
> rest of the CPUs.
> 
> In this manner only one CPU has to deal with the slowness of the HPET; the
> rest of the CPUs don't have to read or write any HPET registers. A sysfs
> entry could be added to configure which CPU will have to deal with the HPET
> timer. However, profiling could not be done accurately on such CPU.

Please forgive my simple question:

What happens when this one CPU is the one that locks up?

thnx,
-- 
~Randy
