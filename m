Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D368567A44
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 08:20:01 +1000 (EST)
Message-ID: <44513DC1.8040608@orkun.us>
Date: Thu, 27 Apr 2006 16:55:13 -0500
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot-Users] Re: FT u-boot shim
References: <20060427194055.3EED1353A57@atlas.denx.de>
In-Reply-To: <20060427194055.3EED1353A57@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <D358E665-60E4-48C0-82FD-7A1C16DAF00C@kernel.crashing.org> you wrote:
>> The problem is that there are somethings that u-boot knows that needs  
>> to go into the blob (memory size, boot args, initrd info,  
>> frequencies, etc.)
> 
> Yes. Can we append auch variable data to the fixed part of the dts?
> 
>> How would we distinguish the bootm command that takes a blob versus  
>> the ones we have today?
> 
> Arg count. For example:
> 
> OLD:	bootm <kernel_addr>
>    or	bootm <kernel_addr> <ramdisk_addr>
> 
> NEW:	bootm <kernel_addr> - <dts_addr>
>    or	bootm <kernel_addr> <ramdisk_addr> <dts_addr>


How would you like to handle the case when dts is packed into 
multi-image file? Is bootm going to assume that the 3rd Image is dts?

Since dts is tightly coupled to kernel I would prefer something like:

bootm <kernel_addr>[:<dts_addr>] <ramdisk_addr>

Best regards,
Tolunay
