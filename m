Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C4852C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 04:32:11 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 23:57:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 040FD3940043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 00:02:04 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5QIW0BC29163716
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 00:02:01 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5QIW2gN019359
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 04:32:04 +1000
Message-ID: <51CB32E0.3040106@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 23:58:48 +0530
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
 <1372260823.18733.263.camel@gandalf.local.home>
 <20130626172948.GD4405@mtj.dyndns.org>
In-Reply-To: <20130626172948.GD4405@mtj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 Steven Rostedt <rostedt@goodmis.org>, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 oleg@redhat.com, sbw@mit.edu, David Laight <David.Laight@ACULAB.COM>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2013 10:59 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jun 26, 2013 at 11:33:43AM -0400, Steven Rostedt wrote:
>> I thought the whole deal with this patchset was to remove stop_machine
>> from CPU hotplug. Why halt all CPUs just to remove one? stomp_machine()
>> is extremely intrusive for the entire system, where as one CPU making
>> sure all CPUs schedule isn't very intrusive at all.
>>
>> I didn't think the idea of this patch set was to make CPU hotplug
>> faster, just less intrusive to the system.
> 
> Yeap, removal of stop_machine is a great improvement in itself.

Absolutely. To make hotplug less intrusive on the system.

>  ISTR
> mentions of hot-unplug latency but I could be mistaken.  Srivatsa, can
> you please chime in on that?
> 

Yes, we were discussing hot-unplug latency for use-cases such as
suspend/resume. We didn't want to make those operations slower in the
process of removing stop_machine() from hotplug.

Regards,
Srivatsa S. Bhat
