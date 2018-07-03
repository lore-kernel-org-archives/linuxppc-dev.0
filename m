Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KftS28x0zF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 20:07:12 +1000 (AEST)
Subject: Re: CONFIG_LD_DEAD_CODE_DATA_ELIMINATION: Section mismatch in
 reference from the variable via_pmu_driver to the function
 .init.text:pmu_init()
To: Mathieu Malaterre <malat@debian.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <CA+7wUsxznwK8fztA+2TAWJL9nEHek_tyUcDm9HCvy-4MdvpAWQ@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3c0e6f6a-8d95-c76b-3496-bb135f54ef8d@c-s.fr>
Date: Tue, 3 Jul 2018 12:07:08 +0200
MIME-Version: 1.0
In-Reply-To: <CA+7wUsxznwK8fztA+2TAWJL9nEHek_tyUcDm9HCvy-4MdvpAWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/07/2018 à 11:40, Mathieu Malaterre a écrit :
> Hi Nick,
> 
> Would you consider this a bug:

Looks more like a feature ...

In /drivers/macintosh/adb.c you have, and it's the only place 
via_pmu_driver is used.

#if defined(CONFIG_ADB_PMU) || defined(CONFIG_ADB_PMU68K)
	&via_pmu_driver,
#endif

Is one of those defined in your .config ? If not then via_pmu_driver 
gets eliminated hence nothing to warn on.


Christophe


> 
> $ touch drivers/macintosh/via-pmu.c
> $ CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n make ARCH=powerpc
> CROSS_COMPILE=powerpc-linux-gnu-
> ...
>    LD      vmlinux.o
>    MODPOST vmlinux.o
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
>    AR      init/built-in.a
>    AR      built-in.a
>    LD      vmlinux.o
>    MODPOST vmlinux.o
>    KSYM    .tmp_kallsyms1.o
>    KSYM    .tmp_kallsyms2.o
>    LD      vmlinux
>    SORTEX  vmlinux
>    SYSMAP  System.map
> ...
> 
> Thanks for comment
> 
