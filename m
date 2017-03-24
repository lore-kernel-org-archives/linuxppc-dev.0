Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqBT6644zzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 16:15:38 +1100 (AEDT)
Message-ID: <1490332539.28113.63.camel@neuling.org>
Subject: Re: [PATCH v3 05/10] VAS: Define helpers to init window context
From: Michael Neuling <mikey@neuling.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 apopple@au1.ibm.com,  oohall@gmail.com
Date: Fri, 24 Mar 2017 16:15:39 +1100
In-Reply-To: <1489721642-5657-6-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-6-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> Define helpers to initialize window context registers of the VAS
> hardware. These will be used in follow-on patches when opening/closing
> VAS windows.
>=20
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog[v3]
> 	- Have caller, rather than init_xlate_regs() reset window regs
> 	=C2=A0=C2=A0so we don't reset any settings caller may already have set.
> 	- Translation mode should be 0x3 (0b11) not 0x11.
> 	- Skip initilaizing read-only registers NX_UTIL and NX_UTIL_SE
> 	- Skip initializing adder registers from UWC - they are already
> 	=C2=A0=C2=A0initialized from the HVWC.
> 	- Check winctx->user_win when setting translation registers
> ---
> =C2=A0drivers/misc/vas/vas-internal.h |=C2=A0=C2=A059 ++++++-
> =C2=A0drivers/misc/vas/vas-window.c=C2=A0=C2=A0=C2=A0| 334
> ++++++++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 390 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-inter=
nal.h
> index 15b62e0..8e721df 100644
> --- a/drivers/misc/vas/vas-internal.h
> +++ b/drivers/misc/vas/vas-internal.h
> @@ -11,6 +11,7 @@
> =C2=A0#define VAS_INTERNAL_H
> =C2=A0#include <linux/atomic.h>
> =C2=A0#include <linux/idr.h>
> +#include <linux/io.h>
> =C2=A0#include <asm/vas.h>
> =C2=A0
> =C2=A0#ifdef CONFIG_PPC_4K_PAGES
> @@ -336,9 +337,6 @@ struct vas_window {
> =C2=A0	/* Feilds applicable only to receive windows */
> =C2=A0	enum vas_cop_type cop;
> =C2=A0	atomic_t num_txwins;
> -
> -	int32_t hwirq;
> -	uint64_t irq_port;

We are removing things already? :-)

> =C2=A0};
> =C2=A0
> =C2=A0/*
> @@ -392,4 +390,59 @@ struct vas_winctx {
> =C2=A0extern int vas_initialized;
> =C2=A0extern int vas_window_reset(struct vas_instance *vinst, int winid);
> =C2=A0extern struct vas_instance *find_vas_instance(int vasid);
> +
> +/*
> + * VREG(x):
> + * Expand a register's short name (eg: LPID) into two parameters:
> + *	- the register's short name in string form ("LPID"), and
> + *	- the name of the macro (eg: VAS_LPID_OFFSET), defining the
> + *	=C2=A0=C2=A0register's offset in the window context
> + */
> +#define VREG_SFX(n, s)	__stringify(n), VAS_##n##s
> +#define VREG(r)		VREG_SFX(r, _OFFSET)
> +
> +#ifndef vas_debug
> +static inline void vas_log_write(struct vas_window *win, char *name,
> +			void *regptr, uint64_t val)
> +{
> +	if (val)
> +		pr_err("%swin #%d: %s reg %p, val 0x%llx\n",
> +				win->tx_win ? "Tx" : "Rx", win->winid, name,
> +				regptr, val);
> +}
> +
> +#else	/* vas_debug */
> +
> +#define vas_log_write(win, name, reg, val)
> +
> +#endif	/* vas_debug */
> +
> +static inline void write_uwc_reg(struct vas_window *win, char *name,
> +			int32_t reg, uint64_t val)
> +{
> +	void *regptr;
> +
> +	regptr =3D win->uwc_map + reg;
> +	vas_log_write(win, name, regptr, val);
> +
> +	out_be64(regptr, val);
> +}
> +
> +static inline void write_hvwc_reg(struct vas_window *win, char *name,
> +			int32_t reg, uint64_t val)
> +{
> +	void *regptr;
> +
> +	regptr =3D win->hvwc_map + reg;
> +	vas_log_write(win, name, regptr, val);
> +
> +	out_be64(regptr, val);
> +}
> +
> +static inline uint64_t read_hvwc_reg(struct vas_window *win,
> +			char *name __maybe_unused, int32_t reg)
> +{
> +	return in_be64(win->hvwc_map+reg);
> +}
> +
> =C2=A0#endif
> diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.=
c
> index 32dd1d0..edf5c9f 100644
> --- a/drivers/misc/vas/vas-window.c
> +++ b/drivers/misc/vas/vas-window.c
> @@ -14,6 +14,8 @@
> =C2=A0#include <asm/vas.h>
> =C2=A0#include "vas-internal.h"
> =C2=A0
> +static int fault_winid;
> +
> =C2=A0/*
> =C2=A0 * Compute the paste address region for the window @window using th=
e
> =C2=A0 * ->win_base_addr and ->win_id_shift we got from device tree.
> @@ -138,6 +140,338 @@ int map_wc_mmio_bars(struct vas_window *window)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * Reset all valid registers in the HV and OS/User Window Contexts for
> + * the window identified by @window.
> + *
> + * NOTE: We cannot really use a for loop to reset window context. Not al=
l
> + *	=C2=A0offsets in a window context are valid registers and the valid
> + *	=C2=A0registers are not sequential. And, we can only write to offsets
> + *	=C2=A0with valid registers (or is that only in Simics?).
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
> +	=C2=A0* The send and receive window credit adder registers are also
> +	=C2=A0* accessible from HVWC and have been initialized above. We don't
> +	=C2=A0* need to initialize from the OS/User Window Context, so skip
> +	=C2=A0* following calls:
> +	=C2=A0*
> +	=C2=A0*	write_uwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
> +	=C2=A0*	write_uwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
> +	=C2=A0*/
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
> +	uint64_t lpcr, msr, val;
> +
> +	msr =3D mfmsr();
> +	WARN_ON_ONCE(!(msr & MSR_SF));

