Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id BCBF1679FD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 06:31:29 +1000 (EST)
Date: Tue, 24 May 2005 13:31:23 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Message-ID: <20050524133123.A23084@cox.net>
References: <200505242119.29197.niklaus.giger@member.fsf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200505242119.29197.niklaus.giger@member.fsf.org>;
	from niklaus.giger@member.fsf.org on Tue, May 24, 2005 at
	09:19:28PM +0200
Cc: rtai@rtai.org, linuxppc-embedded@ozlabs.org
Subject: Re: Newbie question about accessing memory in kernel space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, May 24, 2005 at 09:19:28PM +0200, Niklaus Giger wrote:
> Hi
> 
> I am working on a custom PPC405 board where I have a 2.6.10 kernel with RTAI 
> patches (fusion) running.
> 
> I am trying to access some custom CPLD chip hanging at 0x7D000000. In my 
> intial board (hcu3_map_io) I added a corresponding io_block_mapping.

Is a "corresponding" mapping a 1:1 mapping? Don't do that.  You cannot
map stuff that way since it is below TASK_SIZE i.e. it's in user address
space, not kernel address space.

> Now I compiled a module which tries to access the CPLD during the insmod phase
> and I get the following output.
> 
> Oops: kernel access of bad area, sig: 11 [#1]

<snip>

> What is wrong with my code? 

You mapped the device into user virtual address space.  The TLB
replacement code is unable to load a TLB entry for a page outside
of kernel space...so you crash.

Don't use io_block_map()...it allows you to shoot yourself in the
foot very easily (as you just witnessed). Use ioremap() to map
your device.

-Matt
