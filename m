Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KbYb2Q3nzF1LK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 17:37:23 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so1899913oie.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 00:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7wUsz6AWY63hCwax2YSUPawRQbLfyje23qWKNGVUGM=OxM4Q@mail.gmail.com>
 <20180703172332.7210ec7a@roar.ozlabs.ibm.com>
In-Reply-To: <20180703172332.7210ec7a@roar.ozlabs.ibm.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 3 Jul 2018 09:37:09 +0200
Message-ID: <CA+7wUswneEQvEMfWgQHuMoVE93cZ+P6pVVM0PnC8+QMt1=U1Mg@mail.gmail.com>
Subject: Re: 83a092cf95f28: powerpc: Link warning for orphan sections
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 3, 2018 at 9:23 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Tue, 3 Jul 2018 09:03:46 +0200
> Mathieu Malaterre <malat@debian.org> wrote:
>
> > Hi Nick,
> >
> > I am building my kernel (ppc32) with both
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y and CONFIG_UBSAN=y. This leads
> > to ~316428 warnings such as:
> >
> > + powerpc-linux-gnu-ld -EB -m elf32ppc -Bstatic --orphan-handling=warn
> > --build-id --gc-sections -X -o .tmp_vmlinux1 -T
> > ./arch/powerpc/kernel/vmlinux.lds --who
> > le-archive built-in.a --no-whole-archive --start-group lib/lib.a --end-group
> > powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data393'
> > from `init/main.o' being placed in section `.data..Lubsan_data393'.
> > powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data394'
> > from `init/main.o' being placed in section `.data..Lubsan_data394'.
> > powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data395'
> > from `init/main.o' being placed in section `.data..Lubsan_data395'.
> > powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data396'
> > from `init/main.o' being placed in section `.data..Lubsan_data396'.
> > ...
> >
> > What would you recommend to reduce the number of warnings produced ? I
> > tried `--warn-once` but that only affect undefined symbols.
>
> I'm not sure if the linker can be quietened. You could try putting
> *(.data..Lubsan_data*) into the .data section in
> powerpc/kernel/vmlinux.lds.S

Nice ! Will submit a patch. Thanks

> Thanks,
> Nick
