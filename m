Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C36F22C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 04:25:39 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 23:48:06 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2804C3940053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:55:33 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5QIPUuE27000942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:55:30 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5QIPVK0032708
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 04:25:33 +1000
Message-ID: <51CB3159.8000509@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 23:52:17 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 15/45] rcu: Use get/put_online_cpus_atomic() to prevent
 CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625202755.16593.67819.stgit@srivatsabhat.in.ibm.com>
 <20130625220026.GG3828@linux.vnet.ibm.com>
 <51CAF624.6060004@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72AA@saturn3.aculab.com>
 <20130626143424.GN3828@linux.vnet.ibm.com>
 <1372258271.18733.256.camel@gandalf.local.home>
 <20130626152148.GA4405@mtj.dyndns.org>
In-Reply-To: <20130626152148.GA4405@mtj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: peterz@infradead.org, fweisbec@gmail.com, oleg@redhat.com,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 Steven Rostedt <rostedt@goodmis.org>, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbw@mit.edu,
 David Laight <David.Laight@ACULAB.COM>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2013 08:51 PM, Tejun Heo wrote:
> On Wed, Jun 26, 2013 at 10:51:11AM -0400, Steven Rostedt wrote:
>>> It would also increase the latency of CPU-hotunplug operations.
>>
>> Is that a big deal?
> 
> I thought that was the whole deal with this patchset - making cpu
> hotunplugs lighter and faster mostly for powersaving.  That said, just
> removing stop_machine call would be a pretty good deal and I don't
> know how meaningful reducing CPU hotunplug latency is.  Srivatsa?
> 

Keeping the hotunplug latency is important for suspend/resume, where
we take all non-boot CPUs in a loop. That's an interesting use-case
where intrusiveness doesn't matter much, but latency does. So yes,
making CPU hotplug faster is also one of the goals of this patchset.

Regards,
Srivatsa S. Bhat
