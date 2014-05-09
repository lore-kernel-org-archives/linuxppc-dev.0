Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C3FB814009B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 05:36:45 +1000 (EST)
Date: Fri, 9 May 2014 14:36:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [v6,3/5] powerpc/book3e: support kgdb for kernel space
Message-ID: <20140509193614.GA28739@home.buserror.net>
References: <1382520685-11609-4-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1382520685-11609-4-git-send-email-tiejun.chen@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 23, 2013 at 05:31:23PM +0800, Tiejun Chen wrote:
> Currently we need to skip this for supporting KGDB.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> 
> ---
> arch/powerpc/kernel/exceptions-64e.S |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index a55cf62..0b750c6 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -597,11 +597,13 @@ kernel_dbg_exc:
>  	rfdi
>  
>  	/* Normal debug exception */
> +1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
> +#ifndef CONFIG_KGDB
>  	/* XXX We only handle coming from userspace for now since we can't
>  	 *     quite save properly an interrupted kernel state yet
>  	 */
> -1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
>  	beq	kernel_dbg_exc;		/* if from kernel mode */
> +#endif

Now that we have support for properly saving state on special level
exceptions, that should be used here.  With the above patch, what happens
if e.g. a debug exception fires during a TLB miss, and the kgdb handler
takes its own TLB miss accessing the serial port?

-Scott
