Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B9606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ssTokEbi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD5N55Yv5z2yKn;
	Tue, 27 Oct 2026 07:49:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e36" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793047781;
	cv=pass; b=dIM3PLfLlkgKhnN+04oAX1VvpXFFkZDbWEsCdFBMXVM7vtloPP8QsmHfzOkFHKeqihbI0vn1rhE5BeTOnGQkF2iHFG8B+ztPQ4zK/NlkpeosUKRUWlH2dLZR6WczcbuqYsX4ZvsvQ8fAojCNh5zKM3Ma0iDpP1NPW/APqksZUyFsJuKUS7Vg3YJCJzhUDgb+IKIHyi7JTtdTXfEJiHRrhpqy9R/2Gg97HHl71cePtGBzkVNmZrIKloSq+YhQowEZm1WsVRgFr4PikZMizBCm7GqAqXGIlr1sauegFjyaVJpP6Ee2SLXw2/HK7sF6buv1s1g06X/GoKgK/C1+Hjgmog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793047781; c=relaxed/relaxed;
	bh=eEKPapKQIiWh5bUIcb5N/LuB8yx8USeXRcJ+z78vdxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNPEtTuWkG8wpUF2WjXp/97D2rRAx38SFQ5JasEi18NhuT+6lxI8cY4RzVEK1qeRYvYMLe1LAAUKDU0FeCKD7GidCtZIFke7U3IksI7Un0cb+3GT6vwX+3wIZTtAmMQnnyDoLaaZhfrQGSWAubhubU13t9KfpWsnQS8UZ927Q/+hamGoi/kucR/Z65UE7DL+kd55FPqhEi2lR7r3kodmTQghGDw6jkPxaz5MSmZ7B52XPBNazqLMIaI6T1oib4oxqn7c+XSMCnDHKv4SwR8DhMXfsDLDJvd1XLcbP97Ze43vDzlGBcgHD40pllk7q2Elg4yXJrHIUPx9UYBmv3Z1OQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ssTokEbi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ssTokEbi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD5N43hvlz2xlp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 07:49:39 +1100 (AEDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-7cccb2c96d0so666458137.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 13:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793047776; cv=none;
        d=google.com; s=arc-20260327;
        b=CKJACiRuTNrmH++qYvUe+1XqV6Zbrs+SV4UyuUAz3KkVzsho8LEUHctdnmx/FllZY6
         W8xP9cRAC/lVFXHzYaB/kNDqCiWdotrV7tyVHfsamPCq6qLQ43E0SZLaQaGBCTGyPsfK
         4qnyptTTsO1GI8k7CIMtcYKmWerDP5cxr6sEA4a6yaWkn1+Cf02pudmJoawF7S6EzQoC
         SR1Ls4W75pD1ywEYtfS3xxJhiEipsz7gIxl+gWDm162POIKqzPIpFXa6KOI4VQVJaS9c
         Ws9bx6Xzpa1WrLKsQDhcJyyWdtaKLdWO1q9VGtVHiMefylL+CBnwAnQZBQ0OzS0onfBL
         hjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eEKPapKQIiWh5bUIcb5N/LuB8yx8USeXRcJ+z78vdxU=;
        fh=KUlOozoHgnF4phxrNLW9yfKt4ge7pet5QEusxpN2Sug=;
        b=aMWqm4le4cOyqsLgir0UCOJclSgnhms8sEnn8Dh9j2U2KXKi6t1RFFoXcnuIHM1DXd
         oidbToUd1LFoFFQOpeZOVqEhNXNZ4sSx7rNPn5Fv2KvXkLtggogRzZXVMYhZvJuLJeFH
         b1Y+kP5BHQYiZrSj9REL9AXfBnM137SOn/EFS0TmFGqGs6J8QojiAK3wOmj2LYfodQ/X
         1IhndZ08UHksXgID49hQON4HYqGEiFjXBMM+vq4C9mtzhQSmdVZfXEh3QxqtrIOvbxQN
         SxebYaC4lKcpTR9vSb59PWuaqgpcBPAsOB7lc/uABqYyJP/0Nx7oHKUz0sKqQfWHBg9s
         XsEg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793047776; x=1793652576; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eEKPapKQIiWh5bUIcb5N/LuB8yx8USeXRcJ+z78vdxU=;
        b=ssTokEbi5P6/x1EuWrCdslSd7wRPGHo6RAn14r/+nQnhxEc1FZH88z8E4XxeCy9090
         w+L3eB/8D+/ja6H71pleBBly3XWUYc3rbgUkL9DJCEK8/eQ/bryv20cx/SomSiLCd1K4
         WFdagvAljZFKpb5DCWP6PwKd+pD7FznlPWDseoRMnnWtKmPXtyjRWZNUmTOLxZfwBkZO
         GomeW/c7P6GlkA2RvnR21pAd72ArryB9tL/Ec/rysq4pOA/lHiJJatBMkP7oIfao/MAf
         IcCWJFBQ7fGw+JkF+06zZJ3HafCqbIVghwpNV6JwBErtauv6jabQUykJE5T3e1vMi6vG
         G99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793047776; x=1793652576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEKPapKQIiWh5bUIcb5N/LuB8yx8USeXRcJ+z78vdxU=;
        b=mXfs2DbMGIOlfXzHTQT9WQ/yXgisydnqC9wrTWDnsXAzJSAalZNH7efCgPidEzXrxU
         zbYHeUXX0WQ3vAcX2RMv2UovAhqRJ9nMXXWYEGyEPGgChE2+FkS4s9zokU65RoBZsGtJ
         iL+C8ufPdAfXgUIVzRX2GisQjvmLUUrrIkyzeDMElqe1k03HL2G7Wp3ePabmauybjO4+
         yMtLluQiwiXQopUd8317H5c1w1ocsk+Xn+slhiWGpywxiQAYNbmbwzK+guS2dJ/Kkxh9
         ubkD9c7U5TzCQMRcfduFXtFtc+ztEEq/lHvyQghQolQ8SrzhWbnIANaRrIrdrCBs1CcD
         g4PQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1wps9BarlrpcIIcnVngdlpljO6JiFMPCGnKWySJQnblaOLWP222cXUQ9NmJlOfk2S3N2S/r4JLc7qEYQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJXeY2BCy+pWib5TNWekmniMt4MpmWA1Cy/UvJfWGOCMoi/yrB8
	2LnL7gTp4Nb2PyiGnOgIZ1CtBCAp7N+S4P+t4R/+joRsRFyAIOvfDLONZoe+oNarmZnz3bkuUwo
	dFexmZxK3CqW0LF0ETTgjIqCxujjwKIM=
X-Gm-Gg: AYBFou2ou66wFOgXuAM8zXbbfu+RzaNCRR8rO19nd0Etv/KgoGvJveB/KZ1svl87Wd7
	FjPqyZdrlNL9TxHGOYivh5Q25BRwskpaZeOeXzSP24FwIfC63sHDPah1PpY+18jsF9C7gpNU2pQ
	jERrNsR3NXklok3LxP5Hz0jm+RTz73b5FDgetscY0AWg2Gz/Touk8MM6iztl0dgqVymsrnc3zCS
	tB+hmlUc+hW8aGvrTulZxUaHTbjizYPmxX/UfGTC/LFE5S0ZF9AaEpJBFwt+4GEEAGcoYQBFXJH
	TR4Y3Xs0AOpyseZUIV7akiE/M7p4m9VvuD0vy9B0DOWZtKT8SoMO/qe48ep4VmvvZUAcREXG7ht
	0UQvuJEKPLA2L1EskwB4UXWy4LsQDieClUoSfensyXxcYEfEZAwHwbITyKUzpxr43l4iS9A7UAh
	eabBbBni0u5ZtDOLNQCoDJ8T83hn0M8+HqB8+pZtQV0PzfqAR2QI7QHm2w8jDJP/HZWElP4sVKe
	mQkPWPzHsD6yfIHqz2v2FgqLcR1NgkR8jonCpf7smtE8NlCj30=
X-Received: by 2002:a67:e114:0:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7ce5ccdca48mr2010224137.10.1793047776347; Mon, 26 Oct 2026
 13:49:36 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <at4bw-G8czG-G7Wl@ashevche-desk.local> <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local> <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local> <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
 <at-vyZ1sDhYPu0W5@ashevche-desk.local> <CADvTj4o_CENc3i92OQEZudOErSKPUptT4t2CCqDaGbseuK0QcQ@mail.gmail.com>
 <2026102631-stove-preview-b534@gregkh> <CADvTj4pCnnzx4B28H_1BuY4gm2fh_8HYL9jLpsAoJcWfiUXOHw@mail.gmail.com>
 <2026102657-tubby-tragedy-5f1b@gregkh>
In-Reply-To: <2026102657-tubby-tragedy-5f1b@gregkh>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 14:49:24 -0600
X-Gm-Features: AclHuK9UNYlzFhcHxdKzFFVeehL7ZLxndmHwf2zdIRC7OGdlKpLpZQpwjo4GLVA
Message-ID: <CADvTj4oFBznFO9ZxL_8wZtcPaweSSt-a_brVkmQKzqJsBX2P5w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 2:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 26, 2026 at 02:24:58PM -0600, James Hilliard wrote:
> > On Mon, Oct 26, 2026 at 2:17=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Oct 26, 2026 at 01:59:06PM -0600, James Hilliard wrote:
> > > > On Mon, Oct 26, 2026 at 1:53=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> > > > > > On Mon, Oct 26, 2026 at 3:33=E2=80=AFAM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrot=
e:
> > > > > > > > On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
> > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard =
wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > Some people might want to test the stuff. And sending too=
 often you actually
> > > > > > > > > will get the opposite results, people will be tired to ev=
en start reviewing
> > > > > > > > > and/or testing your code as it's changed way too quickly.
> > > > > > > >
> > > > > > > > My thought process was that people wouldn't want to be test=
ing code that
> > > > > > > > had known bugs flagged in Sashiko reviews.
> > > > > > >
> > > > > > > Sashiko reviews are not visible in my or any other mailbox. T=
o see them I have
> > > > > > > to go to some URL and so on, meaning to waste time to see why=
 on the earth the
> > > > > > > new version has been sent.
> > > > > >
> > > > > > Maybe the Sashiko reviews are getting caught in spam filtering =
or something?
> > > > > > They are showing up for me and on the mailing list[0] so I'm a =
bit confused why
> > > > > > you aren't seeing them. You shouldn't have to go to the web int=
erface[1] to look
> > > > > > up the reviews.
> > > > > >
> > > > > > [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.or=
g/
> > > > > >
> > > > > > [1] https://sashiko.dev/
> > > > > >
> > > > > > > It's better before addressing Sashiko comments,
> > > > > > > reply to all people involved and to Sashiko's original email,=
 so it will be
> > > > > > > visible in the previous version why you issued (actually abou=
t to issue) the
> > > > > > > next version.
> > > > > >
> > > > > > Hmm, maybe it makes sense to enable recipients in the reply_to =
config[2]?
> > > > >
> > > > > It's up to the list owners / subsystem maintainers.
> > > > >
> > > > > > [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/project=
s/linux/mailing_lists.toml#L290
> > > > > >
> > > > > > > And before even issuing it, wait for a while, people might
> > > > > > > disagree with Sashiko judgement or your replies on how to add=
ress that.
> > > > > >
> > > > > > I was assuming everyone was seeing the Sashiko reviews getting =
posted to
> > > > > > the mailing list already. The are ending up in lore so unless s=
omeone isn't
> > > > > > subscribed to the list I'm not sure why they wouldn't be seeing=
 those reviews
> > > > > > already.
> > > > >
> > > > > I assume you already answered your Q. mailing list in this sense =
doesn't mean
> > > > > recipients. I think it simply goes to the mailing list without fo=
rwarding.
> > > >
> > > > Do we want those reviews going to recipients as well as the mailing=
 list?
> > >
> > > For serial patches, we decided to only have it go to the submitter an=
d
> > > the list.
> >
> > When it goes to the list is it supposed to go to list subscribers as
> > well or only to lore?
>
> All list subscribers as well, I've watched your interactions just fine
> :)

Andy, are you subscribed to the linux-serial list?

I'm wondering if some mail is getting dropped, in this particular thread I =
never
actually received the review from Maciej W. Rozycki <macro@orcam.me.uk> at
all and had to manually import the email from lore. I think that's the
only review
email that I saw go missing myself.

That one getting dropped seems especially strange since it had a
direct reply to me.

>
> thanks,
>
> greg k-h

