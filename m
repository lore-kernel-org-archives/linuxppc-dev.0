Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ACBCADDF39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 04:33:29 +1100 (EST)
In-Reply-To: <200702131608.55630.laurent.pinchart@technotrade.biz>
References: <200702131608.55630.laurent.pinchart@technotrade.biz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CA43D092-C7B2-4132-95CF-814CFFF9A043@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Best way to define flash partitions for an MPC8248
Date: Tue, 13 Feb 2007 11:32:50 -0600
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
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


On Feb 13, 2007, at 9:08 AM, Laurent Pinchart wrote:

> Hi everybody,
>
> I'm running Linux 2.6.20 on an MPC8248 using arch/ppc/.
>
> The system flash is divided in 5 partitions, which are currently  
> defined in
> both U-Boot and in the Linux kernel (hardcoded in platform specific  
> code in
> arch/ppc/platforms/). This is error prone, as modifying partition  
> information
> requires a change to the U-Boot environment variables and a  
> recompilation of
> the Linux kernel.
>
> I would like to get rid of partition data in the kernel. I found 3  
> ways for
> the Linux kernel to get those data from elsewhere:
>
> - command line parsing (using the mtdparts argument)
> - redboot partition table parsing
> - OF device tree (drivers/mtd/maps/physmap_of.c)
>
> What is the best suited method ? I don't really like the redboot  
> partition
> table, is I haven't found any way to write it from U-Boot. Do I  
> need to
> switch to arch/powerpc/ to use the OF device tree ? If so, is it  
> possible
> today for the MPC8248 processor, or is it still badly supported in
> arch/powerpc/ ? Last but not least, is it possible to change the OF  
> device
> tree from U-Boot at runtime to resize partitions ?

You'll have to switch to arch/powerpc for using the of device tree  
parsing.  I believe the 8248/827x are supported under arch/powerpc at  
this point.

I don't believe its possible to change the OF device tree at runtime  
currently, you'll have to add code to u-boot to do that.  U-boot does  
very little with the device tree beyond setting it up and filling in  
some values that are needed (memory sizes, frequencies, etc.)

- k
