Return-Path: <gerickson@nuovations.com>
Received: from relay02.pair.com (relay02.pair.com [209.68.5.16])
	by ozlabs.org (Postfix) with SMTP id 4E956DDF18
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 06:13:59 +1100 (EST)
Date: Thu, 18 Dec 2008 11:13:34 -0800
Subject: Re: [PATCH v2] Add PPC/4xx "ibm,sdram-4xx-ddr2" EDAC MC Driver
From: Grant Erickson <gerickson@nuovations.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Message-ID: <C56FE0DE.1387F%gerickson@nuovations.com>
In-Reply-To: <20081218175622.GA18201@yoda.jdub.homelinux.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/18/08 9:56 AM, Josh Boyer wrote:
> On Wed, Dec 17, 2008 at 05:42:21PM -0800, Grant Erickson wrote:
>> This adds support for an EDAC memory controller adaptation driver for
>> the "ibm,sdram-4xx-ddr2" ECC controller realized in the AMCC PowerPC
>> 405EX[r].
>> 
>> Signed-off-by: Grant Erickson <gerickson@nuovations.com>
>> ---
>> 
>> drivers/edac/Kconfig                |    9 +
>> drivers/edac/Makefile               |    2 +-
>> drivers/edac/ppc4xx_edac.c          | 1332
>> +++++++++++++++++++++++++++++++++++
>> drivers/edac/ppc4xx_edac.h          |  179 +++++
>> 4 files changed, 1521 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
>> new file mode 100644
>> index 0000000..5caadc6
>> --- /dev/null
>> +++ b/drivers/edac/ppc4xx_edac.c
>> @@ -0,0 +1,1332 @@
>> [ ... ]
>> +/*
>> + * This file implements a driver for monitoring and handling events
>> + * associated with the IMB DDR2 ECC controller found in the AMCC/IBM
>> + * 405EX[r], 440SP, 440SPe, 460EX, 460GT and 460SX.
>> + *
>> + * As realized in the 405EX[r], this controller features:
>> + *
>> [ ... ]
>> + *
>> + * As realized in the 440SP and 440SPe, this controller changes/adds:
>> + *
>> [ ... ]
>> + *
>> + * As realized in the 460EX and 460GT, this controller changes/adds:
>> + *
>> [ ... ]
>> + *
>> + * At present, this driver has ONLY been tested against the controller
>> + * realization in the 405EX[r] on the AMCC Kilauea and Haleakala
>> + * boards (256 MiB w/o ECC memory soldered onto the board) and a
>> + * proprietary board based on those designs (128 MiB ECC memory, also
>> + * soldered onto the board).
>> + *
>> + * Dynamic feature detection and handling needs to be added for the
>> + * other realizations of this controller listed above.
> 
> Then I think you should omit anything about 440SP and 460 until it works.

I'd like to include as many breadcrumbs as possible--in the form of
comments, so that in days, weeks, months or years when I or someone else
come along to implement support for said controller realizations, there's
some information to get started in the right direction.

>> +#define PPC4XX_EDAC_MODULE_REVISION " v1.0.0 " __DATE__
> 
> Do you really want __DATE__ there?  It's sort of meaningless.

I'd agree; however, this seems to be the prevailing convention for this
driver:

    % grep '__DATE__' *
    amd76x_edac.c:#define AMD76X_REVISION   " Ver: 2.0.2 "  __DATE__
    e752x_edac.c:#define E752X_REVISION     " Ver: 2.0.2 " __DATE__
    e7xxx_edac.c:#define    E7XXX_REVISION " Ver: 2.0.2 " __DATE__
    edac_module.c:#define EDAC_VERSION "Ver: 2.1.0 " __DATE__
    i5000_edac.c:#define I5000_REVISION    " Ver: 2.0.12 " __DATE__
    i82860_edac.c:#define  I82860_REVISION " Ver: 2.0.2 " __DATE__
    i82875p_edac.c:#define I82875P_REVISION " Ver: 2.0.2 " __DATE__
    i82975x_edac.c:#define I82975X_REVISION " Ver: 1.0.0 " __DATE__
    mpc85xx_edac.h:#define MPC85XX_REVISION " Ver: 2.0.0 " __DATE__
    mv64x60_edac.h:#define MV64x60_REVISION " Ver: 2.0.0 " __DATE__
    r82600_edac.c:#define R82600_REVISION   " Ver: 2.0.2 " __DATE__

When in Rome or do the right thing?

>> +/*
>> + * Convenience macros to support indirect DCR read and write access to
>> + * the SDRAM controller registers.
>> + *
>> + * TODO: If in the future the indirect address and data windows for
>> + * this controller are not the same across realizations, the windows
>> + * will have to be read from the device tree and these mnemonic
>> + * accessors will have to become programmatic in a manner similar to
>> + * the existing dcr_{map,unmap,read,write} functions.
>> + */
>> +#define mfsdram(reg)   mfdcri(SDRAM0, SDRAM_ ## reg)
>> +#define mtsdram(reg, value)  mtdcri(SDRAM0, SDRAM_ ## reg, value)
> 
> I have no general problems with using this, but others might want you to
> use dcr_read and dcr_write.  They get the DCR offsets from the device
> tree.  It would be a cleaner way to handle that.

