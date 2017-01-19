Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x22e.google.com (mail-it0-x22e.google.com
 [IPv6:2607:f8b0:4001:c0b::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v498W17HgzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 04:00:59 +1100 (AEDT)
Received: by mail-it0-x22e.google.com with SMTP id k200so5620160itb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 09:00:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9KnTpEUf14LpNTabv1qaXagWKZ0yRqbOL2JSNw+90oEw@mail.gmail.com>
References: <1484827365-8515-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9KnTpEUf14LpNTabv1qaXagWKZ0yRqbOL2JSNw+90oEw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 19 Jan 2017 17:00:56 +0000
Message-ID: <CAKv+Gu8D=PWbm5YcoBLER918qquo1usuwprCvDPSgM=H5y7AeA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] modversions: redefine kcrctab entries as relative
 CRC pointers
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>,
 Jessica Yu <jeyu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19 January 2017 at 16:55, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 19 January 2017 at 12:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> The modversion symbol CRCs are emitted as ELF symbols, which allows us to
>> easily populate the kcrctab sections by relying on the linker to associate
>> each kcrctab slot with the correct value.
>>
>> This has a couple of downsides:
>> - On architectures that support runtime relocation, a R_<arch>_RELATIVE
>>   relocation entry is emitted for each CRC value, which identifies it as
>>   a quantity that requires fixing up based on the actual runtime load
>>   offset of the kernel. This results in corrupted CRCs unless we
>>   explicitly undo the fixup (and this is currently being handled in the
>>   core module code),
>> - On 64 bit architectures, such runtime relocation entries take up 24
>>   bytes of __init space each, resulting in a x8 overhead in [uncompressed]
>>   kernel size for CRCs,
>> - The use of ELF symbols to represent things other than virtual addresses
>>   is poorly supported (and mostly untested) in GNU binutils.
>>
>> So avoid these issues by redefining the kcrctab entries as signed relative
>> offsets pointing to the actual CRC value stored elsewhere in the kernel
>> image (or in the module). This removes all the ELF hackery involving
>> symbols and relocations, at the expense of 4 additional bytes of space per
>> CRC on 32-bit architectures. (On 64-bit architectures, each 8 byte CRC
>> symbol reference is replaced by a 4 byte relative offset and the 4 byte
>> CRC value elsewhere in the image)
>>
>> Note that this mostly reverts commit d4703aefdbc8 ("module: handle ppc64
>> relocating kcrctabs when CONFIG_RELOCATABLE=y")
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> v2: update modpost as well, so that genksyms no longer has to emit symbols
>>     for both the actual CRC value and the reference to where it is stored
>>     in the image
>>
>
> Annoyingly, the following is required on top of this patch to ensure
> that we only subtract the section VMA from the symbol value in modpost
> if we are dealing with a fully linked file. This is necessary since,
> as it turns out, partially linked ELF objects may have non-zero
> section VMAs (for whatever reason).
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index d69f3ceae19e..75b0dac1cc11 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -624,7 +624,8 @@
>                 if (sym->st_shndx != SHN_UNDEF)
>                         crcp = (void *)info->hdr + sym->st_value +
>                                info->sechdrs[sym->st_shndx].sh_offset -
> -                              info->sechdrs[sym->st_shndx].sh_addr;
> +                              (hdr->e_type != ET_REL ?

This should be info->hdr->e_type ^^^. Apologies.

> +                               info->sechdrs[sym->st_shndx].sh_addr : 0);
>
>                 is_crc = true;
>                 crc = crcp ? *crcp : 0;
>
