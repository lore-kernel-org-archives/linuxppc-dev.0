Return-Path: <SRS0=bUW7=VN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2B8C76188
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 10:08:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE85020659
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 10:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE85020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nx185x1lzDqcP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 20:08:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nwz84F6vzDqPc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 20:06:22 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id a127so15102971oii.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 03:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SKSKLDsZNWfrDqHnwOUMB50WqSsunNsqcQ+sfiyuXlw=;
 b=sUKTXAtt+TIWIo71XbP0m4gwup6lf3AMgh9VXD87aVJ3MMcFVbcQJ/NJsvGrpVZuD/
 t5pO+/uV3DhhIYgNvcZ5QtG2+RsmAcfZwmL19XBqKT8Isfm+OsfUIQXkHV41JNc1zLsm
 RghRkfeJyFs16vLVVFwPdg/9XmyQ4qaoj74WnOIUMfxmZ8m9/VePCdVME5j759hfF/nn
 VWif5wlruRoWmQ3DGjVB7lAd1jUopsPxGUhsk9IhJCRR76iw8yoycOY6cijfZDvq6Wcs
 DYlpRjt4DFtnrSFdc7SJXDOT8NdPobPL7pMyl4WttFYYJpgodQKnh4TJi7EDPkcyDOQZ
 4Z7A==
X-Gm-Message-State: APjAAAWViEu/uZKZ0yLANfkfyI4Va3IvvXJbM8e49yup+DCxz4XFWr0Q
 ZDXX6w04ACIIkOHelTFbYT4L3jR5ci0SAnrm+uA=
X-Google-Smtp-Source: APXvYqz+9SLeYZezhd1CiiqSz9N5lOWLlOsr+u93YAb04Q18lnnuxQ5teq8PO6tM0DnrmvA9w9XvcWX+j6bgyJjGrm4=
X-Received: by 2002:aca:edc8:: with SMTP id
 l191mr15705198oih.103.1563271579314; 
 Tue, 16 Jul 2019 03:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563269894.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1563269894.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2019 12:06:08 +0200
Message-ID: <CAJZ5v0iqYHNt6NQy3Fi1B=XtjNOm2x0mX3+7eWBREgFZRpUS+w@mail.gmail.com>
Subject: Re: [PATCH 00/10] cpufreq: Migrate users of policy notifiers to QoS
 requests
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
Cc: "open list:ACPI COMPONENT ARCHITECTURE \(ACPICA\)" <devel@acpica.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>,
 Robert Moore <robert.moore@intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eduardo Valentin <edubezval@gmail.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Javi Merino <javi.merino@kernel.org>, Erik Schmauss <erik.schmauss@intel.com>,
 Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 16, 2019 at 11:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hello,
>
> Now that cpufreq core supports taking QoS requests for min/max cpu
> frequencies, lets migrate rest of the users to using them instead of the
> policy notifiers.

Technically, this still is linux-next only. :-)

> The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
> removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
> CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
> the policy notifiers aren't completely removed.

That's not entirely accurate, because arch_topology is going to use
CPUFREQ_CREATE_POLICY now too.

> Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)
>
> This has already gone through build bot for a few days now.

So I'd prefer patches [5-8] to go right after the first one and then
do the cleanups on top of that, as somebody may want to backport the
essential changes without the cleanups.
