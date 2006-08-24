Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AD58667D7B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 04:06:23 +1000 (EST)
Date: Thu, 24 Aug 2006 22:06:25 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: bwarren@qstreams.com
Subject: Re: Platform device style question
Message-ID: <20060824220625.515d9b3c@vitb.ru.mvista.com>
In-Reply-To: <1156441997.17977.44.camel@saruman.qstreams.net>
References: <1156441997.17977.44.camel@saruman.qstreams.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 24 Aug 2006 13:53:17 -0400
Ben Warren <bwarren@qstreams.com> wrote:

> Hello,
> 
> A 'newbie-to-platform-devices' question:
> 
> In a patch that Kumar just sent for a compact flash device, the resource
> data (I/O addresses, IRQ # etc.) are retrieved from the platform system.
> I guess I can either modify the device tree in U-boot by adding
> additional nodes, or instantiate a platform device in Linux __init code
> based on static information.  The former gives the advantage of having
> the bootloader pass the info to the OS.  (Somebody please correct me if
> I'm off-base here!)  
> 
I'd suggest to make a look at LDD concerning linux device model...
For platform device, there's no need to cope with u-boot at all. You'll prolly need to 
register the respective platform device from the board-specific code, with proper name 
and driver's board-specific platform info. You may have a look at arch/ppc/syslib/ppc_sys.c about static
PD definitions usage.


> Are device trees meant to only contain information about the CPU and
> tightly-coupled peripherals, or is it considered OK-form to also include
> board-level hardware info?  I guess they can really hold anything, but
> I'm trying to figure out the original intent.
> 
I'd make sense to figure out the platform device bus before digging into device trees. It's slightly 
different stuff, for similar aim, but anyway... Actually you do not strictly need devtree to cope with 
your case afaiu.

> regards,
> Ben
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
