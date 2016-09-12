Return-Path: <bp@alien8.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXljN2nGWzDsMk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 21:20:40 +1000 (AEST)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by ozlabs.org (Postfix) with ESMTP id 3sXljM666Bz9sC4
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Sep 2016 21:20:39 +1000 (AEST)
Date: Mon, 12 Sep 2016 13:20:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: dougthompson@xmission.com, mchehab@kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@ozlabs.org, arnd@arndb.de
Subject: Re: [PATCH v2] drivers/edac: NO_IRQ removal from powerpc-only drivers
Message-ID: <20160912112035.2xwcjnrqsvtcmrz5@pd.tnic>
References: <1473674436-19467-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1473674436-19467-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 12, 2016 at 08:00:36PM +1000, Michael Ellerman wrote:
> We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
> from powerpc-only drivers.
> 
> The pdata structs are kzalloc'ed, so we don't need to initialise those
> to 0, we can just drop the assignments entirely.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v2: Don't initialise pdata fields to 0, the entire struct is kzalloc'ed.
> 
> mpc85xx_edac.c is not shared with arm64. It is built together with
> fsl_ddr_edac.c on powerpc to form mpc85xx_edac. On arm64 fsl_ddr_edac.c is
> built with layerscape_edac.c to form layerscape_edac. So changing
> mpc85xx_edac.c has no dependency on arm64 changes.
> 
> 
>  drivers/edac/mpc85xx_edac.c | 2 --
>  drivers/edac/mv64x60_edac.c | 4 ----
>  drivers/edac/ppc4xx_edac.c  | 4 +---
>  3 files changed, 1 insertion(+), 9 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