We don't support 32 bit userspace?  I would return an error rather than thi=
s.

> +
> +	val =3D 0ULL;
> +	if (user_win) {
> +		val =3D SET_FIELD(VAS_XLATE_MSR_DR, val, true);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_TA, val, false);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_PR, val, true);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_US, val, false);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_HV, val, true);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_SF, val, true);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_UV, val, false);
> +	} else {
> +		val =3D SET_FIELD(VAS_XLATE_MSR_DR, val, false);

kernel contexts don't go through the nestmmu?

> +		val =3D SET_FIELD(VAS_XLATE_MSR_TA, val, false);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_PR, val, msr & MSR_PR);

I don't understand this.  It should just be 0 for the kernel.

> +		val =3D SET_FIELD(VAS_XLATE_MSR_US, val, false);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_HV, val, true);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_SF, val, true);
> +		val =3D SET_FIELD(VAS_XLATE_MSR_UV, val, false);
> +	}
> +	write_hvwc_reg(window, VREG(XLATE_MSR), val);
> +
> +	lpcr =3D mfspr(SPRN_LPCR);
> +	val =3D 0ULL;
> +	/*
> +	=C2=A0* NOTE: From Section 5.7.6.1 Segment Lookaside Buffer of the
> +	=C2=A0*	=C2=A0Power ISA, v2.07, Page size encoding is 0 =3D 4KB, 5 =3D =
64KB.
> +	=C2=A0*
> +	=C2=A0* NOTE: From Section 1.3.1, Address Translation Context of the
> +	=C2=A0*	=C2=A0Nest MMU Workbook, LPCR_SC should be 0 for Power9.
> +	=C2=A0*/
> +	val =3D SET_FIELD(VAS_XLATE_LPCR_PAGE_SIZE, val, 5);
> +	val =3D SET_FIELD(VAS_XLATE_LPCR_ISL, val, lpcr & LPCR_ISL);
> +	val =3D SET_FIELD(VAS_XLATE_LPCR_TC, val, lpcr & LPCR_TC);
> +	val =3D SET_FIELD(VAS_XLATE_LPCR_SC, val, 0);
> +	write_hvwc_reg(window, VREG(XLATE_LPCR), val);
> +
> +	/*
> +	=C2=A0* Section 1.3.1 (Address translation Context) of NMMU workbook.
> +	=C2=A0*	0b00	Hashed Page Table mode
> +	=C2=A0*	0b01	Reserved
> +	=C2=A0*	0b10	Radix on HPT - not supported in P9
> +	=C2=A0*	0b11	Radix on Radix (only mode supported in Linux on
> P9).

Linux supports hash on P9.

Does VAS only support radix?  If so you should error out if we are booted h=
ash.

> +	=C2=A0*/
> +	val =3D 0ULL;
> +	val =3D SET_FIELD(VAS_XLATE_MODE, val, 0x3);

You can use radix_enabled() to set this for hash vs radix.

> +	write_hvwc_reg(window, VREG(XLATE_CTL), val);
> +
> +	/*
> +	=C2=A0* TODO: Can we mfspr(AMR) even for user windows?
> +	=C2=A0*/
> +	val =3D 0ULL;
> +	val =3D SET_FIELD(VAS_AMR, val, mfspr(SPRN_AMR));
> +	write_hvwc_reg(window, VREG(AMR), val);
> +
> +	/*
> +	=C2=A0* TODO: Assuming Secure Executable ID Register (SEIDR) is only us=
ed
> +	=C2=A0*	=C2=A0in the ultravisor mode. Since MSR(UV) is 0 for now, set
> SEIDR
> +	=C2=A0*	=C2=A0to 0 as well, although we should 'mfspr(SEIDR)' at some
> point.
> +	=C2=A0*/
> +	val =3D 0ULL;
> +	val =3D SET_FIELD(VAS_SEIDR, val, 0);
> +	write_hvwc_reg(window, VREG(SEIDR), val);
> +}
> +
> +/*
> + * Initialize Reserved Send Buffer Count for the send window. It involve=
s
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
> + * Compute the log2() of the FIFO size expressed as kilobytes. It is int=
ended
> + * to be used to initialize the Local FIFO Size Register defined in Sect=
ion
> + * 3.14.25 of the VAS Workbook.

There is a ilog2() function..

> + */
> +static int map_fifo_size_to_reg(int fifo_size)
> +{
> +	int kb;
> +	int map;
> +
> +	kb =3D fifo_size / 1024;
> +	if (!kb)
> +		kb =3D 1;
> +
> +	map =3D -1;
> +	while (kb) {
> +		kb >>=3D 1;
> +		map++;
> +	}
> +
> +	return map;
> +}
> +
