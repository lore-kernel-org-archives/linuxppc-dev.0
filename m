Return-Path: <michael@ozlabs.org>
In-Reply-To: <1389916434-2288-4-git-send-email-cody@linux.vnet.ibm.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/8] powerpc: add hvcalls for 24x7 and gpci (get
 performance counter info)
Message-Id: <20140201055806.A25152C00B2@ozlabs.org>
Date: Sat,  1 Feb 2014 16:58:06 +1100 (EST)
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-16-01 at 23:53:49 UTC, Cody P Schafer wrote:
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hvcall.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index d8b600b..48d6efa 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -269,11 +269,15 @@
>  #define H_COP			0x304
>  #define H_GET_MPP_X		0x314
>  #define H_SET_MODE		0x31C
> -#define MAX_HCALL_OPCODE	H_SET_MODE
> +#define H_GET_24X7_CATALOG_PAGE 0xF078
> +#define H_GET_24X7_DATA		0xF07C
> +#define H_GET_PERF_COUNTER_INFO 0xF080

Ugh, why the hell did they put them up there.

> +#define MAX_HCALL_OPCODE	H_GET_PERF_COUNTER_INFO

We have an array which is sized based on this, which is unpleasant.

I think you're better off putting these below in the platform specific section,
and leaving MAX_HCALL_OPCODE alone. The only downside is you can't use the
hcall tracing to see them.

>  /* Platform specific hcalls, used by KVM */
>  #define H_RTAS			0xf000


cheers
