Return-Path: <anton@ozlabs.org>
Date: Fri, 23 Mar 2007 09:19:45 -0500
From: Anton Blanchard <anton@samba.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 07/10] Page fault handler should not depend on
	CONFIG_KPROBES
Message-ID: <20070323141945.GB17198@kryten>
References: <20070321013810.404636000@samba.org>
	<20070321013825.385423000@samba.org>
	<20070321161342.GA17211@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321161342.GA17211@lst.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> NACK until the performace implication a fixed.  Martin measured this
> costs 300 cycles on s390 even without any notifier activce, and while
> ppc might be slightly bad that's still too much to add to the pagefault
> handler unconditionally.  Please add a light weight method to check
> whether there is any activce user of the notifications.  Also please
> move the code into kernel/ at the same time instead of having the exact
> same thing duplicated all over, as in my notify_die patches.

Im struggling to understand how they could take 300 cycles to execute
this code sequence. We have seen similar questions on the ia64 side,
they both must have some pretty fundamental branch prediction issues.

I measured this in sim and the sequence takes under 20 cycles on a
power5 class machine, and thats a pessimistic estimate.

Anton
