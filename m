Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76CCB2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 02:30:27 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/e500: add paravirt QEMU platform
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4FF71164.3040501@freescale.com>
Date: Fri, 6 Jul 2012 18:30:19 +0200
Message-Id: <D89B244E-C8E0-4CCD-9118-2E84A13B6633@suse.de>
References: <20120627235005.GB9100@tyr.buserror.net>
 <36624A62-88AD-404A-A7A8-02D62E8700F0@suse.de>
 <4FF71164.3040501@freescale.com>
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


On 06.07.2012, at 18:25, Scott Wood wrote:

> On 07/06/2012 07:29 AM, Alexander Graf wrote:
>>=20
>> On 28.06.2012, at 01:50, Scott Wood wrote:
>>=20
>>> This gives the kernel a paravirtualized machine to target, without
>>> requiring both sides to pretend to be targeting a specific board
>>> that likely has little to do with the host in KVM scenarios.  This
>>> avoids the need to add new boards to QEMU just to be able to
>>> run KVM on new CPUs.
>>>=20
>>> As this is the first platform that can run with either e500v2 or
>>> e500mc, CONFIG_PPC_E500MC is now a legitimately user configurable
>>> option, so add a help text.
>>>=20
>>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>>> ---
>>> arch/powerpc/platforms/85xx/Kconfig     |   16 +++++++
>>> arch/powerpc/platforms/85xx/Makefile    |    1 +
>>> arch/powerpc/platforms/85xx/qemu_e500.c |   66 =
+++++++++++++++++++++++++++++++
>>> arch/powerpc/platforms/Kconfig.cputype  |    4 ++
>>=20
>> I really think we should document what exactly this machine expects.
>=20
> Well, the point of this paravirt machine is to avoid such assumptions =
--
> it's all device-tree driven, at least in theory.  If a certain qemu
> configuration ends up breaking the Linux platform (such as using a
> different PIC), then that's a lack of flexibility on Linux's part that
> should get fixed if someone finds it useful enough to justify the
> effort.  Same with real hardware -- if you care about it, you add
> support -- we just don't have a unique name for every configuration.
> The information is there in the device tree, though.
>=20
> Honestly, even having "qemu" in there is more specific than I'd =
prefer,
> but I don't want to stir up the "generic platform" argument again
> without at least limiting the scope.

Well, can't we note down the assumptions we make to make sure that =
whoever develops an implementation of it knows what to implement? It's =
ppc specific for example. I also don't think that plugging a G3 in there =
works, would it?

>=20
>>> +void __init qemu_e500_pic_init(void)
>>> +{
>>> +	struct mpic *mpic;
>>> +
>>> +	mpic =3D mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN | =
MPIC_SINGLE_DEST_CPU,
>>> +			0, 256, " OpenPIC  ");
>>=20
>> Does that mean we're configuring the MPIC regardless of what the
>> guest tells us? So the MPIC is a hard requirement. We can't use UIC
>> or XPIC with this machine, right? This needs to be documented.
>=20
> Then what would we do if we want to add an ePAPR virtual PIC instead?
> Or if something replaces MPIC on future FSL chips?

Then we need a different compatible anyways, because we wouldn't be =
backwards compatible, no?

> Better to change the Linux implementation as needed than to change a =
spec.

Why not keep the 2 in sync in the same patch? Just throw a file with a =
rough outline of the machine in Documentation/.


Alex
