Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 102132C0308
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 07:09:07 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sat, 2 Mar 2013 01:36:49 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 191953940055
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:39:01 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21K8wQl9437396
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 Mar 2013 01:38:58 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21K8x57017733
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 Mar 2013 07:09:01 +1100
Message-ID: <51310A5F.1070001@linux.vnet.ibm.com>
Date: Sat, 02 Mar 2013 01:36:55 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] lglock: add read-preference local-global rwlock
References: <512BBAD8.8010006@linux.vnet.ibm.com>
 <CACvQF51jCxk5jUqmhD=QBBtUsBkQWZzakacrKO4Gsk=w61rNwQ@mail.gmail.com>
 <512C7A38.8060906@linux.vnet.ibm.com>
 <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com>
 <20130301175349.GC2481@mtj.dyndns.org>
In-Reply-To: <20130301175349.GC2481@mtj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lai Jiangshan <eag0628@gmail.com>, linux-doc@vger.kernel.org,
 peterz@infradead.org, fweisbec@gmail.com, oleg@redhat.com,
 Michel Lespinasse <walken@google.com>, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, Lai Jiangshan <laijs@cn.fujitsu.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vincent.guittot@linaro.org, sbw@mit.edu, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/01/2013 11:23 PM, Tejun Heo wrote:
> Hey, guys and Oleg (yes, I'm singling you out ;p because you're that
> awesome.)
> 
> On Sat, Mar 02, 2013 at 01:44:02AM +0800, Lai Jiangshan wrote:
>> Performance:
>> We only focus on the performance of the read site. this read site's fast path
>> is just preempt_disable() + __this_cpu_read/inc() + arch_spin_trylock(),
>> It has only one heavy memory operation. it will be expected fast.
>>
>> We test three locks.
>> 1) traditional rwlock WITHOUT remote competition nor cache-bouncing.(opt-rwlock)
>> 2) this lock(lgrwlock)
>> 3) V6 percpu-rwlock by "Srivatsa S. Bhat". (percpu-rwlock)
>>    (https://lkml.org/lkml/2013/2/18/186)
>>
>> 		nested=1(no nested)	nested=2	nested=4
>> opt-rwlock	 517181			1009200		2010027
>> lgrwlock	 452897			 700026		1201415
>> percpu-rwlock	1192955			1451343		1951757
> 
> On the first glance, the numbers look pretty good and I kinda really
> like the fact that if this works out we don't have to introduce yet
> another percpu synchronization construct and get to reuse lglock.
> 
> So, Oleg, can you please see whether you can find holes in this one?
> 
> Srivatsa, I know you spent a lot of time on percpu_rwlock but as you
> wrote before Lai's work can be seen as continuation of yours, and if
> we get to extend what's already there instead of introducing something
> completely new, there's no reason not to

Yep, I agree!

> (and my apologies for not
> noticing the possibility of extending lglock before).

No problem at all! You gave so many invaluable suggestions to make this
whole thing work in the first place! Now, if we can reuse the existing
stuff and extend it to what we want, then its just even better! :-)

>  So, if this can
> work, it would be awesome if you guys can work together.

Absolutely!

>  Lai might
> not be very good at communicating in english yet but he's really good
> at spotting patterns in complex code and playing with them.
>

That sounds great! :-)

I'll soon take a closer look at his code and the comparisons he posted,
and work towards taking this effort forward.

Thank you very much!

Regards,
Srivatsa S. Bhat
