Return-Path: <sshtylyov@mvista.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id CCB74B70FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 00:04:47 +1100 (EST)
Received: by ewy2 with SMTP id 2so205352ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 05:04:44 -0800 (PST)
Message-ID: <4CE280DC.4040009@mvista.com>
Date: Tue, 16 Nov 2010 16:02:20 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Dongdong Deng <dongdong.deng@windriver.com>
Subject: Re: [Kgdb-bugreport] [PATCH] kgdb, ppc: Corrected the address using
	of current->thread.evr register
References: <1289912316-4580-1-git-send-email-dongdong.deng@windriver.com>
In-Reply-To: <1289912316-4580-1-git-send-email-dongdong.deng@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kgdb-bugreport@lists.sourceforge.net, shan.hai@windriver.com,
	linuxppc-dev@lists.ozlabs.org, miltonm@bga.com, jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 16-11-2010 15:58, Dongdong Deng wrote:

> Passing the address of current->thread.evr register to memcpy function.

> Signed-off-by: Dongdong Deng<dongdong.deng@windriver.com>
> CC: Hai Shan<shan.hai@windriver.com>
> CC: Milton Miller<miltonm@bga.com>
> CC: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kernel/kgdb.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 7a9db64..781acff 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -337,7 +337,7 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>   		/* FP registers 32 ->  63 */
>   #if defined(CONFIG_FSL_BOOKE)&&  defined(CONFIG_SPE)
>   		if (current)
> -			memcpy(mem, current->thread.evr[regno-32],
> +			memcpy(mem, (void *)&current->thread.evr[regno-32],
>   					dbg_reg_def[regno].size);
>   #else
>   		/* fp registers not used by kernel, leave zero */
> @@ -362,7 +362,7 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>   	if (regno>= 32&&  regno<  64) {
>   		/* FP registers 32 ->  63 */
>   #if defined(CONFIG_FSL_BOOKE)&&  defined(CONFIG_SPE)
> -		memcpy(current->thread.evr[regno-32], mem,
> +		memcpy((void *)&current->thread.evr[regno-32], mem,

    Doesn't any pointer type get converted to 'void *' automatically? These 
casts are not really needed...

WBR, Sergei
