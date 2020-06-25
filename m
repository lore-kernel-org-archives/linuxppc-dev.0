Return-Path: <SRS0=tFHQ=AG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B42C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:57:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37B3206A1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37B3206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49t1lr6FdKzDqwh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 23:56:56 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 49t17Z1yJszDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 23:28:57 +1000 (AEST)
Received: by mail-ot1-f65.google.com with SMTP id t6so5209829otk.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 06:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OV4WC/OGzJxfoXBFjW4vy0msSEZBQa3DQSv+ctqbI9s=;
 b=SrV/Io80ovd1NenIDWGiERfugw6UKfCCSq+4EAdpLDT3TsB7FQpJJiwCwDOpXJBkkP
 HGszG2qQ/XiVfDxJyJt5ZWf1mSmcpgKwgVbIuLhLKmYL9m2pGYss7qH88iPzcE05SXUv
 rtwKPN/uFg0IQmnlp2lkduS3pa7YoTTrXLxyr0vhY1OmnJwpYcucaSeCmA72YBdihhNb
 O/6B3Gtrcta5fz9a4dRJl3Ny2OJ0hCyu8eDL0515xUMrwsbLlOPWLsZFztDYyWHZz12F
 Y029Uq7z63X7URxOrMwo0KprzD3/vKEbOaIWlOSSwoBpESASNwDS4XDwLAxtAgXuPg4b
 3+jA==
X-Gm-Message-State: AOAM532smK63uHU4H3FL33c7+8C3dbtVjPVXqGG656w9ZmrqQWciHXSy
 NNkr/P7yFAeatXNpl+b5SwKbGQRLehFsDF+MBUU=
X-Google-Smtp-Source: ABdhPJxlUXOc9imwl9lPejVNcyeUZKKYcc4bvi+l4uR/l8F3vA3oLuAVU6XT/a0cSQMG33eUfVPp/S664VWlHO/mRZ4=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr25888354otn.118.1593091734743; 
 Thu, 25 Jun 2020 06:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
 <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
 <20200625115318.GA219598@google.com>
In-Reply-To: <20200625115318.GA219598@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jun 2020 15:28:43 +0200
Message-ID: <CAJZ5v0jQkeu5dJXxXN2eQ+cAwv8oSK_wZZgTW3cvMZX0ks9jHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
To: Quentin Perret <qperret@google.com>
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
 Viresh Kumar <viresh.kumar@linaro.org>, adharmap@codeaurora.org,
 Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Todd Kjos <tkjos@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 25, 2020 at 1:53 PM Quentin Perret <qperret@google.com> wrote:
>
> On Thursday 25 Jun 2020 at 13:44:34 (+0200), Rafael J. Wysocki wrote:
> > On Thu, Jun 25, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > This change is not right IMO. This part handles the set-policy case,
> > > where there are no governors. Right now this code, for some reasons
> > > unknown to me, forcefully uses the default governor set to indicate
> > > the policy, which is not a great idea in my opinion TBH. This doesn't
> > > and shouldn't care about governor modules and should only be looking
> > > at strings instead of governor pointer.
> >
> > Sounds right.
> >
> > > Rafael, I even think we should remove this code completely and just
> > > rely on what the driver has sent to us. Using the selected governor
> > > for set policy drivers is very confusing and also we shouldn't be
> > > forced to compiling any governor for the set-policy case.
> >
> > Well, AFAICS the idea was to use the default governor as a kind of
> > default policy proxy, but I agree that strings should be sufficient
> > for that.
>
> I agree with all the above. I'd much rather not rely on the default
> governor name to populate the default policy, too, so +1 from me.

So before this series the default governor was selected at the kernel
configuration time (pre-build) and was always built-in.  Because it
could not go away, its name could be used to indicate the default
policy for the "setpolicy" drivers.

After this series, however, it cannot be used this way reliably, but
you can still pass cpufreq_param_governor to cpufreq_parse_policy()
instead of def_gov->name in cpufreq_init_policy(), can't you?
