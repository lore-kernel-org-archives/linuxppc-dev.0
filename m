Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DAC9F1007D2
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2011 17:42:30 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 29 Nov 2011 06:40:47 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAT6gII35283970
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2011 17:42:18 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAT6gH1Q016678
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2011 17:42:18 +1100
Message-ID: <4ED47EC2.2090802@linux.vnet.ibm.com>
Date: Tue, 29 Nov 2011 12:12:10 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/4] cpuidle: (powerpc) Add cpu_idle_wait() to
 allow switching of idle routines
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>	<20111117112830.9191.1951.stgit@localhost6.localdomain6>	<1322434096.23348.6.camel@pasglop>	<4ED36A37.3030409@linux.vnet.ibm.com>
 <1322512522.23348.43.camel@pasglop>
In-Reply-To: <1322512522.23348.43.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/29/2011 02:05 AM, Benjamin Herrenschmidt wrote:

> On Mon, 2011-11-28 at 16:32 +0530, Deepthi Dharwar wrote:
> 
>>> Additionally, I'm a bit worried (but maybe we already discussed that a
>>> while back, I don't know) but cpu_idle_wait() has "wait" in the name,
>>> which makes me think it might need to actually -wait- for all cpus to
>>> have come out of the function.
>>
>> cpu_idle_wait is used to ensure that all the CPUs discard old idle
>> handler and update to new one.  Required while changing idle
>> handler on SMP systems.
>>
>>> Now your implementation doesn't provide that guarantee. It might be
>>> fine, I don't know, but if it is, you'd better document it well in the
>>> comments surrounding the code, because as it is, all you do is shoot an
>>> interrupt which will cause the target CPU to eventually come out of idle
>>> some time in the future.
>>
>>
>> I was hoping that sending an explicit reschedule to the cpus would
>> do the trick but sure we can add some documentation around the code.
> 
> Well, the question is what guarantee do you expect. Sending a reschedule
> IPI will take the other CPUs out of the actual sleep mode, but it will
> be some time from there back to getting out of the handler function
> (first back out of hypervisor etc...).
> 
> The code as you implemented it doesn't wait for that to happen. It might
> be fine ... or not. I don't know what semantics you are after precisely.
> 
> Cheers,
> Ben.
> 
> 


Yes, this could be problematic as there is small window for the
race condition to occur . Otherwise we need to manually schedule
it by running a kernel thread but this would definitely have a
overhead and would be an overkill.

Regards,
Deepthi
