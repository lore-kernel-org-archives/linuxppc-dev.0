Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x22e.google.com (mail-oi0-x22e.google.com
 [IPv6:2607:f8b0:4003:c06::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C27911A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 20:35:48 +1000 (AEST)
Received: by oigm66 with SMTP id m66so75390280oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2015 03:35:46 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1441102876-26978-1-git-send-email-colin.king@canonical.com>
References: <1441102876-26978-1-git-send-email-colin.king@canonical.com>
Date: Tue, 1 Sep 2015 12:35:46 +0200
Message-ID: <CAMuHMdUm-eRpPmoNARdPVsi9=4Fqxp8crfgOXZkVTdAFhNzngQ@mail.gmail.com>
Subject: Re: [PATCH] ps3-vuart: BUG_ON on null drv before dereferencing it on
 dev_dbg
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Colin King <colin.king@canonical.com>
Cc: Geoff Levand <geoff@infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Colin,

On Tue, Sep 1, 2015 at 12:21 PM, Colin King <colin.king@canonical.com> wrote:
> On the unlikely event that drv is null, the current code will
> perform a null pointer dereference with it when printing a dev_dbg
> message.  Instead, the BUG_ON check on drv should be performed
> before we emit the dev_dbg message.

What about just removing the BUG_ON()?

The system will crash anyway, providing a backtrace.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/ps3/ps3-vuart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
> index d6db822..632701a 100644
> --- a/drivers/ps3/ps3-vuart.c
> +++ b/drivers/ps3/ps3-vuart.c
> @@ -1000,12 +1000,11 @@ static int ps3_vuart_probe(struct ps3_system_bus_device *dev)
>         dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
>
>         drv = ps3_system_bus_dev_to_vuart_drv(dev);
> +       BUG_ON(!drv);
>
>         dev_dbg(&dev->core, "%s:%d: (%s)\n", __func__, __LINE__,
>                 drv->core.core.name);
>
> -       BUG_ON(!drv);
> -
>         if (dev->port_number >= PORT_COUNT) {
>                 BUG();
>                 return -EINVAL;


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
