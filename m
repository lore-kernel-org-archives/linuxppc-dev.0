Return-Path: <jeyu@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF30M2TYqzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 14:54:43 +1100 (AEDT)
Date: Thu, 2 Feb 2017 22:54:41 -0500
From: Jessica Yu <jeyu@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 arnd@arndb.de, rusty@rustcorp.com.au, mpe@ellerman.id.au,
 viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org,
 linux@armlinux.org.uk, linux-arch@vger.kernel.org
Subject: Re: modversions: redefine kcrctab entries as 32-bit values
Message-ID: <20170203035441.GA2964@packer-debian-8-amd64.digitalocean.com>
References: <1485274600-21976-1-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1485274600-21976-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+++ Ard Biesheuvel [24/01/17 16:16 +0000]:
>This v4 is a followup to [0] 'modversions: redefine kcrctab entries as
>relative CRC pointers', but since relative CRC pointers do not work in
>modules, and are actually only needed by powerpc with CONFIG_RELOCATABLE=y,
>I have made it a Kconfig selectable feature instead.
>
>Patch #1 introduces the MODULE_REL_CRCS Kconfig symbol, and adds the kbuild
>handling of it, i.e., modpost, genksyms and kallsyms.
>
>Patch #2 switches all architectures to 32-bit CRC entries in kcrctab, where
>all architectures except powerpc with CONFIG_RELOCATABLE=y use absolute ELF
>symbol references as before.
>
>v4: make relative CRCs kconfig selectable
>    use absolute CRC symbols in modules regardless of kconfig selection
>    split into two patches

This asymmetry threw me off a bit, especially the Kconfig naming (only
vmlinux crcs get the relative offsets, and only on powerpc atm, but all
modules keep the absolute syms, but it is called MODULE_REL_CRCS...),
if we keep this asymmetric crc treatment, it would be really nice to
note this discrepancy this somewhere, perhaps in the Kconfig, to keep
our heads from spinning :-)

I'm still catching up on the previous discussion threads, but can you
explain a bit more why you switched away from full blown relative crcs
from your last patchset [1]? I had lightly tested your v3 on ppc64le
previously, and relative offsets with modules seemed to worked very
well. I'm probably missing something very obvious.

[1] http://marc.info/?l=linux-arch&m=148493613415294&w=2

>v3: emit CRCs into .rodata rather than .rodata.modver, given that the latter
>    will be emitted with read-write permissions, making the CRCs end up in a
>    writable module segment.
>
>    fold the modpost fix to ensure that the section address is only substracted
>    from the symbol address when the ELF object in question is fully linked
>    (i.e., ET_DYN or ET_EXEC, and not ET_REL)
>
>v2: update modpost as well, so that genksyms no longer has to emit symbols
>    for both the actual CRC value and the reference to where it is stored
>    in the image
>
>[0] http://marc.info/?l=linux-arch&m=148493613415294&w=2
>
>Ard Biesheuvel (2):
>  kbuild: modversions: add infrastructure for emitting relative CRCs
>  modversions: treat symbol CRCs as 32 bit quantities
>
> arch/powerpc/Kconfig              |  1 +
> arch/powerpc/include/asm/module.h |  4 --
> arch/powerpc/kernel/module_64.c   |  8 ----
> include/asm-generic/export.h      | 11 ++---
> include/linux/export.h            | 14 ++++++
> include/linux/module.h            | 14 +++---
> init/Kconfig                      |  4 ++
> kernel/module.c                   | 45 ++++++++++----------
> scripts/Makefile.build            |  2 +
> scripts/genksyms/genksyms.c       | 19 ++++++---
> scripts/kallsyms.c                | 12 ++++++
> scripts/mod/modpost.c             | 10 +++++
> 12 files changed, 93 insertions(+), 51 deletions(-)
>
>-- 
>2.7.4
>
