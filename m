Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 7D12B67BD3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 18:47:49 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id B0D988780B7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 01:47:37 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r69l014737D-00-2
	for linuxppc-embedded@ozlabs.org; Thu, 21 Sep 2006 01:47:37 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 8C29E878093
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 01:47:37 -0700 (PDT)
Message-ID: <451251A9.9080504@gmail.com>
Date: Thu, 21 Sep 2006 14:17:37 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Steven Kaiser <skaiser.uci@gmail.com>
Subject: Re: MPC5200b kernel module memory mapping
References: <000001c6dd12$417d7a50$6e4ec880@volt>
In-Reply-To: <000001c6dd12$417d7a50$6e4ec880@volt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Stevenson Kaiser,

Steven Kaiser wrote:
> #define MPC5xxx_MM_IPBI		(MPC5xxx_MBAR + 0x0054)
>
> void *ioaddr = NULL;
>
>
> 	// map our physical address into kernal virtual address space
> 	// do I need this call?
> 	ioaddr = ioremap(MALab_MM_START,MALab_MM_SIZE);
>
>   
Try typecasting.        ioaddr = (u16 *)ioremap (start, size );

Regards
Sudheer

> return 0;
> }
>
> Later (in a ioctrl routine), I will try and write something to the first
> location in my address range.  I tried these three ways:
>
> 	*(volatile u16 *)MALab_MM_START = 0x5555;
> 	outw(0x5555,MALab_MM_START);
> 	outw(0x5555,ioaddr);
>
> Any and all of the these calls crash the kernel so horrendously I have to
> reboot.  Sometimes I have to delete and mknod a new /dev entry.
>
> I have tried the io memory map technique instead of the above io port map
> technique, using request_mem_region(), with the same crashing results upon
> any writew() call or direct variants.  I tried things without the ioremap()
> call--  I get a segmentation fault in these cases.
>
> The request_region() or request_mem_region() seems to work ok.  I can cat
> /proc/iomem or /proc/ioports and see my range in there.  I am pretty sure I
> am setting up the LocalBus chip select registers ok.
>
> Yet obviously I am doing something profoundly stupid.  Is my error obvious?
> Can someone enlighten me in my darkness?
>
> Steven Kaiser
> Chemistry Electronics Facility
> University of California, Irvine
> 2347 Natural Sciences 2
> Irvine, CA  92697-2025
> (949)824-7520
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
