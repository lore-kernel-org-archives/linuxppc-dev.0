Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 57FD7B7CF4
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 05:10:53 +1100 (EST)
Received: by gyf1 with SMTP id 1so3884385gyf.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 11:10:52 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BAA4C8A.70104@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 24 Mar 2010 12:10:32 -0600
Message-ID: <fa686aa41003241110u75e9486dn503c6b039944708c@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 24, 2010 at 11:31 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>> On Wed, Mar 24, 2010 at 11:00 AM, Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>>>>> Why the phandle redirection? =A0Why not just put the firmware blob in=
to
>>>>> a property in the QE node, or as a subnode?
>>>>
>>>> Because there might be multiple QE devices on a single chip, and each
>>>> will need to upload the same firmware. =A0So instead of embedding the
>>>> firmware multiple times, just embed it once, and have a pointer.
>>>
>>> You're messing up the binding because of a (perceived) deficiency in
>>> the DTB format?
>
> Huh? =A0Who says anything about messing up? =A0I don't see anything "mess=
ed up" about including a blob of data with proper compatible properties, et=
c.
>
>>> Or maybe just the DTS format. =A0Or maybe you shouldn't
>>> even care about size here. =A0Or really, the device tree is the wrong
>>> place to store firmware blobs at all.
>>
>> That is a good question. =A0Why is it necessary to pass the blob via the
>> tree?
>
> Because sometimes the firmware is needed before networking or serial I/O =
can function. =A0Today, we do one of two things on systems with QE (or QE-l=
ike microcontrollers):
>
> 1) U-Boot uploads the firmware, and may create a DTB node that provides s=
ome information about the firmware.
>
> 2) U-Boot uploads the firmware, but then gives Linux the physical address=
 (in flash) of the firmware so that it can upload it again.
>
>> So far we've avoided using firmware blobs in the flat trees.
>> Or to ask in other words; what is the use case that requires passing
>> via the device tree?
>
> The Fman devices on the Freescale P4080 needs to have the firmware upload=
ed by the kernel before they will function. =A0I can't depend on having the=
 firmware on the root file system, and we can't embed it in the kernel itse=
lf (because it's proprietary), so where else should I put it? =A0Today, we =
just leave it in flash and give the physical address to the Fman Linux driv=
er via a command-line parameter. =A0But that doesn't work because then it m=
eans we have to have flash mapped to every partition that runs Linux.

Thanks.  This is important information when talking about his.

You can also put it into an initrd and use the Linux firmware loader.
That would also neatly solve your GPL distribution issues.

>> Also, depending on firmware to correctly squirt the firmware blob into
>> the dtb at boot is risky. =A0Even when firmware is buggy, there is
>> resistance to upgrading firmware on working boards because it could
>> result in a bricked board.
>
> I'm not sure what you're getting at. =A0This has nothing to do with upgra=
ding firmware. =A0The firmware is already in flash, I just need a better wa=
y of giving it to the kernel. =A0If you upgrade the firmware in flash, then=
 U-Boot will automatically provide the new version to the kernel via the DT=
B. =A0I just don't see how upgrading is a factor.

Heh, can't you understand my completely ambiguous statements?  Sorry
about that, I should have been clearer.  Let me rephrase...

Also, depending on U-Boot (or any other boot firmware) to correctly
squirt the QE blob into
the dtb at boot is risky.  Even when U-Boot is buggy, there is
resistance to upgrading U-Boot
on working boards because it could result in a bricked board.

>> =A0In fact, every time we depend on firmware

to revise my statement: s/firmware/U-Boot/

>> to modify the dtb at boot is risky, so it should only be done when
>> strictly necessary (I would even say that to date we've probably been
>> rather too liberal about getting u-boot to modify the device tree).
>
> Embedding the firmware blob in the DTS is uglier than having U-Boot do it=
, IMHO.

Not with the right syntax, see below...

>> I would say that either the firmware should be loaded via the existing
>> (non-dt) firmware loading mechanism,
>
> That, unfortunately, is not an option.
>
>> or it should be built into the
>> static dtb blob. =A0Don't try to add it at runtime.
>
> Then how do I distribute the firmware blob? =A0It's not GPL, so it can't =
go into arch/powerpc/boot/dts/. =A0Are you suggesting I do this in the DTS:
>
> / {
> =A0 =A0 =A0 =A0model =3D "MPC8323EMDS";
> =A0 =A0 =A0 =A0compatible =3D "MPC8323EMDS", "MPC832xMDS", "MPC83xxMDS";
> =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0#size-cells =3D <1>;
>
> ...
>
> =A0 =A0 =A0 =A0qe_firmware:qe-firmware {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,qe-firmware";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,firmware =3D <0x70 0xcd 0x00 0x00 0x01=
 0x46 0x45 0x63 ...>
> =A0 =A0 =A0 =A0}

You're right, that wouldn't be very nice.  Try this syntax instead:

fsl,firmware =3D /incbin/("firmware-file-name.bin");

> }
>
> Most firmware is 8-12KB, so this will make for one ugly DTS. =A0Plus, the=
re's the issue of distributing non-GPL firmware data inside a DTS, which is=
 GPL.

You've got the distribution problem that needs to be solved regardless
because it cannot be part of U-Boot either.  How do you plan to handle
QE firmware distribution and loading?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
