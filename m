Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdwkv17nfzDrTT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 19:25:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/12] powerpc/vas: Define helpers to init window
 context
In-Reply-To: <1503556688-15412-6-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-6-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 19:25:54 +1000
Message-ID: <87bmn4uhgd.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> index a3a705a..3a50d6a 100644
> --- a/arch/powerpc/platforms/powernv/vas-window.c
> +++ b/arch/powerpc/platforms/powernv/vas-window.c
> @@ -11,6 +11,7 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> +#include <linux/log2.h>
>  
>  #include "vas.h"
>  
> @@ -185,6 +186,310 @@ int map_winctx_mmio_bars(struct vas_window *window)
>  	return 0;
>  }
>  
> +/*
> + * Reset all valid registers in the HV and OS/User Window Contexts for
> + * the window identified by @window.
> + *
> + * NOTE: We cannot really use a for loop to reset window context. Not all
> + *	 offsets in a window context are valid registers and the valid
> + *	 registers are not sequential. And, we can only write to offsets
> + *	 with valid registers (or is that only in Simics?).

I assume there's no "reset everything" register we can write to do this
for us?

Also if you can clean up the comment to not mention Simics, I would
assume that applies on real hardware too.

> + */
> +void reset_window_regs(struct vas_window *window)
> +{
> +	write_hvwc_reg(window, VREG(LPID), 0ULL);
> +	write_hvwc_reg(window, VREG(PID), 0ULL);
> +	write_hvwc_reg(window, VREG(XLATE_MSR), 0ULL);
> +	write_hvwc_reg(window, VREG(XLATE_LPCR), 0ULL);
> +	write_hvwc_reg(window, VREG(XLATE_CTL), 0ULL);
> +	write_hvwc_reg(window, VREG(AMR), 0ULL);
> +	write_hvwc_reg(window, VREG(SEIDR), 0ULL);
> +	write_hvwc_reg(window, VREG(FAULT_TX_WIN), 0ULL);
> +	write_hvwc_reg(window, VREG(OSU_INTR_SRC_RA), 0ULL);
> +	write_hvwc_reg(window, VREG(HV_INTR_SRC_RA), 0ULL);
> +	write_hvwc_reg(window, VREG(PSWID), 0ULL);
> +	write_hvwc_reg(window, VREG(SPARE1), 0ULL);
> +	write_hvwc_reg(window, VREG(SPARE2), 0ULL);
> +	write_hvwc_reg(window, VREG(SPARE3), 0ULL);
> +	write_hvwc_reg(window, VREG(SPARE4), 0ULL);
> +	write_hvwc_reg(window, VREG(SPARE5), 0ULL);
> +	write_hvwc_reg(window, VREG(SPARE6), 0ULL);

Should we be writing to spare registers? Presumably in a future hardware
revision they might have some unknown purpose.

> +	write_hvwc_reg(window, VREG(LFIFO_BAR), 0ULL);
> +	write_hvwc_reg(window, VREG(LDATA_STAMP_CTL), 0ULL);
> +	write_hvwc_reg(window, VREG(LDMA_CACHE_CTL), 0ULL);
> +	write_hvwc_reg(window, VREG(LRFIFO_PUSH), 0ULL);
> +	write_hvwc_reg(window, VREG(CURR_MSG_COUNT), 0ULL);
> +	write_hvwc_reg(window, VREG(LNOTIFY_AFTER_COUNT), 0ULL);
> +	write_hvwc_reg(window, VREG(LRX_WCRED), 0ULL);
> +	write_hvwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
> +	write_hvwc_reg(window, VREG(TX_WCRED), 0ULL);
> +	write_hvwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
> +	write_hvwc_reg(window, VREG(LFIFO_SIZE), 0ULL);
> +	write_hvwc_reg(window, VREG(WINCTL), 0ULL);
> +	write_hvwc_reg(window, VREG(WIN_STATUS), 0ULL);
> +	write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), 0ULL);
> +	write_hvwc_reg(window, VREG(TX_RSVD_BUF_COUNT), 0ULL);
> +	write_hvwc_reg(window, VREG(LRFIFO_WIN_PTR), 0ULL);
> +	write_hvwc_reg(window, VREG(LNOTIFY_CTL), 0ULL);
> +	write_hvwc_reg(window, VREG(LNOTIFY_PID), 0ULL);
> +	write_hvwc_reg(window, VREG(LNOTIFY_LPID), 0ULL);
> +	write_hvwc_reg(window, VREG(LNOTIFY_TID), 0ULL);
> +	write_hvwc_reg(window, VREG(LNOTIFY_SCOPE), 0ULL);
> +	write_hvwc_reg(window, VREG(NX_UTIL_ADDER), 0ULL);
> +
> +	/* Skip read-only registers: NX_UTIL and NX_UTIL_SE */
> +
> +	/*
> +	 * The send and receive window credit adder registers are also
> +	 * accessible from HVWC and have been initialized above. We don't
> +	 * need to initialize from the OS/User Window Context, so skip
> +	 * following calls:
> +	 *
> +	 *	write_uwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
> +	 *	write_uwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
> +	 */
> +}
> +
> +/*
> + * Initialize window context registers related to Address Translation.
> + * These registers are common to send/receive windows although they
> + * differ for user/kernel windows. As we resolve the TODOs we may
> + * want to add fields to vas_winctx and move the initialization to
> + * init_vas_winctx_regs().
> + */
> +static void init_xlate_regs(struct vas_window *window, bool user_win)
> +{
> +	uint64_t lpcr, val;
> +
> +	/*
> +	 * MSR_TA, MSR_US are false for both kernel and user.
> +	 * MSR_DR and MSR_PR are false for kernel.
> +	 */
> +	val = 0ULL;
> +	val = SET_FIELD(VAS_XLATE_MSR_HV, val, true);

Using a bool here presumably works, but if you actually wrote:

  ((u64)true << VAS_XLATE_MSR_HV)

It would look pretty weird. Using an int would be more normal.

> +	val = SET_FIELD(VAS_XLATE_MSR_SF, val, true);
> +	if (user_win) {
> +		val = SET_FIELD(VAS_XLATE_MSR_DR, val, true);
> +		val = SET_FIELD(VAS_XLATE_MSR_PR, val, true);
> +	}
> +	write_hvwc_reg(window, VREG(XLATE_MSR), val);
> +
> +	lpcr = mfspr(SPRN_LPCR);
> +	val = 0ULL;
> +	/*
> +	 * NOTE: From Section 5.7.6.1 Segment Lookaside Buffer of the
> +	 *	 Power ISA, v2.07, Page size encoding is 0 = 4KB, 5 = 64KB.

Which is 5.7.8.1 in ISA v3.0B.

> +	 *
> +	 * NOTE: From Section 1.3.1, Address Translation Context of the
> +	 *	 Nest MMU Workbook, LPCR_SC should be 0 for Power9.
> +	 */
> +	val = SET_FIELD(VAS_XLATE_LPCR_PAGE_SIZE, val, 5);
> +	val = SET_FIELD(VAS_XLATE_LPCR_ISL, val, lpcr & LPCR_ISL);
> +	val = SET_FIELD(VAS_XLATE_LPCR_TC, val, lpcr & LPCR_TC);
> +	val = SET_FIELD(VAS_XLATE_LPCR_SC, val, 0);
> +	write_hvwc_reg(window, VREG(XLATE_LPCR), val);
> +
> +	/*
> +	 * Section 1.3.1 (Address translation Context) of NMMU workbook.
> +	 *	0b00	Hashed Page Table mode
> +	 *	0b01	Reserved
> +	 *	0b10	Radix on HPT
> +	 *	0b11	Radix on Radix
> +	 */
> +	val = 0ULL;
> +	val = SET_FIELD(VAS_XLATE_MODE, val, radix_enabled() ? 3 : 2);
> +	write_hvwc_reg(window, VREG(XLATE_CTL), val);
> +
> +	/*
> +	 * TODO: Can we mfspr(AMR) even for user windows?
> +	 */
> +	val = 0ULL;
> +	val = SET_FIELD(VAS_AMR, val, mfspr(SPRN_AMR));
> +	write_hvwc_reg(window, VREG(AMR), val);
> +
> +	val = 0ULL;
> +	val = SET_FIELD(VAS_SEIDR, val, 0);
> +	write_hvwc_reg(window, VREG(SEIDR), val);
> +}
> +
> +/*
> + * Initialize Reserved Send Buffer Count for the send window. It involves
> + * writing to the register, reading it back to confirm that the hardware
> + * has enough buffers to reserve. See section 1.3.1.2.1 of VAS workbook.
> + *
> + * Since we can only make a best-effort attempt to fulfill the request,
> + * we don't return any errors if we cannot.
> + *
> + * TODO: Reserved (aka dedicated) send buffers are not supported yet.
> + */
> +static void init_rsvd_tx_buf_count(struct vas_window *txwin,
> +				struct vas_winctx *winctx)
> +{
> +	write_hvwc_reg(txwin, VREG(TX_RSVD_BUF_COUNT), 0ULL);
> +}
> +
> +/*
> + * init_winctx_regs()
> + *	Initialize window context registers for a receive window.
> + *	Except for caching control and marking window open, the registers
> + *	are initialized in the order listed in Section 3.1.4 (Window Context
> + *	Cache Register Details) of the VAS workbook although they don't need
> + *	to be.
> + *
> + * Design note: For NX receive windows, NX allocates the FIFO buffer in OPAL
> + *	(so that it can get a large contiguous area) and passes that buffer
> + *	to kernel via device tree. We now write that buffer address to the
> + *	FIFO BAR. Would it make sense to do this all in OPAL? i.e have OPAL
> + *	write the per-chip RX FIFO addresses to the windows during boot-up
> + *	as a one-time task? That could work for NX but what about other
> + *	receivers?  Let the receivers tell us the rx-fifo buffers for now.

Why did we do it that way?

If I'm reading the skiboot code right, the "large contiguous area" is 32K.

That's less than a single page?!


cheers
