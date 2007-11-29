Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83DB5DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 23:42:58 +1100 (EST)
Message-ID: <474EB36D.1080408@dlasys.net>
Date: Thu, 29 Nov 2007 07:41:17 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: schardt <g.schardt@fz-juelich.de>
Subject: Re: Init hangs on Xilinx4
References: <474D8839.6020609@fz-juelich.de>
In-Reply-To: <474D8839.6020609@fz-juelich.de>
Content-Type: text/plain; charset=iso-8859-1
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I had a similar problem. In my instance it turned out that I was
inadvertently using the physical address of my uart as the output address.
This worked during boot becasue there was a 1:1 physical-logical entry
stuffed into the MMU. But since Linux did nto know about it, as soon as
the VM system decided to use that TLB entry IO died - right in the
middle of a string.

While it is unlikely you made exactly the same mistake. One area you can
check is memory.

What is your output device ?

schardt wrote:
> Hi all,
>
> i still have some problems booting linux from flash and don't know how
> to debug.
>
> i have a xilinx4-ppc with 64MB Ram and 4MB Flash, U-Boot works fine,
> kernel is booting, but my little hello world program runs as init, died
> after printing "He" (intead of "Hello World"). i tried initramfs with
> build in cpio-image and jffs2 rootfs
>
> Is there a log-buffer to look at ?
> Should i try another compiler version ? (btw. booting from systemace
> works with the version i use).
>
> ---------------------------
> famous last words :
>
> [   50.476641] VFS: Mounted root (jffs2 filesystem).
> [   50.533581] Freeing unused kernel memory: 68k init
> He
> ---------------------------
>
>
> regards
> Georg
>
>
>
> -------------------------------------------------------------------
> -------------------------------------------------------------------
> Forschungszentrum Jülich GmbH
> 52425 Jülich
>
> Sitz der Gesellschaft: Jülich
> Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
> Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
> Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender),
> Dr. Ulrich Krafft (stellv. Vorsitzender), Dr. Sebastian M. Schmidt
> -------------------------------------------------------------------
> -------------------------------------------------------------------
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
