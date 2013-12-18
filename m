Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0152.outbound.protection.outlook.com [207.46.163.152])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9A2D72C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 14:50:54 +1100 (EST)
Message-ID: <1387338638.3140.43.camel@snotra.buserror.net>
Subject: Re: [v3][PATCH 8/8] book3e/kexec/kdump: recover "r4 = 0" to create
 the initial TLB
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 17 Dec 2013 21:50:38 -0600
In-Reply-To: <1373357007-30785-9-git-send-email-tiejun.chen@windriver.com>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-9-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-09 at 16:03 +0800, Tiejun Chen wrote:
> In commit 96f013f, "powerpc/kexec: Add kexec "hold" support for Book3e
> processors", requires that GPR4 survive the "hold" process, for IBM Blue
> Gene/Q with with some very strange firmware. But for FSL Book3E, r4 = 1
> to indicate that the initial TLB entry for this core already exists so
> we still should set r4 with 0 to create that initial TLB.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/head_64.S |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 0b46c9d..d546c5e 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -127,6 +127,10 @@ __secondary_hold:
>  	/* Grab our physical cpu number */
>  	mr	r24,r3
>  	/* stash r4 for book3e */
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +	/* we need to setup initial TLB entry. */
> +	li	r4,0
> +#endif
>  	mr	r25,r4

This breaks being able to build one kernel that supports both FSL book3e
and IBM book3e.

-Scott
