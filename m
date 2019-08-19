Return-Path: <SRS0=1Kal=WP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3815C3A59B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 08:22:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBEE2082C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 08:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBEE2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Bn3p5q5dzDr41
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 18:22:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Bn196srJzDqn4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2019 18:20:26 +1000 (AEST)
Received: by mail-ot1-f68.google.com with SMTP id r20so903563ota.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2019 01:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xS8pnTXr+3PwEje+y6dB7oMHpWB4o5rNXOdh/Rkk++Q=;
 b=Lx7WyqjcPFWZc7sopnomZQqmnu1jgRJkPEJJxAS+rnWDYGcztNdYEqndu7VMTz3nZJ
 O9wfDPEr4ag61ixkY7Zj1M17vDh3IVjpyJ1elwTmboR7zbWcB3N1882rOc6BG24ueJLy
 5ayoXJdM/E+eG3HduCa9i+QFYE7Q1G2S5TsYWyuyOfedqBbNnH6ZyIQ3XQwWKKPGUK+1
 1iRm/g8HhSLlMQKoXKwyBhOb39XJpcZ5cvdgHNEgk0yVD6IjdCNljxmuVFvoQYlH4+nR
 PM7wg/vSKJw1CyZos8Jep/2dsrg0gO6p1u4PTq8aG0q2BICDmFlzt09Xqz/Yc2G2yxJ3
 21ng==
X-Gm-Message-State: APjAAAWL6+owKxTbvXYBmNK2m4/PO/TUIdJvMAR2quKt2YEVNYkRq5oI
 p+BcjTeFEY3MxGACAfVua12519xDHgNlXll5m3I=
X-Google-Smtp-Source: APXvYqzWpuiaz71ScmIyZbNRmxlq1ByZY1iRfxME8FhAce0Jv5HInimy281JwzZBnuDa9m2zO5ABaIRP6MB3pyYh/eI=
X-Received: by 2002:a9d:674c:: with SMTP id w12mr13640118otm.118.1566202822686; 
 Mon, 19 Aug 2019 01:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190724074722.12270-1-ran.wang_1@nxp.com>
 <4158639.B12JYek7R7@kreacher>
 <DB8PR04MB682632A586827032F8D6EA2DF1A80@DB8PR04MB6826.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB682632A586827032F8D6EA2DF1A80@DB8PR04MB6826.eurprd04.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2019 10:20:11 +0200
Message-ID: <CAJZ5v0i58p-GsswzMGEsgD5OXDqJ_G5zXDYf8jq8JJbWxZv+nQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] PM: wakeup: Add routine to help fetch wakeup
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
Cc: Mark Rutland <mark.rutland@arm.com>, Biwen Li <biwen.li@nxp.com>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 19, 2019 at 10:15 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Rafael,
>
> On Monday, August 05, 2019 17:59, Rafael J. Wysocki wrote:
> >
> > On Wednesday, July 24, 2019 9:47:20 AM CEST Ran Wang wrote:
> > > Some user might want to go through all registered wakeup sources and
> > > doing things accordingly. For example, SoC PM driver might need to do
> > > HW programming to prevent powering down specific IP which wakeup
> > > source depending on. So add this API to help walk through all
> > > registered wakeup source objects on that list and return them one by one.
> > >
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > > Change in v5:
> > >     - Update commit message, add decription of walk through all wakeup
> > >     source objects.
> > >     - Add SCU protection in function wakeup_source_get_next().
> > >     - Rename wakeup_source member 'attached_dev' to 'dev' and move it
> > up
> > >     (before wakeirq).
> > >
> > > Change in v4:
> > >     - None.
> > >
> > > Change in v3:
> > >     - Adjust indentation of *attached_dev;.
> > >
> > > Change in v2:
> > >     - None.
> > >
> > >  drivers/base/power/wakeup.c | 24 ++++++++++++++++++++++++
> > >  include/linux/pm_wakeup.h   |  3 +++
> > >  2 files changed, 27 insertions(+)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > index ee31d4f..2fba891 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/suspend.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/debugfs.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/pm_wakeirq.h>
> > >  #include <trace/events/power.h>
> > >
> > > @@ -226,6 +227,28 @@ void wakeup_source_unregister(struct
> > wakeup_source *ws)
> > >     }
> > >  }
> > >  EXPORT_SYMBOL_GPL(wakeup_source_unregister);
> > > +/**
> > > + * wakeup_source_get_next - Get next wakeup source from the list
> > > + * @ws: Previous wakeup source object, null means caller want first one.
> > > + */
> > > +struct wakeup_source *wakeup_source_get_next(struct wakeup_source
> > > +*ws) {
> > > +   struct list_head *ws_head = &wakeup_sources;
> > > +   struct wakeup_source *next_ws = NULL;
> > > +   int idx;
> > > +
> > > +   idx = srcu_read_lock(&wakeup_srcu);
> > > +   if (ws)
> > > +           next_ws = list_next_or_null_rcu(ws_head, &ws->entry,
> > > +                           struct wakeup_source, entry);
> > > +   else
> > > +           next_ws = list_entry_rcu(ws_head->next,
> > > +                           struct wakeup_source, entry);
> > > +   srcu_read_unlock(&wakeup_srcu, idx);
> > > +
> >
> > This is incorrect.
> >
> > The SRCU cannot be unlocked until the caller of this is done with the object
> > returned by it, or that object can be freed while it is still being accessed.
>
> Thanks for the comment. Looks like I was not fully understanding your point on
> v4 discussion. So I will implement 3 APIs by referring wakeup_sources_stats_seq_start/next/stop()
>
> > Besides, this patch conflicts with some general wakeup sources changes in the
> > works, so it needs to be deferred and rebased on top of those changes.
>
> Could you please tell me which is the right code base I should developing on?
> I just tried applying v5 patch on latest git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git branch master (d1abaeb Linux 5.3-rc5)
> and no conflict encountered.

It is better to use the most recent -rc from Linus (5.3-rc5 as of
today) as the base unless your patches depend on some changes that are
not in there.
