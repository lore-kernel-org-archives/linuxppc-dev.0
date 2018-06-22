Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Bv1k4GzhzF0tm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 19:50:02 +1000 (AEST)
Received: by mail-ot0-f193.google.com with SMTP id v24-v6so6832272otk.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 02:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-17-malat@debian.org>
In-Reply-To: <20180322202007.23088-17-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 22 Jun 2018 11:49:49 +0200
Message-ID: <CA+7wUsxFJqjnygdg0a84QYktFGMUYeSiGD6=Ld3O06QsZkgG9g@mail.gmail.com>
Subject: Re: [PATCH 16/19] powerpc/powermac: Add missing include of header
 pmac.h
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This one is also ok.

On Thu, Mar 22, 2018 at 9:21 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> The header `pmac.h` was not included, leading to the following warnings,
> treated as error with W=3D1:
>
>   arch/powerpc/platforms/powermac/time.c:69:13: error: no previous protot=
ype for =E2=80=98pmac_time_init=E2=80=99 [-Werror=3Dmissing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:207:15: error: no previous proto=
type for =E2=80=98pmac_get_boot_time=E2=80=99 [-Werror=3Dmissing-prototypes=
]
>   arch/powerpc/platforms/powermac/time.c:222:6: error: no previous protot=
ype for =E2=80=98pmac_get_rtc_time=E2=80=99 [-Werror=3Dmissing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:240:5: error: no previous protot=
ype for =E2=80=98pmac_set_rtc_time=E2=80=99 [-Werror=3Dmissing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:259:12: error: no previous proto=
type for =E2=80=98via_calibrate_decr=E2=80=99 [-Werror=3Dmissing-prototypes=
]
>   arch/powerpc/platforms/powermac/time.c:311:13: error: no previous proto=
type for =E2=80=98pmac_calibrate_decr=E2=80=99 [-Werror=3Dmissing-prototype=
s]
>
> The function `via_calibrate_decr` was made static to silence a warning.
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/platforms/powermac/time.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platfo=
rms/powermac/time.c
> index 274af6fa388e..5cc6fa40fcc4 100644
> --- a/arch/powerpc/platforms/powermac/time.c
> +++ b/arch/powerpc/platforms/powermac/time.c
> @@ -34,6 +34,8 @@
>  #include <asm/nvram.h>
>  #include <asm/smu.h>
>
> +#include "pmac.h"
> +
>  #undef DEBUG
>
>  #ifdef DEBUG
> @@ -256,7 +258,7 @@ int pmac_set_rtc_time(struct rtc_time *tm)
>   * Calibrate the decrementer register using VIA timer 1.
>   * This is used both on powermacs and CHRP machines.
>   */
> -int __init via_calibrate_decr(void)
> +static int __init via_calibrate_decr(void)
>  {
>         struct device_node *vias;
>         volatile unsigned char __iomem *via;
> --
> 2.11.0
>
