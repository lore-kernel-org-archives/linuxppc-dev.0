Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F5B41A0151
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 13:36:08 +1100 (AEDT)
Message-ID: <1427337346.6468.105.camel@kernel.crashing.org>
Subject: Re: linux-next: build failure after merge of the powerpc-mpe tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 26 Mar 2015 13:35:46 +1100
In-Reply-To: <20150326132948.3feecd0c@canb.auug.org.au>
References: <20150326132948.3feecd0c@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-26 at 13:29 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc-mpe tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> 
> In file included from arch/powerpc/platforms/powernv/setup.c:36:0:
> arch/powerpc/include/asm/opal.h:214:17: error: 'enum OpalMessageType' declared inside parameter list [-Werror]
>           struct notifier_block *nb);
>                  ^
> 
> Caused by commit d7cf83fcaf1b ("powerpc/powernv: Move opal-api.h closer
> to the Skiboot version") interacting with commit b921e90260ce
> ("powerpc/powernv: Add OPAL message notifier unregister function") from
> the powerpc tree.
> 
> I have added the following merge fix patch:

Michael,  you can pull my next-misc branch and apply this fix to the
merge commit to avoid bisection breakage.

Cheers,
Ben.

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 26 Mar 2015 13:25:58 +1100
> Subject: [PATCH] powerpc/powernv: fix for OpalMessageType name change
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/asm/opal.h       | 2 +-
>  arch/powerpc/platforms/powernv/opal.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index d430ec7e60c6..c08de77f398a 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -210,7 +210,7 @@ extern int opal_notifier_unregister(struct notifier_block *nb);
>  
>  extern int opal_message_notifier_register(enum opal_msg_type msg_type,
>  						struct notifier_block *nb);
> -extern int opal_message_notifier_unregister(enum OpalMessageType msg_type,
> +extern int opal_message_notifier_unregister(enum opal_msg_type msg_type,
>  					    struct notifier_block *nb);
>  extern void opal_notifier_enable(void);
>  extern void opal_notifier_disable(void);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2c590e69a928..d403b2b08626 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -318,7 +318,7 @@ int opal_message_notifier_register(enum opal_msg_type msg_type,
>  				&opal_msg_notifier_head[msg_type], nb);
>  }
>  
> -int opal_message_notifier_unregister(enum OpalMessageType msg_type,
> +int opal_message_notifier_unregister(enum opal_msg_type msg_type,
>  				     struct notifier_block *nb)
>  {
>  	return atomic_notifier_chain_unregister(
> -- 
> 2.1.4
> 
