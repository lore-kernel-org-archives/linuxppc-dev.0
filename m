Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B1CD9679FB
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 07:26:44 +1100 (EST)
Date: Thu, 2 Mar 2006 12:26:34 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Unsafe pte_update() in do_page_fault() (4xx and Book-E)
Message-ID: <20060302202634.GA14387@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

For the last couple of days I was debugging rare 

  swap_dup: Bad swap file entry 0x00000080

errors in my custom 2.4 kernel running on 405GPr system.

My current theory is that this error is caused by the special lazy 
dcache/icache flush handling on 4xx and BookE. Because this code in my 
2.4 was actually a backport from 2.6, I think we have a problem in 
current 2.6 as well.

Here is what I think happens. On 4xx/BookE we use execute bit to 
deffer dcache to icache flush, in do_page_fault() we flush page when 
execute trap triggers and enable _PAGE_HWEXEC bit in PTE. 

Unfortunately, we don't lock this PTE and it's possible that after 
pte_present() check but _before_ pte_update() call this particular 
page was purged from the memory, e.g. because of extreme memory 
pressure (of course, I'm assuming enabled preempt). 

If this happens, pte_update() sets _PAGE_HWEXEC bit in just cleared 
PTE. Sometime later, another page fault happens for this page, but 
because of that set bit, pte_none() test in handle_pte_fault() fails, 
and we continue along the wrong path, thinking that this PTE was 
swapped out to the swap file, and this triggers swap_dup error I 
mentioned at the beginning.

_PAGE_HWXEC is 0x200 on 405GPr, and because swap entry is PTE shifted 
2 bits to the right, we get that "0x00000080" value.

Paul, does my theory make any sense? I cannot test 2.6 on our hw. So 
far, after I added additional page_table_lock locking to my 2.4 in 
do_page_fault(), I haven't seen these errors, but it's too early to be 
100% sure :).

I'll make a patch for 2.6 if you think my analysis is correct.

-- 
Eugene
