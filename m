Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id E4B8667BD7
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 04:26:24 +1100 (EST)
In-Reply-To: <BAY102-F21BB220054F2541A7614E4A9FD0@phx.gbl>
References: <BAY102-F21BB220054F2541A7614E4A9FD0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1003DD59-BA95-4277-BCDE-652624C5B126@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Booting without Uboot on 8548E
Date: Sat, 4 Nov 2006 12:22:36 -0500
To: M Ptich <ptich@hotmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 4, 2006, at 3:52 AM, M Ptich wrote:

> Documentation mentions that the only dependencies between 2.6  
> Kernel and
> bootloader are:
>
> 1. 5 input parameters (bd_t pointer, start and end of command line,  
> start
> and end of ram disk)
> 2. bd_t pointer and command line must with within 16MB of Kernel
> 3. Initial TLB1 entry must have IPROT=1

I don't know where these are "documented", but there are
many more dependencies. :-)  Take a look at the cpu initialization
code from u-boot and you will notice how the TLB CAMs need
to be initialized with the various memory maps.  All of the local
bus windows likewise need to be properly set up and match
the kernel configuration.

> And now we are stuck with apparently another dependency: our Kernel  
> fails to
> advance beyond time calibration because jiffies are not getting  
> incremented,

The time base needs to be enabled in HID0 prior to calling
the kernel.

All of these "dependencies" are typically things a boot rom is
going to also need for proper functioning.  We just chose not
to do it again in the kernel.  You are going to find more.

Thanks.


	-- Dan
