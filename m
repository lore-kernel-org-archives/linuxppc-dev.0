Message-ID: <3B930D22.2C2F88A4@lge.com>
Date: Mon, 03 Sep 2001 13:54:58 +0900
From: Sangyong Lee <dobest@lge.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Promise Ultra66 - one more time
References: <200109010222.TAA05540@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> 2) My ATA driver only requires the following defines now (given the addresses
>    above). My question is what the values are for these addresses?
>
> #define CFG_ATA_BASE_ADDR     /* MBAR address (MBAR0?) */
> #define CFG_ATA_IDE0_OFFSET   /* Offset to Memory base for IDE0 ctrl */
> #define CFG_ATA_IDE1_OFFSET    /* Offset to Memory base for IDE0 ctrl */
> /*
>  * Definitions for accessing IDE controller registers
>  */
> #define CFG_ATA_DATA_OFFSET    /* Offset from IDE0/1 addr for DATA registers*/
> #define CFG_ATA_REG_OFFSET    /* Offset from IDE0/1 addr for Control regs */
> #define CFG_ATA_ALT_OFFSET    /* Offset for IDE0/1 alternate regs */
>
> The BASE_ADDR is one of the MBAR's, I believe this is MBAR0.
> The DATA, REG, and ALT offsets are the values you add to the BASE_ADDR
> to get at these registers.
>
> Second question: Given the MBAR's programmed above, what are the offsets
> for the standard ATA registers?
>
> Many thanks in advance; I know this has little todo with Linux or PPCBoot,
> however, I have sent several emails to Promise Tech Support and they have
> all but ignored my email messages.
>
>                                 -James
>

There are two standard ATA register sets
:command block registers, control block registers.
There are 8 command block registers and 2 control block registers

As you know all are 8 bit registers

Command block registers begin at address MBAR0.
And control block registers begin at address MBAR1.
You can confirm this from chip manual, I guess.

I've used two E-IDE controller: via and cmd.
like this.

see below macros.

And you can know  this from ATA spec.

#define IDE_BASE         MBAR0
#define IDE_CTL_BASE     MBAR1

#define IDE_DATA_REG     (IDE_BASE + 0)     /* Data register           */
#define IDE_ERROR_REG    (IDE_BASE + 1)     /* Error register          */
#define IDE_FEATURES_REG (IDE_BASE + 1)     /* Features register       */
#define IDE_SECCNT_REG   (IDE_BASE + 2)     /* Sector Count            */
#define IDE_SECTOR_REG   (IDE_BASE + 3)     /* Sector  number          */
#define IDE_CYLLO_REG    (IDE_BASE + 4)     /* Cylinder low            */
#define IDE_CYLHI_REG    (IDE_BASE + 5)     /* Cylinder high           */
#define IDE_DRVHD_REG    (IDE_BASE + 6)     /* Drive/Head              */
#define IDE_STATUS_REG   (IDE_BASE + 7)     /* Status                  */
#define IDE_COMMAND_REG  (IDE_BASE + 7)     /* Command                 */

#define IDE_CNTRL_REG    (IDE_CTL_BASE + 2) /* Control (when writing)   */
#define IDE_ALTSTATUS_REG IDE_CNTRL_REG     /* alternate status(when reading) */

hope this helps to you.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
