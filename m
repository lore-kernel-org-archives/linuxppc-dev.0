Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C35B4DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 15:38:04 +1100 (EST)
Subject: Re: question on modifying pte entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <4728DB43.1060205@nortel.com>
References: <4728DB43.1060205@nortel.com>
Content-Type: text/plain
Date: Thu, 01 Nov 2007 15:37:52 +1100
Message-Id: <1193891872.7176.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-31 at 13:45 -0600, Chris Friesen wrote:
> Hi all,
> 
> We've got some kernel code that monitors which pages have been dirtied 
> by an application.
> 
> The pages are locked in memory, and the system has no swap.  Initially 
> we mark the pages clean using ptep_clear_flush_dirty(), then when 
> requested by the app we scanning through the pages and check the dirty 
> bit using pte_dirty().  If it's dirty we store the address and then mark 
> it clean using the same function as above.  The above is all done while 
> holding both mm->mmap_sem and mm->page_table_lock.
> 
> This worked fine in 2.6.10 but now in 2.6.14 it's giving us problems. 
> Periodically we'll get a page that we know has been dirtied, but it 
> doesn't get detected as such.  It appears that once this occurs, that 
> page will never again be detected as dirty.
> 
> Does anyone have any ideas what may be happening?  Were there any 
> changes in the page table area other than moving to 4-level mappings? 
> Anyone aware of any missing tlb flushes that were fixed later?

.14 ? ouch that's old... I can't tell you for sure what went in when,
also you aren't telling us whether you are using 32 or 64 bits kernels
and what processor family it is, so it's hard to help you there.

What comes to mind though:

 - At one point, a PTE page lock was introduced. You need to take that
instead of the PTL (actually, you may need to take both, I'm not sure).
I don't know off hand if 2.6.14 has it already though.

 - Flushes are batched on ppc64. There might be something wrong with the
batching... clear_flush_dirty should flush but maybe it's not doing it
or something like that... There used to be a subtle race with the
batching as well that you may hit, not sure, that's why I reworked it
all recently (in .22 or .23 iirc).

 - Maybe the VM is messing around and disliking the changes to the PTE
you are doing behind its back ?

Ben.
