Return-Path: <SRS0=jKXk=YO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C77CA9EB7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 08:41:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202F1214AE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 08:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202F1214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46xVTv6Wb1zDqXq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 19:41:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46xVQn6TJGzDqdx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2019 19:38:21 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id g13so10257397otp.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2019 01:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Isdqq0Ubh24QJiFJ2l26RYaK1W86JQo/S0O5rntTFZ0=;
 b=Ga6xHqrzIkUdw9sKzYM4oB2G5wXG+wMlibSP0fvZJCR690cxtPWZWK4MZf+dWhLTnO
 kG7Oye8WXu5GSHXpT6t5BQaS+qrbR9JB8JVGtqYkz0p/wx8HW+biICuhw2pLQpkNONrq
 izmpfLKWSr8CUdQxiNkMzxjpMGRq/udIJTzTgYoC5ixEq606Tu8FTJZx3w/bQzbTNdQG
 RIHTXas/056DnjbafLQliPQKZN/4QYXhXOKrzQAF+FAzLBu95zdUFNdblGY538Kvw/D3
 Hc8UBK3wRZ9fllA6fIr+tH74EtvGcEaZQdPpUFbLYbtMgwPts/vjm3hPJCRy/mrKPYHF
 B1UQ==
X-Gm-Message-State: APjAAAUgctfzw8IcV4XQ0A7J/qprPK7VmMOtk1nVoJGO5mLQN+lbNdeJ
 juBYLdTp8WrQSKRUBlodlWjEsEJBHG2NbaUwK4o=
X-Google-Smtp-Source: APXvYqzxJsJuV6BUauy4Sb2At789fmamDYr15BmrQGLKIW7qtsWxPoUU1OE8Ucyvvce+T2vjIx84kc60si7Pd9H8+Xs=
X-Received: by 2002:a05:6830:1e69:: with SMTP id
 m9mr17885485otr.262.1571647098420; 
 Mon, 21 Oct 2019 01:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191021034927.19300-1-ran.wang_1@nxp.com>
In-Reply-To: <20191021034927.19300-1-ran.wang_1@nxp.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2019 10:38:07 +0200
Message-ID: <CAJZ5v0hO5Jtr_kyBbCawYc+fS0JQGcU-xfhS9S7DKiFQYJSJvQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] PM: wakeup: Add routine to help fetch wakeup
 source object.
To: Ran Wang <ran.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Mark Rutland <mark.rutland@arm.com>, Li Biwen <biwen.li@nxp.com>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 21, 2019 at 5:49 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Some user might want to go through all registered wakeup sources
> and doing things accordingly. For example, SoC PM driver might need to
> do HW programming to prevent powering down specific IP which wakeup
> source depending on. So add this API to help walk through all registered
> wakeup source objects on that list and return them one by one.
>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> Change in v7:
>         - Remove define of member *dev in wake_irq to fix conflict with commit
>         c8377adfa781 ("PM / wakeup: Show wakeup sources stats in sysfs"), user
>         will use ws->dev->parent instead.
>         - Remove '#include <linux/of_device.h>' because it is not used.
>
> Change in v6:
>         - Add wakeup_source_get_star() and wakeup_source_get_stop() to aligned
>         with wakeup_sources_stats_seq_start/nex/stop.
>
> Change in v5:
>         - Update commit message, add decription of walk through all wakeup
>         source objects.
>         - Add SCU protection in function wakeup_source_get_next().
>         - Rename wakeup_source member 'attached_dev' to 'dev' and move it up
>         (before wakeirq).
>
> Change in v4:
>         - None.
>
> Change in v3:
>         - Adjust indentation of *attached_dev;.
>
> Change in v2:
>         - None.
>
>  drivers/base/power/wakeup.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_wakeup.h   |  3 +++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5817b51..dee1b09 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -248,6 +248,43 @@ void wakeup_source_unregister(struct wakeup_source *ws)
>  EXPORT_SYMBOL_GPL(wakeup_source_unregister);
>
>  /**
> + * wakeup_source_get_star - Begin a walk on wakeup source list

The "get" in the name suggests acquiring a reference of some kind
which doesn't happen here.

What about renaming it to wakeup_sources_walk_start()?

> + * @srcuidx: Lock index allocated for this caller.
> + */
> +struct wakeup_source *wakeup_source_get_start(int *srcuidx)

I don't quite like the calling convention here with passing an int
pointer to get the SRCU index back.

What about splitting this into, say, wakeup_sources_read_lock() (that
will return the SRCU index) and wakeup_sources_walk_start() (that will
return the first list entry)?

Then, you could do something like

idx = wakeup_sources_read_lock();

ws = wakeup_sources_walk_start();
while (ws) {

        stuff

        ws = wakeup_sources_walk_next();
}

wakeup_sources_read_unlock(idx);

Or even define for_each_wakeup_source(ws) as

    for (ws = wakeup_sources_walk_start(); ws; ws = wakeup_sources_walk_next())

and use that under a _read_lock()/_read_unlock() pair?
