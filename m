Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhSlg30FPzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 22:35:26 +1000 (AEST)
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com
 [209.85.216.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB4CF21AC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 12:35:24 +0000 (UTC)
Received: by mail-qt0-f181.google.com with SMTP id x36so13988090qtx.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 05:35:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170807232919.30247-2-robh@kernel.org>
References: <20170807232919.30247-2-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Aug 2017 07:35:03 -0500
Message-ID: <CAL_JsqKXYubBHVhcJ9ist8d6gFOCthdgc_pwnMGxNR7ajuXPrg@mail.gmail.com>
Subject: Re: [PATCH v3] sound: aoa: Convert to using %pOF instead of full_name
To: Takashi Iwai <tiwai@suse.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 7, 2017 at 6:29 PM, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: alsa-devel@alsa-project.org
> ---
> v3: Split aoa to separate patch

Ping.

>
>  sound/aoa/codecs/tas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
> index 733b6365dad6..15c05755d270 100644
> --- a/sound/aoa/codecs/tas.c
> +++ b/sound/aoa/codecs/tas.c
> @@ -905,8 +905,8 @@ static int tas_i2c_probe(struct i2c_client *client,
>                 goto fail;
>         }
>         printk(KERN_DEBUG
> -              "snd-aoa-codec-tas: tas found, addr 0x%02x on %s\n",
> -              (unsigned int)client->addr, node->full_name);
> +              "snd-aoa-codec-tas: tas found, addr 0x%02x on %pOF\n",
> +              (unsigned int)client->addr, node);
>         return 0;
>   fail:
>         mutex_destroy(&tas->mtx);
> --
> 2.11.0
>
