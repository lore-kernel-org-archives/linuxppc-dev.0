Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvKfW2D7KzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 21:54:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 03/21] powerpc: Mark the variable
 earlycon_acpi_spcr_enable maybe_unused
In-Reply-To: <20180225172236.29650-4-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-4-malat@debian.org>
Date: Sun, 04 Mar 2018 21:54:08 +1100
Message-ID: <87po4kglgv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:

> Re-use the object-like macro EARLYCON_USED_OR_UNUSED to mark
> `earlycon_acpi_spcr_enable` as maybe_unused.
>
> Fix the following warning (treated as error in W=3D1)
>
>   CC      arch/powerpc/kernel/setup-common.o
> In file included from ./include/linux/serial_8250.h:14:0,
>                  from arch/powerpc/kernel/setup-common.c:33:
> ./include/linux/serial_core.h:382:19: error: =E2=80=98earlycon_acpi_spcr_=
enable=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>  static const bool earlycon_acpi_spcr_enable;
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  include/linux/serial_core.h | 1 +

I can't take this one as that's not a file I maintain.

The script says:

  $ ./scripts/get_maintainer.pl include/linux/serial_core.h
  gregkh@linuxfoundation.org
  jslaby@suse.com
  linux-kernel@vger.kernel.org


Can you resend it to them?

> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b32df49a3bd5..4d14ecd7dbe8 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -379,6 +379,7 @@ extern int of_setup_earlycon(const struct earlycon_id=
 *match,
>  extern bool earlycon_acpi_spcr_enable __initdata;
>  int setup_earlycon(char *buf);
>  #else
> +EARLYCON_USED_OR_UNUSED
>  static const bool earlycon_acpi_spcr_enable;

The macro eventually turns into an __attribute__, which I think is
typically placed after the variable, so eg:

  static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;


cheers

>  static inline int setup_earlycon(char *buf) { return 0; }
>  #endif
> --=20
> 2.11.0
