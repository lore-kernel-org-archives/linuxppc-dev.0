Return-Path: <srs0=h86y=3b=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqcVN1QbJzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:48:12 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vqcVN0nPSz8t6y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:48:12 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vqcVM4qlQz9s78
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2017 08:48:11 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2OLhVCs105644
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 17:48:04 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29daxs1mcf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 17:48:04 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 17:48:02 -0400
Date: Fri, 24 Mar 2017 14:47:57 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v3 05/10] VAS: Define helpers to init window context
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490332539.28113.63.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1490332539.28113.63.camel@neuling.org>
Message-Id: <20170324214757.GE8330@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [mikey@neuling.org] wrote:
> On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> > =A0#ifdef CONFIG_PPC_4K_PAGES
> > @@ -336,9 +337,6 @@ struct vas_window {
> > =A0	/* Feilds applicable only to receive windows */
> > =A0	enum vas_cop_type cop;
> > =A0	atomic_t num_txwins;
> > -
> > -	int32_t hwirq;
> > -	uint64_t irq_port;
>=20
> We are removing things already? :-)

:-) They are needed when we add support for user windows will
remove them in the earlier patch.=20

>=20
> > =A0};
> > =A0
> > =A0/*
> > @@ -392,4 +390,59 @@ struct vas_winctx {
> > =A0extern int vas_initialized;
> > =A0extern int vas_window_reset(struct vas_instance *vinst, int winid);
> > =A0extern struct vas_instance *find_vas_instance(int vasid);
> > +
> > +/*
> > + * VREG(x):
> > + * Expand a register's short name (eg: LPID) into two parameters:
> > + *	- the register's short name in string form ("LPID"), and
> > + *	- the name of the macro (eg: VAS_LPID_OFFSET), defining the
> > + *	=A0=A0register's offset in the window context
> > + */
> > +#define VREG_SFX(n, s)	__stringify(n), VAS_##n##s
> > +#define VREG(r)		VREG_SFX(r, _OFFSET)
> > +
> > +#ifndef vas_debug
> > +static inline void vas_log_write(struct vas_window *win, char *name,
> > +			void *regptr, uint64_t val)
> > +{
> > +	if (val)
> > +		pr_err("%swin #%d: %s reg %p, val 0x%llx\n",
> > +				win->tx_win ? "Tx" : "Rx", win->winid, name,
> > +				regptr, val);
> > +}
> > +
> > +#else	/* vas_debug */
> > +
> > +#define vas_log_write(win, name, reg, val)
> > +
> > +#endif	/* vas_debug */
> > +
> > +static inline void write_uwc_reg(struct vas_window *win, char *name,
> > +			int32_t reg, uint64_t val)
> > +{
> > +	void *regptr;
> > +
> > +	regptr =3D win->uwc_map + reg;
> > +	vas_log_write(win, name, regptr, val);
> > +
> > +	out_be64(regptr, val);
> > +}
> > +
> > +static inline void write_hvwc_reg(struct vas_window *win, char *name,
> > +			int32_t reg, uint64_t val)
> > +{
> > +	void *regptr;
> > +
> > +	regptr =3D win->hvwc_map + reg;
> > +	vas_log_write(win, name, regptr, val);
> > +
> > +	out_be64(regptr, val);
> > +}
> > +
> > +static inline uint64_t read_hvwc_reg(struct vas_window *win,
> > +			char *name __maybe_unused, int32_t reg)
> > +{
> > +	return in_be64(win->hvwc_map+reg);
> > +}
> > +
> > =A0#endif
> > diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-windo=
w.c
> > index 32dd1d0..edf5c9f 100644
> > --- a/drivers/misc/vas/vas-window.c
> > +++ b/drivers/misc/vas/vas-window.c
> > @@ -14,6 +14,8 @@
> > =A0#include <asm/vas.h>
> > =A0#include "vas-internal.h"
> > =A0
> > +static int fault_winid;
> > +
> > =A0/*
> > =A0 * Compute the paste address region for the window @window using the
> > =A0 * ->win_base_addr and ->win_id_shift we got from device tree.
> > @@ -138,6 +140,338 @@ int map_wc_mmio_bars(struct vas_window *window)
> > =A0	return 0;
> > =A0}
> > =A0
> > +/*
> > + * Reset all valid registers in the HV and OS/User Window Contexts for
> > + * the window identified by @window.
> > + *
> > + * NOTE: We cannot really use a for loop to reset window context. Not =
all
> > + *	=A0offsets in a window context are valid registers and the valid
> > + *	=A0registers are not sequential. And, we can only write to offsets
> > + *	=A0with valid registers (or is that only in Simics?).
> > + */
> > +void reset_window_regs(struct vas_window *window)
> > +{
> > +	write_hvwc_reg(window, VREG(LPID), 0ULL);
> > +	write_hvwc_reg(window, VREG(PID), 0ULL);
> > +	write_hvwc_reg(window, VREG(XLATE_MSR), 0ULL);
> > +	write_hvwc_reg(window, VREG(XLATE_LPCR), 0ULL);
> > +	write_hvwc_reg(window, VREG(XLATE_CTL), 0ULL);
> > +	write_hvwc_reg(window, VREG(AMR), 0ULL);
> > +	write_hvwc_reg(window, VREG(SEIDR), 0ULL);
> > +	write_hvwc_reg(window, VREG(FAULT_TX_WIN), 0ULL);
> > +	write_hvwc_reg(window, VREG(OSU_INTR_SRC_RA), 0ULL);
> > +	write_hvwc_reg(window, VREG(HV_INTR_SRC_RA), 0ULL);
> > +	write_hvwc_reg(window, VREG(PSWID), 0ULL);
> > +	write_hvwc_reg(window, VREG(SPARE1), 0ULL);
> > +	write_hvwc_reg(window, VREG(SPARE2), 0ULL);
> > +	write_hvwc_reg(window, VREG(SPARE3), 0ULL);
> > +	write_hvwc_reg(window, VREG(SPARE4), 0ULL);
> > +	write_hvwc_reg(window, VREG(SPARE5), 0ULL);
> > +	write_hvwc_reg(window, VREG(SPARE6), 0ULL);
> > +	write_hvwc_reg(window, VREG(LFIFO_BAR), 0ULL);
> > +	write_hvwc_reg(window, VREG(LDATA_STAMP_CTL), 0ULL);
> > +	write_hvwc_reg(window, VREG(LDMA_CACHE_CTL), 0ULL);
> > +	write_hvwc_reg(window, VREG(LRFIFO_PUSH), 0ULL);
> > +	write_hvwc_reg(window, VREG(CURR_MSG_COUNT), 0ULL);
> > +	write_hvwc_reg(window, VREG(LNOTIFY_AFTER_COUNT), 0ULL);
> > +	write_hvwc_reg(window, VREG(LRX_WCRED), 0ULL);
> > +	write_hvwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
> > +	write_hvwc_reg(window, VREG(TX_WCRED), 0ULL);
> > +	write_hvwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
> > +	write_hvwc_reg(window, VREG(LFIFO_SIZE), 0ULL);
> > +	write_hvwc_reg(window, VREG(WINCTL), 0ULL);
> > +	write_hvwc_reg(window, VREG(WIN_STATUS), 0ULL);
> > +	write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), 0ULL);
> > +	write_hvwc_reg(window, VREG(TX_RSVD_BUF_COUNT), 0ULL);
> > +	write_hvwc_reg(window, VREG(LRFIFO_WIN_PTR), 0ULL);
> > +	write_hvwc_reg(window, VREG(LNOTIFY_CTL), 0ULL);
> > +	write_hvwc_reg(window, VREG(LNOTIFY_PID), 0ULL);
> > +	write_hvwc_reg(window, VREG(LNOTIFY_LPID), 0ULL);
> > +	write_hvwc_reg(window, VREG(LNOTIFY_TID), 0ULL);
> > +	write_hvwc_reg(window, VREG(LNOTIFY_SCOPE), 0ULL);
> > +	write_hvwc_reg(window, VREG(NX_UTIL_ADDER), 0ULL);
> > +
> > +	/* Skip read-only registers: NX_UTIL and NX_UTIL_SE */
> > +
> > +	/*
> > +	=A0* The send and receive window credit adder registers are also
> > +	=A0* accessible from HVWC and have been initialized above. We don't
> > +	=A0* need to initialize from the OS/User Window Context, so skip
> > +	=A0* following calls:
> > +	=A0*
> > +	=A0*	write_uwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
> > +	=A0*	write_uwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
> > +	=A0*/
> > +}
> > +
> > +/*
> > + * Initialize window context registers related to Address Translation.
> > + * These registers are common to send/receive windows although they
> > + * differ for user/kernel windows. As we resolve the TODOs we may
> > + * want to add fields to vas_winctx and move the initialization to
> > + * init_vas_winctx_regs().
> > + */
> > +static void init_xlate_regs(struct vas_window *window, bool user_win)
> > +{
> > +	uint64_t lpcr, msr, val;
> > +
> > +	msr =3D mfmsr();
> > +	WARN_ON_ONCE(!(msr & MSR_SF));
>=20
> We don't support 32 bit userspace?  I would return an error rather than t=
his.

I will return an error and add a TODO for 32-bit.

>=20
> > +
> > +	val =3D 0ULL;
> > +	if (user_win) {
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_DR, val, true);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_TA, val, false);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_PR, val, true);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_US, val, false);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_HV, val, true);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_SF, val, true);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_UV, val, false);
> > +	} else {
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_DR, val, false);
>=20
> kernel contexts don't go through the nestmmu?

