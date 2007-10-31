Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zrtps0kp.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 90914DDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 07:13:31 +1100 (EST)
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com
	[47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	l9VJjNY19353
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 19:45:24 GMT
Message-ID: <4728DB43.1060205@nortel.com>
Date: Wed, 31 Oct 2007 13:45:07 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: question on modifying pte entries
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

We've got some kernel code that monitors which pages have been dirtied 
by an application.

The pages are locked in memory, and the system has no swap.  Initially 
we mark the pages clean using ptep_clear_flush_dirty(), then when 
requested by the app we scanning through the pages and check the dirty 
bit using pte_dirty().  If it's dirty we store the address and then mark 
it clean using the same function as above.  The above is all done while 
holding both mm->mmap_sem and mm->page_table_lock.

This worked fine in 2.6.10 but now in 2.6.14 it's giving us problems. 
Periodically we'll get a page that we know has been dirtied, but it 
doesn't get detected as such.  It appears that once this occurs, that 
page will never again be detected as dirty.

Does anyone have any ideas what may be happening?  Were there any 
changes in the page table area other than moving to 4-level mappings? 
Anyone aware of any missing tlb flushes that were fixed later?

Thanks,

Chris
