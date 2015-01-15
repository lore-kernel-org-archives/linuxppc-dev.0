Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B91F61A0D74
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:25:51 +1100 (AEDT)
Message-ID: <1421295950.11409.3.camel@ellerman.id.au>
Subject: Re: [PATCH] pseries/le: Fix endiannes issue in RTAS call from xmon
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 15:25:50 +1100
In-Reply-To: <1416838073-16642-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1416838073-16642-1-git-send-email-ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-24 at 15:07 +0100, Laurent Dufour wrote:
> On pseries system (LPAR) xmon failed to enter when running in LE mode, system
> is hunging. Inititating xmon will lead to such an output on the console:
> 
> SysRq : Entering xmon
> cpu 0x15: Vector: 0  at [c0000003f39ffb10]
>     pc: c00000000007ed7c: sysrq_handle_xmon+0x5c/0x70
>     lr: c00000000007ed7c: sysrq_handle_xmon+0x5c/0x70
>     sp: c0000003f39ffc70
>    msr: 8000000000009033
>   current = 0xc0000003fafa7180
>   paca    = 0xc000000007d75e80	 softe: 0	 irq_happened: 0x01
>     pid   = 14617, comm = bash
> Bad kernel stack pointer fafb4b0 at eca7cc4
> cpu 0x15: Vector: 300 (Data Access) at [c000000007f07d40]
>     pc: 000000000eca7cc4
>     lr: 000000000eca7c44
>     sp: fafb4b0
>    msr: 8000000000001000
>    dar: 10000000
>  dsisr: 42000000
>   current = 0xc0000003fafa7180
>   paca    = 0xc000000007d75e80	 softe: 0	 irq_happened: 0x01
>     pid   = 14617, comm = bash
> cpu 0x15: Exception 300 (Data Access) in xmon, returning to main loop
> xmon: WARNING: bad recursive fault on cpu 0x15
> 
> The root cause is that xmon is calling RTAS to turn off the surveillance
> when entering xmon, and RTAS is requiring big endian parameters.
> 
> This patch is byte swapping the RTAS arguments when running in LE mode.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/powerpc/xmon/xmon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index b988b5addf86..c8efbb37d6e0 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -293,10 +293,10 @@ static inline void disable_surveillance(void)
>  	args.token = rtas_token("set-indicator");
>  	if (args.token == RTAS_UNKNOWN_SERVICE)
>  		return;

I just noticed we're not handling the token correctly here. It is be32 also.

cheers
