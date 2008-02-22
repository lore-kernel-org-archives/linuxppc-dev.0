Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id DBB90DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 18:40:54 +1100 (EST)
Date: Fri, 22 Feb 2008 08:40:48 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] Linux 2.6.25-rc2 - Regression from 2.6.24-rc1-git1
	softlockup while bootup on powerpc
Message-ID: <20080222074048.GA23197@kernel.dk>
References: <alpine.LFD.1.00.0802151302210.9496@woody.linux-foundation.org>
	<47B67E5E.4010001@linux.vnet.ibm.com>
	<20080217192913.GO23197@kernel.dk>
	<20080219170432.9c04376f.kamezawa.hiroyu@jp.fujitsu.com>
	<20080219083633.GN23197@kernel.dk>
	<20080221232418.b93db8d9.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080221232418.b93db8d9.akpm@linux-foundation.org>
Cc: Dhaval Giani <dhaval@linux.vnet.ibm.com>,
	Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21 2008, Andrew Morton wrote:
> On Tue, 19 Feb 2008 09:36:34 +0100 Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > But I think the radix 'scan over entire tree' is a bit fragile.
> 
> eek, it had better not be.  Was this an error in the caller?  Hope so.

The cfq use of it, not the radix tree code! It juggled the keys and
wants to make sure that we see all users, modulo raced added ones (ok if
we see them, doesn't matter if we don't).

> > This
> > patch adds a parallel hlist for ease of properly browsing the members,
> 
> Even though io_contexts are fairly uncommon, adding more stuff to a data
> structure was a pretty sad alternative to fixing a bug in
> radix_tree_gang_lookup(), or to fixing a bug in a caller of it.
> 
> IOW: what exactly went wrong here??

I could not convince myself that the current code would always do the
right thing. We should not have been seeing ->key == NULL entries in
there, it implied a double exit of that process. So I decided to fix it
by making the code a lot more readable (the patch in question deleted a
lot more than it added), at the cost of that hlist head + node.

-- 
Jens Axboe
