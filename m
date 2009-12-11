Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98F40B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 09:13:59 +1100 (EST)
Subject: Re: [RFC PATCH v2 4/4] powerpc: wii: allow ioremap within the
	memory hole
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1260297833-17625-5-git-send-email-albert_herranz@yahoo.es>
References: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
	<1260297833-17625-5-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 09:13:54 +1100
Message-ID: <1260569634.16132.376.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-08 at 19:43 +0100, Albert Herranz wrote:
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> ---
>  arch/powerpc/platforms/embedded6xx/wii.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
> index 5eaed86..0df8a91 100644
> --- a/arch/powerpc/platforms/embedded6xx/wii.c
> +++ b/arch/powerpc/platforms/embedded6xx/wii.c
> @@ -97,6 +97,9 @@ void __init wii_memory_fixups(void)
>  
>  	/* reserve the hole */
>  	lmb_reserve(wii_hole_start, wii_hole_size);
> +
> +	/* allow ioremapping the address space in the hole */
> +	__allow_ioremap_reserved = 1;
>  }
>  
>  unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
