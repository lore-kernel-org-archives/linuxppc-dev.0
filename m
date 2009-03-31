Return-Path: <wg@grandegger.com>
Message-ID: <49D26CFB.3070502@grandegger.com>
Date: Tue, 31 Mar 2009 21:20:27 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/8] powerpc/85xx: Add support for the "socrates" board
	(MPC8544).
References: <20090331123727.853787299@denx.de>	
	<20090331124035.594457231@denx.de>
	<fa686aa40903310857w57b9d020i71d56f33ede4e875@mail.gmail.com>
In-Reply-To: <fa686aa40903310857w57b9d020i71d56f33ede4e875@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sergei Poselenov <sposelenov@emcraft.com>, devicetree-discuss@ozlabs.org,
	Ilya Yanok <yanok@emcraft.com>,
	Dmitry Rakhchev <rda@emcraft.com>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> On Tue, Mar 31, 2009 at 6:37 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Supported are Ethernet, serial console, I2C, I2C-based RTC and
>> temperature sensors, NOR and NAND flash, PCI, USB, CAN and Lime
>> display controller.
>>
>> The multiplexing of FPGA interrupts onto PowerPC interrupt lines is
>> supported through our own fpga_pic interrupt controller driver.
>>
>> For example the SJA1000 controller is level low sensitive connected to
>> fpga_pic line 2 and is routed to the second (of three) irq lines to
>> the CPU:
>>
>>    can@3,100 {
>>            compatible = "philips,sja1000";
>>            reg = <3 0x100 0x80>;
>>            interrupts = <2 2>;
>>            interrupts = <2 8 1>;   // number, type, routing
>>            interrupt-parent = <&fpga_pic>;
>>    };
>>
>> Signed-off-by: Sergei Poselenov <sposelenov@emcraft.com>
>> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> Signed-off-by: Dmitry Rakhchev <rda@emcraft.com>
>> ---
>>  arch/powerpc/boot/dts/socrates.dts              |  338 +++++
>>  arch/powerpc/configs/85xx/socrates_defconfig    | 1410 ++++++++++++++++++++++++
> 
> I always ask this question: Do you really need a board specific
> defconfig file?  We are multiplatform now.
> 
>>  arch/powerpc/platforms/85xx/Kconfig             |    6
>>  arch/powerpc/platforms/85xx/Makefile            |    1
>>  arch/powerpc/platforms/85xx/socrates.c          |  133 ++
>>  arch/powerpc/platforms/85xx/socrates_fpga_pic.c |  327 +++++
>>  arch/powerpc/platforms/85xx/socrates_fpga_pic.h |   16
> 
> socrates_fpga_pic is only ever going to be used by socrates.c.  I'd
> roll the two socrates.c files into one and eliminate the header file.
> 
>> Index: linux-2.6/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
>> ===================================================================
>> --- /dev/null
>> +++ linux-2.6/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
> [...]
>> +struct socrates_fpga_irq_info {
>> +       unsigned int irq_line;
>> +       int type;
>> +};
>> +
>> +/*
>> + * Interrupt routing and type table
>> + *
>> + * IRQ_TYPE_NONE means the interrupt type is configurable,
>> + * otherwise it's fixed to the specified value.
>> + */
>> +static struct socrates_fpga_irq_info fpga_irqs[SOCRATES_FPGA_NUM_IRQS] = {
>> +       [0] = {0, IRQ_TYPE_NONE},
>> +       [1] = {0, IRQ_TYPE_LEVEL_HIGH},
>> +       [2] = {0, IRQ_TYPE_LEVEL_LOW},
>> +       [3] = {0, IRQ_TYPE_NONE},
>> +       [4] = {0, IRQ_TYPE_NONE},
>> +       [5] = {0, IRQ_TYPE_NONE},
>> +       [6] = {0, IRQ_TYPE_NONE},
>> +       [7] = {0, IRQ_TYPE_NONE},
>> +       [8] = {0, IRQ_TYPE_LEVEL_HIGH},
>> +};
> 
> It is good practice to use named elements in initializers: {.type =
> IRQ_TYPE_LEVEL_HIGH},
> 
> Static variables are initialized to zero.  Everything that is 0 can be
> dropped from this initializer (lines 0 and 3-7, and the irq_line
> field).

Right, missed that.

This is one of the patches I sent accidentally. I think Kumar already
applied it to his tree.

Sorry for the noise.

Wolfgang.
