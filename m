Return-Path: <rupesh.sugathan@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.199])
	by ozlabs.org (Postfix) with ESMTP id E44FC2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 02:44:32 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so676221rnk
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 09:44:31 -0700 (PDT)
Message-ID: <1e44ebcf0410140944620f1dab@mail.gmail.com>
Date: Thu, 14 Oct 2004 09:44:30 -0700
From: Rupesh S <rupesh.sugathan@gmail.com>
To: jonathan@jonmasters.org
In-Reply-To: <35fb2e590410121603624c27a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1e44ebcf04101214247d3072b6@mail.gmail.com>
	<20041012213634.GA4936@gate.ebshome.net>
	<35fb2e590410121603624c27a2@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC kernel hangs
Reply-To: Rupesh S <rupesh.sugathan@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the informations.
I used "ioremap" and it works !!

However, when I checked out some documentaions on this regard, I
happened to notice that for "cache disabled acees in some arch", we
would probably need to use "ioremap_nocache". My requirement is for a
cache disabled access. Also, I read that in some processor arch, the
"nocache" and the normmal version is all the same. How is it in PPC ?

I could also read that it is encouraged to use "readl", "writel" to
access the memory rather than the normal pointer dereferencing.
However, in my driver, the normal pointer dereferencing works, but the
"readl" and "writel" doesn't work. Here is the code snippet for the
write operation. Any clues ?
################################################################
volatile __u32* __fpga;

__fpga = (__u32*) ioremap_nocache(0x60000000, (4*1024));

/* writel(data, ((__u32)__fpga + 0x0C)); */ /* This does not work */

*(volatile __u32*)((__u32)__fpga + 0x0C) = data; /* This works */
#############################################################



On Wed, 13 Oct 2004 00:03:21 +0100, Jon Masters <jonmasters@gmail.com> wrote:
> On Tue, 12 Oct 2004 14:36:34 -0700, Eugene Surovegin <ebs@ebshome.net> wrote:
> 
> > Did you use ioremap to get valid kernel virtual address for your
> > device registers? You generally cannot just use physical address to
> > access device from the device driver.
> 
> Possibly also use io_block_mapping on ppc to map a block of IO memory
> before ioremapping.
> 
> Jon.
> 


-- 
Rupesh S
