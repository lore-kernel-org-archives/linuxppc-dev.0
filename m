Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB3742C0292
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:32:05 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 05:25:14 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5978F2BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:32:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJJtn733685566
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:19:55 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AJW2V8010467
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:32:04 +1100
Message-ID: <5117F53A.20307@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 01:00:02 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 05/45] percpu_rwlock: Make percpu-rwlocks IRQ-safe,
 optimally
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073400.13822.52336.stgit@srivatsabhat.in.ibm.com>
 <20130210184209.GA3041@redhat.com>
In-Reply-To: <20130210184209.GA3041@redhat.com>
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

On 02/11/2013 12:12 AM, Oleg Nesterov wrote:
> only one cosmetic nit...
> 
> On 01/22, Srivatsa S. Bhat wrote:
>>
>> +#define READER_PRESENT		(1UL << 16)
>> +#define READER_REFCNT_MASK	(READER_PRESENT - 1)
>> +
>>  #define reader_uses_percpu_refcnt(pcpu_rwlock, cpu)			\
>>  		(ACCESS_ONCE(per_cpu(*((pcpu_rwlock)->reader_refcnt), cpu)))
>>
>>  #define reader_nested_percpu(pcpu_rwlock)				\
>> -			(__this_cpu_read(*((pcpu_rwlock)->reader_refcnt)) > 1)
>> +	(__this_cpu_read(*((pcpu_rwlock)->reader_refcnt)) & READER_REFCNT_MASK)
>>
>>  #define writer_active(pcpu_rwlock)					\
>>  			(__this_cpu_read(*((pcpu_rwlock)->writer_signal)))
> 
> I think this all can go to lib/percpu-rwlock.c. Nobody needs to know
> these implementation details.
> 

Ok, will move them.
 
Regards,
Srivatsa S. Bhat
