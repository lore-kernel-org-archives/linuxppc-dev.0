Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 67ABFB7C59
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 06:47:17 +1100 (EST)
Message-ID: <4B858243.8010908@mlbassoc.com>
Date: Wed, 24 Feb 2010 12:47:15 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com>
	<4B85746F.3020200@freescale.com>	<4B857AA8.9000208@mlbassoc.com>
	<4B857EA1.6030605@freescale.com>
In-Reply-To: <4B857EA1.6030605@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2010 12:31 PM, Scott Wood wrote:
> Gary Thomas wrote:
>> On 02/24/2010 11:48 AM, Scott Wood wrote:
>>> Gary Thomas wrote:
>>>> Does anyone have experience setting up the PCI controller on
>>>> the MPC8349? I have it running fine when my system has 128MB
>>>> or less of main memory, but when I have 256MB or more, it all
>>>> falls apart :-(
>>>>
>>>> Any indication of the pertinent settings would be appreciated.
>>>
>>> Check the inbound PCI translation registers, especially PIWARn.
>>
>> Yes, I set it to 256MB (the size of RAM).
>> I also set PCI_AR0 to a 512MB window (when it's set to 256, I
>> get address [segmentation violation] errors when accessing my
>> devices that end up at the high end of the logical address space)
>> Finally, I set POCMR0 to a 512MB window (corresponding to PCI_AR0)
>
> I don't see what the outbound window size has to do with RAM size... are there any other differences between the 128MiB and 256MiB setups? Same exact software? What happens if you
> take the 256MiB setup and restrict the kernel to using the lower 128MiB ("mem=128M" on the kernel bootargs), with no other changes? What happens if you use a 512MiB outbound window
> on the 128MiB setup?

Yes, I'm using the exact same kernel with these two different PCI
setups (done by the boot loader).

Restricting the memory via mem=128M has no effect - the PCI layout is the same.

I think the outbound window size is required because of how the Linux PCI
remaps the space (note in my dumps that it put the MMIO of the boards starting
at 0xD0000000 when the inbound window is 0x10000000)

> Is this behavior consistent across multiple boards (i.e. could there be a hardware problem)?

I've had this same problem on many platforms before (834x and 8248 as well).  In the
past, I didn't have the time to spend fixing it, so I just worked around it by limiting
the system to 128MB  in the boot loader + PCI setup)

> Are there any errors indicated in the device, the PCI controller, the arbiter, etc?

None that are obvious to me.

To be clear, here are my observations:

* total memory 128MB (or less), inbound window 128MB, outbound window 128MB
   ==> device is happy
* total memory 256MB, inbound window 128MB, outbound window 128MB
   ==> device hangs, unable to access RAM (Linux handed it something higher than 128MB)
* total memory 256MB, inbound window 256MB, outbound window 128MB
   ==> segmentation violation when accessing device MMIO space
* total memory 256MB, inbound window 256MB, outbound window 256MB
   ==> access to MMIO space fails (Linux can't find device).  In this case, the SATA_SIL reports
          ata1: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
          ata2: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
       which implies that the driver get's junk when accessing the device MMIO space

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
