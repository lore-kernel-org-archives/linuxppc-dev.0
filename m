Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 35030DDF17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 04:01:57 +1000 (EST)
Message-ID: <462F98B4.2000108@ru.mvista.com>
Date: Wed, 25 Apr 2007 22:06:44 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Xilinx framebuffer device driver
References: <462E0D5C.1090105@ru.mvista.com> <200704250035.18673.arnd@arndb.de>
In-Reply-To: <200704250035.18673.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Rick Moleres <rick.moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Arnd,

Arnd Bergmann wrote:
>> +       .activate =     FB_ACTIVATE_NOW,
>> +       .height =       99,     /* in mm of NEC NL6448BC20-08 on ML300 */
>> +       .width =        132     /* in mm of NEC NL6448BC20-08 on ML300 */
>> +};
> 
> The size looks very specific to a particular display hardware. I guess
> when the driver gets converted to an of_platform_driver, this should come
> from the device tree.
> 
> Until then, maybe a config option, with a reasonable default would be
> right.

I could add these to platform data.
Together with the "use DCR access" option.
Say,

--------------------------------------------------------
struct xilinxfb_platform_data {
	u32 use_dcr;
	u32 screen_height_mm;
	u32 screen_width_mm;
};

static struct xilinxfb_platform_data xilinxfb_pdata = {
#if defined(XPAR_TFT_0_USE_DCR) && (XPAR_TFT_0_USE_DCR != 0)
	.use_dcr = 1;
#else
	.use_dcr = 0;
#endif
	.screen_height_mm = CONFIG_FB_XILINX_SCR_HEIGHT;
	.screen_width_mm = CONFIG_FB_XILINX_SCR_WIDTH;
};

...

/* ML300/403 reference design framebuffer */
#if defined(XPAR_TFT_0_BASEADDR)
	{
		.name		= "xilinxfb",
		.id		= 0,
		.dev.platform_data = &xilinxfb_pdata,
		.num_resources	= 1,
		.resource = (struct resource[]) {
			{
				.start	= XPAR_TFT_0_BASEADDR,
				.end	= XPAR_TFT_0_BASEADDR+7,
				.flags	= IORESOURCE_IO,
			},
		},
	},
#endif
--------------------------------------------------------

Does it look OK?

>> +
>> +struct xilinxfb_drvdata {
>> +
>> +       struct fb_info  info;           /* FB driver info record */
>> +
>> +       unsigned long   regs_phys;      /* phys. address of the control registers */
>> +       u32             *regs;          /* virt. address of the control registers */
>> +
>> +       unsigned char   *fb_virt;       /* virt. address of the frame buffer */
> 
> The virtual addresses should be marked as __iomem, so you can check the correct
> usage with sparse.

OK. Thanks.

> Not sure about regs_phys. Can this be beyond the 32 bit limit on any machine?

The driver is for Xilinx FPGAs only (the video controller is the "soft core" IP
block).
My personal feeling is that someday in the future Virtex FPGAs would carry ppc440 "hard" cores.
But all current FPGAs have only ppc405 "hard core" CPU blocks inside (0, 1 or several per chip).
Another option is to use Microblaze "soft core" CPU which is 32-bit too.
I doubt someone would connect a Virtex FPGA to a "standalone" CPU to use
the FPGA as video controller (this is not impossible though).

I.e. for the moment
   u32	regs_phys;
should be OK.

Other options could be
   dma_addr_t	regs_phys;
or
   resource_size_t	regs_phys;
which are u32 or u64 depending on the architecture.
But both don't sound like intended specifically for phys. addresses
(not necessary DMA-able).

What would you recommend?

>> +
>> +       drvdata = kmalloc(sizeof(struct xilinxfb_drvdata), GFP_KERNEL);
>> +       if (!drvdata) {
>> +               printk(KERN_ERR "Couldn't allocate device private record\n");
>> +               return -ENOMEM;
>> +       }
>> +       memset((void*)drvdata, 0, sizeof(struct xilinxfb_drvdata));
> 
> Use
> 	drvdata = kzalloc(sizeof (*drvdata), GFP_KERNEL);

Oops.. Sure I will.

>> +       drvdata->regs_phys = regs_res->start;
>> +       drvdata->regs = (u32 *) ioremap(regs_res->start, 8);
> 
> u32 __iomem*

OK

> 	Arnd <><

Thanks,
Andrei
