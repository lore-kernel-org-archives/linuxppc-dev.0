Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17973.32577.253554.707441@cargo.ozlabs.ibm.com>
Date: Mon, 30 Apr 2007 15:31:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powermac: proper sleep management
In-Reply-To: <1177767996.5102.9.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
	<17971.14223.435220.418649@cargo.ozlabs.ibm.com>
	<1177767996.5102.9.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> Are you serious? The only thing the generic code does here is invoke our
> stuff in the right order. That shouldn't be too much of a constraint. We

Yes I'm serious.  At a quick look, the generic code is calling
freeze_processes and shrink_all_memory, and I don't see where it's
doing a sync.  I really don't like the process freezer; as Linus
pointed out, it has caused more deadlocks than it solved.

Also, you're now calling pbook_alloc_pci_save after interrupts are
disabled, and it does a kmalloc(..., GFP_KERNEL).  Oops.

Part of the problem is exactly what Linus pointed out: that the
generic code tries to use the same code paths for suspend to RAM and
suspend to disk, but they are two totally different things.

I have no objection to adding code to enable the generic code to do
the (mostly) right thing when you write "mem" into /sys/power/state.
I have no objection to code being refactored to eliminate
duplication.  All I ask is that the PMU ioctls continue to do
essentially the same things in the same order.

Paul.
