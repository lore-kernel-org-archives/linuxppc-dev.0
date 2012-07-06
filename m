Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 708D52C01B4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 02:59:32 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/e500: add paravirt QEMU platform
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4FF717D3.1020005@freescale.com>
Date: Fri, 6 Jul 2012 18:59:24 +0200
Message-Id: <0C067161-2FF3-4EF6-BC4D-B3C93828ED36@suse.de>
References: <20120627235005.GB9100@tyr.buserror.net>
 <36624A62-88AD-404A-A7A8-02D62E8700F0@suse.de>
 <4FF71164.3040501@freescale.com>
 <D89B244E-C8E0-4CCD-9118-2E84A13B6633@suse.de>
 <4FF717D3.1020005@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06.07.2012, at 18:52, Scott Wood wrote:

> On 07/06/2012 11:30 AM, Alexander Graf wrote:
>>=20
>> On 06.07.2012, at 18:25, Scott Wood wrote:
>>=20
>>> On 07/06/2012 07:29 AM, Alexander Graf wrote:
>>>> I really think we should document what exactly this machine =
expects.
>>>=20
>>> Well, the point of this paravirt machine is to avoid such =
assumptions --
>>> it's all device-tree driven, at least in theory.  If a certain qemu
>>> configuration ends up breaking the Linux platform (such as using a
>>> different PIC), then that's a lack of flexibility on Linux's part =
that
>>> should get fixed if someone finds it useful enough to justify the
>>> effort.  Same with real hardware -- if you care about it, you add
>>> support -- we just don't have a unique name for every configuration.
>>> The information is there in the device tree, though.
>>>=20
>>> Honestly, even having "qemu" in there is more specific than I'd =
prefer,
>>> but I don't want to stir up the "generic platform" argument again
>>> without at least limiting the scope.
>>=20
>> Well, can't we note down the assumptions we make to make sure that
>> whoever develops an implementation of it knows what to implement?
>> It's ppc specific for example. I also don't think that plugging a G3
>> in there works, would it?
>=20
> Well, it does have "e500" in the name. :-P
>=20
>>>>> +void __init qemu_e500_pic_init(void)
>>>>> +{
>>>>> +	struct mpic *mpic;
>>>>> +
>>>>> +	mpic =3D mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN | =
MPIC_SINGLE_DEST_CPU,
>>>>> +			0, 256, " OpenPIC  ");
>>>>=20
>>>> Does that mean we're configuring the MPIC regardless of what the
>>>> guest tells us? So the MPIC is a hard requirement. We can't use UIC
>>>> or XPIC with this machine, right? This needs to be documented.
>>>=20
>>> Then what would we do if we want to add an ePAPR virtual PIC =
instead?
>>> Or if something replaces MPIC on future FSL chips?
>>=20
>> Then we need a different compatible anyways, because we wouldn't be =
backwards compatible, no?
>=20
> No, that's exactly what I'm trying to avoid.  This notion of a =
toplevel
> compatible that tells you everything you need to know about the =
machine
> (even if Linux chooses to be device-tree-based for some arbitrary =
subset
> of that information) is incompatible with a flexible virtual platform.
>=20
> All this compatible is saying is "see the rest of the device tree".
> How well Linux does so is a quality of implementation issue that can =
be
> addressed as needed.  The information about what sort of interrupt
> controller you have is already in the device tree.  The device tree is
> the machine spec.
>=20
> Another assumption this patch makes is that it doesn't need SWIOTLB.  =
Is
> "has more than 4GiB RAM" a machine attribute that would warrant a
> separate toplevel compatible?  SWIOTLB for PCI is handled due to the
> previous patch that provides common PCI code -- but in a previous
> version of the patch it was not handled.  Is it yet another =
incompatible
> machine spec if RAM must be less than 4GiB minus PCICSRBAR (ignoring =
the
> QEMU bug that PCICSRBAR is not implemented)?

Well, the thing that I'm wary of is the following. Imagine we make this =
the default machine type for all e500 user cases. Which is reasonable. =
Now we release 3.6 which works awesome with QEMU 1.2. We change =
something in QEMU. QEMU 1.3 comes out. It can no longer boot your old =
kernel 3.6.

That's the type of situation I don't want to be in. We need to be =
backwards compatible with what we used to be able to run. We can get =
away with declaring things as experimental for now, until we settled on =
a reasonable compromise to achieve said compatibility. But it needs to =
be our goal somewhere.

One idea would be to version the machine type according to what Linux =
implements. If Linux finds a machine type that is newer than what it =
implements, it spawns a warning. If we want, we can implement backwards =
compatible machine types in QEMU, similar to how we implement -M pc-0.12 =
and friends today.

Again, no need to do so as long as we tell users to not use it. As soon =
as we want them to actually run the machine, we need to have independent =
upgrade paths in place. New QEMU needs to be able to run old kernels. =
New kernels need to be run on old QEMU.

>=20
>>> Better to change the Linux implementation as needed than to change a =
spec.
>>=20
>> Why not keep the 2 in sync in the same patch? Just throw a file with =
a rough outline of the machine in Documentation/.
>=20
> Because that would give people the wrong impression about what this
> machine is, and be unlikely to stay in sync or be a complete listing =
of
> current assumptions.  You're basically suggesting to use =
Documentation/
> as a bug tracker.

I'm just saying that every time we hardcode assumptions, we need to make =
sure we document it somewhere. And currently we do hardcode assumptions, =
even though only a few.


Alex
