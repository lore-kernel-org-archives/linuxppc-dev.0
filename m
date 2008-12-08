Return-Path: <gerickson@nuovations.com>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
	by ozlabs.org (Postfix) with SMTP id CD0AADDF5F
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 09:08:15 +1100 (EST)
Date: Mon, 08 Dec 2008 14:08:01 -0800
Subject: Re: PPC4xx ECC Configs, Defines and Source
From: Grant Erickson <gerickson@nuovations.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Message-ID: <C562DAC1.1352D%gerickson@nuovations.com>
In-Reply-To: <20081208202152.GA10929@yoda.jdub.homelinux.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/8/08 12:21 PM, Josh Boyer wrote:
> On Mon, Dec 08, 2008 at 11:28:15AM -0800, Grant Erickson wrote:
>> Does anyone have any strong preferences on where configurations, definitions
>> and sources for a PPC4xx ECC monitoring and reporting driver should go?
>> 
>> Specifically, this concerns ECC handling code for the IBM DDR2 ECC
>> controller found in the 405EX[r], 440SP, 440SPe, 460EX and 460GT. However,
>> I'd like to do this in a way that other ECC contributors and maintainers can
>> build on.
>> 
>> Static Configs
>> --------------
>> 
>> I thought I might leverage the definitions Stefan Roese came up with for
>> u-boot for the base memory controller:
>> 
>>    CONFIG_PPC4xx_IBM_SDRAM:   Applicable to 405GP, 405CR, 405EP, AP1000,
>>                               and ML2
>>    CONFIG_PPC4xx_IBM_DDR:     Applicable to 440GP, 440GX, 440EP, and 440GR
>>    CONFIG_PPC4xx_DENALI_DDR2: Applicable to 440EPX and 440GRX
>>    CONFIG_PPC4xx_IBM_DDR2:    Applicable to 405EX[r], 440SP, 440SPe, 460EX
>>                               and 460GT.
> 
> Config options for what?  Enabling certain function?  Not sure that's needed
> if we can get away with it by just binding to the appropriate controller.

A good clarifying question. The configs would cover enabling compiled-in or
module support for the ECC monitoring and reporting code under discussion. I
suspect embedded platforms that do not have ECC would not want to compile
support for this.

>> Controlling whether ECC monitoring and reporting support should be compiled
>> in or a module:
>> 
>>    CONFIG_PPC_ECC or CONFIG_ECC
> 
> That's a bit too generic, unless you are trying to make a menu list under
> that which would be used to allow people to enable things like:
> CONFIG_4XX_ECC, CONFIG_FSL_ECC, etc.

I'll have to think about this some more. More elaboration below.

Today, we can choose CONFIG_405EX. That nails down CONFIG_PPC4xx_IBM_DDR2
leaving the only open question at that point as to whether CONFIG_ECC is
'y', 'n' or 'm'.

That said, I am sure I am thinking too "statically" about compile-time
configuration, however.

>> Source
>> ------
>> 
>>    arch/powerpc/sysdev/
>>        ppc4xx_ibm_sdram_ecc.c [future]
>>        ppc4xx_ibm_ddr_ecc.c [future]
>>        ppc4xx_ibm_ddr2_ecc.c
>>        ppc4xx_ibm_ddr2denali_ecc.c [future]
> 
> Why is there a need to have so many files?  I would think you could
> have a single file with all the ECC monitoring implementations in it
> called ppc4xx_ecc.c (or such).  Surely they would share some amount
> of code?

Based on my foggy memory of the 405GP (ibm_sdram_ecc) roughly ten years ago,
a cursory look at today's Denali controller (from u-boot code), and the
405EX[r], the ECC handling code for these is all quite different.

There will likely be some common, shared code and that could go in something
like ppc4xx_ecc.c. My focus is only on the 405EX[r] and the associated DDR2
controller, so further abstraction will probably occur once another
controller is integrated.

>> Headers and Defines
>> -------------------
>> 
>>    arch/powerpc/include/asm/ppc4xx_ibm_ddr2.h
>> 
>>    OR
>> 
>>    arch/powerpc/sysdev/ppc4xx_ibm_ddr2.h
> 
> That depends on the contents of the file.  If it's DCR defines, etc
> it should be in the dcr-regs.h file.  Otherwise, I would think having
> the header in sysdev should be sufficient unless there is some other
> facility that would need whatever the contents there are.

