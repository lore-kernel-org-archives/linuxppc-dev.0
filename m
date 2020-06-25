Return-Path: <SRS0=tFHQ=AG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBC9C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 11:46:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DEF20706
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DEF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49sysF3c2vzDqsR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 21:46:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.195;
 helo=mail-oi1-f195.google.com; envelope-from=rjwysocki@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49syqN6CxnzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 21:44:47 +1000 (AEST)
Received: by mail-oi1-f195.google.com with SMTP id j11so2001881oiw.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 04:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fhbzaom2oYWTb3uPp4imDnoJSzGngQDDOGjO9gwcXTY=;
 b=HUjxnrpnP7/vekU3kxWszQegEh2IDkmMVnCANsESrd1RNohCLrayQuBJo6HgD/J8oX
 FdAZvzbYjqcgOHBFim9h1ZPDgfR2MayBesH3bcZDAxD1t8XiCz4WMcFT6DM6GlVxmWDV
 eWKlUjALkxsGH8iHOKpKQcM+mgo5afXNUHrL+MSAuUuX3IEA+r0SpPlLa+CD5SbvF47l
 uYbA04ShXqJ7KOOI3EDBHmjXvEVMeCJmZcpQlHLSQSQgczdCs8ZiJlGmJO5KoLrmAlf4
 FWYwtDj3BLackY8aENCcG6CCxu+Ire83JHDTLF5Fkjo2Ve7P7uKtKC79fowlomGqs96P
 NAOA==
X-Gm-Message-State: AOAM532mQv49DUkfvNJVIuSO/Yddf4EQ+mZLLCFGHSq9a9LLpDPPOY+M
 oo/78grrbVUZ6Pmd978h3rrr7bM8CgoUyLOxp4I=
X-Google-Smtp-Source: ABdhPJxcGZrXWWyZIuQWJhk3RrxSQPVylSRGu51cIIXGopaqDSitWSeU603zryF35zthebkIoYQ1rZCgrLiOq60oduA=
X-Received: by 2002:a54:4585:: with SMTP id z5mr1861850oib.110.1593085485302; 
 Thu, 25 Jun 2020 04:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
In-Reply-To: <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jun 2020 13:44:34 +0200
Message-ID: <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
To: Viresh Kumar <viresh.kumar@linaro.org>
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
Cc: Juri Lelli <juri.lelli@redhat.com>,
 "Cc: Android Kernel" <kernel-team@android.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Linux PM <linux-pm@vger.kernel.org>, Quentin Perret <qperret@google.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, adharmap@codeaurora.org,
 Todd Kjos <tkjos@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 25, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> After your last email (reply to my patch), I noticed a change which
> isn't required. :)
>
> On 23-06-20, 15:21, Quentin Perret wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0128de3603df..4b1a5c0173cf 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -50,6 +50,9 @@ static LIST_HEAD(cpufreq_governor_list);
> >  #define for_each_governor(__governor)                                \
> >       list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
> >
> > +static char cpufreq_param_governor[CPUFREQ_NAME_LEN];
> > +static struct cpufreq_governor *default_governor;
> > +
> >  /**
> >   * The "cpufreq driver" - the arch- or hardware-dependent low
> >   * level driver of CPUFreq support, and its spinlock. This lock
> > @@ -1055,7 +1058,6 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
> >
> >  static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  {
> > -     struct cpufreq_governor *def_gov = cpufreq_default_governor();
> >       struct cpufreq_governor *gov = NULL;
> >       unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> >
> > @@ -1065,8 +1067,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >               if (gov) {
> >                       pr_debug("Restoring governor %s for cpu %d\n",
> >                                policy->governor->name, policy->cpu);
> > -             } else if (def_gov) {
> > -                     gov = def_gov;
> > +             } else if (default_governor) {
> > +                     gov = default_governor;
> >               } else {
> >                       return -ENODATA;
> >               }
>
>
> > @@ -1074,8 +1076,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >               /* Use the default policy if there is no last_policy. */
> >               if (policy->last_policy) {
> >                       pol = policy->last_policy;
> > -             } else if (def_gov) {
> > -                     pol = cpufreq_parse_policy(def_gov->name);
> > +             } else if (default_governor) {
> > +                     pol = cpufreq_parse_policy(default_governor->name);
>
> This change is not right IMO. This part handles the set-policy case,
> where there are no governors. Right now this code, for some reasons
> unknown to me, forcefully uses the default governor set to indicate
> the policy, which is not a great idea in my opinion TBH. This doesn't
> and shouldn't care about governor modules and should only be looking
> at strings instead of governor pointer.

Sounds right.

> Rafael, I even think we should remove this code completely and just
> rely on what the driver has sent to us. Using the selected governor
> for set policy drivers is very confusing and also we shouldn't be
> forced to compiling any governor for the set-policy case.

Well, AFAICS the idea was to use the default governor as a kind of
default policy proxy, but I agree that strings should be sufficient
for that.

I'll have a look at what to do with that code.
