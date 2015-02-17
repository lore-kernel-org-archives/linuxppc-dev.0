Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0112.outbound.protection.outlook.com [207.46.100.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05EEF1A0409
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 11:50:23 +1100 (AEDT)
Message-ID: <1424134201.13699.138.camel@aoeu.buserror.net>
Subject: Re: [RFC v2 01/10] fsl_bman: Add drivers for the Freescale DPAA BMan
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Mon, 16 Feb 2015 18:50:01 -0600
In-Reply-To: <1424101581-22109-2-git-send-email-Emilian.Medve@Freescale.com>
References: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
 <1424101581-22109-2-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Geoff Thorpe <Geoff.Thorpe@Freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-16 at 09:46 -0600, Emil Medve wrote:
> From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
> 
> Change-Id: I075944acf740dbaae861104c17a9ff7247dec1be
> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>

Remove Change-Id.
Provide a description of what BMan is.

> diff --git a/drivers/soc/freescale/Kconfig b/drivers/soc/freescale/Kconfig
> new file mode 100644
> index 0000000..63bf002
> --- /dev/null
> +++ b/drivers/soc/freescale/Kconfig
> @@ -0,0 +1,51 @@
> +menuconfig FSL_DPA
> +	tristate "Freescale DPAA Buffer management"
> +	depends on HAS_FSL_QBMAN
> +	default y

"default y" is normally a bad idea for drivers (though it can make sense
for options within a driver).

Where is HAS_FSL_QBMAN defined (if the answer is in a later patch,
rearrange it)?

> +if FSL_DPA
> +
> +config FSL_DPA_CHECKING
> +	bool "additional driver checking"

Option texts are usually capitalized.

> +	default n
> +	---help---
> +	  Compiles in additional checks to sanity-check the drivers and any
> +	  use of it by other code. Not recommended for performance.
> +
> +config FSL_DPA_CAN_WAIT
> +	bool
> +	default y
> +config FSL_DPA_CAN_WAIT_SYNC
> +	bool
> +	default y
> +
> +config FSL_DPA_PIRQ_FAST
> +	bool
> +	default y

Use consistent whitespace.

Add help texts to these options to document them, even if they're not
user-visible.

> +config FSL_BMAN_CONFIG
> +	bool "BMan device management"
> +	default y
> +	---help---
> +	  If this linux image is running natively, you need this option. If this
> +	  linux image is running as a guest OS under the hypervisor, only one
> +	  guest OS ("the control plane") needs this option.

"the hypervisor"?  I suspect this refers to the Freescale Embedded
Hypervisor (a.k.a. Topaz), rather than KVM or something else.

It would also be nice if the help text explained what the option does,
rather than just when it's needed.

> +struct bman;

Where is this struct defined?

> +union bman_ecir {
> +	u32 ecir_raw;
> +	struct {
> +		u32 __reserved1:4;
> +		u32 portal_num:4;
> +		u32 __reserved2:12;
> +		u32 numb:4;
> +		u32 __reserved3:2;
> +		u32 pid:6;
> +	} __packed info;
> +};

Get rid of __packed.  It causes GCC to generate terrible code with
bitfields.  For that matter, consider getting rid of the bitfields.

> +#define BMAN_HWE_TXT(a, b) { .mask = BM_EIRQ_##a, .txt = b }
> +
> +static const struct bman_hwerr_txt bman_hwerr_txts[] = {
> +	BMAN_HWE_TXT(IVCI, "Invalid Command Verb"),
> +	BMAN_HWE_TXT(FLWI, "FBPR Low Watermark"),
> +	BMAN_HWE_TXT(MBEI, "Multi-bit ECC Error"),
> +	BMAN_HWE_TXT(SBEI, "Single-bit ECC Error"),
> +	BMAN_HWE_TXT(BSCN, "Pool State Change Notification"),
> +};
> +#define BMAN_HWE_COUNT (sizeof(bman_hwerr_txts)/sizeof(struct bman_hwerr_txt))

Use ARRAY_SIZE(), here and elsewhere.

> +/* Add this in Kconfig */
> +#define BMAN_ERRS_TO_UNENABLE (BM_EIRQ_FLWI)

Add what to kconfig?

> +/**
> + * bm_err_isr_<reg>_<verb> - Manipulate global interrupt registers
> + * @v: for accessors that write values, this is the 32-bit value
> + *
> + * Manipulates BMAN_ERR_ISR, BMAN_ERR_IER, BMAN_ERR_ISDR, BMAN_ERR_IIR. All
> + * manipulations except bm_err_isr_[un]inhibit() use 32-bit masks composed of
> + * the BM_EIRQ_*** definitions. Note that "bm_err_isr_enable_write" means
> + * "write the enable register" rather than "enable the write register"!
> + */
> +#define bm_err_isr_status_read(bm)	\
> +		__bm_err_isr_read(bm, bm_isr_status)
> +#define bm_err_isr_status_clear(bm, m)	\
> +		__bm_err_isr_write(bm, bm_isr_status, m)
> +#define bm_err_isr_enable_read(bm)	\
> +		__bm_err_isr_read(bm, bm_isr_enable)
> +#define bm_err_isr_enable_write(bm, v)	\
> +		__bm_err_isr_write(bm, bm_isr_enable, v)
> +#define bm_err_isr_disable_read(bm)	\
> +		__bm_err_isr_read(bm, bm_isr_disable)
> +#define bm_err_isr_disable_write(bm, v)	\
> +		__bm_err_isr_write(bm, bm_isr_disable, v)
> +#define bm_err_isr_inhibit(bm)		\
> +		__bm_err_isr_write(bm, bm_isr_inhibit, 1)
> +#define bm_err_isr_uninhibit(bm)	\
> +		__bm_err_isr_write(bm, bm_isr_inhibit, 0)

Is this layer really helpful?

> +/*
> + * TODO: unimplemented registers
> + *
> + * BMAN_POOLk_SDCNT, BMAN_POOLk_HDCNT, BMAN_FULT,
> + * BMAN_VLDPL, BMAN_EECC, BMAN_SBET, BMAN_EINJ
> + */

What does it mean for registers to be unimplemented, in a piece of
software?  If you mean accessors to those registers, why is that needed
if nothing uses them (yet)?

> +/* Encapsulate "struct bman *" as a cast of the register space address. */
> +
> +static struct bman *bm_create(void *regs)
> +{
> +	return (struct bman *)regs;
> +}

Unnecessary cast -- and unnecessary encapsulation (especially since you
only use it once).  It's also missing __iomem -- have you run sparse on
this?

> +static u32 __generate_thresh(u32 val, int roundup)
> +{
> +	u32 e = 0;	/* co-efficient, exponent */
> +	int oddbit = 0;
> +	while (val > 0xff) {
> +		oddbit = val & 1;
> +		val >>= 1;
> +		e++;
> +		if (roundup && oddbit)
> +			val++;
> +	}
> +	DPA_ASSERT(e < 0x10);
> +	return val | (e << 8);
> +}
> +
> +static void bm_set_pool(struct bman *bm, u8 pool, u32 swdet, u32 swdxt,
> +			u32 hwdet, u32 hwdxt)
> +{
> +	DPA_ASSERT(pool < bman_pool_max);
> +	bm_out(POOL_SWDET(pool), __generate_thresh(swdet, 0));
> +	bm_out(POOL_SWDXT(pool), __generate_thresh(swdxt, 1));
> +	bm_out(POOL_HWDET(pool), __generate_thresh(hwdet, 0));
> +	bm_out(POOL_HWDXT(pool), __generate_thresh(hwdxt, 1));
> +}

Why the underscores on __generate_thresh()?  I don't see a
generate_thresh() to contrast with.

> +static void bm_set_memory(struct bman *bm, u64 ba, int prio, u32 size)
> +{
> +	u32 exp = ilog2(size);
> +	/* choke if size isn't within range */
> +	DPA_ASSERT((size >= 4096) && (size <= 1073741824) &&
> +			is_power_of_2(size));

Rewrite 1073741824 in a more readable way, such as (1024 * 1024 * 1024).

> +/*****************/
> +/* Config driver */
> +/*****************/

/*
 * Linux multi-line
 * Comment style is
 * like this
 */

It's also not clear what the comment means.  Is there a separate driver
for configuration?

> +/* We support only one of these. */
> +static struct bman *bm;
> +static struct device_node *bm_node;
> +
> +/* And this state belongs to 'bm'. It is set during fsl_bman_init(), but used
> + * during bman_init_ccsr(). */
> +static dma_addr_t fbpr_a;
> +static size_t fbpr_sz;

What state in this driver doesn't belong to bman?  Why is it not in
struct bman?

I don't think the comment about being set in fsl_bman_init() is still
accurate.

> +static int bman_fbpr(struct reserved_mem *rmem)
> +{
> +	fbpr_a = rmem->base;
> +	fbpr_sz = rmem->size;
> +
> +	WARN_ON(!(fbpr_a && fbpr_sz));
> +
> +	return 0;
> +}
> +RESERVEDMEM_OF_DECLARE(bman_fbpr, "fsl,bman-fbpr", bman_fbpr);
> +
> +static int __init fsl_bman_init(struct device_node *node)

It's confusing to have both that and bman_init().  I suggest
s/fsl_bman_init/bman_init_early_one/ -- or just move the code into
bman_init_early() and get rid of the outer loop (just work with the
first fsl,bman match you find).

> +{
> +	struct resource res;
> +	u32 __iomem *regs;
> +	int ret;
> +	u16 id;
> +	u8 major, minor;
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret) {
> +		pr_err("Can't get %s property 'reg'\n",
> +				node->full_name);
> +		return ret;
> +	}
> +
> +	/* Global configuration */
> +	regs = ioremap(res.start, res.end - res.start + 1);

Use of_iomap()

> +	bm = bm_create(regs);
> +	BUG_ON(!bm);

BUG_ON is not warranted here or (most likely) anywhere else in this
driver.

This case doesn't even warrant a WARN_ON -- it's just a bad device tree
node, or a lack of ioremap space, etc.  A simple error message will
suffice.

> +	bm_node = node;
> +	bm_get_version(bm, &id, &major, &minor);
> +	pr_info("Bman ver:%04x,%02x,%02x\n", id, major, minor);
> +	if ((major == 1) && (minor == 0)) {
> +		bman_ip_rev = BMAN_REV10;
> +		bman_pool_max = 64;
> +	} else if ((major == 2) && (minor == 0)) {
> +		bman_ip_rev = BMAN_REV20;
> +		bman_pool_max = 8;
> +	} else if ((major == 2) && (minor == 1)) {
> +		bman_ip_rev = BMAN_REV21;
> +		bman_pool_max = 64;
> +	} else {
> +		pr_warn("unknown Bman version, default to rev1.0\n");
> +	}

Default to rev1.0?  Or to uninitialized values for bman_ip_rev and
bman_pool_max?  You should probably just error out if you don't
recognize the version (e.g. if you didn't recognize rev 2.0, you'd have
a too-high value for bman_poool_max).

> +int bman_have_ccsr(void)
> +{
> +	return bm ? 1 : 0;
> +}

Just open-code this in the one caller...

> +int bm_pool_set(u32 bpid, const u32 *thresholds)
> +{
> +	if (!bm)
> +		return -ENODEV;

...like you do other places that want to check.

> +	bm_set_pool(bm, bpid, thresholds[0], thresholds[1],
> +		thresholds[2], thresholds[3]);
> +	return 0;
> +}
> +EXPORT_SYMBOL(bm_pool_set);

Please document functions exported for use outside the driver.

> +__init void bman_init_early(void)
> +{
> +	struct device_node *dn;
> +	int ret;
> +
> +	for_each_compatible_node(dn, NULL, "fsl,bman") {
> +		if (bm)
> +			pr_err("%s: only one 'fsl,bman' allowed\n",
> +				dn->full_name);

break; rather than indenting the rest.

> +		else {
> +			if (!of_device_is_available(dn))
> +				continue;
> +
> +			ret = fsl_bman_init(dn);
> +			BUG_ON(ret);

Again, no BUG_ON.

> +static void log_edata_bits(u32 bit_count)
> +{
> +	u32 i, j, mask = 0xffffffff;
> +
> +	pr_warn("Bman ErrInt, EDATA:\n");
> +	i = bit_count/32;
> +	if (bit_count%32) {

Spaces around binary operators.

> +		i++;
> +		mask = ~(mask << bit_count%32);

Isn't this all a bit elaborate given there aren't any relevant memories
with non-multiple-of-32 bits?

> +	}
> +	j = 16-i;
> +	pr_warn("  0x%08x\n", bm_in(EDATA(j)) & mask);
> +	j++;
> +	for (; j < 16; j++)
> +		pr_warn("  0x%08x\n", bm_in(EDATA(j)));

DPAARM says, "When BMAN_ECSR indicates a memory that contains fewer
than 256 data bits, the data is left-justified in these registers, such
that bit 0 from the memory is always in bit 0 of BMAN_EDATA0, bit 32
from the memory is in bit 0 of BMAN_DATA1, and so on."  The code appears
to assume the opposite.

Not to mention that we could just keep the software simple and dump
everything, and let the person interpreting the dump figure out which
bits are not useful.

> +}
> +
> +static void log_additional_error_info(u32 isr_val, u32 ecsr_val)
> +{
> +	union bman_ecir ecir_val;
> +	union bman_eadr eadr_val;
> +
> +	ecir_val.ecir_raw = bm_in(ECIR);
> +	/* Is portal info valid */
> +	if (ecsr_val & PORTAL_ECSR_ERR) {
> +		pr_warn("Bman ErrInt: SWP id %d, numb %d, pid %d\n",
> +			ecir_val.info.portal_num, ecir_val.info.numb,
> +			ecir_val.info.pid);
> +	}
> +	if (ecsr_val & (BM_EIRQ_SBEI|BM_EIRQ_MBEI)) {
> +		eadr_val.eadr_raw = bm_in(EADR);
> +		pr_warn("Bman ErrInt: EADR Memory: %s, 0x%x\n",
> +			error_mdata[eadr_val.info.memid].txt,
> +			error_mdata[eadr_val.info.memid].addr_mask
> +				& eadr_val.info.eadr);

Try not to let unexpected hardware register values lead to indexing
beyond the end of an array...

> +			if (bman_hwerr_txts[i].mask & BMAN_ERRS_TO_UNENABLE) {
> +				pr_devel("Bman un-enabling error 0x%x\n",
> +					bman_hwerr_txts[i].mask);

s/unenable/disable/

> +	bm_err_isr_status_clear(bm, isr_val);
> +	return IRQ_HANDLED;
> +}
> +
> +static int __bind_irq(void)

Why the underscores?

> +{
> +	int ret, err_irq;
> +
> +	err_irq = of_irq_to_resource(bm_node, 0, NULL);
> +	if (err_irq == NO_IRQ) {
> +		pr_info("Can't get %s property '%s'\n", bm_node->full_name,
> +			"interrupts");
> +		return -ENODEV;
> +	}

Why is "interrupts" a %s rather than embedded in the format string?

> +int bman_init_ccsr(struct device_node *node)
> +{
> +	int ret;
> +	if (!bman_have_ccsr())
> +		return 0;

This is success?  You'll print "Bman err interrupt handler present" in
this case...

> +static int of_fsl_bman_probe(struct platform_device *ofdev)

So there are three init phases of this driver?  Early, subsys init, and
platform device probe?  Can the latter two be combined, using deferred
probing instead of subsys init?

For that matter, I don't see anything in the early init that needs to be
early, now that the reserved mem mechanism is being used.

> +/* BTW, the drivers (and h/w programming model) already obtain the required
> + * synchronisation for portal accesses via lwsync(), hwsync(), and
> + * data-dependencies. Use of barrier()s or other order-preserving primitives
> + * simply degrade performance. Hence the use of the __raw_*() interfaces, which
> + * simply ensure that the compiler treats the portal registers as volatile (ie.
> + * non-coherent). */

s/BTW, the/The/
What does volatile have to do with non-coherence?

> +/* Cache-enabled (index) register access */
> +#define __bm_cl_touch_ro(bm, o) dcbt_ro((bm)->addr_ce + (o))
> +#define __bm_cl_touch_rw(bm, o) dcbt_rw((bm)->addr_ce + (o))
> +#define __bm_cl_in(bm, o)	__raw_readl((bm)->addr_ce + (o))
> +#define __bm_cl_out(bm, o, val) \
> +	do { \
> +		u32 *__tmpclout = (bm)->addr_ce + (o); \
> +		__raw_writel((val), __tmpclout); \
> +		dcbf(__tmpclout); \
> +	} while (0)
> +#define __bm_cl_invalidate(bm, o) dcbi((bm)->addr_ce + (o))

Can these be done as inline functions?  What is the type of "bm"?

> +/* --------------- */
> +/* --- RCR API --- */
> +
> +/* Bit-wise logic to wrap a ring pointer by clearing the "carry bit" */
> +#define RCR_CARRYCLEAR(p) \
> +	(void *)((unsigned long)(p) & (~(unsigned long)(BM_RCR_SIZE << 6)))
> +
> +/* Bit-wise logic to convert a ring pointer to a ring index */
> +static inline u8 RCR_PTR2IDX(struct bm_rcr_entry *e)
> +{
> +	return ((uintptr_t)e >> 6) & (BM_RCR_SIZE - 1);
> +}

Why u8?

Can you replace 6 with a symbolic constant?

Don't put function names in ALLCAPS.

> +/* Increment the 'cursor' ring pointer, taking 'vbit' into account */
> +static inline void RCR_INC(struct bm_rcr *rcr)
> +{
> +	/* NB: this is odd-looking, but experiments show that it generates
> +	 * fast code with essentially no branching overheads. We increment to
> +	 * the next RCR pointer and handle overflow and 'vbit'. */
> +	struct bm_rcr_entry *partial = rcr->cursor + 1;
> +	rcr->cursor = RCR_CARRYCLEAR(partial);
> +	if (partial != rcr->cursor)
> +		rcr->vbit ^= BM_RCR_VERB_VBIT;
> +}
> +
> +static inline int bm_rcr_init(struct bm_portal *portal, enum bm_rcr_pmode pmode,
> +		__maybe_unused enum bm_rcr_cmode cmode)

You don't need __maybe_unused on function arguments.

> +{
> +	/* This use of 'register', as well as all other occurrences, is because
> +	 * it has been observed to generate much faster code with gcc than is
> +	 * otherwise the case. */
> +	register struct bm_rcr *rcr = &portal->rcr;

It's a bit sad if GCC can't figure out to use a register in a case like
this...  Is this still true of recent GCC versions?  Does it even matter
in an init function?

> +static inline void bm_rcr_finish(struct bm_portal *portal)
> +{
> +	register struct bm_rcr *rcr = &portal->rcr;
> +	u8 pi = bm_in(RCR_PI_CINH) & (BM_RCR_SIZE - 1);
> +	u8 ci = bm_in(RCR_CI_CINH) & (BM_RCR_SIZE - 1);
> +	DPA_ASSERT(!rcr->busy);
> +	if (pi != RCR_PTR2IDX(rcr->cursor))
> +		pr_crit("losing uncommited RCR entries\n");
> +	if (ci != rcr->ci)
> +		pr_crit("missing existing RCR completions\n");
> +	if (rcr->ci != RCR_PTR2IDX(rcr->cursor))
> +		pr_crit("RCR destroyed unquiesced\n");
> +}

Can you use dev_crit instead?  These messages have no context...

> +static inline struct bm_rcr_entry *bm_rcr_start(struct bm_portal *portal)
> +{
> +	register struct bm_rcr *rcr = &portal->rcr;
> +	DPA_ASSERT(!rcr->busy);
> +	if (!rcr->available)
> +		return NULL;
> +#ifdef CONFIG_FSL_DPA_CHECKING
> +	rcr->busy = 1;
> +#endif
> +	dcbz_64(rcr->cursor);
> +	return rcr->cursor;
> +}
> +
> +static inline void bm_rcr_abort(struct bm_portal *portal)
> +{
> +	__maybe_unused register struct bm_rcr *rcr = &portal->rcr;
> +	DPA_ASSERT(rcr->busy);
> +#ifdef CONFIG_FSL_DPA_CHECKING
> +	rcr->busy = 0;
> +#endif

Does it make sense to check rcr->busy if CONFIG_FSL_DPA_CHECKING is not
defined?  It might be harmless if the lack of checking makes DPA_ASSERT
a no-op, but it's awkward, especially with the __maybe_used...

You could also have inline functions to set/clear busy based on
CONFIG_FSL_DPA_CHECKING, with something like "(void)rcr;" in the
non-checking case, so that only the inline functions have to care about
the ifdefs.


> struct bm_portal *portal)
> +{
> +	register struct bm_rcr *rcr = &portal->rcr;
> +	return rcr->ithresh;
> +}
> +
> +static inline void bm_rcr_set_ithresh(struct bm_portal *portal, u8 ithresh)
> +{
> +	register struct bm_rcr *rcr = &portal->rcr;
> +	rcr->ithresh = ithresh;
> +	bm_out(RCR_ITR, ithresh);
> +}
> +
> +static inline u8 bm_rcr_get_avail(struct bm_portal *portal)
> +{
> +	register struct bm_rcr *rcr = &portal->rcr;
> +	return rcr->available;
> +}
> +
> +static inline u8 bm_rcr_get_fill(struct bm_portal *portal)
> +{
> +	register struct bm_rcr *rcr = &portal->rcr;
> +	return BM_RCR_SIZE - 1 - rcr->available;
> +}

I really doubt that even these functions benefit from "register"...

Likewise, I see way too many "inline"s.

> +struct bman_portal {
> +	struct bm_portal p;

Having both bman_portal and bm_portal is confusing.

> +	/* 2-element array. pools[0] is mask, pools[1] is snapshot. */
> +	struct bman_depletion *pools;

Symbolic names for 0/1?  Is there a benefit to using an array here?

> +	int thresh_set;
> +	unsigned long irq_sources;
> +	u32 slowpoll;	/* only used when interrupts are off */
> +#ifdef CONFIG_FSL_DPA_CAN_WAIT_SYNC
> +	struct bman_pool *rcri_owned; /* only 1 release WAIT_SYNC at a time */
> +#endif

Please try to sort structs to reduce obvious padding.

> +#ifdef CONFIG_FSL_DPA_PORTAL_SHARE
> +	raw_spinlock_t sharing_lock; /* only used if is_shared */
> +	int is_shared;
> +	struct bman_portal *sharing_redirect;
> +#endif
> +	/* When the cpu-affine portal is activated, this is non-NULL */
> +	const struct bm_portal_config *config;
> +	/* 64-entry hash-table of pool objects that are tracking depletion
> +	 * entry/exit (ie. BMAN_POOL_FLAG_DEPLETION). This isn't fast-path, so
> +	 * we're not fussy about cache-misses and so forth - whereas the above
> +	 * members should all fit in one cacheline.
> +	 * BTW, with 64 entries in the hash table and 64 buffer pools to track,
> +	 * you'll never guess the hash-function ... */
> +	struct bman_pool *cb[64];

Symbolic constant for 64?

If this driver is assuming at most 64 buffer pools, is this checked
anywhere (e.g. if someone were to modify the version checking code in
the future, without auditing the rest of the driver)?

> +	/* Track if the portal was alloced by the driver */
> +	u8 alloced;

bool?

> +#ifdef CONFIG_FSL_DPA_PORTAL_SHARE
> +static inline struct bman_portal *get_affine_portal(void)
> +{
> +	struct bman_portal *p = get_raw_affine_portal();
> +	if (p->sharing_redirect)
> +		return p->sharing_redirect;
> +	return p;
> +}

Some documentation on sharing_redirect would be nice.

> +static inline void put_affine_portal(void)
> +{
> +	put_cpu_var(bman_affine_portal);
> +}
> +static inline struct bman_portal *get_poll_portal(void)
> +{
> +	return this_cpu_ptr(&bman_affine_portal);
> +}
> +#define put_poll_portal()

static inline void put_poll_portal(void)
{
}

Is this expected to become non-empty in the future?  How do we have
confidence that the put_poll_portal() calls are correct if it never does
anything?

> +
> +/* GOTCHA: this object type refers to a pool, it isn't *the* pool. There may be
> + * more than one such object per Bman buffer pool, eg. if different users of the
> + * pool are operating via different portals. */
> +struct bman_pool {

So maybe call it bman_pool_ref or similar?

> +/* (De)Registration of depletion notification callbacks */
> +static void depletion_link(struct bman_portal *portal, struct bman_pool *pool)
> +{
> +	__maybe_unused unsigned long irqflags;

Have PORTAL_IRQ_LOCK unconditionally consume irqflags (by casting to
void) instead of having callers use __maybe_unused.

> +static void depletion_unlink(struct bman_pool *pool)
> +{
> +	struct bman_pool *it, *last = NULL;
> +	struct bman_pool **base = &pool->portal->cb[pool->params.bpid];
> +	__maybe_unused unsigned long irqflags;
> +	PORTAL_IRQ_LOCK(pool->portal, irqflags);
> +	it = *base;	/* <-- gotcha, don't do this prior to the irq_save */
> +	while (it != pool) {
> +		last = it;
> +		it = it->next;
> +	}

How long can this list be?

> +/* In the case that the application's core loop calls
> + * bman_poll(), we ought to balance how often we incur the overheads of the
> + * slow-path poll. We'll use two decrementer sources. The idle decrementer
> + * constant is used when the last slow-poll detected no work to do, and the busy
> + * decrementer constant when the last slow-poll had work to do. */
> +#define SLOW_POLL_IDLE 1000
> +#define SLOW_POLL_BUSY 10
> +static u32 __poll_portal_slow(struct bman_portal *p, u32 is);

Why underscores?  Likewise elsewhere where it doesn't distinguish from a
non-underscore version.

Why the forward declaration instead of reordering?

> +
> +/* Portal interrupt handler */
> +static irqreturn_t portal_isr(__always_unused int irq, void *ptr)
> +{
> +	struct bman_portal *p = ptr;
> +	u32 clear = p->irq_sources;
> +	u32 is = bm_isr_status_read(&p->p) & p->irq_sources;
> +	clear |= __poll_portal_slow(p, is);
> +	bm_isr_status_clear(&p->p, clear);
> +	return IRQ_HANDLED;
> +}

Don't return IRQ_HANDLED unless something was actually handled.

> +struct bman_portal *bman_create_portal(
> +				       struct bman_portal *portal,
> +				       const struct bm_portal_config *config)
> +{
> +	struct bm_portal *__p;

Why the underscores?

> +	if (!portal) {
> +		portal = kmalloc(sizeof(*portal), GFP_KERNEL);
> +		if (!portal)
> +			return portal;

s/return portal/return NULL/

> +/* When release logic waits on available RCR space, we need a global waitqueue
> + * in the case of "affine" use (as the waits wake on different cpus which means
> + * different portals - so we can't wait on any per-portal waitqueue). */
> +static DECLARE_WAIT_QUEUE_HEAD(affine_queue);
> +
> +static u32 __poll_portal_slow(struct bman_portal *p, u32 is)
> +{
> +	struct bman_depletion tmp;

This could use a better name.

> +	u32 ret = is;

What is "is"?
(I'm assuming "interrupt status", but please use a more normal name for
that).

> +		PORTAL_IRQ_LOCK(p, irqflags);
> +		bm_mc_start(&p->p);
> +		bm_mc_commit(&p->p, BM_MCC_VERB_CMD_QUERY);
> +		while (!(mcr = bm_mc_result(&p->p)))
> +			cpu_relax();
> +		tmp = mcr->query.ds.state;
> +		PORTAL_IRQ_UNLOCK(p, irqflags);

How long can that loop take?  No timeout?

> +		for (i = 0; i < 2; i++) {

ARRAY_SIZE()?

> +			int idx = i * 32;
> +			/* tmp is a mask of currently-depleted pools.
> +			 * pools[0] is mask of those we care about.
> +			 * pools[1] is our previous view (we only want to
> +			 * be told about changes). */
> +			tmp.__state[i] &= p->pools[0].__state[i];
> +			if (tmp.__state[i] == p->pools[1].__state[i])

Why do struct members have leading underscores?

> +				/* fast-path, nothing to see, move along */
> +				continue;
> +			for (j = 0; j <= 31; j++, idx++) {

Symbolic constant for 31?

> +				struct bman_pool *pool = p->cb[idx];
> +				int b4 = bman_depletion_get(&p->pools[1], idx);
> +				int af = bman_depletion_get(&tmp, idx);
> +				if (b4 == af)
> +					continue;

b4? af? srsly?

For a second I thought I was looking at hex numbers. :-P

> +const cpumask_t *bman_affine_cpus(void)
> +{
> +	return &affine_mask;
> +}
> +EXPORT_SYMBOL(bman_affine_cpus);

Why not just export affine_mask?

> +		ret = (u32)-1;

:-(

> +/* Legacy wrapper */

Legacy?  From what?

> +static inline struct bm_rcr_entry *try_rel_start(struct bman_portal **p,
> +#ifdef CONFIG_FSL_DPA_CAN_WAIT
> +					__maybe_unused struct bman_pool *pool,
> +#endif

Please don't put ifdefs in the middle of an argument list.

> +					__maybe_unused unsigned long *irqflags,
> +					__maybe_unused u32 flags)
> +{
> +	struct bm_rcr_entry *r;
> +	u8 avail;
> +
> +	*p = get_affine_portal();
> +	PORTAL_IRQ_LOCK(*p, (*irqflags));
> +#ifdef CONFIG_FSL_DPA_CAN_WAIT_SYNC
> +	if (unlikely((flags & BMAN_RELEASE_FLAG_WAIT) &&
> +			(flags & BMAN_RELEASE_FLAG_WAIT_SYNC))) {
> +		if ((*p)->rcri_owned) {
> +			PORTAL_IRQ_UNLOCK(*p, (*irqflags));
> +			put_affine_portal();
> +			return NULL;
> +		}
> +		(*p)->rcri_owned = pool;
> +	}
> +#endif
> +	avail = bm_rcr_get_avail(&(*p)->p);
> +	if (avail < 2)
> +		update_rcr_ci(*p, avail);
> +	r = bm_rcr_start(&(*p)->p);
> +	if (unlikely(!r)) {
> +#ifdef CONFIG_FSL_DPA_CAN_WAIT_SYNC
> +		if (unlikely((flags & BMAN_RELEASE_FLAG_WAIT) &&
> +				(flags & BMAN_RELEASE_FLAG_WAIT_SYNC)))
> +			(*p)->rcri_owned = NULL;
> +#endif
> +		PORTAL_IRQ_UNLOCK(*p, (*irqflags));
> +		put_affine_portal();
> +	}
> +	return r;
> +}

Where does the unlock happen in the "likely" case that r != NULL?

> +/* to facilitate better copying of bufs into the ring without either (a) copying
> + * noise into the first byte (prematurely triggering the command), nor (b) being
> + * very inefficient by copying small fields using read-modify-write */
> +struct overlay_bm_buffer {
> +	u32 first;
> +	u32 second;
> +};

This ought to be a hint that the bitfields should go away.

> +static inline int __bman_release(struct bman_pool *pool,
> +			const struct bm_buffer *bufs, u8 num, u32 flags)
> +{
> +	struct bman_portal *p;
> +	struct bm_rcr_entry *r;
> +	struct overlay_bm_buffer *o_dest;
> +	struct overlay_bm_buffer *o_src = (struct overlay_bm_buffer *)&bufs[0];
> +	__maybe_unused unsigned long irqflags;
> +	u32 i = num - 1;
> +
> +#ifdef CONFIG_FSL_DPA_CAN_WAIT
> +	if (flags & BMAN_RELEASE_FLAG_WAIT)
> +		r = wait_rel_start(&p, pool, &irqflags, flags);
> +	else
> +		r = try_rel_start(&p, pool, &irqflags, flags);
> +#else
> +	r = try_rel_start(&p, &irqflags, flags);
> +#endif
> +	if (!r)
> +		return -EBUSY;
> +	/* We can copy all but the first entry, as this can trigger badness
> +	 * with the valid-bit. Use the overlay to mask the verb byte. */
> +	o_dest = (struct overlay_bm_buffer *)&r->bufs[0];
> +	o_dest->first = (o_src->first & 0x0000ffff) |
> +		(((u32)pool->params.bpid << 16) & 0x00ff0000);
> +	o_dest->second = o_src->second;
> +	if (i)
> +		copy_words(&r->bufs[1], &bufs[1], i * sizeof(bufs[0]));
> +	bm_rcr_pvb_commit(&p->p, BM_RCR_VERB_CMD_BPID_SINGLE |
> +			(num & BM_RCR_VERB_BUFCOUNT_MASK));
> +#ifdef CONFIG_FSL_DPA_CAN_WAIT_SYNC
> +	/* if we wish to sync we need to set the threshold after h/w sees the
> +	 * new ring entry. As we're mixing cache-enabled and cache-inhibited
> +	 * accesses, this requires a heavy-weight sync. */
> +	if (unlikely((flags & BMAN_RELEASE_FLAG_WAIT) &&
> +			(flags & BMAN_RELEASE_FLAG_WAIT_SYNC))) {
> +		hwsync();
> +		bm_rcr_set_ithresh(&p->p, 1);
> +	}
> +#endif
> +	PORTAL_IRQ_UNLOCK(p, irqflags);

Where was the lock acquired?

> +int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
> +			u32 flags)
> +{
> +	int ret = 0;
> +#ifdef CONFIG_FSL_DPA_CHECKING
> +	if (!num || (num > 8))
> +		return -EINVAL;
> +	if (pool->params.flags & BMAN_POOL_FLAG_NO_RELEASE)
> +		return -EINVAL;
> +#endif
> +	/* Without stockpile, this API is a pass-through to the h/w operation */
> +	if (!(pool->params.flags & BMAN_POOL_FLAG_STOCKPILE))
> +		return __bman_release(pool, bufs, num, flags);
> +#ifdef CONFIG_FSL_DPA_CHECKING
> +	if (!atomic_dec_and_test(&pool->in_use)) {
> +		pr_crit("Parallel attempts to enter bman_released() detected.");
> +		panic("only one instance of bman_released/acquired allowed");
> +	}

panic() is even worse than BUG_ON().  WARN_ON and return would be
appropriate here.

s/bman_released/bman_release/

> +static inline int __bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs,
> +					u8 num)
> +{
> +	struct bman_portal *p = get_affine_portal();
> +	struct bm_mc_command *mcc;
> +	struct bm_mc_result *mcr;
> +	__maybe_unused unsigned long irqflags;
> +	int ret;
> +
> +	PORTAL_IRQ_LOCK(p, irqflags);
> +	mcc = bm_mc_start(&p->p);
> +	mcc->acquire.bpid = pool->params.bpid;
> +	bm_mc_commit(&p->p, BM_MCC_VERB_CMD_ACQUIRE |
> +			(num & BM_MCC_VERB_ACQUIRE_BUFCOUNT));
> +	while (!(mcr = bm_mc_result(&p->p)))
> +		cpu_relax();
> +	ret = mcr->verb & BM_MCR_VERB_ACQUIRE_BUFCOUNT;
> +	if (bufs)
> +		copy_words(&bufs[0], &mcr->acquire.bufs[0],
> +				num * sizeof(bufs[0]));
> +	PORTAL_IRQ_UNLOCK(p, irqflags);

Again, how long will this take, loop timeout, etc.

> +/* After initialising cpus that own shared portal configs,

If they're shared why is there an owning cpu?

>  we cache the
> + * resulting portals (ie. not just the configs) in this array. Then we
> + * initialise slave cpus that don't have their own portals, redirecting them to
> + * portals from this cache in a round-robin assignment. */
>
> +static struct bman_portal *shared_portals[NR_CPUS] __initdata;
> +static int num_shared_portals __initdata;
> +static int shared_portals_idx __initdata;
> +static struct list_head unused_pcfgs __initdata = LIST_HEAD_INIT(unused_pcfgs);
> +
> +static void *affine_bportals[NR_CPUS];
> +
> +static struct bm_portal_config * __init parse_pcfg(struct device_node *node)
> +{
> +	struct bm_portal_config *pcfg;
> +	int irq, ret;
> +
> +	pcfg = kmalloc(sizeof(*pcfg), GFP_KERNEL);
> +	if (!pcfg) {
> +		pr_err("can't allocate portal config");
> +		return NULL;
> +	}
> +
> +	if (of_device_is_compatible(node, "fsl,bman-portal-1.0") ||
> +		of_device_is_compatible(node, "fsl,bman-portal-1.0.0")) {
> +		bman_ip_rev = BMAN_REV10;
> +		bman_pool_max = 64;
> +	} else if (of_device_is_compatible(node, "fsl,bman-portal-2.0") ||
> +		of_device_is_compatible(node, "fsl,bman-portal-2.0.8")) {
> +		bman_ip_rev = BMAN_REV20;
> +		bman_pool_max = 8;
> +	} else if (of_device_is_compatible(node, "fsl,bman-portal-2.1.0") ||
> +		   of_device_is_compatible(node, "fsl,bman-portal-2.1.1") ||
> +		   of_device_is_compatible(node, "fsl,bman-portal-2.1.2") ||
> +		   of_device_is_compatible(node, "fsl,bman-portal-2.1.3")) {
> +		bman_ip_rev = BMAN_REV21;
> +		bman_pool_max = 64;
> +	}

Is this to deal with VMs that have portals but no bman node?

> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq == NO_IRQ) {

Don't use NO_IRQ.  An open-coded value of zero indicates the absence of
an IRQ.

> +static struct bman_portal * __init init_pcfg(struct bm_portal_config *pcfg)
> +{
> +	struct bman_portal *p = bman_create_affine_portal(pcfg);
> +
> +	if (p) {
> +#ifdef CONFIG_FSL_DPA_PIRQ_SLOW
> +		bman_p_irqsource_add(p, BM_PIRQ_RCRI | BM_PIRQ_BSCN);
> +#endif
> +		pr_info("Bman portal %s initialised, cpu %d\n",
> +			pcfg->public_cfg.is_shared ? "(shared) " : "",
> +			pcfg->public_cfg.cpu);

This seems a bit verbose given the number of portals.

> +int __init bman_init(void)
> +{
> +	struct cpumask slave_cpus;
> +	struct cpumask unshared_cpus = *cpu_none_mask;
> +	struct cpumask shared_cpus = *cpu_none_mask;
> +	LIST_HEAD(unshared_pcfgs);
> +	LIST_HEAD(shared_pcfgs);
> +	struct device_node *dn;
> +	struct bm_portal_config *pcfg;
> +	struct bman_portal *p;
> +	int cpu;
> +	struct cpumask offline_cpus;
> +
> +	/* Initialise the Bman (CCSR) device */
> +	for_each_compatible_node(dn, NULL, "fsl,bman") {
> +		if (!bman_init_ccsr(dn))
> +			pr_info("Bman err interrupt handler present\n");
> +		else
> +			pr_err("Bman CCSR setup failed\n");
> +	}

Shouldn't you abort on an error here?

And the message on success is a bit weird given the function name (also
too verbose) and the else message.

> +extern u16 bman_ip_rev; /* 0 if uninitialised, otherwise BMAN_REVx */

All global/static variables are 0 if uninitialized.

> +struct bm_portal_config {
> +	/* Corenet portal addresses;
> +	 * [0]==cache-enabled, [1]==cache-inhibited. */
> +	__iomem void *addr_virt[2];

Usually __iomem goes after the "void".

Any reason for this to be an array?

> +	struct resource addr_phys[2];

Why do you need the physical address?  Can you use of_ioremap() instead?

> +#ifdef CONFIG_FSL_BMAN_CONFIG
> +/* Hooks from bman_driver.c to bman_config.c */
> +int bman_init_ccsr(struct device_node *node);
> +#endif
> +
> +/* Hooks from bman_driver.c in to bman_high.c */

Document what functions do, not which files call or implement them (grep
can answer that, and the info will stay up to date).

> +/* Pool logic in the portal driver, during initialisation, needs to know if
> + * there's access to CCSR or not (if not, it'll cripple the pool allocator). */
> +#ifdef CONFIG_FSL_BMAN_CONFIG
> +int bman_have_ccsr(void);
> +#else
> +#define bman_have_ccsr() 0
> +#endif

static inline -- or just let the address stay NULL and test that.

> +/* This interface is needed in a few places and though it's not specific to
> + * USDPAA as such, creating a new header for it doesn't make any sense. The
> + * qbman kernel driver implements this interface and uses it as the backend for
> + * both the FQID and BPID allocators. The fsl_usdpaa driver also uses this
> + * interface for tracking per-process allocations handed out to user-space
> + */

I don't see an fsl_usdpaa driver in this patchset.  Is that coming
later, or is this a reference to something that won't go upstream any
time soon?

> +struct dpa_alloc {
> +	struct list_head free;
> +	spinlock_t lock;
> +	struct list_head used;
> +};
> +
> +#define DECLARE_DPA_ALLOC(name) \
> +	struct dpa_alloc name = { \
> +		.free = { \
> +			.prev = &name.free, \
> +			.next = &name.free \
> +		}, \
> +		.lock = __SPIN_LOCK_UNLOCKED(name.lock), \
> +		.used = { \
> +			 .prev = &name.used, \
> +			 .next = &name.used \
> +		 } \
> +	}
> +
> +/* The allocator is a (possibly-empty) list of these */
> +struct alloc_node {
> +	struct list_head list;
> +	u32 base;
> +	u32 num;
> +	/* refcount and is_alloced are only set
> +	   when the node is in the used list */
> +	unsigned int refcount;
> +	int is_alloced;
> +};

Is there any reason why lib/genalloc.c couldn't be used?

> +/* When copying aligned words or shorts, try to avoid memcpy() */
> +#define CONFIG_TRY_BETTER_MEMCPY

Hmm?

> +/***********************/
> +/* Misc inline assists */
> +/***********************/
> +
> +/* TODO: NB, we currently assume that hwsync() and lwsync() imply compiler
> + * barriers and that dcb*() won't fall victim to compiler or execution
> + * reordering with respect to other code/instructions that manipulate the same
> + * cacheline. */

If you don't want dcb* to be reordered relative to memory accesses, use
a memory clobber.

> +#define hwsync() __asm__ __volatile__ ("sync" : : : "memory")
> +#define lwsync() __asm__ __volatile__ (stringify_in_c(LWSYNC) : : : "memory")
> +#define dcbf(p) __asm__ __volatile__ ("dcbf 0,%0" : : "r" (p) : "memory")
> +#define dcbt_ro(p) __asm__ __volatile__ ("dcbt 0,%0" : : "r" (p))
> +#define dcbt_rw(p) __asm__ __volatile__ ("dcbtst 0,%0" : : "r" (p))
> +#define dcbi(p) dcbf(p)
> +#ifdef CONFIG_PPC_E500MC
> +#define dcbzl(p) __asm__ __volatile__ ("dcbzl 0,%0" : : "r" (p))
> +#define dcbz_64(p) dcbzl(p)
> +#define dcbf_64(p) dcbf(p)
> +/* Commonly used combo */
> +#define dcbit_ro(p) \
> +	do { \
> +		dcbi(p); \
> +		dcbt_ro(p); \
> +	} while (0)
> +#else
> +#define dcbz(p) __asm__ __volatile__ ("dcbz 0,%0" : : "r" (p))
> +#define dcbz_64(p) \
> +	do { \
> +		dcbz((u32)p + 32);	\
> +		dcbz(p);	\
> +	} while (0)
> +#define dcbf_64(p) \
> +	do { \
> +		dcbf((u32)p + 32); \
> +		dcbf(p); \
> +	} while (0)
> +/* Commonly used combo */
> +#define dcbit_ro(p) \
> +	do { \
> +		dcbi(p); \
> +		dcbi((u32)p + 32); \
> +		dcbt_ro(p); \
> +		dcbt_ro((u32)p + 32); \
> +	} while (0)
> +#endif /* CONFIG_PPC_E500MC */

This is not the place for such defines.  Put it in a common PPC header.

> +static inline u64 mfatb(void)
> +{
> +	u32 hi, lo, chk;
> +	do {
> +		hi = mfspr(SPRN_ATBU);
> +		lo = mfspr(SPRN_ATBL);
> +		chk = mfspr(SPRN_ATBU);
> +	} while (unlikely(hi != chk));
> +	return ((u64)hi << 32) | (u64)lo;
> +}

Why do you need the ATB?

> +#ifdef CONFIG_FSL_DPA_CHECKING
> +#define DPA_ASSERT(x) \
> +	do { \
> +		if (!(x)) { \
> +			pr_crit("ASSERT: (%s:%d) %s\n", __FILE__, __LINE__, \
> +				__stringify_1(x)); \
> +			dump_stack(); \
> +			panic("assertion failure"); \

WARN_ON

> +		} \
> +	} while (0)
> +#else
> +#define DPA_ASSERT(x)

#define DPA_ASSERT(x) do { (void)(x); } while (0)

or,

static inline void DPA_ASSERT(bool x)
{
}

> +/* memcpy() stuff - when you know alignments in advance */
> +#ifdef CONFIG_TRY_BETTER_MEMCPY
> +static inline void copy_words(void *dest, const void *src, size_t sz)
> +{
> +	u32 *__dest = dest;
> +	const u32 *__src = src;
> +	size_t __sz = sz >> 2;
> +	BUG_ON((unsigned long)dest & 0x3);
> +	BUG_ON((unsigned long)src & 0x3);
> +	BUG_ON(sz & 0x3);
> +	while (__sz--)
> +		*(__dest++) = *(__src++);
> +}
> +static inline void copy_shorts(void *dest, const void *src, size_t sz)
> +{
> +	u16 *__dest = dest;
> +	const u16 *__src = src;
> +	size_t __sz = sz >> 1;
> +	BUG_ON((unsigned long)dest & 0x1);
> +	BUG_ON((unsigned long)src & 0x1);
> +	BUG_ON(sz & 0x1);
> +	while (__sz--)
> +		*(__dest++) = *(__src++);
> +}

Doesn't PPC memcpy already check for alignment?

And if it didn't, this wouldn't be the right place to try to implement
something better.

> +static inline void copy_bytes(void *dest, const void *src, size_t sz)
> +{
> +	u8 *__dest = dest;
> +	const u8 *__src = src;
> +	while (sz--)
> +		*(__dest++) = *(__src++);
> +}

What does this accomplish beyond plain memcpy()?

> +/************/
> +/* Bootargs */
> +/************/
> +
> +/* Bman has "bportals=", they use the same syntax
> + * though; a comma-separated list of items, each item being a cpu index and/or a
> + * range of cpu indices, and each item optionally be prefixed by "s" to indicate
> + * that the portal associated with that cpu should be shared. See bman_driver.c
> + * for more specifics. */
> +static int __parse_portals_cpu(const char **s, unsigned int *cpu)
> +{
> +	*cpu = 0;
> +	if (!isdigit(**s))
> +		return -EINVAL;
> +	while (isdigit(**s))
> +		*cpu = *cpu * 10 + (*((*s)++) - '0');
> +	return 0;
> +}

What does this do that kstrtoull() doesn't?

> +/* Last updated for v00.79 of the BG */

Don't leave comments in the code making cryptic references to internal
documents...  and check that this is still correct based on the final,
published documentation.

> +static inline int bman_depletion_get(const struct bman_depletion *c, u8 bpid)
> +{
> +	return c->__state[__bmdep_word(bpid)] & __bmdep_bit(bpid);
> +}
> +static inline void bman_depletion_set(struct bman_depletion *c, u8 bpid)
> +{
> +	c->__state[__bmdep_word(bpid)] |= __bmdep_bit(bpid);
> +}
> +static inline void bman_depletion_unset(struct bman_depletion *c, u8 bpid)
> +{
> +	c->__state[__bmdep_word(bpid)] &= ~__bmdep_bit(bpid);
> +}

What do these do that test_bit, __set_bit, and __clear_bit don't?

-Scott
