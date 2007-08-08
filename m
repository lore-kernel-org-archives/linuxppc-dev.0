Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id 6D328DDE9A
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 23:04:11 +1000 (EST)
Date: Wed, 08 Aug 2007 16:03:58 +0300
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix>
Message-ID: <op.twqrwwx2nhx3hy@phoenix>
In-Reply-To: <op.twqn4vtsnhx3hy@phoenix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 08 Aug 2007 14:42:34 +0300, Alexandros Kostopoulos  =

<akostop@inaccessnetworks.com> wrote:

> On Tue, 07 Aug 2007 18:20:12 +0300, Scott Wood <scottwood@freescale.co=
m>  =

> wrote:
>
>> Alexandros Kostopoulos wrote:
>>> Except from some macros arch/powerpc/include/asm/io.h /  =

>>> mpc8260_pci9.h, I  can seem to find anywhere the code regarding PCI =
 =

>>> Erratum 9. The defined  macros(in io.h) for read/write are sufficien=
t  =

>>> as a workaround for PCI9?  Who does DMA and register initialization =
 =

>>> for this (it used to be done in  arch/ppc/syslib/m8260_pci_erratum9.=
c  =

>>> in arc/ppc). Maybe u-boot or the  bootwrapper?
>>
>> I don't think the workaround exists yet in arch/powerpc, despite the =
 =

>> config option.
>>
>
> Is there a plan to be implemented on arch/powerpc, or devices with the=
  =

> erratum will have to keep on using the legacy arch/ppc code?
>
>>> Another question regarding resource allocation: when   =

>>> alloc_resource(pci_32.c), called from pcibios_allocate_resources(), =
 =

>>> during  pcibios init, attempts to allocate resources using  =

>>> request_resource(), the  request fails. This seems to happen because=
  =

>>> the previously scanned PCI  devices request resources in the form,  =

>>> e.g. 00000- 0000f (i.e. starting  from zero), and this should be  =

>>> mapped somewhere else in cpu mem space. My  question (in order to fi=
nd  =

>>> my bug) is, who performs this mapping, from PCI  space to CPU space,=
  =

>>> the kernel (and if yes, where?) or the host bridge (in  which case, =
 =

>>> I've probably failed to configure it properly).
>>
>> If the error message is the one I'm thinking of (it always helps to  =

>> post the actual messages), that's normal for when the PCI bus hasn't =
 =

>> been probed by the firmware.  Linux first tries to use the BARs as  =

>> they're already set, which will obviously fail because they haven't  =

>> been set, and then it will properly allocated them.  It's harmless  =

>> verbosity, though it'd be nice to have a flag to tell the PCI layer t=
o  =

>> not bother trying to preserve any existing BARs.
>>
>
> Well, the error message is:
> PCI:0000:00:16.0: Resource 0: 0000000000000000-0000000000000fff (f=3D2=
00)
> PCI: Cannot allocate resource region 0 of device 0000:00:16.0
> PCI:  parent is c03c4058: 0000000080000000-00000000bfffffff (f=3D200)
>
> The thing is, POBARs are already setup by uboot. However the resource =
 =

> allocation for the PCI devices (not the host bridge) fails in  =

> request_resource (which seems to use the region requested by the devic=
e  =

> as is and not some mapped region in the cpu address space), and I can =
 =

> not find where in the code happens the mapping from PCI to local bus m=
em  =

> region. I mean, each PCI device requests some region, e.g. from  =

> 0000-00ff and this is mapped to some region in the PCI outbound window=
,  =

> right. For some reason this fails in my case, and I cannot find where =
in  =

> the code this mapping should happen.
>
> Thank you for your help
>
> Alex


Oops, I think I found it. I think resources are allocated properly in  =

pci_assign_resource(), and you were probably talking about the PCI devic=
e  =

BAR, not the host bridge POBARs, right. So the error message in my  =

previous mail is the one you say it's ok?


>
>> -Scott
>
