Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC5F32C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 04:13:30 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 04:01:59 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CAAAF2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 04:13:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5OHwckf58785944
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 03:58:38 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5OIDOdH030284
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 04:13:26 +1000
Message-ID: <51C88B76.90806@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 23:39:58 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 22/45] percpu_counter: Use get/put_online_cpus_atomic()
 to prevent CPU offline
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623134256.19094.99231.stgit@srivatsabhat.in.ibm.com>
 <20130624175535.GA1918@mtj.dyndns.org> <20130624180636.GB1918@mtj.dyndns.org>
In-Reply-To: <20130624180636.GB1918@mtj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, Al Viro <viro@zeniv.linux.org.uk>, namhyung@kernel.org,
 tglx@linutronix.de, laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com,
 netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2013 11:36 PM, Tejun Heo wrote:
> On Mon, Jun 24, 2013 at 10:55:35AM -0700, Tejun Heo wrote:
>>> @@ -105,6 +106,7 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
>>>  		ret += *pcount;
>>>  	}
>>>  	raw_spin_unlock(&fbc->lock);
>>> +	put_online_cpus_atomic();
>>
>> I don't think this is necessary.  CPU on/offlining is explicitly
>> handled via the hotplug callback which synchronizes through fbc->lock.
>> __percpu_counter_sum() racing with actual on/offlining doesn't affect
>> correctness and adding superflous get_online_cpus_atomic() around it
>> can be misleading.
> 
> Ah, okay, so you added a debug feature which triggers warning if
> online mask is accessed without synchronization.

Exactly!

>  Yeah, that makes
> sense and while the above is not strictly necessary, it probably is
> better to just add it rather than suppressing the warning in a
> different way.

Yeah, I was beginning to scratch my head as to how to suppress the
warning after I read your explanation as to why the calls to
get/put_online_cpus_atomic() would be superfluous in this case...

But as you said, simply invoking those functions is much simpler ;-)

>  Can you please at least add a comment explaining that?
> 

Sure, will do. Thanks a lot Tejun!
 
Regards,
Srivatsa S. Bhat
