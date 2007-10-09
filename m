Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id CF930DDFBB
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 07:18:36 +1000 (EST)
Date: Tue, 9 Oct 2007 16:18:19 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Hard hang in hypervisor!?
Message-ID: <20071009211819.GR29559@localdomain>
References: <20071009203724.GM4350@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071009203724.GM4350@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> 
> I was futzing with linux-2.6.23-rc8-mm1 in a power6 lpar when,
> for whatever reason, a spinlock locked up. The bizarre thing 
> was that the rest of system locked up as well: an ssh terminal,
> and also an hvc console.
> 
> Breaking into the debugger showed 4 cpus, 1 of which was 
> deadlocked in the spinlock, and the other 3 in 
> .pseries_dedicated_idle_sleep
> 
> This was, ahhh, unexpected.  What's up with that? Can
> anyone provide any insight?

Sounds consistent with a task trying to double-acquire the lock, or an
interrupt handler attempting to acquire a lock that the current task
holds.  Or maybe even an uninitialized spinlock.  Do you know which
lock it was?
