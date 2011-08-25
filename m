Return-Path: <B34182@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9AFEBB6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 13:40:16 +1000 (EST)
From: Liu Gang-B34182 <B34182@freescale.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Subject: RE: [PATCH] fsl-rio: Correct IECSR register clear value
Date: Thu, 25 Aug 2011 03:39:57 +0000
Message-ID: <9A1C2A9ACC704641BC472A1588CE16470ECAB8@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1312798419-3912-1-git-send-email-b34182@freescale.com>
	<9A1C2A9ACC704641BC472A1588CE16470EC9C3@039-SN1MPN1-004.039d.mgd.msft.net>
	<20110824115355.92febdfc.akpm@linux-foundation.org>
In-Reply-To: <20110824115355.92febdfc.akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>,
	Li Yang-R58472 <r58472@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Andrew,

Thanks for your comments.

I think you are right and a more detailed description will be better.

This bug causes the IECSR register clear failure.
In this case, the RETE (retry error threshold exceeded) interrupt will be g=
enerated and cannot be cleared.
So the related ISR may be called persistently.

Thanks again!

Regards,

Liu Gang

-----Original Message-----
From: Andrew Morton [mailto:akpm@linux-foundation.org]=20
Sent: Thursday, August 25, 2011 2:54 AM
To: Liu Gang-B34182
Cc: 'linuxppc-dev@lists.ozlabs.org'; Li Yang-R58472; Gala Kumar-B11780; Zan=
g Roy-R61911
Subject: Re: [PATCH] fsl-rio: Correct IECSR register clear value

On Wed, 24 Aug 2011 09:31:21 +0000
Liu Gang-B34182 <B34182@freescale.com> wrote:

> Hi, Andrew,
>=20
> Thank you for applying the patch "[PATCH] rio: Use discovered bit to test=
 if enumeration is complete "!
>=20
> So far the following patch "[PATCH] fsl-rio: Correct IECSR register clear=
 value " has no comment or response.

Perhaps because you didn't tell anyone what the patch does.

> To: linuxppc-dev@ozlabs.org
> Cc: akpm@linux-foundation.org; Li Yang-R58472; Gala Kumar-B11780; Zang=20
> Roy-R61911; Liu Gang-B34182; Liu Gang-B34182
> Subject: [PATCH] fsl-rio: Correct IECSR register clear value
>=20
> The RETE bit in IECSR is cleared by writing a 1 to it.
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_rio.c=20
> b/arch/powerpc/sysdev/fsl_rio.c index b3fd081..cdd765b 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -54,6 +54,7 @@
>  #define ODSR_CLEAR		0x1c00
>  #define LTLEECSR_ENABLE_ALL	0xFFC000FC
>  #define ESCSR_CLEAR		0x07120204
> +#define IECSR_CLEAR		0x80000000
> =20
>  #define RIO_PORT1_EDCSR		0x0640
>  #define RIO_PORT2_EDCSR		0x0680
> @@ -1089,11 +1090,11 @@ static void port_error_handler(struct=20
> rio_mport *port, int offset)
> =20
>  	if (offset =3D=3D 0) {
>  		out_be32((u32 *)(rio_regs_win + RIO_PORT1_EDCSR), 0);
> -		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), 0);
> +		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), IECSR_CLEAR);
>  		out_be32((u32 *)(rio_regs_win + RIO_ESCSR), ESCSR_CLEAR);
>  	} else {
>  		out_be32((u32 *)(rio_regs_win + RIO_PORT2_EDCSR), 0);
> -		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), 0);
> +		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), IECSR_CLEAR);
>  		out_be32((u32 *)(rio_regs_win + RIO_PORT2_ESCSR), ESCSR_CLEAR);
>  	}
>  }

Apparently it fixes some bug.  But because you didn't tell us what the user=
-visible effects of that bug are, I am unable to determine what kernel vers=
ions (if any) the patch should be merged into.
