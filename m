Return-Path: <timur.tabi@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by ozlabs.org (Postfix) with ESMTP id E26D4DE801
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 01:47:54 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so2292255wra.1
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 08:47:53 -0700 (PDT)
Message-ID: <ed82fe3e0808060847r227c298ey82f2c3e1ead40863@mail.gmail.com>
Date: Wed, 6 Aug 2008 10:47:53 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Li Yang" <leoli@freescale.com>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
In-Reply-To: <1218007000-27320-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1218007000-27320-1-git-send-email-leoli@freescale.com>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb@vger.kernel.org, Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 2:16 AM, Li Yang <leoli@freescale.com> wrote:

> +/*---------------------------------------------------------------------
> + *             Mask definitions for usb BD                           *
> + *--------------------------------------------------------------------*/
> +#define QE_SIZEOF_BD       sizeof(struct qe_bd)
> +
> +#define BD_BUFFER_ARG(bd)                   (((struct qe_bd *)bd)->buf)
> +#define BD_BUFFER_CLEAR(bd)                 out_be32(&(BD_BUFFER_ARG(bd)), 0);
> +#define BD_BUFFER(bd)                       in_be32(&(BD_BUFFER_ARG(bd)))
> +#define BD_STATUS_AND_LENGTH_SET(bd, val)   out_be32((u32 *)bd, val)
> +#define BD_STATUS_AND_LENGTH(bd)            in_be32((u32 *)bd)
> +#define BD_BUFFER_SET(bd, buffer)           out_be32(&(BD_BUFFER_ARG(bd)), \
> +                                                       (u32)(buffer))

Delete all of these.  Don't use these silly macros at all.  Reference
the structure fields directly, and use the in_ and out_ functions
directly.

Using macros like these encourages unnecessary typecasts.  "struct
qe_bd" has been defined, so you should use it.

-- 
Timur Tabi
Linux kernel developer at Freescale
