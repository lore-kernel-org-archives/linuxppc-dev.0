Return-Path: <dan.j.williams@gmail.com>
Received: from mail-pz0-f181.google.com (mail-pz0-f181.google.com
	[209.85.222.181]) by ozlabs.org (Postfix) with ESMTP id 23D8BB7D03
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Mar 2010 16:14:28 +1100 (EST)
Received: by pzk11 with SMTP id 11so1678020pzk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 21:14:27 -0800 (PST)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1267126777-21520-1-git-send-email-steve@digidescorp.com>
References: <1267126777-21520-1-git-send-email-steve@digidescorp.com>
Date: Sun, 28 Feb 2010 22:14:27 -0700
Message-ID: <e9c3a7c21002282114w3de2806eoe2ecc8e0f9207d00@mail.gmail.com>
Subject: Re: [async_tx-next PATCH v2 2/2] fsldma: Fix cookie issues
From: Dan Williams <dan.j.williams@intel.com>
To: "Steven J. Magnani" <steve@digidescorp.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Zhang Wei <zw@zh-kernel.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2010 at 12:39 PM, Steven J. Magnani
<steve@digidescorp.com> wrote:
> fsl_dma_update_completed_cookie() appears to calculate the last completed
> cookie incorrectly in the corner case where DMA on cookie 1 is in progres=
s
> just following a cookie wrap.
>
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
> ---
> diff -uprN a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> --- a/drivers/dma/fsldma.c =A0 =A0 =A02010-02-22 11:16:36.000000000 -0600
> +++ b/drivers/dma/fsldma.c =A0 =A0 =A02010-02-22 11:08:41.000000000 -0600
> @@ -819,8 +819,11 @@ static void fsl_dma_update_completed_coo
> =A0 =A0 =A0 =A0desc =3D to_fsl_desc(chan->ld_running.prev);
> =A0 =A0 =A0 =A0if (dma_is_idle(chan))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cookie =3D desc->async_tx.cookie;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cookie =3D desc->async_tx.cookie - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(cookie < DMA_MIN_COOKIE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cookie =3D DMA_MAX_COOKIE;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0chan->completed_cookie =3D cookie;
>
> diff -uprN a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> --- a/include/linux/dmaengine.h 2010-02-22 11:18:11.000000000 -0600
> +++ b/include/linux/dmaengine.h 2010-02-22 11:18:30.000000000 -0600
> @@ -31,6 +31,8 @@
> =A0* if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error co=
de
> =A0*/
> =A0typedef s32 dma_cookie_t;
> +#define DMA_MIN_COOKIE 1
> +#define DMA_MAX_COOKIE ((1 << 31) - 1)
>

This patch introduces a new warning::

drivers/dma/fsldma.c:825: warning: integer overflow in expression

I'll fix this up to use INT_MAX instead.

--
Dan

powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (Sourcery G++ Lite 4.2-50) 4.2.1
