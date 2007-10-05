Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 450A8DDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 15:15:03 +1000 (EST)
In-Reply-To: <20070925143440.GD5323@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143440.GD5323@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21434A69-74CD-4F04-A2DE-1D87CB20415E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] [POWERPC] QE pario: support for MPC85xx layout
Date: Fri, 5 Oct 2007 00:15:08 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 25, 2007, at 9:34 AM, Anton Vorontsov wrote:

> 8 bytes padding required to match MPC85xx registers layout.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/sysdev/qe_lib/qe_io.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/ 
> sysdev/qe_lib/qe_io.c
> index e32b45b..d566e89 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe_io.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
> @@ -36,6 +36,9 @@ struct port_regs {
>  	__be32	cpdir2;		/* Direction register */
>  	__be32	cppar1;		/* Pin assignment register */
>  	__be32	cppar2;		/* Pin assignment register */
> +#ifdef CONFIG_MPC85xx

use CONFIG_PPC_85xx

> +	u8	pad[8];
> +#endif
>  };

- k
