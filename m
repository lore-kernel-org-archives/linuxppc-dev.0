Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFF272C01B4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 02:52:47 +1000 (EST)
Message-ID: <4FF717D3.1020005@freescale.com>
Date: Fri, 6 Jul 2012 11:52:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/3] powerpc/e500: add paravirt QEMU platform
References: <20120627235005.GB9100@tyr.buserror.net>
 <36624A62-88AD-404A-A7A8-02D62E8700F0@suse.de>
 <4FF71164.3040501@freescale.com>
 <D89B244E-C8E0-4CCD-9118-2E84A13B6633@suse.de>
In-Reply-To: <D89B244E-C8E0-4CCD-9118-2E84A13B6633@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2012 11:30 AM, Alexander Graf wrote:
> 
> On 06.07.2012, at 18:25, Scott Wood wrote:
> 
>> On 07/06/2012 07:29 AM, Alexander Graf wrote:
>>> I really think we should document what exactly this machine expects.
>>
>> Well, the point of this paravirt machine is to avoid such assumptions --
>> it's all device-tree driven, at least in theory.  If a certain qemu
>> configuration ends up breaking the Linux platform (such as using a
>> different PIC), then that's a lack of flexibility on Linux's part that
>> should get fixed if someone finds it useful enough to justify the
>> effort.  Same with real hardware -- if you care about it, you add
>> support -- we just don't have a unique name for every configuration.
>> The information is there in the device tree, though.
>>
>> Honestly, even having "qemu" in there is more specific than I'd prefer,
>> but I don't want to stir up the "generic platform" argument again
>> without at least limiting the scope.
> 
> Well, can't we note down the assumptions we make to make sure that
> whoever develops an implementation of it knows what to implement?
> It's ppc specific for example. I also don't think that plugging a G3
> in there works, would it?

Well, it does have "e500" in the name. :-P

>>>> +void __init qemu_e500_pic_init(void)
>>>> +{
>>>> +	struct mpic *mpic;
>>>> +
>>>> +	mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU,
>>>> +			0, 256, " OpenPIC  ");
>>>
>>> Does that mean we're configuring the MPIC regardless of what the
>>> guest tells us? So the MPIC is a hard requirement. We can't use UIC
>>> or XPIC with this machine, right? This needs to be documented.
>>
>> Then what would we do if we want to add an ePAPR virtual PIC instead?
>> Or if something replaces MPIC on future FSL chips?
> 
> Then we need a different compatible anyways, because we wouldn't be backwards compatible, no?

No, that's exactly what I'm trying to avoid.  This notion of a toplevel
compatible that tells you everything you need to know about the machine
(even if Linux chooses to be device-tree-based for some arbitrary subset
of that information) is incompatible with a flexible virtual platform.

All this compatible is saying is "see the rest of the device tree".
How well Linux does so is a quality of implementation issue that can be
addressed as needed.  The information about what sort of interrupt
controller you have is already in the device tree.  The device tree is
the machine spec.

Another assumption this patch makes is that it doesn't need SWIOTLB.  Is
"has more than 4GiB RAM" a machine attribute that would warrant a
separate toplevel compatible?  SWIOTLB for PCI is handled due to the
previous patch that provides common PCI code -- but in a previous
version of the patch it was not handled.  Is it yet another incompatible
machine spec if RAM must be less than 4GiB minus PCICSRBAR (ignoring the
QEMU bug that PCICSRBAR is not implemented)?

>> Better to change the Linux implementation as needed than to change a spec.
> 
> Why not keep the 2 in sync in the same patch? Just throw a file with a rough outline of the machine in Documentation/.

Because that would give people the wrong impression about what this
machine is, and be unlikely to stay in sync or be a complete listing of
current assumptions.  You're basically suggesting to use Documentation/
as a bug tracker.

-Scott
