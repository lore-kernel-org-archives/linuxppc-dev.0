Return-Path: <peerlessdeepaks@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id A4A7BDDDF5
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 14:40:22 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4576851wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Dec 2008 19:40:10 -0800 (PST)
Message-ID: <cbaa36330812041940p603659f4q6afe38fca928c831@mail.gmail.com>
Date: Fri, 5 Dec 2008 09:10:10 +0530
From: "Deepak Pandian" <peerlessdeepaks@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: PCI Resource allocation
In-Reply-To: <1228431244.10722.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cbaa36330812041036u751ea939qc0aea60002655d07@mail.gmail.com>
	<1228431244.10722.4.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Fri, Dec 5, 2008 at 4:24 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2008-12-05 at 00:06 +0530, Deepak Pandian wrote:
>> Hi,
>>
>> In ppc4xx_pci i see the pci size to be declared as
>>  u32 lah, lal, pciah, pcial, sa;
>
> I think the 4xx code is pretty much ok at this stage no ?

Nope. I dont think so . sa is declared as u32 which overrules pci
region width > 4GB.
Further while setting up the outbound mapping ,

          if (!is_power_of_2(sa) || sa < 0x100000 ||
                            sa > 0xffffffffu) {
                        printk(KERN_WARNING "%s: Resource out of range\n",
                               port->node->full_name);
                        continue;
                }
the code marks regions with width > 4 GB as out of range.


>> Also at many other places I see the pci region is not capable of
>> handling resources > 4GB. I am planning to work on this arch specific
>> code to make it handle pci resource of width greater than 4 GB.
>
> Which "many other places" ?

In 4xx the OMR registers are programmed to handle only a maximum of 4 GB.
 I am in process of understanding how pci resources are allocated in
core kernel. But as far as i digged I could see
pci_read_bases,pci_alloc_bus_resource needs fixing.

>> But before that i wanted to clarify whether the core kernel will be
>> able to handle pci regions with width greater than  4GB.
>
> There's at least one place in the generic PCI code, in
> pci_read_bridge_bases(), that needs fixing in a similar way as we
> already fixed __pci_read_base(), ie by testing the resource_size_t size
> rather than whether the platform is 64-bit.
>

Thanks Ben. Luckily I have a  device which seeks more than 4 GB , so I
will try to fix it


-- 
With Regards,
Deepak Pandian
"Time is precious,One day we will find that we have less than what we
think" -RandyPausch
www.peerlessdeepak.wordpress.com
