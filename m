Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC33C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:47:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917CA21104
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL+0lGw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917CA21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433wqd3PMRzDqbs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 18:47:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SL+0lGw3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=zkqh=og=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SL+0lGw3"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433wkc4v4xzDqbX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 18:43:20 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1B1D20873;
 Tue, 27 Nov 2018 07:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543304598;
 bh=4tNTvtlXoc6ceRPUPI1lsKzKP69M+Yqx/pm4mlaT608=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SL+0lGw3vyPOms/UE5f5PQ6hlaGhg9kdpKGYx/0+vDiUd8WHOzkFhnqSvF89BhWFw
 bKEtDxdIyH2QgAJyowMMU4ORL28FCmI7x46U8Xomi7mcp83QfcfDETgfhf16dmqjm5
 kFylzGlX7lfC3NkZyrh6oJip6kraHyUKPqGD1EcQ=
Date: Tue, 27 Nov 2018 08:43:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] lkdtm: do not depend on CONFIG_BLOCK
Message-ID: <20181127074316.GC13965@kroah.com>
References: <ca27a073c872e243be1d17a89afb4b4aeb9a298b.1541714054.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca27a073c872e243be1d17a89afb4b4aeb9a298b.1541714054.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 09, 2018 at 07:05:51AM +0000, Christophe Leroy wrote:
> Most parts of lkdtm don't require CONFIG_BLOCK.
> 
> This patch limits dependency to CONFIG_BLOCK in order to give embedded
> platforms which don't select CONFIG_BLOCK the opportunity to use LKDTM.
> 
> Fixes: fddd9cf82c9f ("make LKDTM depend on BLOCK")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/misc/lkdtm/core.c | 7 ++++++-
>  lib/Kconfig.debug         | 1 -
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 2837dc77478e..bc76756b7eda 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -40,9 +40,12 @@
>  #include <linux/interrupt.h>
>  #include <linux/hrtimer.h>
>  #include <linux/slab.h>
> -#include <scsi/scsi_cmnd.h>
>  #include <linux/debugfs.h>
>  
> +#ifdef CONFIG_BLOCK
> +#include <scsi/scsi_cmnd.h>
> +#endif

Why would this config option be needed to be checked just to be able to
include a .h file?

And shouldn't you be depending on SCSI instead?

> +
>  #ifdef CONFIG_IDE
>  #include <linux/ide.h>
>  #endif
> @@ -101,7 +104,9 @@ static struct crashpoint crashpoints[] = {
>  	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
>  	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
>  	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
> +# ifdef CONFIG_BLOCK
>  	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_dispatch_cmd"),
> +# endif

Again, scsi?

thanks,

greg k-h