I think so, but will check with Alistair/Ben.

>=20
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_TA, val, false);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_PR, val, msr & MSR_PR);
>=20
> I don't understand this.  It should just be 0 for the kernel.

Ok.

>=20
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_US, val, false);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_HV, val, true);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_SF, val, true);
> > +		val =3D SET_FIELD(VAS_XLATE_MSR_UV, val, false);
> > +	}
> > +	write_hvwc_reg(window, VREG(XLATE_MSR), val);
> > +
> > +	lpcr =3D mfspr(SPRN_LPCR);
> > +	val =3D 0ULL;
> > +	/*
> > +	=A0* NOTE: From Section 5.7.6.1 Segment Lookaside Buffer of the
> > +	=A0*	=A0Power ISA, v2.07, Page size encoding is 0 =3D 4KB, 5 =3D 64KB.
> > +	=A0*
> > +	=A0* NOTE: From Section 1.3.1, Address Translation Context of the
> > +	=A0*	=A0Nest MMU Workbook, LPCR_SC should be 0 for Power9.
> > +	=A0*/
> > +	val =3D SET_FIELD(VAS_XLATE_LPCR_PAGE_SIZE, val, 5);
> > +	val =3D SET_FIELD(VAS_XLATE_LPCR_ISL, val, lpcr & LPCR_ISL);
> > +	val =3D SET_FIELD(VAS_XLATE_LPCR_TC, val, lpcr & LPCR_TC);
> > +	val =3D SET_FIELD(VAS_XLATE_LPCR_SC, val, 0);
> > +	write_hvwc_reg(window, VREG(XLATE_LPCR), val);
> > +
> > +	/*
> > +	=A0* Section 1.3.1 (Address translation Context) of NMMU workbook.
> > +	=A0*	0b00	Hashed Page Table mode
> > +	=A0*	0b01	Reserved
> > +	=A0*	0b10	Radix on HPT - not supported in P9
> > +	=A0*	0b11	Radix on Radix (only mode supported in Linux on
> > P9).
>=20
> Linux supports hash on P9.

Ok. I was quoting from the Nest MMU spec. Will remove the text in ()s.

>=20
> Does VAS only support radix?  If so you should error out if we are booted=
 hash.

I think VAS just offloads the translation to NestMMU and doesn't really
depend on radix/HPT. I was going by the comment in the spec.

>=20
> > +	=A0*/
> > +	val =3D 0ULL;
> > +	val =3D SET_FIELD(VAS_XLATE_MODE, val, 0x3);
>=20
> You can use radix_enabled() to set this for hash vs radix.

