Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id B10D22BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 04:21:50 +1000 (EST)
Message-ID: <4166D5E7.8080209@mvista.com>
Date: Fri, 08 Oct 2004 11:01:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
References: <E1CFESm-0002PH-00@real.realitydiluted.com>
	<4165E52E.60908@waitefamily.us>
	<20041008111345.GA23212@linux-mips.org>
	<1097234203.318.89.camel@hades.cambridge.redhat.com>
	<20041008122633.C17999@flint.arm.linux.org.uk>
In-Reply-To: <20041008122633.C17999@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Brian Waite <brian@waitefamily.us>, lachwani@pmc-sierra.com,
	Ralf Baechle <ralf@linux-mips.org>, mdharm@momenco.com,
	linuxppc-embedded@ozlabs.org, sjhill@realitydiluted.com,
	David Woodhouse <dwmw2@infradead.org>, rabeeh@galileo.co.il
Subject: OCP vs. platform_device (was Marvell 64360/64340 GigE driver for
 MIPS and PPC....)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Moving to a wider PPC audience...

Mark
--

Russell King wrote:

>On Fri, Oct 08, 2004 at 12:16:43PM +0100, David Woodhouse wrote:
>  
>
>>On Fri, 2004-10-08 at 13:13 +0200, Ralf Baechle wrote:
>>    
>>
>>>I was already considering to implement something like OCP for MIPS also.
>>>Since it already exists on PPC I instead would suggest to move
>>>arch/ppc/syslib/ocp.c into generic code, something like drivers/ocp/
>>>maybe?
>>>      
>>>
>>Fine... but if you're doing that instead of extending platform_device to
>>meet your needs, make sure you remove platform_device while you're at it
>>and convert its users to OCP.
>>    
>>
>
>There are a lot of users of platform devices, and this now includes
>virtually everything in the input layer.  This would be a very large
>amount of work to rip out platform devices.
>
>Let's look at this:
>
>struct ocp_def {
>        unsigned int    vendor;
>        unsigned int    function;
>
>These are meaningless for the vast majority of platform devices.
>
>        int             index;
>        phys_addr_t     paddr;
>
>Some platform devices have multiple addresses.  phys_addr_t isn't
>sensible anyway - it really really really wants to be a struct
>resource so that you're integrated into the kernels resource
>management system.
>
>        int             irq;
>
>And have multiple IRQs, and may very well have multiple DMA channel
>numbers.
>
>        unsigned long   pm;
>        void            *additions;
>        void            (*show)(struct device *);
>};
> 
> 
>/* Struct for a given device instance */
>struct ocp_device {
>        struct list_head        link;
>
>Unnecessary - the device model provides this for us already.
>
>        char                    name[80];       /* device name */
>
>Already part of platform_device.
>
>        struct ocp_def          *def;           /* device definition */
>        void                    *drvdata;       /* driver data for this device */
>
>This is a duplication of the driver data in struct device.
>
>        struct ocp_driver       *driver;
>
>Another duplication.
>
>        u32                     current_state;  /* Current operating state. In ACPI-speak,
>                                                   this is D0-D3, D0 being fully functional,
>                                                   and D3 being off. */
>
>and yet again another duplication.
>
>        struct                  device dev;
>};
>
>So I think ripping out platform devices and throwing in something
>which is very different is a backwards step.
>
>  
>
