Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x230.google.com (mail-it0-x230.google.com
 [IPv6:2607:f8b0:4001:c0b::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3hg03jbFzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 09:37:16 +1100 (AEDT)
Received: by mail-it0-x230.google.com with SMTP id r185so21756424ita.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 14:37:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFz2=B1WmVFREpouYJcUb31zH7ijqU6jvTsveQdb_yJ=sg@mail.gmail.com>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
 <1484681173-11644-4-git-send-email-ard.biesheuvel@linaro.org>
 <CA+55aFzKZySX1VC3YTcZxafDuhLT_HE3voS3UN1eNVh5+6XmNw@mail.gmail.com>
 <CAKv+Gu_mBtp9Y341ZZ8hA-Oo_Hf755QWZytptFKJPma05CSheg@mail.gmail.com>
 <CAKv+Gu8xPR3axtVEM9f6jX6yAn6bqE-=izNXdEZ7LxP6ZNPnbw@mail.gmail.com>
 <CA+55aFx5QHfi3X6cxbmXHcxTWfBfxTG33N+kX4Ro=747rnuxtw@mail.gmail.com>
 <CA+55aFz2=B1WmVFREpouYJcUb31zH7ijqU6jvTsveQdb_yJ=sg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 18 Jan 2017 22:37:13 +0000
Message-ID: <CAKv+Gu-wqoQVXvZcEF8xfAnHmrakKU73ToMNO+2Lw158B4teJA@mail.gmail.com>
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

On 18 January 2017 at 18:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Jan 18, 2017 at 10:27 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I wonder what happened to gold, and why it didn't take over. I'm
>> assuming it had _other_ bugs.. Oh well.
>
> Google for gold problems, I note that it has been reported to get
> "internal error"s during kernel builds - and at least some of them
> have been due to ksyms.
>
> So the core problem seems to mainly be that gcc normally itself never
> generates any absolute symbols, so the whole ksyms model depends on
> things that get almost zero testing in the toolchain.
>
> Oh well.
>

There is one alternative that gets rid of all the hackiness, but it
does increase the CRC footprint on 32-bit platforms:

diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 06121ce524a7..9f739c7224c3 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -693,7 +693,10 @@ void export_symbol(const char *name)
                        fputs(">\n", debugfile);

                /* Used as a linker script. */
-               printf("%s__crc_%s = 0x%08lx ;\n", mod_prefix, name, crc);
+               printf("SECTIONS { .rodata.__crc_%s : ALIGN(4) "
+                      "{ %s__crcp_%s = .; LONG(0x%08lx); } }\n"
+                      "%s__crc_%s = 0x%08lx;\n",
+                      name, mod_prefix, name, crc, mod_prefix, name, crc);
        }
 }

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index e3508a3d6e53..5e95a552a871 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -49,8 +49,8 @@ KSYM(__kstrtab_\name):
        .section ___kcrctab\sec+\name,"a"
        .balign KCRC_ALIGN
 KSYM(__kcrctab_\name):
-       .long KSYM(__crc_\name)
-       .weak KSYM(__crc_\name)
+       .long KSYM(__crcp_\name) - .
+       .weak KSYM(__crcp_\name)
        .previous
 #endif
 #endif

(and an equivalent change in include/linux/export.h)

So the kcrctab contains the relative (signed) offset to where the CRC
is stored, which gets rid of any absolute relocations. To grab the
CRC, we only have to add the value of the kcrctab entry to its
address, and dereference the resulting pointer.

This would remove the need for patches 1 and 2, and get rid of the
overhead of the runtime relocation entries not only for arm64 but for
powerpc as well. It would also get rid of the abuse of ELF symbols
once and for all, hopefully avoiding bugs in GNU ld and gold in the
future.

For a ballpark number of 10,000 CRCs in the core kernel, this would
increase the size of the image by 40 KB for 32-bit architectures (and
if saving 40 KB is essential, chances are you won't be using
modversions in the first place). For 64-bit architectures, there would
be no change in size, of course, except for saving 24 bytes of __init
space *per CRC* for arm64 and powerpc64 with CONFIG_RELOCATABLE=y

I will send out a separate RFC so we can discuss this alternative
