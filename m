Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 4394CDDEEE
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 05:36:30 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so482879anc
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 10:36:29 -0800 (PST)
Message-ID: <fa686aa40711221036n6438c252lde71cffdaff97ea9@mail.gmail.com>
Date: Thu, 22 Nov 2007 11:36:29 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: [RFC/PATCH] powerpc: Move CPM command handling into the cpm
	drivers
In-Reply-To: <4745BB5F.6060002@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4745BB5F.6060002@scram.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/22/07, Jochen Friedrich <jochen@scram.de> wrote:
> This patch moves the CPM command handling into commproc.c
> for CPM1 and cpm2_common.c. This is yet another preparation
> to get rid of drivers accessing the CPM via the global cpmp.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/powerpc/sysdev/commproc.c          |   20 ++++++++++++++++++++
>  arch/powerpc/sysdev/cpm2_common.c       |   17 +++++++++++++++++
>  drivers/net/fs_enet/mac-fcc.c           |   10 +---------
>  drivers/net/fs_enet/mac-scc.c           |   11 +----------
>  drivers/serial/cpm_uart/cpm_uart_cpm1.c |    6 +-----
>  drivers/serial/cpm_uart/cpm_uart_cpm2.c |    8 +-------
>  include/asm-powerpc/cpm.h               |    1 +
>  7 files changed, 42 insertions(+), 31 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
> index f6a6378..2bddbde 100644
> --- a/arch/powerpc/sysdev/commproc.c
> +++ b/arch/powerpc/sysdev/commproc.c
> @@ -240,6 +240,26 @@ void __init cpm_reset(void)
>  #endif
>  }
>
> +#define MAX_CR_CMD_LOOPS        10000
> +
> +int cpm_command(u32 command, u8 opcode)
> +{
> +       int i;
> +
> +       if (command & 0xffffff0f)
> +               return -EINVAL;
> +
> +       out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode << 8));
> +       for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
> +               if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
> +                       return 0;
> +
> +       printk(KERN_ERR "%s(): Not able to issue CPM command\n",
> +               __FUNCTION__);
> +       return -EIO;

Do these need to be protected with a spin lock?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
