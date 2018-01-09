Return-Path: <srs0=+o32=ee=gmail.com=joel.stan@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG34q5vbjzF0bH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 18:03:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zG34q4zVTz8tKK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 18:03:07 +1100 (AEDT)
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zG34q01T2z9sBZ
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2018 18:03:06 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id r39so16647934qtr.13
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Jan 2018 23:03:06 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180108165453.26066-7-mpe@ellerman.id.au>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-7-mpe@ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 8 Jan 2018 23:02:44 -0800
Message-ID: <CACPK8XfOyB8t+d9ALr38=akc9BKuxeA-b4jU5FqYPGPzGX4qjw@mail.gmail.com>
Subject: Re: [PATCH 07/11] powerpc/64s: Add support for RFI flush of L1-D cache
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 peterz@infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, npiggin@gmail.com,
 "Oliver O'Halloran" <oohall@gmail.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 8, 2018 at 8:54 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On some CPUs we can prevent the Meltdown vulnerability by flushing the
> L1-D cache on exit from kernel to user mode, and from hypervisor to
> guest.

Super minor nitpicks below. Don't let this hold up your work.

> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1449,6 +1449,88 @@ masked_##_H##interrupt:                                  \
>         b       .;                                      \
>         MASKED_DEC_HANDLER(_H)
>
> +TRAMP_REAL_BEGIN(rfi_flush_fallback)
> +       SET_SCRATCH0(r13);
> +       GET_PACA(r13);
> +       std     r9,PACA_EXRFI+EX_R9(r13)
> +       std     r10,PACA_EXRFI+EX_R10(r13)
> +       std     r11,PACA_EXRFI+EX_R11(r13)
> +       std     r12,PACA_EXRFI+EX_R12(r13)
> +       std     r8,PACA_EXRFI+EX_R13(r13)
> +       mfctr   r9
> +       ld      r10,PACA_RFI_FLUSH_FALLBACK_AREA(r13)
> +       ld      r11,PACA_L1D_FLUSH_SETS(r13)
> +       ld      r12,PACA_L1D_FLUSH_CONGRUENCE(r13)
> +       /*
> +        * The load adresses are at staggered offsets within cachelines,
> +        * which suits some pipelines better (on others it should not
> +        * hurt.

Nit: missing ) on the last line.

> +        */
> +       addi    r12,r12,8
> +       mtctr   r11
> +       DCBT_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
> +

> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -116,6 +116,47 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
>         }
>  }
>
> +#ifdef CONFIG_PPC_BOOK3S_64
> +void do_rfi_flush_fixups(enum l1d_flush_type types)
> +{
> +       unsigned int instrs[3], *dest;
> +       long *start, *end;
> +       int i;
> +
> +       start = PTRRELOC(&__start___rfi_flush_fixup),
> +       end = PTRRELOC(&__stop___rfi_flush_fixup);
> +
> +       instrs[0] = 0x60000000; /* nop */
> +       instrs[1] = 0x60000000; /* nop */
> +       instrs[2] = 0x60000000; /* nop */
> +
> +       if (types & L1D_FLUSH_FALLBACK)

This looked a bit confusing on first read. Do we ever get
L1D_FLUSH_FALLBACK and the other types? If not, could it be made
clearer?

  if ( types & L1D_FLUSH_FALLBACK)
      /* stuff */
  else
    /* other types */


> +               /* b .+16 to fallback flush */
> +               instrs[0] = 0x48000010;
> +
> +       i = 0;
> +       if (types & L1D_FLUSH_ORI) {
> +               instrs[i++] = 0x63ff0000; /* ori 31,31,0 speculation barrier */
> +               instrs[i++] = 0x63de0000; /* ori 30,30,0 L1d flush*/
> +       }
> +
> +       if (types & L1D_FLUSH_MTTRIG)
> +               instrs[i++] = 0x7c12dba6; /* mtspr TRIG2,r0 (SPR #882) */
> +
> +       for (i = 0; start < end; start++, i++) {
> +               dest = (void *)start + *start;
> +
> +               pr_devel("patching dest %lx\n", (unsigned long)dest);
> +
> +               patch_instruction(dest, instrs[0]);
> +               patch_instruction(dest + 1, instrs[1]);
> +               patch_instruction(dest + 2, instrs[2]);
> +       }
> +
> +       printk(KERN_DEBUG "rfi-flush: patched %d locations\n", i);
> +}
> +#endif /* CONFIG_PPC_BOOK3S_64 */
> +
>  void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
>  {
>         long *start, *end;
> --
> 2.14.3
>
