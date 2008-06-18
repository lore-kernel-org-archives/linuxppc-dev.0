Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 99868DDFD3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jun 2008 00:18:35 +1000 (EST)
Message-ID: <4859193A.1040105@grandegger.com>
Date: Wed, 18 Jun 2008 16:18:34 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Mike Timmons <mike_timmons@trimble.com>
Subject: Re: Anybody have an mpc5200b mscan linux driver under 2.6.24,
	ARCH=powerpc or equiv?
References: <4858113F.4050203@vecimanetworks.com>	<48582CC6.60004@freescale.com>
	<161B3BAD77161449A144FF054231C3D6022FEAAE@uss-am-xch-01.am.trimblecorp.net>
	<48591167.1050303@grandegger.com>
	<161B3BAD77161449A144FF054231C3D6022FEAC0@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <161B3BAD77161449A144FF054231C3D6022FEAC0@uss-am-xch-01.am.trimblecorp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike Timmons wrote:
> Thanks for the quick response. I'm currently using 2.6.24 ARCH=powerpc
> on the Lite5200b. I just searched for an obvious patch but it is unclear
> to me what patch(es) I should take at this point.
> 
> Can you direct me to the patch(es) I need? Again, thank you.

As a first try you can build Socket-CAN out of tree by just downloading 
the SVN trunk repository as described here:

http://developer.berlios.de/svn/?group_id=6475

Then go to trunk/kernel/2.6 and type:

   $ make ARCH=powerpc KERNELDIR=<path-to-kernel> \
     CONFIG_CAN_MSCAN=m CONFIG_CAN_MPC52XX=m

You need the following modules on your target:

   drivers/net/can/*.ko
   drivers/net/can/mscan/*.ko

There is a script to create kernel patches, but I don't known if it 
works right now (there have been some issues recently). Please ask on 
the Socket-CAN mailing list.

Wolfgang.

> 
> -Mike 
> 
> -----Original Message-----
> From: Wolfgang Grandegger [mailto:wg@grandegger.com] 
> Sent: Wednesday, June 18, 2008 8:45 AM
> To: Mike Timmons
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Anybody have an mpc5200b mscan linux driver under 2.6.24,
> ARCH=powerpc or equiv?
> 
> Mike Timmons wrote:
>> I'm trying to wrestle the peak CAN driver for the old, non-device-tree
>> ppc into submission but I'm making a mess of it so far.
>>
>> I think I'll get it going at some point, but if anybody has or knows
> of
>> an mscan driver for the mpc5200 can you alert me?
> 
> http://svn.berlios.de/svnroot/repos/socketcan/trunk/README
> 
> The Socket-CAN core is part of the official kernel since 2.6.25.
> 
> Wolfgang.
> 
>> Thanks,
>> Mike
>>
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+mike_timmons=trimble.com@ozlabs.org
>> [mailto:linuxppc-embedded-bounces+mike_timmons=trimble.com@ozlabs.org]
>> On Behalf Of Scott Wood
>> Sent: Tuesday, June 17, 2008 4:30 PM
>> To: Mike Winter
>> Cc: linuxppc-embedded@ozlabs.org
>> Subject: Re: PCI DMA Problems With 82xx?
>>
>> Mike Winter wrote:
>>> We are developing with an 8248-based platform, and we have a vendor 
>>> telling us that the PCI hardware is unreliable on this CPU family, in
> 
>>> particular the DMA functionality.  A quick search of this list
> doesn't
>>> turn up any horror stories, although the processor does have some PCI
> 
>>> errata listed.  Does anybody have any practical experience using PCI
>> on 
>>> the 8248 or similar that they can share with me?   Thanks.
>> Make sure that you park the bus on PCI, and elevate PCI's arbitration 
>> priority.  See fixup_pci() in arch/powerpc/boot/cuboot-pq2.c.
>>
>> I haven't had a problem with PCI DMA when that is done, though I
> haven't
>> done significant stress testing.
>>
>> -Scott
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
> 
> 
