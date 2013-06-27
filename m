Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 51FAE2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 18:54:57 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 18339-05 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 27 Jun 2013 09:54:50 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH v2 15/45] rcu: Use get/put_online_cpus_atomic() to prevent
 CPU offline
Date: Thu, 27 Jun 2013 09:54:41 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72AB@saturn3.aculab.com>
In-Reply-To: <51CB3159.8000509@linux.vnet.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625202755.16593.67819.stgit@srivatsabhat.in.ibm.com>
 <20130625220026.GG3828@linux.vnet.ibm.com>
 <51CAF624.6060004@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72AA@saturn3.aculab.com>
 <20130626143424.GN3828@linux.vnet.ibm.com>
 <1372258271.18733.256.camel@gandalf.local.home>
 <20130626152148.GA4405@mtj.dyndns.org> <51CB3159.8000509@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "Tejun Heo" <tj@kernel.org>
Cc: peterz@infradead.org, fweisbec@gmail.com, oleg@redhat.com,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 Steven Rostedt <rostedt@goodmis.org>, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbw@mit.edu, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >>> It would also increase the latency of CPU-hotunplug operations.
> >>
> >> Is that a big deal?
> >
> > I thought that was the whole deal with this patchset - making cpu
> > hotunplugs lighter and faster mostly for powersaving.  That said, =
just
> > removing stop_machine call would be a pretty good deal and I don't
> > know how meaningful reducing CPU hotunplug latency is.  Srivatsa?
> >
>=20
> Keeping the hotunplug latency is important for suspend/resume, where
> we take all non-boot CPUs in a loop. That's an interesting use-case
> where intrusiveness doesn't matter much, but latency does. So yes,
> making CPU hotplug faster is also one of the goals of this patchset.

If you are removing all but one of the cpu, the you only need
one rcu cycle (remove everything from the list first).

I'd also guess that you can't suspend a cpu until you can sleep
the process that is running on it - so if a process has pre-emption
disabled you aren't going to complete suspend until the process
sleeps (this wouldn't be true if you suspended the cpu with its
current stack - but if suspend is removing the non-boot cpus first
it must be doing so from the scheduler idle loop).

If you are doing suspend for aggressive power saving, then all the
processes (and processors) will already be idle. However you
probably wouldn't want the memory accesses to determine this on
a large NUMA system with 1024+ processors.

	David
