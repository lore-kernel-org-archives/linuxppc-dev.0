Return-Path: <streeter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F116B67D74
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 01:01:44 +1000 (EST)
From: Guy Streeter <streeter@redhat.com>
To: FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn>
In-Reply-To: <A9DE2BAF233E444FA9C5E77A5825A01E8652D4@ydmail.sbell.com.cn>
References: <A9DE2BAF233E444FA9C5E77A5825A01E8652D4@ydmail.sbell.com.cn>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 10:01:30 -0500
Message-Id: <1122562890.18454.8.camel@mentos.hsv.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to load a linux kernel under vxworks bootloader (PPC860
	board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-07-28 at 12:16 +0800, FCG WANG Baohua wrote:
> Dear All: 
>   I want to boot a linux 2.4.25 kernel under vxworks bootloader. When
> I using flat mode(0x200000 -->  0x10000) kernel  uncompressed ELF
> format ( vmlinux ),
> 
>  and download it using TFTP of vxworks, it print the "starting at
> 0x1000 ...." and  freeze.  No input or output on serial port.
> 
>  The version of vxworks is 5.3.1.  
>  can you give me some detail advice or give me a tool to slove it?
> thanks !

Most ppc kernels depend on the bootloader to configure some devices and
to leave some configuration data in a known memory location so that the
kernel (or the kernel's boot wrapper) can use the devices and data
during startup.
None of the board-specific startup code in kernel supports booting from
a VxWorks bootloader. Code I have written to do that for some boards
doesn't appear to be in the kernel anywhere.
You will need to look at the startup code your board is using and figure
out how to do without the device and data setup normally provided by the
bootloader. I addition, you will need to make sure the kernel is trying
to use the console port at the same baud rate as VxWorks.

--Guy Streeter
