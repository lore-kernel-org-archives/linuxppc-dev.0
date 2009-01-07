Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E960EDE79A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 14:36:27 +1100 (EST)
Subject: Re: [PATCH] powerpc/cell: fix the prototype of create_vma_map
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090107105822.221c4395.sfr@canb.auug.org.au>
References: <20090107105822.221c4395.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 14:34:59 +1100
Message-Id: <1231299299.14860.58.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 10:58 +1100, Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/oprofile/cell/pr_util.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Arnd, I'm not too sure about this one, what do you think ? Shouldn't the
objectid be a u64 and the callers be fixed instead ?

Cheers,
Ben.

> diff --git a/arch/powerpc/oprofile/cell/pr_util.h b/arch/powerpc/oprofile/cell/pr_util.h
> index 628009c..dfdbffa 100644
> --- a/arch/powerpc/oprofile/cell/pr_util.h
> +++ b/arch/powerpc/oprofile/cell/pr_util.h
> @@ -79,7 +79,7 @@ struct spu_buffer {
>   * the vma-to-fileoffset map.
>   */
>  struct vma_to_fileoffset_map *create_vma_map(const struct spu *spu,
> -					     u64 objectid);
> +					     unsigned long objectid);
>  unsigned int vma_map_lookup(struct vma_to_fileoffset_map *map,
>  			    unsigned int vma, const struct spu *aSpu,
>  			    int *grd_val);
> -- 
> 1.6.0.5
> 
