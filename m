Return-Path: <htejun@gmail.com>
Received: from mail-qc0-x234.google.com (mail-qc0-x234.google.com
 [IPv6:2607:f8b0:400d:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A27292C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 03:30:00 +1000 (EST)
Received: by mail-qc0-f180.google.com with SMTP id a1so8314099qcx.25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 10:29:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Jun 2013 10:29:48 -0700
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 15/45] rcu: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Message-ID: <20130626172948.GD4405@mtj.dyndns.org>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625202755.16593.67819.stgit@srivatsabhat.in.ibm.com>
 <20130625220026.GG3828@linux.vnet.ibm.com>
 <51CAF624.6060004@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72AA@saturn3.aculab.com>
 <20130626143424.GN3828@linux.vnet.ibm.com>
 <1372258271.18733.256.camel@gandalf.local.home>
 <20130626152148.GA4405@mtj.dyndns.org>
 <1372260823.18733.263.camel@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372260823.18733.263.camel@gandalf.local.home>
Cc: peterz@infradead.org, fweisbec@gmail.com, oleg@redhat.com,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com,
 zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sbw@mit.edu, David Laight <David.Laight@ACULAB.COM>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, Jun 26, 2013 at 11:33:43AM -0400, Steven Rostedt wrote:
> I thought the whole deal with this patchset was to remove stop_machine
> from CPU hotplug. Why halt all CPUs just to remove one? stomp_machine()
> is extremely intrusive for the entire system, where as one CPU making
> sure all CPUs schedule isn't very intrusive at all.
> 
> I didn't think the idea of this patch set was to make CPU hotplug
> faster, just less intrusive to the system.

Yeap, removal of stop_machine is a great improvement in itself.  ISTR
mentions of hot-unplug latency but I could be mistaken.  Srivatsa, can
you please chime in on that?

Thanks.

-- 
tejun
