Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3mQd4BlqzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 02:27:05 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DGO7f2032915
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 12:26:59 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sv16h774-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 12:26:59 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 12:26:57 -0400
Date: Thu, 13 Apr 2017 09:26:51 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
 tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
 edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
 bobby.prani@gmail.com, Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH tip/core/rcu 02/40] rcu: Make arch select
 smp_mb__after_unlock_lock() strength
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170413092418.a2rudzukbgookior@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413092418.a2rudzukbgookior@hirez.programming.kicks-ass.net>
Message-Id: <20170413162651.GD3956@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2017 at 11:24:18AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 12, 2017 at 10:39:47AM -0700, Paul E. McKenney wrote:
> > The definition of smp_mb__after_unlock_lock() is currently smp_mb()
> > for CONFIG_PPC and a no-op otherwise.  It would be better to instead
> > provide an architecture-selectable Kconfig option, and select the
> > strength of smp_mb__after_unlock_lock() based on that option. 
> 
> Why is this better? Do we want to have more of this? I thought we still
> wanted to convince PPC to go RCsc and eradicate all this RCpc 'fun'. But
> instead now you're making it look like its OK to grow more of this pain.

ARCH_WEAK_RELEASE_ACQUIRE actually works both ways.

To see this, imagine some strange alternate universe in which the Power
hardware guys actually did decide to switch PPC to doing RCsc as you
suggest.  There would still be a lot of Power hardware out there that
still does RCpc.  Therefore, powerpc builds that needed to run on old
Power hardware would select ARCH_WEAK_RELEASE_ACQUIRE, while kernels
built to run only on the shiny new (but mythical) alternate-universe
Power hardware would avoid selecting this Kconfig option.

But the real reason I queued this patch is that Ingo asked me for it:
https://lkml.org/lkml/2017/1/14/88

							Thanx, Paul
