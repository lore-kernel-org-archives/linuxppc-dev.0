Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfswV2vgszDsgc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 20:21:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH] Work around for enabling CONFIG_CMDLINE on ppc64le
In-Reply-To: <1474525245-10739-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1474525245-10739-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Date: Thu, 22 Sep 2016 20:21:29 +1000
Message-ID: <87d1jw8cba.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:

> Observed that boot arguments (passed as CONFIG_CMDLINE)  are not being
> picked up by kernel while using gcc-ppc64-linux-gnu v5.4.0 and v6.1.1.
> While it works as expected with v5.3.1 .
>
> Found that in init/main.c in  setup_command_line() the pointers passed to
> strcpy() is messed up.

Hi Akshay,

Thanks for debugging this.

> The problem goes away when compiler optimization is restricted to -O1.

> diff --git a/init/main.c b/init/main.c
> index a8a58e2..4259c42 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -358,7 +358,13 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
>   * parsing is performed in place, and we should allow a component to
>   * store reference of name/value for future reference.
>   */
> -static void __init setup_command_line(char *command_line)
> +static void __init
> +#ifdef CONFIG_PPC64
> +	#if  GCC_VERSION > 50301
> +		__attribute__((optimize("-O1")))
> +	#endif
> +#endif
> +		setup_command_line(char *command_line)
>  {
>  	saved_command_line =
>  		memblock_virt_alloc(strlen(boot_command_line) + 1, 0);

But I can't merge that patch.

Our options are one or both of:
 - get GCC fixed and backport the fix to the compilers we care about.
 - blacklist the broken compiler versions.

Is there a GCC bug filed for this?

cheers
