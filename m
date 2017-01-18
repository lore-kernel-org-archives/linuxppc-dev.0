Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com
 [IPv6:2607:f8b0:4001:c0b::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Q1y2vKkzDqHT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 22:37:41 +1100 (AEDT)
Received: by mail-it0-x232.google.com with SMTP id d9so33018743itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 03:37:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFzKZySX1VC3YTcZxafDuhLT_HE3voS3UN1eNVh5+6XmNw@mail.gmail.com>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
 <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
 <CA+55aFzKZySX1VC3YTcZxafDuhLT_HE3voS3UN1eNVh5+6XmNw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 18 Jan 2017 11:37:38 +0000
Message-ID: <CAKv+Gu_mBtp9Y341ZZ8hA-Oo_Hf755QWZytptFKJPma05CSheg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] modversions: treat symbol CRCs as 32 bit
 quantities on 64 bit archs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17 January 2017 at 23:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jan 17, 2017 at 11:26 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> The modversion symbol CRCs are emitted as ELF symbols, which allows us to
>> easily populate the kcrctab sections by relying on the linker to associate
>> each kcrctab slot with the correct value.
>>
>> This has a couple of downsides:
>
> So the whole relocation of the crc is obviously completely crazy, but
> you don't actually seem to *change* that. You just work around it, and
> you make the symbols 32-bit. The latter part I agree with
> whole-heartedly, btw.
>
> But do we really have to accept this relocation insanity?
>
> So I don't actually disagree with this patch 3/3 (turning the whole
> crc array into an array of "u32" is clearly the right thing to do),
> but the two other patches look oddly broken.
>
> Why are those CRC's relocatable to begin with? Shouldn't they be
> absolute values? Why do they get those idiotic relocation things? They
> seem to be absolute on x86-64 (just doing a 'nm vmlinux', so I might
> be missing something), why aren't they on ppc?
>

On powerpc and arm64, those __crc_xxx symbols are absolute as well,
but oddly enough, that does not mean they are not subject to runtime
relocation under -pie, which is how arm64 and powerpc create their
relocatable kernel images. The difference with x86 is that they
invented their own tooling to do runtime relocation, based on
--emit-relocs and filtering based on symbol names, so they don't rely
on ELF relocations at all for runtime relocation of the core kernel.

On ppc64:

$ nm vmlinux |grep __crc_ |head
000000009d37922d a __crc___ablkcipher_walk_complete
00000000c4309a46 a __crc_ablkcipher_walk_done
0000000038e1d7e1 a __crc_ablkcipher_walk_phys
00000000a55b33a4 a __crc_abort_creds
000000005776482e a __crc_access_process_vm
000000001215a9fb a __crc_account_page_dirtied
00000000b25ee3c8 a __crc_account_page_redirty
00000000ccab9422 a __crc_ack_all_badblocks
0000000027013bae a __crc_acomp_request_alloc
0000000013236c1b a __crc_acomp_request_free

[note the lowercase 'a', this is due to my attempt at emitting them as HIDDEN()]

On arm64, patch 3/3 is sufficient, because the linker infers from the
size of the symbol reference that it is not a memory address, and
resolves the relocation at link time.

> Is there something wrong with our generation script? Can we possibly
> do something like
>
>   -       printf("%s__crc_%s = 0x%08lx ;\n", mod_prefix, name, crc);
>   +       printf("%s__crc_%s = ABSOLUTE(0x%08lx) ;\n", mod_prefix, name, crc);
>
> in genksyms.c to get rid of the crazty relocation entries?
>

Nope, no difference at all, given that the symbols were ABSOLUTE to
begin with. Emitting them as HIDDEN() does not help either, nor does
passing -Bsymbolic on the linker command line.

So on powerpc, the linker insists on emitting the relocation into the
runtime relocation section [*], regardless of whether it is ABSOLUTE()
or HIDDEN(), or whether -Bsymbolic is being passed. My suspicion is
that, due to the fact that PIE handling is closely related to shared
library handling, the linker defers the resolution of relocations
against __crc_xxx symbols to runtime because they are preemptible
under ELF rules for shared libraries, i.e., an application linking to
a shared library is able to override symbols that the shared library
defines, and the shared library *must* update its internal references
to point to the new version of the symbol. Of course, this makes no
sense at all for PIE binaries, and on arm64, the toolchain does the
right thing in this regard when passing the -Bsymbolic parameter. On
powerpc, however, the linker *insists* on exposing these relocations
to the runtime loader, even if they are marked hidden (which is
supposed to inhibit this behavior).

I have also tried using relative references (which always get resolved
at link time), e.g.,

diff --git a/include/linux/export.h b/include/linux/export.h
index a000d421526d..df3f6762b3c0 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -54,7 +54,9 @@ extern struct module __this_module;
 #define __CRC_SYMBOL(sym, sec)                                         \
        asm("   .section \"___kcrctab" sec "+" #sym "\", \"a\"  \n"     \
            "   .weak   " VMLINUX_SYMBOL_STR(__crc_##sym) "     \n"     \
-           "   .long   " VMLINUX_SYMBOL_STR(__crc_##sym) "     \n"     \
+           "   .globl  " VMLINUX_SYMBOL_STR(__crc_rel_##sym) " \n"     \
+           VMLINUX_SYMBOL_STR(__crc_rel_##sym)":
 \n"     \
+           "   .long   " VMLINUX_SYMBOL_STR(__crc_##sym) " - . \n"     \
            "   .previous                                       \n");
 #endif
 #else
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 06121ce524a7..8dd9f1da8898 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -693,7 +693,8 @@ void export_symbol(const char *name)
                        fputs(">\n", debugfile);

                /* Used as a linker script. */
-               printf("%s__crc_%s = 0x%08lx ;\n", mod_prefix, name, crc);
+               printf("%s__crc_%s = %s__crc_rel_%s + 0x%08lx;\n", mod_prefix,
+                      name, mod_prefix, name, crc);
        }
 }

but this doesn't work either: the __crc_xxx symbols that are emitted
during partial linking evaluate the __crc_rel_xxx references at
partial link time, which means the resulting relative relocations
refer to the actual CRC value rather than the modified CRC value. The
only way to make /this/ work, afaik, is to hack the build scripts so
that the __crc_xxx = assignments occur in the scope of the final
linker script, rather than during partial linking (but only for
vmlinux, not for modules). All of this complicates the common path
used by all architectures, so I don't think we should go down this
road.

So I don't see any other way to work around this for powerpc (other
than creating some build time tooling to process the 32-bit
relocations for the CRC symbols in the vmlinux ELF binary) Hopefully,
Michael will be able to confirm that this v4 of 2/3 works correctly,
then we can discuss whether to go ahead with this or not.

-- 
Ard.

[*] and sadly, it only counts R_PPC64_RELATIVE relocations in its
.dynamic section's RELACOUNT, which requires additional handling in
patch 2/3
