Return-Path: <gerhard_pircher@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdgxD1krYzDqmH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 06:47:43 +1000 (AEST)
Subject: Re: [PATCH 29/38] powerpc: Move 32-bit probe() machine to later in
 the boot process
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-30-git-send-email-benh@kernel.crashing.org>
From: Gerhard Pircher <gerhard_pircher@gmx.net>
Message-ID: <32078f2a-4e8d-3ac4-f4f6-30563bf7e601@gmx.net>
Date: Mon, 27 Jun 2016 22:42:18 +0200
MIME-Version: 1.0
In-Reply-To: <1467026976-7974-30-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 2016-06-27 um 13:29 schrieb Benjamin Herrenschmidt:
> This converts all the 32-bit platforms to use the expanded device-tree
> which is a pretty mechanical change. Unlike 64-bit, the 32-bit kernel
> didn't rely on platform initializations to setup the MMU since it
> sets it up entirely before probe_machine() so the move has comparatively
> less consequences though it's a bigger patch.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[...]

> diff --git a/arch/powerpc/platforms/amigaone/setup.c b/arch/powerpc/platforms/amigaone/setup.c
> index 2fe1204..a030d3b 100644
> --- a/arch/powerpc/platforms/amigaone/setup.c
> +++ b/arch/powerpc/platforms/amigaone/setup.c
> @@ -143,9 +143,7 @@ void amigaone_restart(char *cmd)
>  
>  static int __init amigaone_probe(void)
>  {
> -	unsigned long root = of_get_flat_dt_root();
> -
> -	if (of_flat_dt_is_compatible(root, "eyetech,amigaone")) {
> +	if (of_machine_is_compatible("eyetech,amigaone")) {
>  		/*
>  		 * Coherent memory access cause complete system lockup! Thus
>  		 * disable this CPU feature, even if the CPU needs it.
This patch series reminds me of a long-standing issue with the
AmigaOne platform code, which would have to clear the coherence
(M) flag for every memory mapping to avoid lockups (especially
on G4 CPUs) - as you can read in the comment below your patch
above.

Now the follow-up code in amigaone/setup.c to clear the
corresponding CPU feature flag is essentially dead code (it used
to work with a second call of do_feature_fixups() before the
handling of the CPU_FTR_NEED_COHERENT flag was changed/inverted
somewhere around v2.6.30). Also it doesn't seem to fix all
deadlocks, as e.g. KVM virtual machines can still inject memory
mappings with the M flag set AFAICT.

Now I wonder, if there is a reasonably clean way to clear the M
flag in all hardware page table and BAT entries without defacing
generic kernel code too much. Any ideas?

BR,
Gerhard
