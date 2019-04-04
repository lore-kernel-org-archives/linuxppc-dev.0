Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DDC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 10:56:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE61D20820
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 10:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAK16tvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE61D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zfyb2Fz9zDqMd
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 21:56:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=ego.lkml@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SAK16tvd"; 
 dkim-atps=neutral
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Zfwb5sLRzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 21:54:52 +1100 (AEDT)
Received: by mail-oi1-x241.google.com with SMTP id l203so1506654oia.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=mNKRYI724wU2ua8Lfa1mKNeq0ZvZ3joRQVVPoI0gIHI=;
 b=SAK16tvdBcDUFOiK0AOv5qY8lw6iSQKIMVknSm5kIQ2HLk2oWFe8H2GCBXbdAy4Bt5
 1K1EBPsFG6009u+vzyoYApZRjiTHgoX3h8sncYkoAekmA348v8d81miR5iIiNozYLVwu
 yc5Mf04canylWe5jgMF04goRQEvIm2ZB3R4ms1GJlnuzgQ6kB30SXNjXywKVcdlFkr7k
 Cd6phMUsUBD66OtGF1bZhTgXdYa+dY1aIz4y6Lzp6UVOXyPKhOq5ITIRMAjj+JgAxUsQ
 5yV4euMkCBlOe8LHjhDuUD4oP3q2+77W5y5odj1x2VAtWfIejUsW9o2UyNIMvkVWi1K6
 Okyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=mNKRYI724wU2ua8Lfa1mKNeq0ZvZ3joRQVVPoI0gIHI=;
 b=aMlkvXTPwZolbttAJE7WkNQ4bUIdOI5ixzMNqWr/D3/aUkkIgKWnm+6ANy5hf7gOf4
 A9ckd19XLu2sji0fmlk/QyEw6WLUXqRXIobqFpruunI1jp32VhPwRcewm9thK2OlgvZH
 lGatzK3McueSdKC5m4s5L3OnDIwfDUD/GTghZsIcf+Z4Z8i/bmwrhioypjEFMtYHYnHC
 9L4S+MEyzfqsoLv7BUHfo7QK5NVqvD49ik0DqCy2rfPw+RwJQ1aBQGLah+B+zoRtVoyF
 Z5LK2UUuBt7YcthqbCebMABTrMO2prC2vLgh2ksEAuNKPMsuqdBDLCG6G3wWD1B5J02x
 0nkQ==
X-Gm-Message-State: APjAAAUtJzXf1IqXaXvTfxOMR4InJe5/Q/htC0rf7JmC8AGAMHJ2j9c3
 zWbBIQvjaKX9PPMtjb9fnoXojecH5h6oKKCfrYc=
X-Google-Smtp-Source: APXvYqysGmkcALA4vogJEgmghDFBvjeP2+7t8dBOGAh4CWSMUvK4FXK9mqsqmX8CdLvPp3SRLFGRJDPsvxKUI0n2+1I=
X-Received: by 2002:aca:61d6:: with SMTP id v205mr2860978oib.122.1554375288745; 
 Thu, 04 Apr 2019 03:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
 <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
 <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
 <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
In-Reply-To: <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
From: Gautham R Shenoy <ego.lkml@gmail.com>
Date: Thu, 4 Apr 2019 16:24:37 +0530
Message-ID: <CAHZ_5WzRn-Q-E8X-_dmyn14gp1Go2LNbceNNuYnbpEcgpM-1Hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To: Daniel Lezcano <daniel.lezcano@linaro.org>
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
Reply-To: ego@linux.vnet.ibm.com
Cc: ego@linux.vnet.ibm.com, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abhishek <huntbag@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Daniel,

On Thu, Apr 4, 2019 at 3:52 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Abhishek,
>
> thanks for taking the time to test the different scenario and give us
> the numbers.
>
> On 01/04/2019 07:11, Abhishek wrote:
> >

[.. snip..]

>
> >>>> In case of POWER, this is problematic, when the predicted state in the
> >>>> aforementioned scenario is a lite stop state, as such lite states will
> >>>> inhibit SMT folding, thereby depriving the other threads in the core
> >>>> from
> >>>> using the core resources.
>
> I can understand an idle state can prevent other threads to use the core
> resources. But why a deeper idle state does not prevent this also?

On POWER9, we have the following classes of platform idle states
(called stop states)

lite    : These do not lose any context including the user context. In
this state
           GPRs are also preserved (stop0_lite)

shallow : These lose user context,but not the hypervisor context. So
GPRs are lost but
               not SPRs. (stop0, stop1, stop2)

deep: These lose hypervisor context. (stop4, stop5)

In the case of lite stop state, only instruction dispatch on the CPU thread
is paused. The thread does not  give up its registers set in this state for the
use of its busy sibling threads in the core.  Hence, SMT folding does not
happen in this state.

With respect to shallow and deep states, not only is the instruction dispatch
paused, it also gives up its registers set for the other siblings to use
These stop states are beneficial for SMT folding.

Hence, if a CPU thread remains in a lite state for too long,
its siblings in the core would not be able to utilize the full resources
of the core for that duration, thereby inhibiting single
thread performance. This is not the case with non-lite states.

-- 
Thanks and Regards
gautham.
