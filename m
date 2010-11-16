Return-Path: <dirk.brandewie@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 0D976B7131
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Nov 2010 16:28:31 +1100 (EST)
Received: by iwn41 with SMTP id 41so520609iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Nov 2010 21:28:30 -0800 (PST)
Message-ID: <4CE2167B.3070101@gmail.com>
Date: Mon, 15 Nov 2010 21:28:27 -0800
From: Dirk Brandewie <dirk.brandewie@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] of: Add support for linking device tree blobs into
	vmlinux
References: <cover.1289877715.git.dirk.brandewie@gmail.com>
	<ca5555dd665a668bf4e2b2256ccf4bb5d010cde1.1289877715.git.dirk.brandewie@gmail.com>
	<20101116044110.GA4074@angua.secretlab.ca>
	<4CE21163.2070806@gmail.com>
	<AANLkTi=G1TwfOHBVB2wpZHpafw_KB7S7yhj6syP339e1@mail.gmail.com>
In-Reply-To: <AANLkTi=G1TwfOHBVB2wpZHpafw_KB7S7yhj6syP339e1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 11/15/2010 09:17 PM, Grant Likely wrote:
> On Mon, Nov 15, 2010 at 10:06 PM, Dirk Brandewie
> <dirk.brandewie@gmail.com>  wrote:
>> On 11/15/2010 08:41 PM, Grant Likely wrote:
>>>
>>> On Mon, Nov 15, 2010 at 08:01:20PM -0800, dirk.brandewie@gmail.com wrote:
>>>>
>>>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>>>
>>>> This patch adds support for linking device tree blobs into
>>>> vmlinux. The device tree blobs are placed in the init.data
>>>> section.
>>>>
>>>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>>>> ---
>>>>   include/asm-generic/vmlinux.lds.h |   19 +++++++++++++++++--
>>>>   scripts/Makefile.lib              |   17 +++++++++++++++++
>>>>   2 files changed, 34 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/asm-generic/vmlinux.lds.h
>>>> b/include/asm-generic/vmlinux.lds.h
>>>> index bd69d79..ea671e7 100644
>>>> --- a/include/asm-generic/vmlinux.lds.h
>>>> +++ b/include/asm-generic/vmlinux.lds.h
>>>> @@ -67,7 +67,14 @@
>>>>    * Align to a 32 byte boundary equal to the
>>>>    * alignment gcc 4.5 uses for a struct
>>>>    */
>>>> -#define STRUCT_ALIGN() . = ALIGN(32)
>>>> +#define STRUCT_ALIGNMENT 32
>>>> +#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
>>>> +
>>>> +/* Device tree blobs linked into the kernel need to have proper
>>>> + * structure alignment to be parsed by the flat device tree library
>>>> + * used in early boot
>>>> +*/
>>>> +#define DTB_ALIGNMENT STRUCT_ALIGNMENT
>>>>
>>>>   /* The actual configuration determine if the init/exit sections
>>>>    * are handled as text/data or they can be discarded (which
>>>> @@ -146,6 +153,13 @@
>>>>   #define TRACE_SYSCALLS()
>>>>   #endif
>>>>
>>>> +
>>>> +#define KERNEL_DTB()                                                   \
>>>> +       . = ALIGN(DTB_ALIGNMENT);                                       \
>>>> +       VMLINUX_SYMBOL(__dtb_start) = .;                                \
>>>> +       *(.dtb.init.rodata)                                             \
>>>> +       VMLINUX_SYMBOL(__dtb_end) = .;
>>>> +
>>>>   /* .data section */
>>>>   #define DATA_DATA                                                     \
>>>>         *(.data)                                                        \
>>>> @@ -468,7 +482,8 @@
>>>>         MCOUNT_REC()                                                    \
>>>>         DEV_DISCARD(init.rodata)                                        \
>>>>         CPU_DISCARD(init.rodata)                                        \
>>>> -       MEM_DISCARD(init.rodata)
>>>> +       MEM_DISCARD(init.rodata)                                        \
>>>> +       KERNEL_DTB()
>>>>
>>>>   #define INIT_TEXT                                                     \
>>>>         *(.init.text)                                                   \
>>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>>> index 4c72c11..a8a4774 100644
>>>> --- a/scripts/Makefile.lib
>>>> +++ b/scripts/Makefile.lib
>>>> @@ -200,6 +200,23 @@ quiet_cmd_gzip = GZIP    $@
>>>>   cmd_gzip = (cat $(filter-out FORCE,$^) | gzip -f -9>    $@) || \
>>>>         (rm -f $@ ; false)
>>>>
>>>> +# DTC
>>>> +#
>>>>   ---------------------------------------------------------------------------
>>>> +$(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>>>> +       @echo '#include<asm-generic/vmlinux.lds.h>'>    $@
>>>> +       @echo '.section .dtb.init.rodata,"a"'>>    $@
>>>> +       @echo '.balign DTB_ALIGNMENT'>>    $@
>>>> +       @echo '.global __dtb_$(*F)_begin'>>    $@
>>>> +       @echo '__dtb_$(*F)_begin:'>>    $@
>>>> +       @echo '.incbin "$<" '>>    $@
>>>> +       @echo '__dtb_$(*F)_end:'>>    $@
>>>> +       @echo '.global __dtb_$(*F)_end'>>    $@
>>>> +       @echo '.balign DTB_ALIGNMENT'>>    $@
>>>> +
>>>> +DTC = $(objtree)/scripts/dtc/dtc
>>>> +
>>>> +quiet_cmd_dtc = DTC    $@
>>>> +      cmd_dtc = $(DTC) -O dtb -o $(obj)/$*.dtb -b 0  $(src)/$*.dts
>>>
>>> Missing the %.dtb: %.dts rule, but otherwise looks okay.  You will
>>> need to make sure this doesn't break powerpc or microblaze when the
>>> dts->dtb rule is added.
>>>
>> I have the rule
>>   $(obj)/%.dtb: $(src)/%.dts
>>           $(call if_changed,dtc)
>> in the arch/x86/kernel/Makefile to prevent this sneaking into other other
>> architectures.
>
> This rule looks correct.  PowerPC and Microblaze need to be modified
> to use it.  It should not be hard to do, give it a try.  Worst case,
> your first attempt is wrong and the rest of us fix it up.  :-)
>
> Hint: PowerPC currently puts the .dtb file in a different directory
> from the source .dts file.  It doesn't need to do it that way.
> arch/powerpc/boot/Makefile will need to be modified.
>

I will give it a shot.  The only real difference except for the directory 
structures is powerpc and microblaze add padding to the dtb with the -p 1024
command line argument to dtc.  Is the padding needed when the blob are linked 
into vmlinux proper?

--Dirk
