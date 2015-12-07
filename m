Return-Path: <ddstreet@gmail.com>
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A33CE1A05EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 06:35:08 +1100 (AEDT)
Received: by iofh3 with SMTP id h3so809750iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Dec 2015 11:35:06 -0800 (PST)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <1449388004.2096.12.camel@hbabu-laptop>
References: <1449388004.2096.12.camel@hbabu-laptop>
From: Dan Streetman <ddstreet@ieee.org>
Date: Mon, 7 Dec 2015 14:34:26 -0500
Message-ID: <CALZtONCw9+wvSQ+vwsvSWa_itR-G9ZBkuXftzNHV9oTd8YZFaw@mail.gmail.com>
Subject: Re: crypto/nx842: Ignore queue overflow informative error
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Michael Ellerman <mpe@ellerman.id.au>, pair@us.ibm.com,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Haren Myneni <hbabu@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 6, 2015 at 2:46 AM, Haren Myneni <haren@linux.vnet.ibm.com> wrote:
>
> NX842 coprocessor sets bit 3 if queue is overflow. It is just for
> information to the user. So the driver prints this informative message
> and ignores it.
>
> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>
> diff --git a/arch/powerpc/include/asm/icswx.h b/arch/powerpc/include/asm/icswx.h
> index 9f8402b..d1a2a2d 100644
> --- a/arch/powerpc/include/asm/icswx.h
> +++ b/arch/powerpc/include/asm/icswx.h
> @@ -164,6 +164,7 @@ struct coprocessor_request_block {
>  #define ICSWX_INITIATED                (0x8)
>  #define ICSWX_BUSY             (0x4)
>  #define ICSWX_REJECTED         (0x2)
> +#define ICSWX_BIT3             (0x1)   /* undefined or set from XERSO. */

Since this isn't defined by the icswx rfc workbook, it probably
shouldn't go here, it would make more sense to put it into nx-842.h
and call it something like "ICSWX_NX_QUEUE_OVERFLOW" or similar
NX-specific meaningful name.

>
>  static inline int icswx(__be32 ccw, struct coprocessor_request_block *crb)
>  {
> diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
> index 9ef51fa..321b8e8 100644
> --- a/drivers/crypto/nx/nx-842-powernv.c
> +++ b/drivers/crypto/nx/nx-842-powernv.c
> @@ -442,6 +442,15 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
>                              (unsigned int)ccw,
>                              (unsigned int)be32_to_cpu(crb->ccw));
>
> +       /*
> +        * NX842 coprocessor uses 3rd bit to report queue overflow which is
> +        * not an error, just for information to user. So, ignore this bit.
> +        */

a meaningfully named bit define means you don't need to explain it
with a comment :-)

However, I suggest that you do explain *why* a queue overflow isn't an
error - either here or (probably better) at the #define of the bit -
because that isn't obvious.

> +       if (ret & ICSWX_BIT3) {
> +               pr_info_ratelimited("842 coprocessor queue overflow\n");

if it's not an error, should this be pr_debug_ratelimited instead?
What is an end user expected to do if they see this msg in the log?

> +               ret &= ~ICSWX_BIT3;
> +       }
> +
>         switch (ret) {
>         case ICSWX_INITIATED:
>                 ret = wait_for_csb(wmem, csb);
>
>
