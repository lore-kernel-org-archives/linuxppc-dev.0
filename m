Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Khyv4gS3zF1LZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 21:41:10 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so3103173oib.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 04:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7wUsxznwK8fztA+2TAWJL9nEHek_tyUcDm9HCvy-4MdvpAWQ@mail.gmail.com>
In-Reply-To: <CA+7wUsxznwK8fztA+2TAWJL9nEHek_tyUcDm9HCvy-4MdvpAWQ@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 3 Jul 2018 13:40:55 +0200
Message-ID: <CA+7wUswfXaECaN5EiU9sNsO+YbgTOggVfsbMC4azStB7Xx9hPw@mail.gmail.com>
Subject: Re: CONFIG_LD_DEAD_CODE_DATA_ELIMINATION: Section mismatch in
 reference from the variable via_pmu_driver to the function
 .init.text:pmu_init()
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 3, 2018 at 11:40 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> Hi Nick,
>
> Would you consider this a bug:
>
> $ touch drivers/macintosh/via-pmu.c
> $ CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n make ARCH=powerpc
> CROSS_COMPILE=powerpc-linux-gnu-
> ...
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.data+0x216018): Section mismatch in reference from
> the variable via_pmu_driver to the function .init.text:pmu_init()
> The variable via_pmu_driver references
> the function __init pmu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
> While:
>
> $ touch drivers/macintosh/via-pmu.c
> $ CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y make ARCH=powerpc
> CROSS_COMPILE=powerpc-linux-gnu-
> ...
>   AR      init/built-in.a
>   AR      built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   KSYM    .tmp_kallsyms1.o
>   KSYM    .tmp_kallsyms2.o
>   LD      vmlinux
>   SORTEX  vmlinux
>   SYSMAP  System.map
> ...
>
> Thanks for comment

Just to clarify I reverted 58935176ad17976b7a7f6ea25c0ceb2ca4308a30
just as to reproduce a warning. So my question (rephrased):

Is this expected that CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y inhibit
the behavior of  CONFIG_DEBUG_SECTION_MISMATCH=y ?

Thanks
