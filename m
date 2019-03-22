Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C00C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 09:47:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBED21904
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 09:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBED21904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qf2w2SsDzDqWG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 20:47:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qf1J3PvMzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 20:46:09 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id x188so1215529oia.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 02:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i4/MNnc1Sea+usyPpKw/vkxvIwHz+vkgmpIh97ysm0E=;
 b=raJLPAgG2/1qrfLQH3r2D11EWsPVsT+6OfRPnOyEzmVqtuAGL6IxKAwZF4tzpAkfb7
 Q9xJW6uZXgDfKtCqefcx55L58TL26+AKQEJ43juICZYVka9+bYXb9DOB0pAqrpAgAnJz
 8FufiF61SNy2nHrBCRdHi6DpECXxVLfK6tMxV90Z0yr4d+3rNeT4JjycKBeLOWgGX73e
 yigB1Hx9sXlK1SAEauh8XqCYiImU6LDa/4awACfyo2Det8lpwosjdnQstiHwyhaQqS+d
 njqig6ILvM7SOmNjuBWWJ0nTPyjAfiLdyy+aF4swRVaUotQfu1DRVmOkZ13Lpsb1yzTN
 Gryw==
X-Gm-Message-State: APjAAAWzbhR3WpV9uk+jZ6s1PKcOK+ufenqGxdeuzR/Y9hltO8XXVYBf
 JX6X+BhLbcPB2CK1tiHw0XQjJUk/9tcbnRZ6mN8=
X-Google-Smtp-Source: APXvYqy8qQWkbml8D0MLXmIVayDzaUmem5mHamQOx04tW4evyz61JMOJSNdIvn/+mQGKYiFxOzaRbOdGBgpPXuKeU8Q=
X-Received: by 2002:aca:6046:: with SMTP id u67mr1152190oib.84.1553247966744; 
 Fri, 22 Mar 2019 02:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Mar 2019 10:45:55 +0100
Message-ID: <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>
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
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
<huntbag@linux.vnet.ibm.com> wrote:
>
> Currently, the cpuidle governors (menu /ladder) determine what idle state
> an idling CPU should enter into based on heuristics that depend on the
> idle history on that CPU. Given that no predictive heuristic is perfect,
> there are cases where the governor predicts a shallow idle state, hoping
> that the CPU will be busy soon. However, if no new workload is scheduled
> on that CPU in the near future, the CPU will end up in the shallow state.
>
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>
> To address this, such lite states need to be autopromoted. The cpuidle-
> core can queue timer to correspond with the residency value of the next
> available state. Thus leading to auto-promotion to a deeper idle state as
> soon as possible.

Isn't the tick stopping avoidance sufficient for that?
