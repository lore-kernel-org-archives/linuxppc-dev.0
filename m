Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKtD70P9fzDsyc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 20:36:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH 4/4] powerpc: mm/slb: blacklist symbols from kprobe
In-Reply-To: <a599d736aa7323a767fd62e1af33b99b235aed39.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <a599d736aa7323a767fd62e1af33b99b235aed39.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Fri, 18 Nov 2016 20:36:22 +1100
Message-ID: <87shqpgmeh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> We can't really take a trap at this point. So, blacklist these symbols.
>
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/slb_low.S | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index c1c7456..c2bae92 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -30,7 +30,7 @@
>   *	r9, r10, r11 are clobbered by this function
>   * No other registers are examined or changed.
>   */
> -_GLOBAL(slb_allocate_realmode)
> +_GLOBAL_NOKPROBE(slb_allocate_realmode)

I think I'd prefer we just leave these as is, and add somewhere nearby:

_ASM_NOKPROBE_SYMBOL(slb_allocate_realmode)


It means someone reading the code doesn't need to worry about the
nokprobe part, just to understand the function. It also means we need
fewer macros :)

cheers