I covered this thread at
<http://ozlabs.org/pipermail/linuxppc-dev/2008-December/066055.html>.
Provided you're OK with this as-is, I'll leave it as-is.

I'd prefer more perspective across a broader set of IDCR address/data window
usage cases before I proposed a dcri_read/dcri_write implementation.

>> +/*
>> + * PPC4xx SDRAM memory controller private instance data
>> + */
>> +struct ppc4xx_edac_pdata {
>> + struct {
>> +  int sec; /* Single-bit correctable error IRQ assigned */
>> +  int ded; /* Double-bit detectable error IRQ assigned */
>> + } irqs;
>> +};
> 
> Is the sub-structure for irqs really needed?  This could just be
> 
> struct ppc4xx_edac_irqs {
> int sec;
> int ded;
> };

Were I to implement feature flags and other things to further parameterize
the driver to handle the aforementioned controller realizations, I'd have
defined this structure as:

    struct ppc4xx_edac_pdata {
        u32 features;
        unsigned int banks;
        size_t width;
        struct {
            int sec;    /* Single-bit correctable error IRQ assigned */
            int ded;    /* Double-bit detectable error IRQ assigned */
        } irqs;
    };

or some such. Consequently, I would prefer leaving the structure as-is and
adding new fields than add new fields and rename the structure.

>> +/* Function Prototypes */
>> +
>> +static int ppc4xx_edac_probe(struct of_device *device,
>> +        const struct of_device_id *device_id);
>> +static int ppc4xx_edac_remove(struct of_device *device);
> 
> Are these really needed?  Hint: no.

>> +static struct of_device_id ppc4xx_edac_match[] = {
>> + {
>> +  .compatible = "ibm,sdram-4xx-ddr2"
>> + },
>> + { }
>> +};
>> +
>> +static struct of_platform_driver ppc4xx_edac_driver = {
>> + .match_table  = ppc4xx_edac_match,
>> + .probe   = ppc4xx_edac_probe,
>> + .remove   = ppc4xx_edac_remove,
>> + .driver   = {
>> +  .owner = THIS_MODULE,
>> +  .name = PPC4XX_EDAC_MODULE_NAME
>> + }
>> +};
> 
> If you move these two definitions below the functions, you
> don't need the prototypes.

Agreed. However, since neither Linux coding style nor checkpatch.pl says
anything about this and my coding style prefers up-top declaration of types
and globals, I'd prefer to leave it as-is

>> +/*
>> + * Strings associated with PLB master IDs capable of being posted in
>> + * SDRAM_BESR or SDRAM_WMIRQ on uncorrectable ECC errors.
>> + */
>> +static const char * const ppc4xx_plb_masters[9] = {
>> + [SDRAM_PLB_M0ID_ICU] = "ICU",
>> + [SDRAM_PLB_M0ID_PCIE0] = "PCI-E 0",
>> + [SDRAM_PLB_M0ID_PCIE1] = "PCI-E 1",
>> + [SDRAM_PLB_M0ID_DMA] = "DMA",
>> + [SDRAM_PLB_M0ID_DCU] = "DCU",
>> + [SDRAM_PLB_M0ID_OPB] = "OPB",
>> + [SDRAM_PLB_M0ID_MAL] = "MAL",
>> + [SDRAM_PLB_M0ID_SEC] = "SEC",
>> + [SDRAM_PLB_M0ID_AHB] = "AHB"
>> +};
> 
> This seems broken.  The PLB master IDs are going to vary both in
> order and in overall number depending on the SoC that is being
> used.  At the very least, you might name this "ppc405ex_plb_masters"
> since that is what this really is.

