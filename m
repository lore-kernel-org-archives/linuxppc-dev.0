Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QWMy3wQxzF1yy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 02:45:50 +1000 (AEST)
Received: by mail-ot0-x241.google.com with SMTP id d9-v6so22098412oth.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 09:45:50 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
References: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 17 Apr 2018 18:45:27 +0200
Message-ID: <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Allow selection of
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2018 at 12:49 PM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> This option does dead code and data elimination with the linker by
> compiling with -ffunction-sections -fdata-sections and linking with
> --gc-sections.
>
> By selecting this option on mpc885_ads_defconfig,
> vmlinux LOAD segment size gets reduced by 10%
>
> Program Header before the patch:
>     LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
>          filesz 0x0036eda4 memsz 0x0038de04 flags rwx
>
> Program Header after the patch:
>     LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
>          filesz 0x00316da4 memsz 0x00334268 flags rwx
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8fe4353be5e3..e1fac49cf465 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -888,6 +888,14 @@ config PPC_MEM_KEYS
>
>           If unsure, say y.
>
> +config PPC_UNUSED_ELIMINATION
> +       bool "Eliminate unused functions and data from vmlinux"
> +       default n
> +       select LD_DEAD_CODE_DATA_ELIMINATION
> +       help
> +         Select this to do dead code and data elimination with the linker
> +         by compiling with -ffunction-sections -fdata-sections and linking
> +         with --gc-sections.
>  endmenu
>

Just for reference, I cannot boot my Mac Mini G4 anymore (yaboot). The
messages I can see (prom_init) are:

---
done
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x01100000 -> 0x01100e02
Device tree struct   0x01101000 -> 0x01109000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x00140000 ...
_
---



>  config ISA_DMA_API
> --
> 2.13.3
>
