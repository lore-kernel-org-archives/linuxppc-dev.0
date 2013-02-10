Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C7292C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:22:16 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 06:20:34 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8FBD82CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:22:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AKMAnl57868466
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:22:11 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AKMAsq015662
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:22:12 +1100
Message-ID: <511800FA.1060007@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 01:50:10 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com>
 <5117F0C0.2030605@linux.vnet.ibm.com> <20130210201312.GB6236@redhat.com>
In-Reply-To: <20130210201312.GB6236@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 mingo@kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2013 01:43 AM, Oleg Nesterov wrote:
> On 02/11, Srivatsa S. Bhat wrote:
>>
>> On 02/09/2013 04:40 AM, Paul E. McKenney wrote:
>>>> +static void announce_writer_inactive(struct percpu_rwlock *pcpu_rwlock)
>>>> +{
>>>> +	unsigned int cpu;
>>>> +
>>>> +	drop_writer_signal(pcpu_rwlock, smp_processor_id());
>>>
>>> Why do we drop ourselves twice?  More to the point, why is it important to
>>> drop ourselves first?
>>>
>>
>> I don't see where we are dropping ourselves twice. Note that we are no longer
>> in the cpu_online_mask, so the 'for' loop below won't include us. So we need
>> to manually drop ourselves. It doesn't matter whether we drop ourselves first
>> or later.
> 
> Yes, but this just reflects its usage in cpu-hotplug. cpu goes away under
> _write_lock.
> 

Ah, right. I guess the code still has remnants from the older version in which
this locking scheme wasn't generic and was tied to cpu-hotplug alone..

> Perhaps _write_lock/unlock shoud use for_each_possible_cpu() instead?
> 

Hmm, that wouldn't be too bad.

> Hmm... I think this makes sense anyway. Otherwise, in theory,
> percpu_write_lock(random_non_hotplug_lock) can race with cpu_up?
> 

Yeah, makes sense. Will change it to for_each_possible_cpu().
And I had previously fixed such races with lglocks with a complicated scheme (to
avoid the costly for_each_possible loop), which was finally rewritten to use
for_each_possible_cpu() for the sake of simplicity..
Regards,
Srivatsa S. Bhat