Fair enough, although the pre-implementation discussion from Ben, Stefan and
you seemed OK with calling it ppc4xx_edac.c and then evolving it as
necessary for other realizations of this controller as well as other PPC4xx
controllers. Between the "vocal":

    if (!of_device_is_compatible(np, "ibm,sdram-405ex") &&
        !of_device_is_compatible(np, "ibm,sdram-405exr")) {
        ppc4xx_edac_notice("Only the PPC405EX[r] is supported.\n");
        return -ENODEV;
    }

check and the comments, I don't think that there is any ambiguity as to what
the driver does and does not work with.

Again, I'm happy to change this instance, but I believe that's a sweater
thread that leads to changing the rest of the driver name space accordingly.

>> +static bool
>> +ppc4xx_edac_check_bank_error(const struct ppc4xx_ecc_status *status,
>> +        unsigned int bank)
>> +{
>> + switch (bank) {
>> +
>> + case 0:  return (status->ecces & SDRAM_ECCES_BK0ER);
>> + case 1:  return (status->ecces & SDRAM_ECCES_BK1ER);
>> + default: return false;
> 
> Your switch statements throughout aren't in Linux coding
> conventions.  You might get asked to fix those.

I'll fix those.

> So, I am not an expert at the EDAC subsystem.  Just looking at the
> number of functions that get call from this interrupt handler, I'm
> wondering if a significant amount of time could be spent here.  With
> all the message building and such, it seems like it could be error
> prone.

The message building functions are really best-effort, straight-through, so
there should be little room if any for error-proneness. Though, snprintf
contained therein is fairly costly as functions go.

> Do you have an idea of the duration of one of these events?  Could
> this schedule a work queue to handle it outside of the hard IRQ
> context?

I'll take some measurements for the worst case message length time. I
certainly thought about a work queue; however, my gut feeling was that it
wasn't warranted.

Stay tuned for measurement data.

>> +static int __devinit
>> +ppc4xx_edac_probe(struct of_device *op, const struct of_device_id *match)
>> +{
>> + int status = 0;
>> + u32 mcopt1, memcheck;
>> + const struct device_node *np = op->node;
>> + struct mem_ctl_info *mci = NULL;
>> + static int ppc4xx_edac_index;
> 
> What does this count?

It's an instance index, passed to the EDAC allocator here:

>> + mci = edac_mc_alloc(sizeof(struct ppc4xx_edac_pdata),
>> +       ppc4xx_edac_nr_csrows,
>> +       ppc4xx_edac_nr_chans,
>> +       ppc4xx_edac_index);

and then updated here on successful instance probing:

>> + ppc4xx_edac_index++;
>> +
>> + return 0;
>> +
>> + fail1:
>> + edac_mc_del_mc(mci->dev);
>> +
>> + fail:
>> + edac_mc_free(mci);
>> +
>> + done:
>> + return status;
>> +}
>>
>> [ ... ]
>>
>> --- /dev/null
>> +++ b/drivers/edac/ppc4xx_edac.h
>> @@ -0,0 +1,179 @@
>> [ ... ]
>> +
>> +/*
>> + * Macro for generating register field mnemonics
>> + */
>> +#define PPC_REG_BITS   32
>> +#define PPC_REG_VAL(bit, val)  ((val) << ((PPC_REG_BITS - 1) - (bit)))
>> +#define PPC_REG_DECODE(bit, val) ((val) >> ((PPC_REG_BITS - 1) - (bit)))
> 
> Are these really needed?  Perhaps it's just me, but I find the code
> much less readable when these are used.

Yes. I can look-up the user manual and see that:

    #define SDRAM_BESR_M0ET_ECC        PPC_REG_VAL(6, 1)

precisely matches what's printed in the register definition table. Whereas:

    #define SDRAM_BESR_M0ET_ECC        0x02000000

requires more time to think through in terms of remembering that PPC bit
ordering is different, etc. It's a case of "ta-may-tow" / "tow-mah-tow" I
suppose.

Thanks for your prompt and pointed review. I'll turn around v3 with the
incorporated feedback.

Regards,

Grant