Ok.

>=20
> > +	write_hvwc_reg(window, VREG(XLATE_CTL), val);
> > +
> > +	/*
> > +	=A0* TODO: Can we mfspr(AMR) even for user windows?
> > +	=A0*/
> > +	val =3D 0ULL;
> > +	val =3D SET_FIELD(VAS_AMR, val, mfspr(SPRN_AMR));
> > +	write_hvwc_reg(window, VREG(AMR), val);
> > +
> > +	/*
> > +	=A0* TODO: Assuming Secure Executable ID Register (SEIDR) is only used
> > +	=A0*	=A0in the ultravisor mode. Since MSR(UV) is 0 for now, set
> > SEIDR
> > +	=A0*	=A0to 0 as well, although we should 'mfspr(SEIDR)' at some
> > point.
> > +	=A0*/
> > +	val =3D 0ULL;
> > +	val =3D SET_FIELD(VAS_SEIDR, val, 0);
> > +	write_hvwc_reg(window, VREG(SEIDR), val);
> > +}
> > +
> > +/*
> > + * Initialize Reserved Send Buffer Count for the send window. It invol=
ves
> > + * writing to the register, reading it back to confirm that the hardwa=
re
> > + * has enough buffers to reserve. See section 1.3.1.2.1 of VAS workboo=
k.
> > + *
> > + * Since we can only make a best-effort attempt to fulfill the request,
> > + * we don't return any errors if we cannot.
> > + *
> > + * TODO: Reserved (aka dedicated) send buffers are not supported yet.
> > + */
> > +static void init_rsvd_tx_buf_count(struct vas_window *txwin,
> > +				struct vas_winctx *winctx)
> > +{
> > +	write_hvwc_reg(txwin, VREG(TX_RSVD_BUF_COUNT), 0ULL);
> > +}
> > +
> > +/*
> > + * Compute the log2() of the FIFO size expressed as kilobytes. It is i=
ntended
> > + * to be used to initialize the Local FIFO Size Register defined in Se=
ction
> > + * 3.14.25 of the VAS Workbook.
>=20
> There is a ilog2() function..

Ok, will use that.

Thanks,

Suka
