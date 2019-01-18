Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC43C43444
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 10:11:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E3F20855
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 10:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E3F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gxYn55rDzDqxs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 21:11:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gxWz3qwszDqsK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 21:10:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43gxWz2b9rz8xKT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 21:10:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43gxWz2D06z9sBn; Fri, 18 Jan 2019 21:10:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43gxWy75Hzz9sBZ
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2019 21:10:06 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id a77so8547407oii.5
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2019 02:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jyo2oggzQ4O6LlrQQxoon7En8MnI9wJz+stelw/9DNQ=;
 b=VNB357P1J4t4fD77sCllS9z33wvUPzpbGGILNQMIuBDJwb9hFxVuz0+LNgeug1jTxU
 5fymZZ567fqodE2jdwI/bgMDtjqn3KP51K8OP1WE7mS9cdKOyUtvIch35aWtUP4Sf5ky
 X96FWzxUR2HCszPw/J8llhIU2SwQgy7jr2lyJQt7rEKRZiXM+P6y5fCF08CQMeRGRw3k
 OC54KAnzz5hdRAFBJzE34Z+ceTqAJSLLWLyCGK2V8UUbfOQ3QkY23MS5GoTJLQKkc4Cj
 eBPohNoq3ZelCkMZSGL0hToc+X213Z65ZqeeAuDzQL7tV+qWJOkTVhnd0dNBh/96yKKD
 lcVg==
X-Gm-Message-State: AJcUukeGa3wiWfaD9e0TaCQzx2aRg28SN7xAV9GaP7f30tEVbRPC+VGy
 PLXAxffo6i2ayB3FawZOJXfVFtMtWM7htzPsZkQ=
X-Google-Smtp-Source: ALg8bN6s6tOTx77tXkO9rmn8IK4zpDkOBowxGdgRaQLNHCxxvsh+xWVKw5dWqcqWcrlMZU9mtZqW7fB0mxGS/r+M3us=
X-Received: by 2002:aca:b05:: with SMTP id 5mr324916oil.258.1547806204506;
 Fri, 18 Jan 2019 02:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
 <8f112153558ae8ffdefba905d83329c8e896d3a9.camel@kernel.crashing.org>
 <20190117094214.26t72sdqknfzxvlx@atom2.tmux.org>
 <ae9672a789b29a546c12149650f0a7f6ab6b762d.camel@kernel.crashing.org>
 <20190118005124.oktx5nebsyy47zbg@atom2.tmux.org>
In-Reply-To: <20190118005124.oktx5nebsyy47zbg@atom2.tmux.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 18 Jan 2019 11:09:52 +0100
Message-ID: <CA+7wUsyj0EsaUOPWzjhUWty_bV7eqZtJwYLpdVs8AWSJ6mG56g@mail.gmail.com>
Subject: Re: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
To: Tobias Ulmer <tobiasu@tmux.org>
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
Cc: Rob Herring <robh@kernel.org>, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 18, 2019 at 1:53 AM Tobias Ulmer <tobiasu@tmux.org> wrote:
>
> On Fri, Jan 18, 2019 at 09:32:07AM +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2019-01-17 at 10:42 +0100, Tobias Ulmer wrote:
> > > On Wed, Jan 16, 2019 at 12:15:14PM +1100, Benjamin Herrenschmidt wrote:
> > > > On Tue, 2019-01-15 at 23:49 +0100, Tobias Ulmer wrote:
> > > > > Hi,
> > > > >
> > > > > both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.
> > > > >
> > > > > Surely I'm not the first to run into this, but I couldn't find any
> > > > > discussion or bug report. Sorry if you're already aware.
> > > > >
> > > > > You can see it hang here (5.0 rc2+, 4.20.2 is nearly identical) until
> > > > > the watchdog triggers a reboot:
> > > > >
> > > > > https://i.imgur.com/UiCVRuG.jpg
> > > > >
> ...
> > I'll be back on monday or tuesday, let me know where you got up to then
> > and I'll take it from there. Also email me your .config please.
>
>
> Hi,
>
> this was caused by 5c63e407aaabb0464236cfc6279a2d79aede7073
> (fbdev: Convert to using %pOFn instead of device_node.name)

See:

https://patchwork.kernel.org/patch/10750931/



> name can't be NULL into offb_init_fb, there's a printk and the call to
> offb_init_palette_hacks where name is matched against OF device names.
>
> With the partial revert below, both 5.0-rc2+ and 4.20 are happy.
>
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 31f769d67195..77c0a2f45b3b 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -419,13 +419,9 @@ static void __init offb_init_fb(const char *name,
>         var = &info->var;
>         info->par = par;
>
> -       if (name) {
> -               strcpy(fix->id, "OFfb ");
> -               strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
> -               fix->id[sizeof(fix->id) - 1] = '\0';
> -       } else
> -               snprintf(fix->id, sizeof(fix->id), "OFfb %pOFn", dp);
> -
> +       strcpy(fix->id, "OFfb ");
> +       strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
> +       fix->id[sizeof(fix->id) - 1] = '\0';
>
>         var->xres = var->xres_virtual = width;
>         var->yres = var->yres_virtual = height;
> @@ -648,7 +644,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
>                 /* kludge for valkyrie */
>                 if (strcmp(dp->name, "valkyrie") == 0)
>                         address += 0x1000;
> -               offb_init_fb(no_real_node ? "bootx" : NULL,
> +               offb_init_fb(no_real_node ? "bootx" : dp->name,
>                              width, height, depth, pitch, address,
>                              foreign_endian, no_real_node ? NULL : dp);
>         }
