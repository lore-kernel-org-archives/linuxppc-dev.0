Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ACAA3DDE49
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 21:41:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IDIli-00033Z-3x
	for linuxppc-embedded@ozlabs.org; Tue, 24 Jul 2007 04:41:34 -0700
Message-ID: <11761280.post@talk.nabble.com>
Date: Tue, 24 Jul 2007 04:41:34 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ask some questions about u-boot's bootm command
In-Reply-To: <200707221539215465156@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <200707221539215465156@163.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


can u send me output of printenv in boot loader..?

Nethra

poorbeyond wrote:
> 
> my cpu is 860T, using bootm command boot a linux kernel image, the
> following message print by smc1:
> 
> bootm 300000
> 
> ## Booting image at 00300000 ...
>    Image Name:   Linux-2.6.20.14
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1081591 Bytes =  1 MB
>    Load Address: 00100000
>    Entry Point:  00100000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Current stack ends at 0x01D5DB10 => set upper limit to 0x00800000
> No initrd
> ## Transferring control to Linux (at address 00100000) ...
> 
> 
> 
> then, the program has no response.
> 
> i debug it througth BDM, in u-boot function "do_bootm_linux", execute at
> "kernel = (void (*)(bd_t *, ulong, ulong, ulong, ulong))hdr->ih_ep", the
> program branch to address "0x00000000", the code is shown as following:
> 00000000    mr    r31,r3
> 00000004    mr    r30,r4
> 00000008    mr    r29,r5
> 0000000C    mr    r28,r6
> 00000010    mr    r27,r7
> 00000014    bl    0x000020C8
> 00000018    mfmsr    r0
> 0000001C    ori    r0,r0,0x30
> 00000020    mtspr    SRR1,r0
> 00000024    lis    r0,0xC0002004@h
> 00000028    ori    r0,r0,0xC0002004@l
> 0000002C    mtspr    SRR0,r0
> 00000030    rfi
> 
> 
> my questions are:
> 
> 1. Is the code "kernel = (void (*)(bd_t *, ulong, ulong, ulong,
> ulong))hdr->ih_ep" branch right?
> 
> 2. What's the expected code after "kernel = (void (*)(bd_t *, ulong,
> ulong, ulong, ulong))hdr->ih_ep"?
> 
> 3. When the kernel run to the "boot/simple/head.s"?
> 
> 
> thanks a lot
> 
> 
> 
> 
> 
> poorbeyond
> 2007-07-22
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/ask-some-questions-about-u-boot%27s-bootm-command-tf4124319.html#a11761280
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
