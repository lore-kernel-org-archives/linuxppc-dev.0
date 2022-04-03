Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6500C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Apr 2022 10:22:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KWVMz0mTVz3bfq
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Apr 2022 20:22:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rutRab4n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=jarkko@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rutRab4n; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KWVMB4KDWz2xD3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Apr 2022 20:21:58 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A3CD161003;
 Sun,  3 Apr 2022 10:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DECC340ED;
 Sun,  3 Apr 2022 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648981315;
 bh=va2wdSIDhigU9l6racetCvNOSAZt+vprXlIct+i0T0k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rutRab4n813Pxfl1QOm3oCQU5Xw0G5pZcmivt9D8npqu4IeZ4XLNRwF6dQRZdruRS
 dQsrnuWExDhYQBC0BY4fFx2WUvuUjn+/gNQyEufnl5Thr194LQyTDkIpvzdPXzVfe2
 Gv7YrSRhK2bJdYj8xSlipwAdkRUOFgih9P1B3sErpDmLLPVUZDBQ89UgGaDF3RV1RQ
 P772i3/NCOcdOFRMNPBpTmgXdzJeQfB0ykaj1GaNDLLhOlo5sNA9xIIMQJakuFFdAR
 fw6wsZpyDuioEbDdlPYXoUIcScjf+fI0xwqZYGjenu5uz91SR5iFuK/NlWI580+F20
 FUdDBek5lAsJw==
Date: Sun, 3 Apr 2022 13:23:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] char: tpm: Prepare cleanup of powerpc's asm/prom.h
Message-ID: <Ykl1ibvVxJUBrhfK@kernel.org>
References: <7a522d9029737d7a1fb513529659321ed62d50d9.1648895070.git.christophe.leroy@csgroup.eu>
 <cfd3a718e147b39620dfa7c779a7ae1af2f6b575.1648895074.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd3a718e147b39620dfa7c779a7ae1af2f6b575.1648895074.git.christophe.leroy@csgroup.eu>
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, linuxppc-dev@lists.ozlabs.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Apr 02, 2022 at 12:29:19PM +0200, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I don't understand this. It changes nothing as far as kernel is concerned.

> ---
>  drivers/char/tpm/tpm_atmel.h   | 2 --
>  drivers/char/tpm/tpm_ibmvtpm.c | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
> index ba37e77e8af3..959f7cce8301 100644
> --- a/drivers/char/tpm/tpm_atmel.h
> +++ b/drivers/char/tpm/tpm_atmel.h
> @@ -26,8 +26,6 @@ struct tpm_atmel_priv {
>  
>  #ifdef CONFIG_PPC64
>  
> -#include <asm/prom.h>
> -
>  #define atmel_getb(priv, offset) readb(priv->iobase + offset)
>  #define atmel_putb(val, priv, offset) writeb(val, priv->iobase + offset)
>  #define atmel_request_region request_mem_region
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 3af4c07a9342..1180cce7067a 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -20,7 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
>  #include <linux/wait.h>
> -#include <asm/prom.h>
>  
>  #include "tpm.h"
>  #include "tpm_ibmvtpm.h"
> -- 
> 2.35.1
> 

BR, Jarkko