Thanks for the confirmation. That was my operating assumption. They would be
DCR sub-definitions, such as:

    /*
     * Macro for generating register field mnemonics
     */
    #define PPC_REG_BITS        32
    #define PPC_REG_VAL(bit, val) ((val) << ((PPC_REG_BITS - 1) - (bit)))
    
    /*
     * Memory controller registers
     */
    #define SDRAM_BESR     0x00    /* PLB bus error status (read/clear) */
    #define SDRAM_BESRT    0x01    /* PLB bus error status (test/set)   */
    #define SDRAM_BEARL    0x02    /* PLB bus error address low         */
    #define SDRAM_BEARH    0x03    /* PLB bus error address high        */
    #if !defined(CONFIG_405EX)
    #define SDRAM_MCSTAT   0x14    /* memory controller status          */
    #else
    #define SDRAM_MCSTAT   0x1F    /* memory controller status          */
    #endif
    #define SDRAM_MCOPT1   0x20    /* memory controller options 1       */
    #define SDRAM_MCOPT2   0x21    /* memory controller options 2       */
    #define SDRAM_ECCCR    0x98    /* ECC error status                  */
    #define SDRAM_ECCES    SDRAM_ECCCR
    
    /*
     * Memory Controller Bus Error Status
     */
    #define SDRAM_BESR_MASK        PPC_REG_VAL(7, 0xFF)
    #define SDRAM_BESR_M0ID_MASK   PPC_REG_VAL(3, 0xF)
    #define SDRAM_BESR_M0ID_ICU    PPC_REG_VAL(3, 0x0)
    #define SDRAM_BESR_M0ID_PCIE0  PPC_REG_VAL(3, 0x1)
    #define SDRAM_BESR_M0ID_PCIE1  PPC_REG_VAL(3, 0x2)
    #define SDRAM_BESR_M0ID_DMA    PPC_REG_VAL(3, 0x3)
    #define SDRAM_BESR_M0ID_DCU    PPC_REG_VAL(3, 0x4)
    #define SDRAM_BESR_M0ID_OPB    PPC_REG_VAL(3, 0x5)
    #define SDRAM_BESR_M0ID_MAL    PPC_REG_VAL(3, 0x6)
    #define SDRAM_BESR_M0ID_SEC    PPC_REG_VAL(3, 0x7)
    #define SDRAM_BESR_M0ET_MASK   PPC_REG_VAL(6, 0x7)
    #define SDRAM_BESR_M0ET_NONE   PPC_REG_VAL(6, 0x0)
    #define SDRAM_BESR_M0ET_ECC    PPC_REG_VAL(6, 0x1)
    #define SDRAM_BESR_M0RW_WRITE  PPC_REG_VAL(7, 0)
    #define SDRAM_BESR_M0RW_READ   PPC_REG_VAL(8, 1)
    
    /*
     * Memory Controller Options 1
     */
    #define SDRAM_MCOPT1_MCHK_MASK       0x30000000
    #define SDRAM_MCOPT1_MCHK_NON        0x00000000 /* No ECC gen        */
    #define SDRAM_MCOPT1_MCHK_GEN        0x20000000 /* ECC gen           */
    #define SDRAM_MCOPT1_MCHK_CHK        0x10000000 /* ECC gen & check   */
    #define SDRAM_MCOPT1_MCHK_CHK_REP    0x30000000 /* ECC gen, chk, rpt */
    #define SDRAM_MCOPT1_MCHK_CHK_DECODE(n) ((((u32)(n))>>28)&0x3)
    
    /*
     * ECC Error Status
     */
    #define SDRAM_ECCES_MASK                 PPC_REG_VAL(21, 0x3FFFFF)
    #define SDRAM_ECCES_BNCE_MASK            PPC_REG_VAL(15, 0xFFFF)
    #define SDRAM_ECCES_BNCE_ENCODE(lane)    PPC_REG_VAL(((lane) & 0xF), 1)
    #define SDRAM_ECCES_CKBER_MASK           PPC_REG_VAL(17, 0x3)
    #define SDRAM_ECCES_CKBER_NONE           PPC_REG_VAL(17, 0)
    #define SDRAM_ECCES_CKBER_16_ECC_0_3     PPC_REG_VAL(17, 2)
    #define SDRAM_ECCES_CKBER_32_ECC_0_3     PPC_REG_VAL(17, 1)
    #define SDRAM_ECCES_CKBER_32_ECC_4_8     PPC_REG_VAL(17, 2)
    #define SDRAM_ECCES_CKBER_32_ECC_0_8     PPC_REG_VAL(17, 3)
    #define SDRAM_ECCES_CE                   PPC_REG_VAL(18, 1)
    #define SDRAM_ECCES_UE                   PPC_REG_VAL(19, 1)
    #define SDRAM_ECCES_BKNER_MASK           PPC_REG_VAL(21, 0x3)
    #define SDRAM_ECCES_BK0ER                PPC_REG_VAL(20, 1)
    #define SDRAM_ECCES_BK1ER                PPC_REG_VAL(21, 1)

Regarding other items that might go into the DTS, I don't have enough
visibility into the other processors that this controller is used on (440SP,
440SPe, 460EX and 460GT) beyond the 405EX[r]; however, I am guessing the
interrupts are almost guaranteed to be different from processor to processor
suggesting an entry akin to:

        SDRAM0: memory-controller {
            compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
            dcr-reg = <0x010 0x002>;

            ECC0: ecc {
                ...
                interrupt-parent = <&SDRAM0>;
                interrupts = <0x0 0x1>;
                interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
                                 /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
                ...
            };
        };

or:

        SDRAM0: memory-controller {
            compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
            dcr-reg = <0x010 0x002>;
            ...
            interrupt-parent = <&SDRAM0>;
            interrupts = <0x0 0x1>;
            interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
                             /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
            ...
        };

or some such. My DTS expertise is near zero and growing.

Regards,

Grant
