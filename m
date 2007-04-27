Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 75E6ADDF43
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 16:48:18 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so603541ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 23:48:16 -0700 (PDT)
Message-ID: <528646bc0704262348s7830c59fx383fb8fad8822ef8@mail.gmail.com>
Date: Fri, 27 Apr 2007 00:48:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "John Williams" <jwilliams@itee.uq.edu.au>
Subject: Re: [RFC] SystemACE driver - abstract register ops
In-Reply-To: <463199EF.3090900@itee.uq.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <463199EF.3090900@itee.uq.edu.au>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/27/07, John Williams <jwilliams@itee.uq.edu.au> wrote:
> Grant,
>
> Thanks for your work on the SystemACE driver - I'll be porting/merging
> this across to MicroBlaze very shortly.
>
> Given that SysACE can be hooked up in any number of ways, bit widths,
> endians, PPC/Microblaze, can you please offer your comments on the
> attached patch?

HAHAHAHAHAHAHA!  Guess what I just finished writing before receiving your email.

I've got something very similar that I'm testing now, but thanks for
the patch.  I feel better that someone else has the same opinion on
how to hook up the bus.

Cheers,
g.

>
> It introduce a private ace_reg_ops structure, with various member
> functions for the different kinds of accesses to the HW.
>
> This patch should not change the functionality of your original driver
> at all, it's just groundwork for what's to come.
>
> I recognise that it adds indirection into the various access paths, and
> potentially a little bloat.  Whether this is better than #if
> 1...#else...#endif is debatable.
>
> Similar issues will arise for most (all?) of the Xilinx drivers that we
> will share between PPC and MicroBlaze.  Hopefully we can converge on a
> nice consistent and clean way of handling these dual arch drivers.
>
> Cheers,
>
> John
>
> Index: linux-2.6.x-petalogix/drivers/block/xsysace.c
> ===================================================================
> --- linux-2.6.x-petalogix/drivers/block/xsysace.c       (revision 2628)
> +++ linux-2.6.x-petalogix/drivers/block/xsysace.c       (working copy)
> @@ -73,6 +73,11 @@
>   *    interrupt, then the kernel timer will expire and the driver can
>   *    continue where it left off.
>   *
> + *  SystemACE can be wired up in different endian orders and data widths.
> + *  It works on both PPC and MicroBlaze architectures.  For this reason,
> + *  an ace_reg_ops structure is used that abstracts away low level
> + *  endian/width/arch access to the HW registers.
> +
>   * To Do:
>   *    - Add FPGA configuration control interface.
>   *    - Request major number from lanana
> @@ -161,32 +166,120 @@
>  /* ---------------------------------------------------------------------
>   * Low level register access
>   */
> +struct reg_ops {
> +       u8 (*read8)(void *addr);
> +       u16 (*read16)(void *addr);
> +       u32 (*read32)(void *addr);
> +       u32 (*readdata)(void *addr);
>
> -/* register access macros */
> +       void (*write16)(void *addr, u16 val);
> +       void (*write32)(void *addr, u32 val);
> +       void (*writedata)(void *addr, u32 val);
> +};
> +
> +#define ace_reg_read8(ace, reg) (ace->ops->read8(ace->baseaddr + reg))
> +#define ace_reg_read16(ace, reg) (ace->ops->read16(ace->baseaddr + reg))
> +#define ace_reg_readdata(ace, reg) (ace->ops->readdata(ace->baseaddr + reg))
> +#define ace_reg_read32(ace, reg) (ace->ops->read32(ace->baseaddr+reg))
> +#define ace_reg_write16(ace, reg, val) (ace->ops->write16(ace->baseaddr+reg, val))
> +#define ace_reg_writedata(ace, reg, val) (ace->ops->writedata(ace->baseaddr + reg, val))
> +#define ace_reg_write32(ace, reg, val) (ace->ops->write32(ace->baseaddr+reg, val))
> +
> +/* register access functions */
>  #if 1 /* Little endian 16-bit regs */
> -#define ace_reg_read8(ace, reg) in_8(ace->baseaddr + reg)
> -#define ace_reg_read16(ace, reg) in_le16(ace->baseaddr + reg)
> -#define ace_reg_readdata(ace, reg) in_be16(ace->baseaddr + reg)
> -#define ace_reg_read32(ace, reg) ((in_le16(ace->baseaddr + reg+2) << 16) | \
> -                                  (in_le16(ace->baseaddr + reg)))
> -#define ace_reg_write16(ace, reg, val) out_le16(ace->baseaddr + reg, val)
> -#define ace_reg_writedata(ace, reg, val) out_be16(ace->baseaddr + reg, val)
> -#define ace_reg_write32(ace, reg, val) { \
> -                           out_le16(ace->baseaddr + reg+2, (val) >> 16); \
> -                           out_le16(ace->baseaddr + reg, val); \
> -                       }
> +static u8 ace_le16_read8(void *addr)
> +{
> +       return in_8(addr);
> +}
> +
> +static u16 ace_le16_read16(void *addr)
> +{
> +       return in_le16(addr);
> +}
> +
> +static u32 ace_le16_read32(void *addr)
> +{
> +       return ((in_le16(addr+2) << 16) | (in_le16(addr)));
> +}
> +
> +static u32 ace_le16_readdata(void *addr)
> +{
> +       return in_be16(addr);
> +}
> +
> +static void ace_le16_write16(void *addr, u16 val)
> +{
> +       out_le16(addr, val);
> +}
> +
> +static void ace_le16_write32(void *addr, u32 val)
> +{
> +       out_le16(addr+2,(val) >> 16); \
> +       out_le16(addr, val);
> +}
> +
> +static void ace_le16_writedata(void *addr, u32 val)
> +{
> +       out_be16(addr, val);
> +}
> +
> +static struct reg_ops ace_ops = {
> +       .read8  =       ace_le16_read8,
> +       .read16 =       ace_le16_read16,
> +       .read32 =       ace_le16_read32,
> +       .readdata =     ace_le16_readdata,
> +       .write16 =      ace_le16_write16,
> +       .write32 =      ace_le16_write32,
> +       .writedata =    ace_le16_writedata
> +} ;
> +
>  #else /* Big endian 16-bit regs */
> -#define ace_reg_read8(ace, reg) in_8(ace->baseaddr + reg)
> -#define ace_reg_read16(ace, reg) in_be16(ace->baseaddr + reg)
> -#define ace_reg_readdata(ace, reg) in_le16(ace->baseaddr + reg)
> -#define ace_reg_read32(ace, reg) ((in_be16(ace->baseaddr + reg+2) << 16) | \
> -                                  (in_be16(ace->baseaddr + reg)))
> -#define ace_reg_write16(ace, reg, val) out_be16(ace->baseaddr + reg, val)
> -#define ace_reg_writedata(ace, reg, val) out_le16(ace->baseaddr + reg, val)
> -#define ace_reg_write32(ace, reg, val) { \
> -                           out_be16(ace->baseaddr + reg+2, (val) >> 16); \
> -                           out_be16(ace->baseaddr + reg, val); \
> -                       }
> +static u8 ace_be16_read8(void *addr)
> +{
> +       return in_8(addr);
> +}
> +
> +static u16 ace_be16_read16(void *addr)
> +{
> +       return in_be16(addr);
> +}
> +
> +static u32 ace_be16_read32(void *addr)
> +{
> +       return ((in_be16(addr+2) << 16) | (in_be16(addr)));
> +}
> +
> +static u32 ace_be16_readdata(void *addr)
> +{
> +       return in_le16(addr);
> +}
> +
> +static void ace_be16_write16(void *addr, u16 val)
> +{
> +       out_be16(addr, val);
> +}
> +
> +static void ace_be16_write32(void *addr, u32 val)
> +{
> +       out_be16(addr+2,(val) >> 16); \
> +       out_be16(addr, val);
> +}
> +
> +static void ace_be16_writedata(void *addr, u32 val)
> +{
> +       out_le16(addr, val);
> +}
> +
> +static struct reg_ops ace_ops = {
> +       .read8  =       ace_be16_read8,
> +       .read16 =       ace_be16_read16,
> +       .read32 =       ace_be16_read32,
> +       .readdata =     ace_be16_readdata,
> +       .write16 =      ace_be16_write16,
> +       .write32 =      ace_be16_write32,
> +       .writedata =    ace_be16_writedata
> +} ;
> +
>  #endif
>
>  struct ace_device {
> @@ -222,6 +315,9 @@
>         int bus_width;  /* 0 := 8 bit; 1 := 16 bit */
>         int lock_count;
>
> +       /* Register access ops */
> +       struct reg_ops *ops;
> +
>         /* Block device data structures */
>         spinlock_t lock;
>         struct device *dev;
> @@ -995,6 +1091,8 @@
>         ace->id = dev->id;
>         ace->irq = NO_IRQ;
>
> +       ace->ops=&ace_ops;
> +
>         for (i = 0; i < dev->num_resources; i++) {
>                 if (dev->resource[i].flags & IORESOURCE_MEM)
>                         ace->physaddr = dev->resource[i].start;
>
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
