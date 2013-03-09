Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F4112C034D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 18:29:17 +1100 (EST)
Message-ID: <1362814152.6977.32.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix dynamic relocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Sat, 09 Mar 2013 18:29:12 +1100
In-Reply-To: <1362790950-23065-1-git-send-email-agraf@suse.de>
References: <1362790950-23065-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-03-09 at 02:02 +0100, Alexander Graf wrote:
> Commit 5ac47f7a introduced dynamic relocation of code by manually
> relocating TOC entries. However, we need to access the TOC using
> the physical address that we have for it, not the virtual address
> that we can't even access yet.
> 
> Drop the offset from the TOC accessing pointer.
> 
> This fixes Linux 3.9 booting on OpenBIOS for me.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> ---
> 
> I've also encountered breakage on a G5 Mac, not sure if it's related.
> I'll have to test whether this is the culprit on that one too.

That might fix the mac too.. Anton's patch assumed OF ran in real mode
in which case the top bits of the address are ignored, meaning we could
use kernel virtual addresses but that isn't the case with Apple OF which
has MMU enabled and maps memory 1:1. I suppose OpenBIOS has the same
problem ? Or is this a 32-bit issue as well ?

> Ben, please make sure that this gets into 3.9.
> ---
>  arch/powerpc/kernel/prom_init.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 7f7fb7f..2bf7cc3 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2851,7 +2851,7 @@ static void reloc_toc(void)
>  		(__prom_init_toc_end - __prom_init_toc_start) / sizeof(long);
>  
>  	/* Need to add offset to get at __prom_init_toc_start */
> -	__reloc_toc(__prom_init_toc_start + offset, offset, nr_entries);
> +	__reloc_toc(__prom_init_toc_start, offset, nr_entries);
>  
>  	mb();
>  }
