Return-Path: <gaashh@yahoo.com>
Received: from web39604.mail.mud.yahoo.com (web39604.mail.mud.yahoo.com
	[209.191.106.35]) by ozlabs.org (Postfix) with SMTP id 2FEC7DDED2
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 18:37:18 +1000 (EST)
Date: Mon, 31 Mar 2008 01:30:37 -0700 (PDT)
From: Gaash Hazan <gaashh@yahoo.com>
Subject: Re: [PATCH] powerpc: Fix deadlock with mmu_hash_lock in hash_page_sync
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <8C22373EA650AF40928EEA0C188D62D206C71041@xmb-ams-338.emea.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <31342.74174.qm@web39604.mail.mud.yahoo.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	gaash-ppclnx@gaashh.com, Gilad Ben-Yossef <gilad@codefidence.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Benjamin Herrenschmidt
> [mailto:benh@kernel.crashing.org] 
> Sent: Monday, March 31, 2008 0:49
> To: gaash-ppclnx@gaashh.com
> Cc: linuxppc-dev@ozlabs.org; Gilad Ben-Yossef; Paul
> Mackerras
> Subject: [PATCH] powerpc: Fix deadlock with
> mmu_hash_lock in
> hash_page_sync
> 
> hash_page_sync() takes and releases the low level
> mmu hash lock in order
> to sync with other processors disposing of page
> tables. Because that
> lock can be needed to service hash misses triggered
> by interrupt
> handler, taking it must be done with interrupts off.
> However,
> hash_page_sync() appear to be called with interrupts
> enabled, thus
> causing occasional deadlocks.
> 
> We fix it by making sure hash_page_sync() masks
> interrupts while holding
> the lock.
> 
> Signed-off-by: Benjamin Herrenschmidt
> <benh@kernel.crashing.org>
> ---
> 
> Please test and report asap thought it's probably
> too late for 2.6.25,
> it can still go into stable later on.
> 

Thank you for the quick acknowledgment and patch. 

Patch works well.

Thanks,
Gaash
