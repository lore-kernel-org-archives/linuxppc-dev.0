Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8A74B6F98
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jun 2011 23:59:57 +1000 (EST)
Subject: Re: [PATCH] Fix doorbell type shift
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <23877.1307328527@neuling.org>
Date: Tue, 7 Jun 2011 07:59:30 -0500
Message-Id: <CC124840-E863-4D55-A28D-1A01C8A6BF10@kernel.crashing.org>
References: <23877.1307328527@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 5, 2011, at 9:48 PM, Michael Neuling wrote:

> doorbell type is defined as bits 32:36 so should be shifted by 63-36 =
> 27 rather than 28.
> 
> We never noticed this bug as we've only every used type PPC_DBELL = 0.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> arch/powerpc/include/asm/dbell.h |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

> 
> Index: linux-ozlabs/arch/powerpc/include/asm/dbell.h
> ===================================================================
> --- linux-ozlabs.orig/arch/powerpc/include/asm/dbell.h
> +++ linux-ozlabs/arch/powerpc/include/asm/dbell.h
> @@ -18,7 +18,7 @@
> #include <asm/ppc-opcode.h>
> 
> #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
> -#define PPC_DBELL_TYPE(x)	(((x) & 0xf) << 28)
> +#define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
> enum ppc_dbell {
> 	PPC_DBELL = 0,		/* doorbell */
> 	PPC_DBELL_CRIT = 1,	/* critical doorbell */
