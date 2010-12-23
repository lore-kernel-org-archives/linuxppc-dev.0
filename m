Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4D127D72.8050303@suse.cz>
References: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
	<1293047849-26078-2-git-send-email-dirk.brandewie@gmail.com>
	<4D127D72.8050303@suse.cz>
Date: Thu, 23 Dec 2010 07:14:20 +0100
Message-ID: <AANLkTik-yqs2Dy+MBAcQ5Gpb9Vcvd80BS=C=fuDe7z-A@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: Add support for linking device tree blobs into
	vmlinux
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michal Marek <mmarek@suse.cz>
Content-Type: text/plain; charset=UTF-8
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, dirk.brandewie@gmail.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/12/22 Michal Marek <mmarek@suse.cz>:
> On 22.12.2010 20:57, dirk.brandewie@gmail.com wrote:
>>
>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>
>> This patch adds support for linking device tree blob(s) into
>> vmlinux. Modifies asm-generic/vmlinux.lds.h to add linking
>> .dtb sections into vmlinux. To maintain compatiblity with the of/fdt
>> driver code platforms MUST copy the blob to a non-init memory location
>> before the kernel frees the .init.* sections in the image.
>>
>> Modifies scripts/Makefile.lib to add a kbuild command to
>> compile DTS files to device tree blobs and a rule to create objects to
>> wrap the blobs for linking.
>>
>> STRUCT_ALIGNMENT is defined in vmlinux.lds.h for use in the rule to
>> create wrapper objects for the dtb in Makefile.lib. =C2=A0The
>> STRUCT_ALIGN() macro in vmlinux.lds.h is modified to use the
>> STRUCT_ALIGNMENT definition.
>>
>> The DTB's are placed on 32 byte boundries to allow parsing the blob
>> with driver/of/fdt.c during early boot without having to copy the blob
>> to get the structure alignment GCC expects.
>>
>> A DTB is linked in by adding the DTB object to the list of objects to
>> be linked into vmlinux in the archtecture specific Makefile using
>> =C2=A0 =C2=A0obj-y +=3D foo.dtb.o
>>
>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>
> Hi,
>
> you can add
> Acked-by: Michal Marek <mmarek@suse.cz>
> but I thing this series should go through the tip tree, as your primary
> target seems to be x86 and patch 2/4 depends on the ce4100 code that is o=
nly
> in tip.

If the two lines

+# device tree blob
+obj-$(CONFIG_X86_INTEL_CE) +=3D ce4100.dtb.o

are removed, patch 2/4 no longer depends on the ce4100 code.
The summary and description for that patch don't mention anything
about ce4100 anyway.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
