Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 093C9DDF7B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 11:43:03 +1100 (EST)
Subject: Re: [RFC] powerpc/8xxx: Clean up setting of CPU_FTR_NEED_COHERENT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090317045815.27319.62728.stgit@localhost.localdomain>
References: <20090317045815.27319.62728.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 18 Mar 2009 11:42:57 +1100
Message-Id: <1237336977.25062.168.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index 48d7f5f..a36494e 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -242,8 +242,7 @@ extern const char *powerpc_base_platform;
>   * 74[45]x and an MPC107 host bridge. Also 83xx and PowerQUICC II
>   * require it for PCI "streaming/prefetch" to work properly.
>   */
> -#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE) \
> -	|| defined(CONFIG_PPC_83xx) || defined(CONFIG_8260)
> +#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
>  #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
>  #else
>  #define CPU_FTR_COMMON                  0

Even the above sucks but at this stage, it's hard to do better. We
really need to fix ppc32 so that the feature fixup is done -after- the
platform probe, so that the platform gets a chance to stick in the bit
when needed.

Ben.
