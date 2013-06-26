Return-Path: <htejun@gmail.com>
Received: from mail-qa0-x231.google.com (mail-qa0-x231.google.com
 [IPv6:2607:f8b0:400d:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7DB82C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 01:22:02 +1000 (EST)
Received: by mail-qa0-f49.google.com with SMTP id hu16so1608764qab.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 08:21:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Jun 2013 08:21:48 -0700
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 15/45] rcu: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Message-ID: <20130626152148.GA4405@mtj.dyndns.org>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625202755.16593.67819.stgit@srivatsabhat.in.ibm.com>
 <20130625220026.GG3828@linux.vnet.ibm.com>
 <51CAF624.6060004@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72AA@saturn3.aculab.com>
 <20130626143424.GN3828@linux.vnet.ibm.com>
 <1372258271.18733.256.camel@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372258271.18733.256.camel@gandalf.local.home>
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

On Wed, Jun 26, 2013 at 10:51:11AM -0400, Steven Rostedt wrote:
> > It would also increase the latency of CPU-hotunplug operations.
> 
> Is that a big deal?

I thought that was the whole deal with this patchset - making cpu
hotunplugs lighter and faster mostly for powersaving.  That said, just
removing stop_machine call would be a pretty good deal and I don't
know how meaningful reducing CPU hotunplug latency is.  Srivatsa?

Thanks.

-- 
tejun
