Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 6FB49B7131
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Nov 2010 16:17:32 +1100 (EST)
Received: by iwn41 with SMTP id 41so506609iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Nov 2010 21:17:31 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4CE21163.2070806@gmail.com>
References: <cover.1289877715.git.dirk.brandewie@gmail.com>
	<ca5555dd665a668bf4e2b2256ccf4bb5d010cde1.1289877715.git.dirk.brandewie@gmail.com>
	<20101116044110.GA4074@angua.secretlab.ca> <4CE21163.2070806@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 15 Nov 2010 22:17:11 -0700
Message-ID: <AANLkTi=G1TwfOHBVB2wpZHpafw_KB7S7yhj6syP339e1@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: Add support for linking device tree blobs into
	vmlinux
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sodaville@linutronix.de, devicetree-discuss@lists.ozlabs.org,
	arjan@linux.intel.com, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 10:06 PM, Dirk Brandewie
<dirk.brandewie@gmail.com> wrote:
> On 11/15/2010 08:41 PM, Grant Likely wrote:
>>
>> On Mon, Nov 15, 2010 at 08:01:20PM -0800, dirk.brandewie@gmail.com wrote=
:
>>>
>>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>>
>>> This patch adds support for linking device tree blobs into
>>> vmlinux. The device tree blobs are placed in the init.data
>>> section.
>>>
>>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>>> ---
>>> =A0include/asm-generic/vmlinux.lds.h | =A0 19 +++++++++++++++++--
>>> =A0scripts/Makefile.lib =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 +++++++++++=
++++++
>>> =A02 files changed, 34 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/asm-generic/vmlinux.lds.h
>>> b/include/asm-generic/vmlinux.lds.h
>>> index bd69d79..ea671e7 100644
>>> --- a/include/asm-generic/vmlinux.lds.h
>>> +++ b/include/asm-generic/vmlinux.lds.h
>>> @@ -67,7 +67,14 @@
>>> =A0 * Align to a 32 byte boundary equal to the
>>> =A0 * alignment gcc 4.5 uses for a struct
>>> =A0 */
>>> -#define STRUCT_ALIGN() . =3D ALIGN(32)
>>> +#define STRUCT_ALIGNMENT 32
>>> +#define STRUCT_ALIGN() . =3D ALIGN(STRUCT_ALIGNMENT)
>>> +
>>> +/* Device tree blobs linked into the kernel need to have proper
>>> + * structure alignment to be parsed by the flat device tree library
>>> + * used in early boot
>>> +*/
>>> +#define DTB_ALIGNMENT STRUCT_ALIGNMENT
>>>
>>> =A0/* The actual configuration determine if the init/exit sections
>>> =A0 * are handled as text/data or they can be discarded (which
>>> @@ -146,6 +153,13 @@
>>> =A0#define TRACE_SYSCALLS()
>>> =A0#endif
>>>
>>> +
>>> +#define KERNEL_DTB() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 . =3D ALIGN(DTB_ALIGNMENT); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 VMLINUX_SYMBOL(__dtb_start) =3D .; =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 *(.dtb.init.rodata) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 VMLINUX_SYMBOL(__dtb_end) =3D .;
>>> +
>>> =A0/* .data section */
>>> =A0#define DATA_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0*(.data) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> @@ -468,7 +482,8 @@
>>> =A0 =A0 =A0 =A0MCOUNT_REC() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> =A0 =A0 =A0 =A0DEV_DISCARD(init.rodata) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> =A0 =A0 =A0 =A0CPU_DISCARD(init.rodata) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> - =A0 =A0 =A0 MEM_DISCARD(init.rodata)
>>> + =A0 =A0 =A0 MEM_DISCARD(init.rodata) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 KERNEL_DTB()
>>>
>>> =A0#define INIT_TEXT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0*(.init.text) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>> index 4c72c11..a8a4774 100644
>>> --- a/scripts/Makefile.lib
>>> +++ b/scripts/Makefile.lib
>>> @@ -200,6 +200,23 @@ quiet_cmd_gzip =3D GZIP =A0 =A0$@
>>> =A0cmd_gzip =3D (cat $(filter-out FORCE,$^) | gzip -f -9> =A0$@) || \
>>> =A0 =A0 =A0 =A0(rm -f $@ ; false)
>>>
>>> +# DTC
>>> +#
>>> =A0--------------------------------------------------------------------=
-------
>>> +$(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>>> + =A0 =A0 =A0 @echo '#include<asm-generic/vmlinux.lds.h>'> =A0$@
>>> + =A0 =A0 =A0 @echo '.section .dtb.init.rodata,"a"'>> =A0$@
>>> + =A0 =A0 =A0 @echo '.balign DTB_ALIGNMENT'>> =A0$@
>>> + =A0 =A0 =A0 @echo '.global __dtb_$(*F)_begin'>> =A0$@
>>> + =A0 =A0 =A0 @echo '__dtb_$(*F)_begin:'>> =A0$@
>>> + =A0 =A0 =A0 @echo '.incbin "$<" '>> =A0$@
>>> + =A0 =A0 =A0 @echo '__dtb_$(*F)_end:'>> =A0$@
>>> + =A0 =A0 =A0 @echo '.global __dtb_$(*F)_end'>> =A0$@
>>> + =A0 =A0 =A0 @echo '.balign DTB_ALIGNMENT'>> =A0$@
>>> +
>>> +DTC =3D $(objtree)/scripts/dtc/dtc
>>> +
>>> +quiet_cmd_dtc =3D DTC =A0 =A0$@
>>> + =A0 =A0 =A0cmd_dtc =3D $(DTC) -O dtb -o $(obj)/$*.dtb -b 0 =A0$(src)/=
$*.dts
>>
>> Missing the %.dtb: %.dts rule, but otherwise looks okay. =A0You will
>> need to make sure this doesn't break powerpc or microblaze when the
>> dts->dtb rule is added.
>>
> I have the rule
> =A0$(obj)/%.dtb: $(src)/%.dts
> =A0 =A0 =A0 =A0 =A0$(call if_changed,dtc)
> in the arch/x86/kernel/Makefile to prevent this sneaking into other other
> architectures.

This rule looks correct.  PowerPC and Microblaze need to be modified
to use it.  It should not be hard to do, give it a try.  Worst case,
your first attempt is wrong and the rest of us fix it up.  :-)

Hint: PowerPC currently puts the .dtb file in a different directory
from the source .dts file.  It doesn't need to do it that way.
arch/powerpc/boot/Makefile will need to be modified.

g.

>
> I need some more skilled in kbuild to help craft the more generic rule so=
 we
> can have the dts files anywhere in the arch/<*>/ directory structure and =
be
> able to find the correct dts files.
>
> --Dirk
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
