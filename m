Return-Path: <mgreer@mvista.com>
Date: Tue, 10 Apr 2007 15:37:12 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: Disable external interrupts in bootwrapper
Message-ID: <20070410223712.GA7835@mag.az.mvista.com>
References: <20070327222840.GA1266@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070327222840.GA1266@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2007 at 03:28:40PM -0700, Mark A. Greer wrote:
> Disable external interrupts very early in the bootwrapper in case
> the firmware left a device generating interrupts.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> ---
> 
>  crt0.S |    6 ++++++
>  1 file changed, 6 insertions(+)
> ---
> 
> diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
> index 3dc8d8f..f048a46 100644
> --- a/arch/powerpc/boot/crt0.S
> +++ b/arch/powerpc/boot/crt0.S
> @@ -23,6 +23,12 @@ _zimage_start:
>  	   and the address where we're running. */
>  	bl	1f
>  1:	mflr	r0
> +	li	r9,(1<<15)@l	/* Disable external intrs (clear MSR[EE]) */
> +	mfmsr	r10
> +	andc	r10,r10,r9
> +	sync
> +	mtmsr	r10
> +	isync
>  	lis	r9,1b@ha
>  	addi	r9,r9,1b@l
>  	subf.	r0,r9,r0

Paul,

Just in case there is any doubt, please ignore this patch.
I can do what I need to do from my platform file.

Mark
