Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 576F567A7A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Feb 2005 03:08:54 +1100 (EST)
Date: Sun, 27 Feb 2005 09:08:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Message-ID: <20050227090851.B11020@cox.net>
References: <200502262328.24165.niklaus.giger@member.fsf.org>
	<200502271610.30615.niklaus.giger@member.fsf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200502271610.30615.niklaus.giger@member.fsf.org>;
	from niklaus.giger@member.fsf.org on Sun, Feb 27, 2005 at
	04:10:30PM +0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problems porting to a custom PPC405GPr board using a vanilla
	2.6.10 kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Feb 27, 2005 at 04:10:30PM +0100, Niklaus Giger wrote:
> Am Samstag, 26. Februar 2005 23.28 schrieb Niklaus Giger:
> > Hi
> >
> > I would like to port Linux to a custom PPC405GPr board. Its hardware runs
> > vxWorks fine for more than a year.
> >
> I made some more progress. After adding 3 lines for MMU support with the BDI
> I can debug the startup up to kernel_start using BDI. 
> 
> Afterwards my console changes the baudrate for still unknown reasons.

How do you know this? Console isn't initialized until after the kernel 
command line printk and a few other facilities are initialized.

> Analysing the __log_buf I get the following output
> (gdb) x/s &__log_buf
> 0xc01accfc <ratelimit_lock.9>:   "<4>Linux version 2.6.10 
> (niklaus@ng.ngiger.dyndns.org) (gcc-Version 3.3.5 (Debian 1:3.3.5-8)) #15 Sun 
> Feb 27 14:44:27 CET 2005\n<7>On node 0 totalpages: 8240\n<7>  DMA zone: 8240 
> pages, LIFO batch:2\n<7>"...
> (gdb) x
> 0xc01acdc4 <ratelimit_lock.9+200>:       "  Normal zone: 0 pages, LIFO 
> batch:1\n<7>  HighMem zone: 0 pages, LIFO batch:1\n<4>Built 1 
> zonelists\n<4>Kernel command line: ip=172.25.1.6\n<4>PID hash table entries: 
> 256 (order:8, 4096 bytes)\n"
> (gdb) x
> 0xc01ace84 <ratelimit_lock.9+392>:       ""

Is this all of the log_buf output? Try setting your kernel cmdline
with "console=ttyS0,115200" where 115200 is you console baudrate
you are using in U-Boot. Otherwise, the kernel 8250 driver has no
idea which baudrate to set for the 8250/console.

-Matt 
