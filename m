Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56BF067C17
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 07:14:53 +1000 (EST)
Message-ID: <4532A430.6060208@dlasys.net>
Date: Sun, 15 Oct 2006 17:12:16 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Robert Corley <rcorley@aegis-inc.net>
Subject: Re: uartlite with 2.6.17 kernel and kernel early text messages
References: <20061013204442.52818.qmail@web56308.mail.re3.yahoo.com>
In-Reply-To: <20061013204442.52818.qmail@web56308.mail.re3.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robert Corley wrote:
> I am still trying to get the UARTLITE to work with 2.6 and a plb_temac design.  I am using EDK 7.1.  I have generated the edk files and copied xparameters_ml300.h to arch/ppc/platforms/4xx/xparameters.xparameters_ml403.h
>
> In an effort to get past the "Rebooting to System ACE Configuration Address 6..." message, I have selected "support for early boot texts over serial port" in kernel debugging.
>   
    I do not think Peter's driver actually supports early boot texts. I 
beleive the patches David  Bolcsfoldi posted add early boot support.

    If you can not get that working I posted a driver in January (as 
part of a patchset for the Pico E12) that has early boot support - 
though on inspection David's patches looked like they should work.


> FYI, I'm using Peter's patches to create the uartlite.c and associated files and have selected the uartlite using make menuconfig.
>
> The first error is as follows:
> athena startup_network # make ARCH=ppc zImage.initrd
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
> dnsdomainname: Unknown host
>   CC      arch/ppc/syslib/gen550_dbg.o
> arch/ppc/syslib/gen550_dbg.c:36: error: `RS_TABLE_SIZE' undeclared here (not in a function)
> arch/ppc/syslib/gen550_dbg.c:38: error: empty scalar initializer
> arch/ppc/syslib/gen550_dbg.c:38: error: (near initialization for `rs_table')
> arch/ppc/syslib/gen550_dbg.c:36: error: storage size of `rs_table' isn't known
> arch/ppc/syslib/gen550_dbg.c:36: warning: 'rs_table' defined but not used
> make[1]: *** [arch/ppc/syslib/gen550_dbg.o] Error 1
> make: *** [arch/ppc/syslib] Error 2
>   
    Unless you actually have an 8250 based Uart in your system - and you 
are not configured for one, then arch/ppc/syslib/gen550_dbg should NOT 
be getting built.
    Proper early boot text support for the UartLite requires both a 
replacement for this AND changes to use those instead of gen550_dbg.c

> so, I modified the gen550_dbg.c file to #include the xparameters.h, where the RS_TABLE_SIZE is defined
>  but still get more errors.  Here they are:
>   
    You do not want to touch gen550_dbg.c
    You need a new uartlite_dbg.c and Makefile and other changes to use it.

>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
> dnsdomainname: Unknown host
>   CC      arch/ppc/syslib/gen550_dbg.o
> arch/ppc/syslib/gen550_dbg.c:37: error: `XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared here (not in a function)
> arch/ppc/syslib/gen550_dbg.c:37: error: initializer element is not constant
> arch/ppc/syslib/gen550_dbg.c:37: error: (near initialization for `rs_table[0].baud_base')
> arch/ppc/syslib/gen550_dbg.c:37: error: `XPAR_INTC_0_UARTNS550_0_VEC_ID' undeclared here (not in a function)
> arch/ppc/syslib/gen550_dbg.c:37: error: initializer element is not constant
> arch/ppc/syslib/gen550_dbg.c:37: error: (near initialization for `rs_table[0].irq')
> arch/ppc/syslib/gen550_dbg.c:37: error: `XPAR_UARTNS550_0_BASEADDR' undeclared here (not in a function)
> arch/ppc/syslib/gen550_dbg.c:37: error: initializer element is not constant
> arch/ppc/syslib/gen550_dbg.c:37: error: (near initialization for `rs_table[0].iomem_base')
> arch/ppc/syslib/gen550_dbg.c:37: error: initializer element is not constant
> arch/ppc/syslib/gen550_dbg.c:37: error: (near initialization for `rs_table[0]')
> make[1]: *** [arch/ppc/syslib/gen550_dbg.o] Error 1
> make: *** [arch/ppc/syslib] Error 2
>
> Questions:
>
> 1.    Now, is this an issue with the UARTLITE driver or is it just not supported for early messaging?
>   
    Peters does not support early boot texts.
    Both David's and my drivers do as do David's patches to Peter's driver./
> 2.   What am I missing w.r.t. getting something out of the serial port?
> 3.    I am assuming that the boot args for a initrd boot are:  "console=ttyUL0 ip=off root=/dev/ram rw", correct?
>   
    Presuming you have no other serial device I think you should not 
need any console= argument at all.
> -corley
>
>
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
