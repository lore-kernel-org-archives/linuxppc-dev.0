Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: David Rientjes <rientjes@google.com>
Subject: Re: linux-next: PowerPC boot failures in next-20120521
In-reply-to: <alpine.DEB.2.00.1205211954340.13522@chino.kir.corp.google.com>
References: <20120522114051.0c9db9a7c2d660bc9e0e1be2@canb.auug.org.au>
 <328.1337652722@neuling.org>
 <alpine.DEB.2.00.1205211924390.13682@chino.kir.corp.google.com>
 <2182.1337654352@neuling.org> <2246.1337654423@neuling.org>
 <alpine.DEB.2.00.1205211942540.29814@chino.kir.corp.google.com>
 <3120.1337655100@neuling.org>
 <alpine.DEB.2.00.1205211954340.13522@chino.kir.corp.google.com>
Date: Tue, 22 May 2012 13:12:15 +1000
Message-ID: <5214.1337656335@neuling.org>
Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Peter Zijlstra <peterz@infradead.org>,
 Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Rientjes <rientjes@google.com> wrote:

> On Tue, 22 May 2012, Michael Neuling wrote:
> 
> > Sorry, got it... CONFIG_DEBUG_VM enabled below...
> > 
> > pid_max: default: 32768 minimum: 301
> > Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
> > Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
> > Mount-cache hash table entries: 4096
> > Initializing cgroup subsys cpuacct
> > Initializing cgroup subsys devices
> > Initializing cgroup subsys freezer
> > POWER7 performance monitor hardware support registered
> > ------------[ cut here ]------------
> > kernel BUG at /scratch/mikey/src/linux-next/include/linux/gfp.h:318!
> 
> Yeah, this is what I was expecting, it's tripping on
> 
> 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES || !node_online(nid));
> 
> and slub won't pass nid < 0.  You're sure my patch is applied? :)

I did have your patch applied but at "b4cdf91 sched/numa: Implement numa
balancer" (where git bisect spotted the fail).  

If I apply your patch on the full next-20120521 it does fix the problem.

Sorry for the confusion.

Thanks!
Mikey
