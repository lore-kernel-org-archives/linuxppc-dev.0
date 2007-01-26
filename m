Return-Path: <tfeller@badgateway.de>
Received: from mail.badgateway.de (mail.badgateway.de [88.198.18.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABC57DE009
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Jan 2007 06:53:36 +1100 (EST)
Received: from [192.168.1.168] (pD9E02EE9.dip0.t-ipconnect.de [217.224.46.233])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.badgateway.de (Postfix) with ESMTP id 8A0623489F5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 20:27:50 +0100 (CET)
Message-ID: <45BA5635.2000001@badgateway.de>
Date: Fri, 26 Jan 2007 20:27:49 +0100
From: Thomas Feller <tfeller@badgateway.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MVME3100 and linux-2.6.10
References: <6386542.1169804641943.SLOX.WebMail.wwwrun@mailserver.gemrad.com>
In-Reply-To: <6386542.1169804641943.SLOX.WebMail.wwwrun@mailserver.gemrad.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

vittorio barulli wrote:
> I have a PowerPc Motorola, I install on it a kernel image (2.6.10) that
> use a ramdisk as root filesystem.
> The original version issued with kernel 2.6.10 is working even if I
> recompile it.
>
> Now I want to modify the original ramdisk to insert some file that I
> need. If I insert in the ramdisk some little file the kernel continue
> to start, but if i insert a great file (4 Mb) the kernel don't boot.
> the result on video is:
>
> loaded at:     01864400 0253356C
> relocated to:  00400000 010CF16C
> board data at: 010CD124 010CD16C
> relocated to:  00405238 00405280
> zimage at:     00405A05 005BA5C2
> initrd at:     005BB000 010CC420
> avail ram:     010D0000 AACC8A8B
>   
The last line here looks wrong. It should be someting like 10000000 (256
MB) or 20000000 (512 MB). Not AACC8A8B which is ~ 2732,783 MB.
I've noticed that this only works right with gcc < 4.1. It seemed like
they did change some things in ld.
> Linux/PPC load: console=ttyS0,9600 root=/dev/ram0 ramdisk_size=64000
> ramdisk_blocksize=1024
> Uncompressing Linux...done.
> Now booting the kernel
>   
That is where my kernel stops to boot too!!!
Is there someone out there who can tell us, what we did wrong?

Regards,
    Thomas
