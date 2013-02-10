Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 022672C029F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:01:20 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 05:55:57 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 42C572CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:01:17 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJmxp264422032
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:48:59 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AK1FDs028813
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:01:16 +1100
Message-ID: <5117FC13.1030002@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 01:29:15 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v5 09/45] smp, cpu hotplug: Fix smp_call_function_*()
 to prevent CPU offline properly
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073508.13822.12784.stgit@srivatsabhat.in.ibm.com>
 <20130209000717.GP2666@linux.vnet.ibm.com>
 <5117F7E9.7070906@linux.vnet.ibm.com>
 <20130210195639.GL2666@linux.vnet.ibm.com>
In-Reply-To: <20130210195639.GL2666@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2013 01:26 AM, Paul E. McKenney wrote:
> On Mon, Feb 11, 2013 at 01:11:29AM +0530, Srivatsa S. Bhat wrote:
>> On 02/09/2013 05:37 AM, Paul E. McKenney wrote:
>>> On Tue, Jan 22, 2013 at 01:05:10PM +0530, Srivatsa S. Bhat wrote:
>>>> Once stop_machine() is gone from the CPU offline path, we won't be able to
>>>> depend on preempt_disable() to prevent CPUs from going offline from under us.
>>>>
>>>> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
>>>> while invoking from atomic context.
>>>>
>>>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>>>
>>> Would it make sense for get_online_cpus_atomic() to return the current
>>> CPU number?
>>
>> Hmm, I'm not so sure. I tried to model it after get_online_cpus(), which doesn't
>> return anything (for other reasons, of course..)
>>
>> Moreover, a function name like *_cpu_* returning the CPU number would be intuitive.
>> But a name such as *_cpus_* (plural) returning a CPU number might appear confusing..
>>
>> And also I don't think it'll make a huge improvement in the callers.. (We might
>> be better off avoiding an smp_processor_id() if possible, since this function could
>> be called in very hot paths).. So I don't see a strong case for returning the
>> CPU number. But let me know if you think it'll still be worth it for some reason...
> 
> I just noted a lot of two-line code sequences in your patch that would be
> one line if the CPU number was returned.

Ah, in that case, I'll reconsider your suggestion while working on the next version.
Thanks!

Regards,
Srivatsa S. Bhat

>  But I don't feel strongly about
> it, so if people are OK with the current version, no problem.
> 
> 							Thanx, Paul
> 
