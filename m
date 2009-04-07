Return-Path: <fredrik.arnerup@edgeware.tv>
Received: from mail.edgeware.tv (mail.edgeware.tv [82.99.7.138])
	by ozlabs.org (Postfix) with ESMTP id 08118DDF8C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 19:09:56 +1000 (EST)
From: "Fredrik Arnerup" <fredrik.arnerup@edgeware.tv>
To: "'Scott Wood'" <scottwood@freescale.com>
References: <1C9CDA9B925A4C77B150D492AFFD022F@edgeware.tv>
	<20090406182650.GB4001@ld0162-tx32.am.freescale.net>
Subject: RE: Recap: Kernel oops while duming user core.
Date: Tue, 7 Apr 2009 11:09:54 +0200
Message-ID: <52D4E83A99B840D78EE55C2BD1609F5F@edgeware.tv>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20090406182650.GB4001@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com] 
> Sent: Monday, April 06, 2009 8:27 PM
> To: Fredrik Arnerup
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: Recap: Kernel oops while duming user core.
>
> On Mon, Apr 06, 2009 at 05:23:12PM +0200, Fredrik Arnerup wrote:
> > Was the kernel oops when dumping core ever resolved?
> > (http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051080.html,
quoted
> > below)
> 
> What was the cause? Is there a patch? A bug tracker ticket?
>
> It was fixed here:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051350.html
>
> > Using ELDK here, so still running 2.6.24 ...
>
> Please consider upgrading.
>
> -Scott

Thanks! Works with the ppc arch too.

/Fredrik


--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -483,7 +483,12 @@ void update_mmu_cache(struct vm_area_struct *vma,
unsigned long address,
                 */
                _tlbie(address, 0 /* 8xx doesn't care about PID */);
 #endif
-               if (!PageReserved(page)
+               /* The _PAGE_USER test should really be _PAGE_EXEC, but
+                * older glibc versions execute some code from no-exec
+                * pages, which for now we are supporting.  If exec-only
+                * pages are ever implemented, this will have to change.
+                */
+               if (!PageReserved(page) && (pte_val(pte) & _PAGE_USER)
                    && !test_bit(PG_arch_1, &page->flags)) {
                        if (vma->vm_mm == current->active_mm) {
                                __flush_dcache_icache((void *) address);
