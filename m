Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C259F68AD3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 16:15:47 +1100 (EST)
In-Reply-To: <20060125161959.GC4390@dmt.cnet>
References: <43D56DE5.5040004@mvista.com> <20060125161959.GC4390@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FC872273-7EAC-420C-8C70-87097D679D72@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Updated Patch to add support for Freescale 83xx Host Mode
	USB
Date: Wed, 25 Jan 2006 23:15:38 -0600
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
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


On Jan 25, 2006, at 10:19 AM, Marcelo Tosatti wrote:

> On Mon, Jan 23, 2006 at 04:59:33PM -0700, Randy Vinson wrote:
>> Greetings,
>>     I've attached an updated patch (based on 2.6.16-rc1) which adds
>> Host mode support for the Dual-Role(DR) and Multi-Port-Host (MPH) USB
>> controllers found in the Freescale 8349. The update was to  
>> reconcile the
>> port numbering scheme such that it matches the 8349 documentation.  
>> Since
>> my previous patch has not yet gone upstream, the maintainer  
>> requested a
>> fresh patch.
>>
>>  Note that this patch only provides the platform-specific code that
>> sets up the external hardware and pin configuration. The actual DR  
>> and
>> MPH controller driver was posted on the linux-usb-devel mailing list.
>>
>>     Using a Freescale 8349CDS reference board, the DR and MPH
>> controllers have been successfully tested using a USB 2.0 high speed
>> FLASH drive, a USB 1.1 full speed 4-port hub and a Siemens  
>> SpeedStream
>> USB to Ethernet adapter (assuming the previous 8349 driver updates
>> posted to linux-usb-devel have been applied).
>>
>>           Randy Vinson
>>           MontaVista Software
>
>> Adding platform support for the 834x Host Mode USB controller.
>>
>> This patch provides the platform-specific hardware setup required  
>> by the
>> 83xx Host Mode USB controller on the Freescale 8349CDS reference  
>> system.
>>
>> Signed-off-by: Randy Vinson <rvinson@mvista.com>
>>
>> ---
>> commit 30caa62b0e433b466b0880efa32375359b6e4fea
>> tree e9bacf15ad1a58f6f15a343a2b5f233affec0ca1
>> parent a3d36ef38dcdcbbc7e1860f2f92569145524b1d5
>> author Randy Vinson <rvinson@linuxbox.(none)> Mon, 23 Jan 2006  
>> 16:46:39 -0700
>> committer Randy Vinson <rvinson@linuxbox.(none)> Mon, 23 Jan 2006  
>> 16:46:39 -0700
>>
>>  arch/ppc/Kconfig                      |    2 +
>>  arch/ppc/platforms/83xx/Kconfig       |   28 +++++++++
>>  arch/ppc/platforms/83xx/mpc834x_sys.c |  100 +++++++++++++++++++++ 
>> ++++++++++++
>>  arch/ppc/platforms/83xx/mpc834x_sys.h |    3 +
>>  arch/ppc/syslib/mpc83xx_devices.c     |   16 +++++
>>  include/asm-ppc/mpc83xx.h             |   17 ++++++
>>  6 files changed, 166 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
>> index 11899f0..b33b0eb 100644
>> --- a/arch/ppc/Kconfig
>> +++ b/arch/ppc/Kconfig
>> @@ -681,6 +681,8 @@ config EV64360
>>  	  platform.
>>  endchoice
>>
>> +source arch/ppc/platforms/83xx/Kconfig
>> +
>>  config PQ2ADS
>>  	bool
>>  	depends on ADS8272
>> diff --git a/arch/ppc/platforms/83xx/Kconfig b/arch/ppc/platforms/ 
>> 83xx/Kconfig
>> new file mode 100644
>> index 0000000..90bc67a
>> --- /dev/null
>> +++ b/arch/ppc/platforms/83xx/Kconfig
>> @@ -0,0 +1,28 @@
>> +config 834x_USB_SUPPORT
>> +	bool "834x USB Support"
>> +	depends on MPC834x_SYS
>> +	default y
>> +	---help---
>> +	  Enables support for the USB controllers on the MPC834x chip.  
>> The 834x
>> +	  reference board is wired for only one USB port. That port may be
>> +	  used by either the MPH or DR USB controller.
>> +	  Requires USB Host EHCI support.
>> +	  If unsure, say Y.
>> +choice
>> +	prompt "834x USB Controller Selection"
>> +	depends on 834x_USB_SUPPORT
>> +	default 834x_DR_USB_SUPPORT
>> +
>> +config 834x_DR_USB_SUPPORT
>> +	bool "DR Controller"
>> +	select USB_EHCI_ROOT_HUB_TT
>> +	---help---
>> +	  Select if using the Dual-Role (DR) USB controller.
>> +
>> +config 834x_MPH_USB_SUPPORT
>> +	bool "MPH Controller"
>> +	---help---
>> +	  Select if using the Multi-Port-Host (MPH) USB controller.
>> +
>> +endchoice
>> +
>> diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/ 
>> platforms/83xx/mpc834x_sys.c
>> index 012e1e6..319661e 100644
>> --- a/arch/ppc/platforms/83xx/mpc834x_sys.c
>> +++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
>> @@ -11,6 +11,9 @@
>>   * under  the terms of  the GNU General  Public License as  
>> published by the
>>   * Free Software Foundation;  either version 2 of the  License,  
>> or (at your
>>   * option) any later version.
>> + *
>> + * USB setup added by Randy Vinson <rvinson@mvista.com> based on  
>> code from
>> + * Hunter Wu.
>>   */
>>
>>  #include <linux/config.h>
>> @@ -93,6 +96,99 @@ mpc83xx_exclude_device(u_char bus, u_cha
>>  }
>>  #endif /* CONFIG_PCI */
>>
>> +/*
>> + * Configure the on-chip USB controller. The MPC834xCDS only  
>> supports the
>> + * second USB interface (port 1). This code sets up the hardware  
>> and then
>> + * lets the platform driver take over device setup.
>> + */
>> +
>> +#ifdef CONFIG_834x_USB_SUPPORT
>> +void mpc834x_board_init(void)
>> +{
>> +	unsigned char __iomem *bcsr;
>> +	volatile unsigned char *bcsr5_p;
>> +
>> +	/*
>> +	 * if SYS board is plug into PIB board,
>> +	 * force to use the PHY on SYS board
>> +	 * */
>> +	bcsr = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
>> +	bcsr5_p = bcsr + BCSR5_OFF;
>> +	if ( (*bcsr5_p & BCSR5_INT_USB) == 0 )
>> +		*bcsr5_p = (*bcsr5_p | BCSR5_INT_USB);
>
> Randy,
>
> Can you please use in/out io accessors instead of direct memory  
> references
> to ?

Marcelo, good comment.  Just, an FYI.  This patch of Randy's isn't  
going into the kernel.  I ask him to post it just so it was on list.   
I wonder if sparse would be capable of warning for doing direct  
pointer load/store on __iomem pointers.

- kumar
