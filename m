Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 108E41A02F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 09:44:11 +1000 (EST)
Date: Thu, 19 Jun 2014 09:44:04 +1000
From: Anton Blanchard <anton@samba.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, rusty@rustcorp.com.au
Subject: Re: [PATCH] powerpc: module: fix TOC symbol CRC
Message-ID: <20140619094404.18e7047b@kryten>
In-Reply-To: <20140617155658.30560.578.stgit@nimbus>
References: <20140617155658.30560.578.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Laurent,

> The commit 71ec7c55ed91 introduced the magic symbol ".TOC." for ELFv2
> ABI. This symbol is built manually and has no CRC value computed. A
> zero value is put in the CRC section to avoid modpost complaining
> about a missing CRC. Unfortunately, this breaks the kernel module
> loading when the kernel is relocated (kdump case for instance)
> because of the relocation applied to the kcrctab values.
> 
> This patch compute a CRC value for the TOC symbol which will match
> the one compute by the kernel when it is relocated - aka '0 -
> relocate_start' done in maybe_relocated called by check_version
> (module.c).

Adding Rusty since he maintains the module loader code.

Anton

> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Cc: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/kernel/module_64.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/module_64.c
> b/arch/powerpc/kernel/module_64.c index 077d2ce..a80c933 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -315,8 +315,15 @@ static void dedotify_versions(struct
> modversion_info *vers, struct modversion_info *end;
>  
>  	for (end = (void *)vers + size; vers < end; vers++)
> -		if (vers->name[0] == '.')
> +		if (vers->name[0] == '.') {
>  			memmove(vers->name, vers->name+1, strlen(vers->name));
> +			/* The TOC symbol has no CRC computed. To avoid CRC
> +			 * check failing, we must force it to the expected
> +			 * value (see CRC check in module.c).
> +			 */
> +			if (!strcmp(vers->name, "TOC."))
> +				vers->crc = -(unsigned long)reloc_start;
> +		}
>  }
>  
>  /* Undefined symbols which refer to .funcname, hack to funcname
> (or .TOC.) */
