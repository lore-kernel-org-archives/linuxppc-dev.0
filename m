Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [72.1.168.231])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "usmamail.tilera.com",
	Issuer "Go Daddy Secure Certification Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17462B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 23:18:43 +1000 (EST)
Message-ID: <4C8E2355.60807@tilera.com>
Date: Mon, 13 Sep 2010 09:12:53 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Vasiliy Kulikov <segooon@gmail.com>
Subject: Re: [PATCH] char: hvc: check for error case
References: <1284317835-5086-1-git-send-email-segooon@gmail.com>
In-Reply-To: <1284317835-5086-1-git-send-email-segooon@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 On 9/12/2010 2:57 PM, Vasiliy Kulikov wrote:
> hvc_alloc() may fail, if so exit from init() with error.
>
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>

Thanks, accepted into my tree (for the next merge window).  In practice all
this means is in debug mode we'll get a warning from do_one_initcall()
rather than silence, but you're right, it's technically better. :-)

> ---
>  I cannot compile this driver at all, so it is not tested.
>
>  drivers/char/hvc_tile.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/hvc_tile.c b/drivers/char/hvc_tile.c
> index c4efb55..7a84a05 100644
> --- a/drivers/char/hvc_tile.c
> +++ b/drivers/char/hvc_tile.c
> @@ -61,7 +61,8 @@ console_initcall(hvc_tile_console_init);
>  
>  static int __init hvc_tile_init(void)
>  {
> -	hvc_alloc(0, 0, &hvc_tile_get_put_ops, 128);
> -	return 0;
> +	struct hvc_struct *s;
> +	s = hvc_alloc(0, 0, &hvc_tile_get_put_ops, 128);
> +	return IS_ERR(s) ? PTR_ERR(s) : 0;
>  }
>  device_initcall(hvc_tile_init);

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
