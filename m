Return-Path: <olof@lixom.net>
Received: from mail-qe0-f51.google.com (mail-qe0-f51.google.com
 [209.85.128.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 73A872C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Dec 2013 18:24:33 +1100 (EST)
Received: by mail-qe0-f51.google.com with SMTP id 1so9716776qee.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Dec 2013 23:24:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1379901913-5945-12-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
 <1379901913-5945-12-git-send-email-anton@samba.org>
Date: Fri, 27 Dec 2013 23:24:29 -0800
Message-ID: <CAOesGMgKjAe5VR9waKCboK+mRwVfde89x+6gew9wjiCf8mAd8A@mail.gmail.com>
Subject: Re: [PATCH 11/39] powerpc: endian safe trampoline
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, chzigotzky@xenosoft.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nothing like some holiday powerpc early boot debugging. :-)

On Sun, Sep 22, 2013 at 7:04 PM, Anton Blanchard <anton@samba.org> wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Create a trampoline that works in either endian and flips to
> the expected endian. Use it for primary and secondary thread
> entry as well as RTAS and OF call return.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Anton Blanchard <anton@samba.org>

Some users reported failure with their kernel config to build and run
3.13-rc5. pasemi_defconfig boots just fine, but it seems that
ppc64_defconfig does not.

I've bisected it down to this particular patch. More below.


> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index 0c51fb4..ce05bba 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -845,6 +845,35 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,946)
>  #define N_SLINE        68
>  #define N_SO   100
>
> -#endif /*  __ASSEMBLY__ */
> +/*
> + * Create an endian fixup trampoline
> + *
> + * This starts with a "tdi 0,0,0x48" instruction which is
> + * essentially a "trap never", and thus akin to a nop.
> + *
> + * The opcode for this instruction read with the wrong endian
> + * however results in a b . + 8
> + *
> + * So essentially we use that trick to execute the following
> + * trampoline in "reverse endian" if we are running with the
> + * MSR_LE bit set the "wrong" way for whatever endianness the
> + * kernel is built for.
> + */
>
> +#ifdef CONFIG_PPC_BOOK3E
> +#define FIXUP_ENDIAN
> +#else
> +#define FIXUP_ENDIAN                                              \
> +       tdi   0,0,0x48;   /* Reverse endian of b . + 8          */ \
> +       b     $+36;       /* Skip trampoline if endian is good  */ \
> +       .long 0x05009f42; /* bcl 20,31,$+4                      */ \
> +       .long 0xa602487d; /* mflr r10                           */ \
> +       .long 0x1c004a39; /* addi r10,r10,28                    */ \
> +       .long 0xa600607d; /* mfmsr r11                          */ \
> +       .long 0x01006b69; /* xori r11,r11,1                     */ \
> +       .long 0xa6035a7d; /* mtsrr0 r10                         */ \
> +       .long 0xa6037b7d; /* mtsrr1 r11                         */ \
> +       .long 0x2400004c  /* rfid                               */

So, the combination of this sequence and its execution at __start
seems to be what's causing problems for me. I've both commented out
and nopped out the second instruction and the handcoded LE opcodes,
and it makes no difference -- it seems to be the execution of the tdi
that traps or causes some other problem. And yeah -- it definitely
shouldn't since TO is 0. Likewise if I replace the tdi with nop and
keep the rest it runs fine.

I'm a bit baffled that there's a difference based on what config is
booted. I'm booting a raw vmlinux from a BE firmware. Initial code
sequence is largely the same for both configs.

Unfortunately I no longer have a JTAG environment such that I can
check the value of r0 at the time of tdi execution. Still, based on
docs it shouldn't matter since there are no TO bits set. I don't see a
rational reason to why the above should fail. And indeed, if I load a
known-different value and set TO=4, I still see failures. Etc.

I also tried moving the FIXUP_ENDIAN call until after the branch to
__start_initialization_multiplatform but before 64-bit enable and
there it runs just fine.

So, I'm really quite baffled right now. Any ideas would be welcome,
I'm sort of stumped. In particular since pasemi_defconfig boots fine.


-Olof
