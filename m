Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 898C867A0E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:46:50 +1000 (EST)
In-Reply-To: <20060427194055.3EED1353A57@atlas.denx.de>
References: <20060427194055.3EED1353A57@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BC840B06-F69E-4304-90E2-415906D29A1D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Thu, 27 Apr 2006 14:46:45 -0500
To: Wolfgang Denk <wd@denx.de>
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


On Apr 27, 2006, at 2:40 PM, Wolfgang Denk wrote:

> In message  
> <D358E665-60E4-48C0-82FD-7A1C16DAF00C@kernel.crashing.org> you wrote:
>>
>> The problem is that there are somethings that u-boot knows that needs
>> to go into the blob (memory size, boot args, initrd info,
>> frequencies, etc.)
>
> Yes. Can we append auch variable data to the fixed part of the dts?

appending is not really how it works, but the runtime fixup is doable.

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
>
>> As stated before, the main issue is doing some runtime fix ups to the
>> blob before its handed to the kernel.
>
> Let's do exactly this: runtime fix ups.
>
>> We could hand bootm a memory location with a blob and do the fix ups
>> at runtime, we would still have some coupling between the blob and u-
>> boot build.  At least the blob wouldn't be built into u-boot.
>
> OK.

Let me play with this some now that I've got some direction.

- kumar
