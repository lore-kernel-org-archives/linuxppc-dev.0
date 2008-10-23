Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id EB061DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Oct 2008 09:28:03 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so221604qwb.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Oct 2008 15:28:02 -0700 (PDT)
Message-ID: <4900FA72.1040201@genesi-usa.com>
Date: Thu, 23 Oct 2008 17:28:02 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Using Bestcomm API (DMA) on MPC5200b with Linux?
References: <406316.49476.qm@web25808.mail.ukl.yahoo.com>
In-Reply-To: <406316.49476.qm@web25808.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: arieswar24b@yahoo.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You need to write a task that does the DMA operation you want; 
GenBD is actually pretty generic and lets you just copy from 
one place to another.

The API is pretty simple; make sure genbd is compiled in, get 
the task structure using bcom_gen_bd_[tr]x_init, and then.. 
uhh.. this is where I always forget.

There is a way to submit a buffer descriptor and have the 
engine basically perform that transfer. I think it's 
bcom_prepare_next_buffer and then bcom_submit_next_buffer.

Actually I can't even FIND those functions in the Linux tree 
right now, but they have to be in there because the FEC driver 
uses them..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Dave Best wrote:
> I am trying to connect a FPGA/FIFO with my MPC5200b on a phytec PCM 030 board  while running a 2.6.23.1 Linux.
> 
> The Linux Kernel source contains an implementation for the Bestcomm API in the form of a driver for ethernet (fec) and ATA.(situated in the arch-powerpc/sysdev/bestcomm path) I tried to make use of it but i've run into some problems.
> 
> So i tried to include the API in a module to utilize its functionality but no luck till now.
> 
> Freescale supports the Bestcomm DMA API not on an OS level. So the problem is adopting this API into a Linux environment, which distinguishes between kernel space and user space while writing to the appropriate registers.
> 
> Further information is very hard to find for such a common task as starting a DMA transfer.
> 
> Dave
> 
> 
> 
>       
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
