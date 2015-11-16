Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA82C1A026E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 22:42:38 +1100 (AEDT)
Received: by ykba77 with SMTP id a77so232624948ykb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 03:42:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5645072A.9000103@redhat.com>
References: <5645072A.9000103@redhat.com>
Date: Mon, 16 Nov 2015 14:42:36 +0300
Message-ID: <CAOJe8K2BSY8C6xcLpHszkbZ4dPTWg9Ckn_fubCX+pi8PtJ1oGw@mail.gmail.com>
Subject: Re: Section mismatches in arch/powerpc/kernel/head_64.S
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <scottwood@freescale.com>,
 Tiejun Chen <tiejun.chen@windriver.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/13/15, Laura Abbott <labbott@redhat.com> wrote:
> Hi,
>
> There seem to be section mismatches coming from head_64.S
>
> WARNING: vmlinux.o(.text+0x8994): Section mismatch in reference from the
> variable __boot_from_prom to the function .init.text:prom_init()
> The function __boot_from_prom() references
> the function __init prom_init().
> This is often because __boot_from_prom lacks a __init
> annotation or the annotation of prom_init is wrong.
>
> WARNING: vmlinux.o(.text+0x8c30): Section mismatch in reference from the
> variable start_here_multiplatform to the function .init.text:early_setup()
> The function start_here_multiplatform() references
> the function __init early_setup().
> This is often because start_here_multiplatform lacks a __init
> annotation or the annotation of early_setup is wrong.
>
> WARNING: vmlinux.o(.text+0x8c54): Section mismatch in reference from the
> variable start_here_common to the function .init.text:setup_system()
> The function start_here_common() references
> the function __init setup_system().
> This is often because start_here_common lacks a __init
> annotation or the annotation of setup_system is wrong.
>
> WARNING: vmlinux.o(.text+0x8c68): Section mismatch in reference from the
> variable start_here_common to the function .init.text:start_kernel()
> The function start_here_common() references
> the function __init start_kernel().
> This is often because start_here_common lacks a __init
> annotation or the annotation of start_kernel is wrong.
>
> FATAL: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> scripts/Makefile.modpost:97: recipe for target 'vmlinux.o' failed
>
> These were noticed when I accidentally turned off
> CONFIG_SECTION_MISMATCH_WARN_ONLY
> (see https://bugzilla.redhat.com/show_bug.cgi?id=1281446) which now
> makes them a compilation failure. Config attached. Currently just working
> around this by keeping that option on.

Looks like something new because I haven't seen these warnings. I'll
check what can be done here...

Thanks!
>
> Thanks,
> Laura
>
