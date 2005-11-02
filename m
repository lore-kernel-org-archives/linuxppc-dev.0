Return-Path: <akonovalov@ru.mvista.com>
Received: from localhost.localdomain (85-21-6-192.broadband.corbina.ru
	[85.21.6.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81C9968672
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Nov 2005 03:45:48 +1100 (EST)
Message-ID: <4368C815.6040703@ru.mvista.com>
Date: Wed, 02 Nov 2005 17:07:17 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: "David H. Lynch Jr" <dhlii@comcast.net>
References: <20050906130029.74727.qmail@web8405.mail.in.yahoo.com>
	<43688AAD.5050208@comcast.net>
In-Reply-To: <43688AAD.5050208@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Board Bringup problem with 2.6.13.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Your problem seems to be due to the CPU_213 errata:

ftp://ftp.xilinx.com/pub/documentation/misc/ppc405f6v5_2_0.pdf, page 22

Best regards,
Andrei


David H. Lynch Jr wrote:
> I am working through bringing up Linux 2.6.13.4 on a Xilinx V4 based 
> ppc405.
> with memory from 0x0 through 0x7fffffff
> 
> 
> 
> Right now I get:
> 
>  >Starting MonitorX.elf: V3.3.2.0.
>  >
>  >loaded at:     00400000 0047F13C
>  >board data at: 0047D128 0047D13C
>  >relocated to:  00405300 00405314
>  >zimage at:     00405A95 0047CE71
>  >avail ram:     00480000 08000000
>  >
>  >Linux/PPC load: console=ttyS0,9600 console=tty0 init=/linuxrc 
> looptype=squashfs cdroot splash=silentttttt
>  >Uncompressing Linux......done.
>  >Now booting the kernel
> 
> I have been able to trace execution into head_4xx.S  to immediately 
> before turn_on_mmu:
> But immediately after this I lose the ability to trace.
> 
> I have been tracing things with a status port at 0x70000000 I can write 
> to and read from the host side with code like
> 
>    lis   r14,0x7000      /* debugging port */
>    li   r15,0x2305      /* value to output */
>    stw   r15,4(r14)     eieio
> 
> after turn_on_mmu executes this does not seem to work.
> looking at other code it appeared that I needed to add
> tophy(r14,r14) prior to the stw
> but that does not seem to help.
> 
> What do I need to do to be able to continue to use my debug port ?
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
