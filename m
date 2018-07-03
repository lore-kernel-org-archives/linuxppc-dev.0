Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KbFm2SlLzF1Nr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 17:23:39 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id j17-v6so570876pfn.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 00:23:39 -0700 (PDT)
Date: Tue, 3 Jul 2018 17:23:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: 83a092cf95f28: powerpc: Link warning for orphan sections
Message-ID: <20180703172332.7210ec7a@roar.ozlabs.ibm.com>
In-Reply-To: <CA+7wUsz6AWY63hCwax2YSUPawRQbLfyje23qWKNGVUGM=OxM4Q@mail.gmail.com>
References: <CA+7wUsz6AWY63hCwax2YSUPawRQbLfyje23qWKNGVUGM=OxM4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 3 Jul 2018 09:03:46 +0200
Mathieu Malaterre <malat@debian.org> wrote:

> Hi Nick,
> 
> I am building my kernel (ppc32) with both
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y and CONFIG_UBSAN=y. This leads
> to ~316428 warnings such as:
> 
> + powerpc-linux-gnu-ld -EB -m elf32ppc -Bstatic --orphan-handling=warn
> --build-id --gc-sections -X -o .tmp_vmlinux1 -T
> ./arch/powerpc/kernel/vmlinux.lds --who
> le-archive built-in.a --no-whole-archive --start-group lib/lib.a --end-group
> powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data393'
> from `init/main.o' being placed in section `.data..Lubsan_data393'.
> powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data394'
> from `init/main.o' being placed in section `.data..Lubsan_data394'.
> powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data395'
> from `init/main.o' being placed in section `.data..Lubsan_data395'.
> powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data396'
> from `init/main.o' being placed in section `.data..Lubsan_data396'.
> ...
> 
> What would you recommend to reduce the number of warnings produced ? I
> tried `--warn-once` but that only affect undefined symbols.

I'm not sure if the linker can be quietened. You could try putting
*(.data..Lubsan_data*) into the .data section in
powerpc/kernel/vmlinux.lds.S

Thanks,
Nick
