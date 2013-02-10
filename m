Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 88A8B2C029E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:34:11 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 05:25:22 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 932D92BB004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:34:06 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJLwHK983502
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:21:58 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AJY4T1011481
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:34:06 +1100
Message-ID: <5117F5B5.6090701@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 01:02:05 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v5 06/45] percpu_rwlock: Allow writers to be readers,
 and add lockdep annotations
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073416.13822.96504.stgit@srivatsabhat.in.ibm.com>
 <20130208234754.GM2666@linux.vnet.ibm.com>
In-Reply-To: <20130208234754.GM2666@linux.vnet.ibm.com>
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

On 02/09/2013 05:17 AM, Paul E. McKenney wrote:
> On Tue, Jan 22, 2013 at 01:04:23PM +0530, Srivatsa S. Bhat wrote:
>> CPU hotplug (which will be the first user of per-CPU rwlocks) has a special
>> requirement with respect to locking: the writer, after acquiring the per-CPU
>> rwlock for write, must be allowed to take the same lock for read, without
>> deadlocking and without getting complaints from lockdep. In comparison, this
>> is similar to what get_online_cpus()/put_online_cpus() does today: it allows
>> a hotplug writer (who holds the cpu_hotplug.lock mutex) to invoke it without
>> locking issues, because it silently returns if the caller is the hotplug
>> writer itself.
>>
>> This can be easily achieved with per-CPU rwlocks as well (even without a
>> "is this a writer?" check) by incrementing the per-CPU refcount of the writer
>> immediately after taking the global rwlock for write, and then decrementing
>> the per-CPU refcount before releasing the global rwlock.
>> This ensures that any reader that comes along on that CPU while the writer is
>> active (on that same CPU), notices the non-zero value of the nested counter
>> and assumes that it is a nested read-side critical section and proceeds by
>> just incrementing the refcount. Thus we prevent the reader from taking the
>> global rwlock for read, which prevents the writer from deadlocking itself.
>>
>> Add that support and teach lockdep about this special locking scheme so
>> that it knows that this sort of usage is valid. Also add the required lockdep
>> annotations to enable it to detect common locking problems with per-CPU
>> rwlocks.
> 
> Very nice!  The write-side interrupt disabling ensures that the task
> stays on CPU, as required.
> 
> One request: Could we please have a comment explaining the reasons for
> the writer incrementing and decrementing the reader reference count?
> 
> It looked really really strange to me until I came back and read the
> commit log.  ;-)
> 

Sure :-)

Regards,
Srivatsa S. Bhat
