Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 73984679FB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 09:06:34 +1000 (EST)
Date: Mon, 7 Aug 2006 18:06:06 -0500
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [RFC] Debugging with a HW probe.
Message-ID: <20060807230606.GC11805@pb15.lixom.net>
References: <E1G9jpY-0004Nv-2d@kmac.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1G9jpY-0004Nv-2d@kmac.watson.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Sun, Aug 06, 2006 at 10:42:16AM -0400, Jimi Xenidis wrote:

> On IBM POWER4 and greater processors (and possibly POWER3 and *Star)
> there is an instruction called ATTN (asm (".long 0x200")) that will
> have the process call out to the HW probe.  This instruction is used
> by RiscWatch software to set "soft breakpoints".
> 
> We have found it useful to teach xmon to make this call so we can then
> debug the SW thru the probe. Is this useful to anyone else?

Being able to correlate software events with the hardware debugger looks
quite useful, yes.

> Below is a quick attempt at a formalized patch, tho' I am torn between
> making it ATTN specific or just making a generic HW Probe Service.

I would say make it generic, maybe with cputables entry or ppc_md
member, especially with the powerpc merge and other platforms coming in,
having it more generic could be useful.

Also, that way you could get rid of the PVR check within xmon.

> All comments welcome.

A couple below.

> +static void xmon_en_hw_probe(int enable)
> +{
> +	ulong hid0;
> +	int threaded = 0;
> +
> +	/* hopefully the hypervisor has set us up */
> +	if (firmware_has_feature(FW_FEATURE_LPAR))
> +		return;
> +	/* should this be a feature? */
> +	switch (PVR_VER(mfspr(SPRN_PVR))) {
> +	default:
> +		return;
> +
> +	case PV_POWER4:
> +	case PV_POWER4p:
> +	case PV_POWER5:
> +	case PV_POWER5p:
> +	case PV_BE:
> +		/* stop both threads */
> +		threaded = 1;

POWER4 multithreaded? I don't think so?

> +	case PV_SSTAR:		

Trailing whitespace. Also, doesn't sstar have HMT?

> +	case PV_970:
> +	case PV_970FX:
> +	case PV_970MP:
> +		break;
> +	}
> +	hid0 = mfspr(SPRN_HID0);
> +	if (enable) {
> +		/* make sure that on threaded processors we stop both
> +		 * threads */
> +		hid0 |= HID0_ATTN | (threaded ? HID0_QATTN : 0);
> +		xmon_hw_probe_enabled = 1;
> +	} else {
> +		/* only turn the feature off */
> +		hid0 &= ~HID0_ATTN;
> +		xmon_hw_probe_enabled = 0;
> +	}
> +	/* many processors require the following sequence */
> +	asm volatile(
> +		"sync\n"
> +		"mtspr     %1, %0\n"
> +		"mfspr     %0, %1\n"
> +		"mfspr     %0, %1\n"
> +		"mfspr     %0, %1\n"
> +		"mfspr     %0, %1\n"
> +		"mfspr     %0, %1\n"
> +		"mfspr     %0, %1\n"
> +		"isync" : "=&r" (hid0) : "i" (SPRN_HID0), "0" (hid0):
> +		"memory");
> +}
> +#else
> +#define xmon_en_hw_probe(x)
> +#endif
> +
>  static inline void sync(void)
>  {
>  	asm volatile("sync; isync");
> @@ -834,6 +904,11 @@ #ifdef CONFIG_PPC_STD_MMU
>  			dump_segments();
>  			break;
>  #endif
> +#ifdef CONFIG_XMON_ATTN
> +		case 'A':
> +			xmon_hw_probe();
> +			break;
> +#endif
>  		default:
>  			printf("Unrecognized command: ");
>  		        do {
> @@ -2565,6 +2640,7 @@ void xmon_init(int enable)
>  		__debugger_dabr_match = NULL;
>  		__debugger_fault_handler = NULL;
>  	}
> +	xmon_en_hw_probe(enable);

Please only enable this right before the call.

>  	xmon_map_scc();
>  }
>  
> diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
> index 2ea66ac..33a7922 100644
> diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
> index bd467bf..ce82965 100644
> --- a/include/asm-powerpc/reg.h
> +++ b/include/asm-powerpc/reg.h
> @@ -207,6 +207,8 @@ #define SPRN_EAR	0x11A		/* External Addr
>  #define SPRN_HASH1	0x3D2		/* Primary Hash Address Register */
>  #define SPRN_HASH2	0x3D3		/* Secondary Hash Address Resgister */
>  #define SPRN_HID0	0x3F0		/* Hardware Implementation Register 0 */
> +#define HID0_QATTN	(1UL<<35)	/* Sup. Proc. attn insn all threads */
> +#define HID0_ATTN	(1UL<<32)	/* Sup. Proc. attn insn */
>  #define HID0_EMCP	(1<<31)		/* Enable Machine Check pin */
>  #define HID0_EBA	(1<<29)		/* Enable Bus Address Parity */
>  #define HID0_EBD	(1<<28)		/* Enable Bus Data Parity */
> diff --git a/include/asm-powerpc/xmon.h b/include/asm-powerpc/xmon.h
> index 43f7129..cd8f48e 100644
> --- a/include/asm-powerpc/xmon.h
> +++ b/include/asm-powerpc/xmon.h
> @@ -8,5 +8,12 @@ extern int xmon(struct pt_regs *excp);
>  extern void xmon_printf(const char *fmt, ...);
>  extern void xmon_init(int);
>  
> +/*
> + * Support Processor Attention Instruction introduced in POWER
> + * architecture processors as of RS64, tho may not be supported by
> + * POWER 3.
> + */
> +#define ATTN() asm volatile(".long 0x00000200; nop")

At least my toolchain understands "attn ; nop"?



-Olof
