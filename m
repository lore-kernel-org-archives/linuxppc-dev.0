Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 90CD567B1A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 16:20:22 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j3B6ORmS018511
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 09:24:28 +0300 (EEST)
Message-ID: <425A1456.7020104@intracom.gr>
Date: Mon, 11 Apr 2005 09:08:22 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: karim@opersys.com
References: <4259FA09.8040508@opersys.com>
In-Reply-To: <4259FA09.8040508@opersys.com>
Content-Type: multipart/mixed; boundary="------------070606090504090502020101"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x with TQM860L
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070606090504090502020101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Karim Yaghmour wrote:
> I've been trying to get a 2.6.x kernel working with a TQM860L board
> with little success. I can get 2.6.11.6 to boot and _sometimes_ get
> to a shell, but most of the times it dies while starting init. From
> reading the archives, this looks very much like an SDRAM config issue
> (i.e. dies mostly when bursting.) Has anyone on this list got a
> 2.6.x kernel working with the TQM860L?
> 
> Thanks,
> 
> Karim

Karim hi

You need the following small patch.

For all the gory details follow the thread
   "8xx v2.6 TLB problems and suggested workaround"

Latest 2.6.12-rc2 works for me.

I don't know if there are any specific problems with TQM860L.

Please be aware that the serial driver has changed
     arch/ppc/8xx_io/uart.c -> drivers/serial/cpm_uart

Also if you use the FEC do give a whirl at drivers/net/fec_8xx.

Regards

Pantelis


--------------070606090504090502020101
Content-Type: text/x-patch;
 name="8xx-tlbie.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8xx-tlbie.patch"

--- linux-2.5/arch/ppc/mm/init.c	2005-04-01 13:33:07.000000000 +0300
+++ linux-2.5-intracom/arch/ppc/mm/init.c	2005-04-05 10:28:04.000000000 +0300
@@ -620,9 +620,10 @@
 		struct page *page = pfn_to_page(pfn);
 		if (!PageReserved(page)
 		    && !test_bit(PG_arch_1, &page->flags)) {
-			if (vma->vm_mm == current->active_mm)
-				__flush_dcache_icache((void *) address);
-			else
+			if (vma->vm_mm == current->active_mm) {
+				_tlbie(address);
+				__flush_dcache_icache((void *)address);
+			} else
 				flush_dcache_icache_page(page);
 			set_bit(PG_arch_1, &page->flags);
 		}

--------------070606090504090502020101--
