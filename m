Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172]) by ozlabs.org (Postfix) with ESMTP id 4BC49B7D20
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 03:20:24 +1100 (EST)
Received: by iwn2 with SMTP id 2so4766867iwn.10
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 08:20:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265096864-3506-4-git-send-email-agust@denx.de>
References: <1265096864-3506-1-git-send-email-agust@denx.de>
	<1265096864-3506-4-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 09:20:03 -0700
Message-ID: <fa686aa41002090820n1242a04bj2c0497f50a71b1be@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: mpc5121: enable support for more PSC UARTs
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 2, 2010 at 12:47 AM, Anatolij Gustschin <agust@denx.de> wrote:
> MPC5121 has 12 PSC devices. Enable UART support for all of
> them by defining the number of max. PSCs depending on
> selection of PPC_MPC512x platform support.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> =A0arch/powerpc/include/asm/mpc52xx_psc.h | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/includ=
e/asm/mpc52xx_psc.h
> index fb84120..42561f4 100644
> --- a/arch/powerpc/include/asm/mpc52xx_psc.h
> +++ b/arch/powerpc/include/asm/mpc52xx_psc.h
> @@ -25,7 +25,11 @@
> =A0#include <asm/types.h>
>
> =A0/* Max number of PSCs */
> +#ifdef CONFIG_PPC_MPC512x
> +#define MPC52xx_PSC_MAXNUM =A0 =A0 12
> +#else
> =A0#define MPC52xx_PSC_MAXNUM =A0 =A0 6
> +#endif

It would be nice to be rid of the stupid pre-allocated port structures
entirely, but that is a much more invasive and complex change.
Regardless;

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Please repost this series and add linux-kernel@vger.kernel.org and
gregkh@suse.de to the cc: list.  I'm happy to either let Greg pick
this series up, or pick up into my tree, but we need to coordinate
with Greg either way.

./scripts/get_maintainer.pl is your friend when posting patches.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
