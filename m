Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbcKQ2KgXzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 21:58:02 +1000 (AEST)
Message-ID: <1466769468.11733.106.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/boot: Add OPAL console to epapr wrappers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, stable@vger.kernel.org
Date: Fri, 24 Jun 2016 21:57:48 +1000
In-Reply-To: <1466754085-8230-1-git-send-email-oohall@gmail.com>
References: <1466754085-8230-1-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-24 at 17:41 +1000, Oliver O'Halloran wrote:
> This patch adds an OPAL console backend to the powerpc boot wrapper
> so
> that decompression failures inside the wrapper can be reported to the
> user. This is important since it typically indicates data corruption
> in
> the firmware and other nasty things.
> 
> Currently this only works when building a little endian kernel. When
> compiling a 64 bit BE kernel the wrapper is always build 32 bit to be
> compatible with some 32 bit firmwares. BE support will be added at a
> later date. Another limitation of this is that only the "raw" type of
> OPAL console is supported, however machines that provide a hvsi
> console
> also provide a raw console so this is not an issue in practice.

You forgot to git-add the new files ?

Cheers,
Ben.

> Actually-written-by: Benjamin Herrenschmidt <benh@kernel.crashing.org
> >
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/powerpc/boot/Makefile  |  4 ++--
>  arch/powerpc/boot/ops.h     |  1 +
>  arch/powerpc/boot/ppc_asm.h |  4 ++++
>  arch/powerpc/boot/serial.c  |  2 ++
>  arch/powerpc/boot/types.h   | 12 ++++++++++++
>  5 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 8fe78a3efc92..00cf88aa9a23 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -70,7 +70,7 @@ $(addprefix $(obj)/,$(zlib) cuboot-c2k.o
> gunzip_util.o main.o): \
>  libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c
> fdt_strerror.c
>  libfdtheader := fdt.h libfdt.h libfdt_internal.h
>  
> -$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o
> epapr.o): \
> +$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o
> opal.o): \
>  	$(addprefix $(obj)/,$(libfdtheader))
>  
>  src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
> @@ -78,7 +78,7 @@ src-wlib-y := string.S crt0.S crtsavres.S stdio.c
> main.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
>  		gunzip_util.c elf_util.c $(zlib) devtree.c stdlib.c
> \
>  		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
> -		uartlite.c mpc52xx-psc.c
> +		uartlite.c mpc52xx-psc.c opal.c opal-calls.S
>  src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
>  src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
>  src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c fsl-soc.c
> diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
> index 5e75e1c5518e..e19b64ef977a 100644
> --- a/arch/powerpc/boot/ops.h
> +++ b/arch/powerpc/boot/ops.h
> @@ -89,6 +89,7 @@ int mpsc_console_init(void *devp, struct
> serial_console_data *scdp);
>  int cpm_console_init(void *devp, struct serial_console_data *scdp);
>  int mpc5200_psc_console_init(void *devp, struct serial_console_data
> *scdp);
>  int uartlite_console_init(void *devp, struct serial_console_data
> *scdp);
> +int opal_console_init(void *devp, struct serial_console_data *scdp);
>  void *simple_alloc_init(char *base, unsigned long heap_size,
>  			unsigned long granularity, unsigned long
> max_allocs);
>  extern void flush_cache(void *, unsigned long);
> diff --git a/arch/powerpc/boot/ppc_asm.h
> b/arch/powerpc/boot/ppc_asm.h
> index 35ea60c1f070..b03373d8b386 100644
> --- a/arch/powerpc/boot/ppc_asm.h
> +++ b/arch/powerpc/boot/ppc_asm.h
> @@ -61,6 +61,10 @@
>  
>  #define SPRN_TBRL	268
>  #define SPRN_TBRU	269
> +#define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0
> */
> +#define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1
> */
> +
> +#define MSR_LE		0x0000000000000001
>  
>  #define FIXUP_ENDIAN						
>    \
>  	tdi   0, 0, 0x48; /* Reverse endian of b . + 8		
> */ \
> diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
> index 167ee9433de6..e04c1e4063ae 100644
> --- a/arch/powerpc/boot/serial.c
> +++ b/arch/powerpc/boot/serial.c
> @@ -132,6 +132,8 @@ int serial_console_init(void)
>  	else if (dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b")
> ||
>  		 dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
>  		rc = uartlite_console_init(devp, &serial_cd);
> +	else if (dt_is_compatible(devp, "ibm,opal-console-raw"))
> +		rc = opal_console_init(devp, &serial_cd);
>  
>  	/* Add other serial console driver calls here */
>  
> diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
> index 31393d17a9c1..cda474cd63c8 100644
> --- a/arch/powerpc/boot/types.h
> +++ b/arch/powerpc/boot/types.h
> @@ -12,6 +12,18 @@ typedef short			s16;
>  typedef int			s32;
>  typedef long long		s64;
>  
> +
> +/* required for opal-api.h */
> +typedef u8  uint8_t;
> +typedef u16 uint16_t;
> +typedef u32 uint32_t;
> +typedef u64 uint64_t;
> +typedef s8  int8_t;
> +typedef s16 int16_t;
> +typedef s32 int32_t;
> +typedef s64 int64_t;
> +
> +
>  #define min(x,y) ({ \
>  	typeof(x) _x = (x);	\
>  	typeof(y) _y = (y);	\
