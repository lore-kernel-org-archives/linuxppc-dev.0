Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BF478DDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 00:08:26 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <46730D5F.4040701@am.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <26778ed0e343676aa0c4fd0f4fa0746b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 24/33] powerpc: Correct __secondary_hold comment
Date: Mon, 18 Jun 2007 09:08:30 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Jun 16 08:06:23 EST 2007, Geoff Levand wrote:
> Remove references to pSeries and OpenFirmware in the __secondary_hold
> usage comment.  __secondary_hold is a generic routine and can be used
> by other platforms.

The comment is correct, just incomplete.  Well, the part that you 
changed anyways.  How about changing the subject to:

Expand comment for other uses of __secondary_hold.

>
> Signed-off-by: Geoff Levand <geoffrey.levand at am.sony.com>
> ---
>  arch/powerpc/kernel/head_64.S |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -103,8 +103,8 @@ __secondary_hold_acknowledge:
>
>         . = 0x60
>  /*
> - * The following code is used on pSeries to hold secondary processors
> - * in a spin loop after they have been freed from OpenFirmware, but
> + * The following code is used to hold secondary processors
> + * in a spin loop after they have entered the kernel, but
>   * before the bulk of the kernel has been relocated.  This code
>   * is relocated to physical address 0x60 before prom_init is run.
>   * All of it must fit below the first exception vector at 0x100.
>

I don't like the resulting wording.  In particular, I don't like "after 
they have entered the kernel", as most of the kernel is not available 
to be entered.  In addition, the unchanged part of the comment refers 
to relocating from offset 0x60-0x100 to address 0x60, but in fact 
offset 0x0-0x100 is placed at address 0 (0x60 is just the entry point), 
and its done from within prom_init not before.

How does this text sound?

This code starting at offset 0x60 is used to hold secondary processors 
before the kernel has been relocated to its linked address.  Any 
platform or pre-boot environment may transfer secondary processors to 
the kernel by copying the first 0x100 bytes to address 0, and then 
instructing the secondary cpus to branch to address 0x60 after placing 
their hardware id (as specified by the device tree) in r3.  When 
booting from OpenFirmware using the client interface, the copy is 
performed by the boot cpu in prom_init and then the start-cpu method is 
used to transfer the cpus to this loop.  Although 
__secondary_hold_acknoledge is used serially to provide a positive 
handshake that each cpu has started, neither its address nor the 
protocol is considered part of the kernel entry ABI and should not be 
relied on by external code.  The code and data for the secondary cpus 
must be contained in bytes 0x4 - 0x100, that is before the first 
exception vector and after at least one instruction for the master 
entrypoint.

milton
