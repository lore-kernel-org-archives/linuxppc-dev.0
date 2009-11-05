Return-Path: <thirumalai.p@datapatterns.co.in>
Received: from ns0.datapatterns.co.in (mx0.datapatterns.co.in [121.242.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83870B7BB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 13:49:24 +1100 (EST)
MIME-Version: 1.0
Date: Thu, 05 Nov 2009 08:16:40 +0530
From: "thirumalai.p" <thirumalai.p@datapatterns.co.in>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regarding FPGA based cascaded PIC
In-Reply-To: <1257367882.13611.65.camel@pasglop>
References: <06737AFD409844ED8DF3D43EFA83A906@itd210>
	<1257315924.13611.54.camel@pasglop>
	<2DA2EE8F96D44EF69D4D8A712410E546@itd210>
	<1257367882.13611.65.camel@pasglop>
Message-ID: <99cb42d33b031818b565d67254059410@datapatterns.co.in>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 05 Nov 2009 07:51:22 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2009-11-04 at 18:09 +0530, Thirumalai wrote:
>> you understood correctly. Here the problem lies.Correct me if i am
wrong.
>> So
>> you are telling that irq_of_parse_and_map() will invoke the map/xlate of
>> my
>> FPGA pic. Right.
>> 
>> But this is what not happening. Instead of calling my map/xlate
functions
>>
>> the irq_of_parse_and_map() function is invoking mpic's map/xlate
>> function.
> 
> irq_of_parse_and_map() will call the map/xlate function of the parent
> PIC for the given interrupt.
> 
> In your case, the interrupts you are calling it for are defined as being
> interrupts wiring the FPGA to the MPIC, hence are MPIC inputs, and thus
> will be parsed/mapped by the MPIC. From the MPIC standpoint, the FPGA is
> just a device.
> 
> So the code is doing what you tell it to do :-)
> 
> I don't understand what you are actually trying to acheive. If those 3
> interrupts aren't outputs from the FPGA to the MPIC but input to the
> FPGA then they shouldn't be there, they should be device interrupts
> connected to the FPGA. Those will end up with map/xlate called in the
> FPGA host.
> 
I Understood the thing. Thank you very much. So you mean to say that my
map/xlate functions will get invoked only for the devices which is
connected the FPGA PIC. So for example suppose if i have an WDT connected
to my FPGA then the interrupt-parent tag should point to FPGA-PIC. So at
that time the irq_of_parse_and_map() will invoke my map/xlate functions
right.


So i need to define the nodes on my device tree for the devices which are
all going to generate interrupts for FPGA and keeping the interrupt-parent
property as fpga-pic.

So my device node for WDT is something like the following

                    wdt@4,2000 {
                       #interrupt-cells = <2>;
                       device_type = "watchdog";
                       compatible = "gef,fpga-wdt";
                       reg = <0x4 0x2000 0x8>;
                       interrupts = <0x1a 0x4>;
                       interrupt-parent = <&fpga_pic>;
               };
Correct me if i am wrong.

> Ben.
> 
>> Here is the piece of code that we are using.
>> 
>> fpga_pic_irq_host = irq_alloc_host(pic, IRQ_HOST_MAP_LINEAR,
>>                         DPVPX0659_FPGA_NUM_IRQS,&fpga_pic_host_ops,
>>                         NO_IRQ);
>>         if (fpga_pic_irq_host == NULL) {
>>                 printk("FPGA PIC: Unable to allocate host\n");
>>                 return;
>>         }
>> 
>>         for (i = 0; i < 3; i++) {
>>                 fpga_irqs[i] = irq_of_parse_and_map(pic, i);
>>                 if (fpga_irqs[i] == NO_IRQ) {
>>                         printk("FPGA PIC: can't get irq %d.\n", i);
>>                         continue;
>>                 }
>>                 printk("interrupt from device tree : %d
>>                 \n",fpga_irqs[i]);
>>                
set_irq_chained_handler(dpvpx0659_fpga_irqs[i],dpvpx0659_fpga_pic_cascade);
>>         }
>> 
>>
Thank you
Thirumalai

**************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
*********** End of Disclaimer ***********DataPatterns ITS Group**********
