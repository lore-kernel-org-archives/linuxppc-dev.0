Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] PowerPC: kernel: compiling issue,
 make additional room in exception vector area
In-reply-to: <517918AB.4020508@asianux.com>
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <20130425062539.GA421@iris.ozlabs.ibm.com> <517918AB.4020508@asianux.com>
Date: Fri, 26 Apr 2013 09:16:08 +1000
Message-ID: <30269.1366931768@ale.ozlabs.ibm.com>
Cc: sfr@canb.auug.org.au, matt@ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Mike Qiu <qiudayu@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chen Gang <gang.chen@asianux.com> wrote:

> 
> When CONFIG_KVM_BOOK3S_64_PR is enabled,
> MASKABLE_EXCEPTION_PSERIES(0x900 ...) will includes __KVMTEST, it will
> exceed 0x980 which STD_EXCEPTION_HV(0x980 ...) will use, it will cause
> compiling issue.
> 
> The related errors:
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:258: Error: attempt to move .org backwards
> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
> 
> The position 0x900 and 0x980 are solid, so can not move the position
> to make room larger. The final solution is to jump to another area to
> execute the related code.
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index e789ee7..8997de2 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -254,7 +254,11 @@ hardware_interrupt_hv:
>  	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
>  	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
>  
> -	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
> +	. = 0x900
> +	.globl decrementer_pSeries
> +decrementer_pSeries:
> +	b	decrementer_pSeries_0
> +

Unfortunately you can't do this ether as we need to save the CFAR[1]
before it's overwritten by any branch. MASKABLE_EXCEPTION_PSERIES does
this.

CFAR is the Come From Register.  It saves the location of the last
branch and is hence overwritten by any branch.

Thanks for trying.

Mikey

>  	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
>  
>  	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
> @@ -536,6 +540,12 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
>  #endif
>  
>  	.align	7
> +	/* moved from 0x900 */
> +decrementer_pSeries_0:
> +	_MASKABLE_EXCEPTION_PSERIES(0x900, decrementer,
> +				    EXC_STD, SOFTEN_TEST_PR)
> +
> +	.align	7
>  	/* moved from 0xe00 */
>  	STD_EXCEPTION_HV_OOL(0xe02, h_data_storage)
>  	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0xe02)
> -- 
> 1.7.7.6
> 
> 
