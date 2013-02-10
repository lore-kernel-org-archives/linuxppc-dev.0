Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B4F3D2C0296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:29:27 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 00:57:16 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3F0E0E0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 01:00:09 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJTIjU32309316
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 00:59:18 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AJTJNx010268
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 19:29:21 GMT
Message-ID: <5117F49D.2030509@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 00:57:25 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v5 05/45] percpu_rwlock: Make percpu-rwlocks IRQ-safe,
 optimally
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073400.13822.52336.stgit@srivatsabhat.in.ibm.com>
 <20130208234403.GL2666@linux.vnet.ibm.com>
In-Reply-To: <20130208234403.GL2666@linux.vnet.ibm.com>
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

On 02/09/2013 05:14 AM, Paul E. McKenney wrote:
> On Tue, Jan 22, 2013 at 01:04:11PM +0530, Srivatsa S. Bhat wrote:
>> If interrupt handlers can also be readers, then one of the ways to make
>> per-CPU rwlocks safe, is to disable interrupts at the reader side before
>> trying to acquire the per-CPU rwlock and keep it disabled throughout the
>> duration of the read-side critical section.
[...]
>> -void percpu_read_lock(struct percpu_rwlock *pcpu_rwlock)
>> +void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
>>  {
>>  	preempt_disable();
>>
>>  	/* First and foremost, let the writer know that a reader is active */
>> -	this_cpu_inc(*pcpu_rwlock->reader_refcnt);
>> +	this_cpu_add(*pcpu_rwlock->reader_refcnt, READER_PRESENT);
>>
>>  	/*
>>  	 * If we are already using per-cpu refcounts, it is not safe to switch
>>  	 * the synchronization scheme. So continue using the refcounts.
>>  	 */
>>  	if (reader_nested_percpu(pcpu_rwlock)) {
>> -		goto out;
>> +		this_cpu_inc(*pcpu_rwlock->reader_refcnt);
> 
> Hmmm...  If the reader is nested, it -doesn't- need the memory barrier at
> the end of this function.  If there is lots of nesting, it might be
> worth getting rid of it.
> 

Yes, good point! Will get rid of it.

Regards,
Srivatsa S. Bhat
