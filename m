Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95975DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 05:13:35 +1000 (EST)
Message-ID: <46B0DB54.8090705@freescale.com>
Date: Wed, 01 Aug 2007 14:13:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC 8xx: bump up initial memory limit for 8xx
References: <20070717011723.23549.44672.stgit@localhost.localdomain>
In-Reply-To: <20070717011723.23549.44672.stgit@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> From: John Traill <john.traill@freescale.com>
> 
> The 8xx can only support a max of 8M during early boot ( it seems a lot of
> 8xx boards only have 8M so the bug was never triggered ). The following
> change makes it able to run with 128M.
> 
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> ---
> 
>  arch/powerpc/mm/init_32.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index e1f5ded..7cee86d 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -133,6 +133,9 @@ void __init MMU_init(void)
>  	/* 601 can only access 16MB at the moment */
>  	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
>  		__initial_memory_limit = 0x01000000;
> +	/* 852 can only access 8MB at the moment */
> +	if (PVR_VER(mfspr(SPRN_PVR)) == 0x50)
> +		__initial_memory_limit = 0x00800000;

The comment should refer to 8xx, not 852, as this is a property of code 
in head_8xx.S and not the chip itself.

Otherwise,
Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
