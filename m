Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AB4CF67BD1
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:40:57 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Apr 2006 14:20:34 CDT."
	<D358E665-60E4-48C0-82FD-7A1C16DAF00C@kernel.crashing.org>
Date: Thu, 27 Apr 2006 21:40:55 +0200
Sender: wd@denx.de
Message-Id: <20060427194055.3EED1353A57@atlas.denx.de>
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

In message <D358E665-60E4-48C0-82FD-7A1C16DAF00C@kernel.crashing.org> you wrote:
>
> The problem is that there are somethings that u-boot knows that needs  
> to go into the blob (memory size, boot args, initrd info,  
> frequencies, etc.)

Yes. Can we append auch variable data to the fixed part of the dts?

> How would we distinguish the bootm command that takes a blob versus  
> the ones we have today?

Arg count. For example:

OLD:	bootm <kernel_addr>
   or	bootm <kernel_addr> <ramdisk_addr>

NEW:	bootm <kernel_addr> - <dts_addr>
   or	bootm <kernel_addr> <ramdisk_addr> <dts_addr>

> As stated before, the main issue is doing some runtime fix ups to the  
> blob before its handed to the kernel.

Let's do exactly this: runtime fix ups.

> We could hand bootm a memory location with a blob and do the fix ups  
> at runtime, we would still have some coupling between the blob and u- 
> boot build.  At least the blob wouldn't be built into u-boot.

OK.



Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is necessary to have purpose.
	-- Alice #1, "I, Mudd", stardate 4513.3
