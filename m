Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6846E1A023C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 11:53:03 +1100 (AEDT)
Message-ID: <1453769574.27129.14.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Saurabh Sengar <saurabh.truth@gmail.com>, qiang.zhao@freescale.com,
 christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 25 Jan 2016 18:52:54 -0600
In-Reply-To: <1453618446-6857-1-git-send-email-saurabh.truth@gmail.com>
References: <1453618446-6857-1-git-send-email-saurabh.truth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] QE: Use GFP_ATOMIC while spin_lock_irqsave is held
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-01-24 at 12:24 +0530, Saurabh Sengar wrote:
> cpm_muram_alloc_common is called twice and both the times
> spin_lock_irqsave is held.
> Using GFP_KERNEL can sleep in spin_lock_irqsave context and cause
> deadlock
> 
> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
> ---
> Let me know if there is any other way to fix it.
> Also, I would say this function should be static as it is not used in any
> other file
>  drivers/soc/fsl/qe/qe_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Yes, it should be static.  Do you plan to send a patch for that?

-Scott
