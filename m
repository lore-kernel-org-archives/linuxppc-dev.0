Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1CA92C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 21:39:16 +1100 (EST)
Received: by mail-vb0-f51.google.com with SMTP id fn1so6920693vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 02:39:14 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1352757066.32153.5@snotra>
References: <CAMuHMdXE0yJNivpirGgx08zqLH2086ydeOU6zswXj-+zn8OsWQ@mail.gmail.com>
 <1352757066.32153.5@snotra>
Date: Tue, 13 Nov 2012 11:39:13 +0100
Message-ID: <CAMuHMdVytJ6YcDb1-MAaqwgTKXDLi3tJaVW3vh9aE5smNwJR=g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.7-rc5
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On Mon, Nov 12, 2012 at 10:51 PM, Scott Wood <scottwood@freescale.com> wrote:
> On 11/12/2012 03:02:46 PM, Geert Uytterhoeven wrote:
>> On Mon, Nov 12, 2012 at 9:58 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > JFYI, when comparing v3.7-rc5 to v3.7-rc4[3], the summaries are:
>> >   - build errors: +14/-4
>>
>> 14 regressions:
>>   + drivers/virt/fsl_hypervisor.c: error: 'MSR_GS' undeclared (first
>> use in this function):  => 799:93
>
> These reports would be more useful if the actual .config were provided,
> rather than just saying "powerpc randconfig".

This can be obtained from the kissb build system.
[1] http://kisskb.ellerman.id.au/kisskb/head/5614/ (all 117 configs)

> I doubt this particular one is a regression; it looks like the dependencies

Yeah, regressions in randconfigs can be misleading.
Still, they're build failures.

> have always been too weak (patch sent) and you're just comparing different
> randomly-generated configs.

Thanks for your patch!

>> powerpc-randconfig
>>
>>   + error: relocation truncated to fit: R_PPC64_REL24 against symbol
>> `._mcount' defined in .text section in arch/powerpc/kernel/entry_64.o:
>> (.text+0x1ff9eb8) => (.text+0x1ffa274), (.text+0x1ff7840)
>>
>> powerpc-allyesconfig
>
>
> It's been over 3 years since powerpc-allyesconfig built (it's just too big
> for the relocation model the kernel uses) -- how is this a regression?

It's a regression because it didn't complain about ".mcount" in the
previous run.

But I'll start stripping them from the rc-incremental reports.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
