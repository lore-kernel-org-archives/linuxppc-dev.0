Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFwBv4GcYzDqVW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 02:51:03 +1000 (AEST)
Date: Thu, 26 May 2016 18:50:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com,
 paulmck@linux.vnet.ibm.com, jeremy@goop.org, chrisw@sous-sol.org,
 akataria@vmware.com, rusty@rustcorp.com.au
Subject: Re: [PATCH v3 0/6] powerpc use pv-qpsinlock as the default spinlock
 implemention
Message-ID: <20160526165047.GM3206@twins.programming.kicks-ass.net>
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 25, 2016 at 04:18:03PM +0800, Pan Xinhui wrote:

> _____test________________spinlcok______________pv-qspinlcok_____
> |futex hash	|	556370 ops	|	629634 ops	|
> |futex lock-pi	|	362 ops		|	367 ops		|
> 
> scheduler test:
> Test how many loops of schedule() can finish within 10 seconds on all cpus.
> 
> _____test________________spinlcok______________pv-qspinlcok_____
> |schedule() loops|	322811921 	|	311449290	|
> 
> kernel compiling test:
> build a linux kernel image to see how long it took
> 
> _____test________________spinlcok______________pv-qspinlcok_____
> | compiling takes|	22m 		|	22m		|


s/spinlcok/spinlock/

Is 'spinlcok' the current test-and-set lock?

And what about regular qspinlock, in case of !SHARED_PROCESSOR?
