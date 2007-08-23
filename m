Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA885DDEEB
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 13:25:32 +1000 (EST)
In-Reply-To: <20070823130913.2e9db6eb.sfr@canb.auug.org.au>
References: <20070823130913.2e9db6eb.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1A23DF12-65EB-4236-B78A-ADF1DDF0FFFD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [POWERPC] Remove cmd_line from head*.S
Date: Wed, 22 Aug 2007 22:27:31 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 10:09 PM, Stephen Rothwell wrote:

> It is just a C char array, so declare it thusly.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/head_32.S        |    8 --------
>  arch/powerpc/kernel/head_44x.S       |    8 --------
>  arch/powerpc/kernel/head_4xx.S       |    7 -------
>  arch/powerpc/kernel/head_64.S        |    8 --------
>  arch/powerpc/kernel/head_8xx.S       |    8 --------
>  arch/powerpc/kernel/head_fsl_booke.S |    8 --------
>  arch/powerpc/kernel/prom.c           |    2 ++
>  7 files changed, 2 insertions(+), 47 deletions(-)
>
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au

[snip]

> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 0028fe6..dc85005 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -60,6 +60,8 @@
>  #endif
>
>
> +char cmd_line[COMMAND_LINE_SIZE];
> +

would this be better in setup-common.c?

>  static int __initdata dt_root_addr_cells;
>  static int __initdata dt_root_size_cells;
>

- k
