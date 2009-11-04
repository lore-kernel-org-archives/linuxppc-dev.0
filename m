Return-Path: <thirumalai.p@datapatterns.co.in>
Received: from ns0.datapatterns.co.in (ns0.datapatterns.co.in [121.242.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5DB91B7BC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 Nov 2009 23:39:54 +1100 (EST)
Message-ID: <2DA2EE8F96D44EF69D4D8A712410E546@itd210>
From: "Thirumalai" <thirumalai.p@datapatterns.co.in>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
References: <06737AFD409844ED8DF3D43EFA83A906@itd210>
	<1257315924.13611.54.camel@pasglop>
In-Reply-To: <1257315924.13611.54.camel@pasglop>
Subject: Re: Regarding FPGA based cascaded PIC
Date: Wed, 4 Nov 2009 18:09:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"; reply-type=original
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


----- Original Message ----- 
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Thirumalai" <thirumalai.p@datapatterns.co.in>
Cc: <scottwood@freescale.com>
Sent: Wednesday, November 04, 2009 11:55 AM
Subject: Re: Regarding FPGA based cascaded PIC


> On Wed, 2009-11-04 at 10:48 +0530, Thirumalai wrote:
>> Hi Ben,
>>         I am a having MPC8640D based board on which i am in the process 
>> of
>> writing cascaded interrupt handler for my FPGA based PIC. I need some
>> clarification on writing customized cascaded interrupt handler. As for as 
>> my
>> understanding we need to use  irq_alloc_host() function for allocating 
>> the
>> irq_host for my FPGA pic and we should use irq_of_parse_and_map() 
>> function
>> for parsing and assignment of virtual IRQ from my device tree. In my case 
>> my
>> FPGA based PIC is giving interrupts to 3 external interrupt of MPC8640D 
>> i.e
>> 1,2,3 . So i have written my fpga-pic node as follows on my device tree.
>
> Please post to the mailing list linuxppc-dev@lists.ozlabs.org for such
> questions.
>
>> fpga-pic@dc000000 {
>>                         compatible = "dp,fpga-pic";
>>                         reg = <0xdc000000 0x7fff>;
>>                         interrupt-controller;
>>                         #interrupt-cells = <3>;
>>                         interrupts = <1 1 2 1 3 1>;
>>                         interrupt-parent = <&mpic>;
>> };
>
> 3 cells per interrupt ? that's a lot :-) What do you put in there ?
>
>>  mpic: pic@40000 {
>>                         clock-frequency = <0>;
>>                         interrupt-controller;
>>                         #address-cells = <0>;
>>                         #interrupt-cells = <2>;
>>                         reg = <0x40000 0x40000>;
>>                         compatible = "chrp,open-pic";
>>                         device_type = "open-pic";
>>                         big-endian;
>>                 };
>
> So far it looks reasonable...
>
>> The function irq_of_parse_and_map is returning VIRQ as 16,17,18
>> successfully. i hooked my chained interrupt handler for this VIRQ using
>> set_irq_chained_handler function. On my user defined interrupt handler 
>> when
>> i am searching the vector need to be returned i am getting 0 as vector. 
>> ie
>> using the function irq_linear_revmap.
>>
>> So here my doubt:
>> ============
>> Even irq_alloc_host has returned a irq_host for my pic, Why my custom map
>> funtion is not called during irq_of_parse_and_map function. Instead of my
>> map/xlate function it is calling mpic's map/xlate function?
>
> That's where I don't follow you...
>
> So interrupts 1,2,3 in your example are outputs of the FPGA PIC
> connected to inputs 1,2,3 of the MPIC. Those get mapped to virq 16.17
> and 18. Those are really MPIC interrupts.
>
> At some stage some interrupts -below- your FPGA PIC (whatever devices
> you have on the FPGA) are going to fire. it's -those- interrupts that
> will use map/xlate from the FPGA host when irq_of_parse_and_map() is
> called for them
>

you understood correctly. Here the problem lies.Correct me if i am wrong. So 
you are telling that irq_of_parse_and_map() will invoke the map/xlate of my 
FPGA pic. Right.

But this is what not happening. Instead of calling my map/xlate functions 
the irq_of_parse_and_map() function is invoking mpic's map/xlate function.

Here is the piece of code that we are using.

fpga_pic_irq_host = irq_alloc_host(pic, IRQ_HOST_MAP_LINEAR,
                        DPVPX0659_FPGA_NUM_IRQS,&fpga_pic_host_ops,
                        NO_IRQ);
        if (fpga_pic_irq_host == NULL) {
                printk("FPGA PIC: Unable to allocate host\n");
                return;
        }

        for (i = 0; i < 3; i++) {
                fpga_irqs[i] = irq_of_parse_and_map(pic, i);
                if (fpga_irqs[i] == NO_IRQ) {
                        printk("FPGA PIC: can't get irq %d.\n", i);
                        continue;
                }
                printk("interrupt from device tree : %d \n",fpga_irqs[i]);
                set_irq_chained_handler(dpvpx0659_fpga_irqs[i],dpvpx0659_fpga_pic_cascade);
        }

> IE. When -those- fire, the FPGA emits one of the 3 interrupts, and your
> cascade handler gets called. It will then fetch off the FPGA PIC what
> interrupts happened and revmap that.
>
> Cheers,
> Ben.
>
>> Kindly reply me soon.
>> Regards
>> Thirumalai
>>
>>
Thank you
Thirumalai 


**************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
*********** End of Disclaimer ***********DataPatterns ITS Group**********
