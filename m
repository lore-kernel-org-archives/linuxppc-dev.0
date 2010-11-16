Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7A52EB715A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 09:02:08 +1100 (EST)
Message-ID: <4CE2FF5A.402@windriver.com>
Date: Tue, 16 Nov 2010 16:02:02 -0600
From: Jason Wessel <jason.wessel@windriver.com>
MIME-Version: 1.0
To: Dongdong Deng <dongdong.deng@windriver.com>
Subject: Re: [PATCH] kgdb,
	ppc: Corrected the address using of current->thread.evr register
References: <1289912316-4580-1-git-send-email-dongdong.deng@windriver.com>
In-Reply-To: <1289912316-4580-1-git-send-email-dongdong.deng@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kgdb-bugreport@lists.sourceforge.net, "Hai, Shan" <shan.hai@windriver.com>,
	linuxppc-dev@lists.ozlabs.org,
	Sergei Shtylyov <sshtylyov@mvista.com>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2010 06:58 AM, Dongdong Deng wrote:
> Passing the address of current->thread.evr register to memcpy function.
>
>   

It turns out that out of all of my test configs and targets I did not
have any that defined both CONFIG_FSL_BOOKE and CONFIG_SPE else this
would have been caught in testing because will definitely crash
dereferencing the contents of the evr registers.

> Signed-off-by: Dongdong Deng <dongdong.deng@windriver.com>
> CC: Hai Shan <shan.hai@windriver.com>
> CC: Milton Miller <miltonm@bga.com>
> CC: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/kgdb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 7a9db64..781acff 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -337,7 +337,7 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>  		/* FP registers 32 -> 63 */
>  #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
>  		if (current)
> -			memcpy(mem, current->thread.evr[regno-32],
> +			memcpy(mem, (void *)&current->thread.evr[regno-32],
>  					dbg_reg_def[regno].size);
>   

As Sergei already pointed out, the (void *) casts should not be needed here.

This would have been fixed correctly had I seen the compile warnings
from the CONFIG_SPE at the test phase.   Namely at the compile phase
doesn't even complete:

arch/powerpc/kernel/kgdb.c: In function 'dbg_get_reg':
arch/powerpc/kernel/kgdb.c:341: error: passing argument 2 of 'memcpy'
makes pointer from integer without a cast
arch/powerpc/include/asm/string.h:25: note: expected 'const void *' but
argument is of type 'long unsigned int'
arch/powerpc/kernel/kgdb.c: In function 'dbg_set_reg':
arch/powerpc/kernel/kgdb.c:366: error: passing argument 1 of 'memcpy'
makes pointer from integer without a cast
arch/powerpc/include/asm/string.h:25: note: expected 'void *' but
argument is of type 'long unsigned int'


Moral of the story... I now have a board and config with the SPE turned
on, and after boot testing confirmed the evr registers are working.

I plan to have a pull request out to Linus with this fix and several
other accumulated regression fixes sometime in the next 48 hours.

Thanks,
Jason.
