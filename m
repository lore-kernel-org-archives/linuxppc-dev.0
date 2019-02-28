Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 06:50:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7A8214D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 06:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Dw7z/eFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7A8214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44938G0vgHzDqMf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 17:50:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="Dw7z/eFz"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44936M4gTBzDqFY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 17:48:26 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id m10so9245593plt.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 22:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
 bh=kGV7nRI+ldFoszJ+37oEautsjOmJKo+1cPryJs1EFgQ=;
 b=Dw7z/eFzUrsTKCGOASP9KaALt8t8s5vzq+QyZc3+NMJs4YZTabokI2qUKHGhKrURBR
 m2vPI+q9QLY9ji92j9AaSz352IUepP62WryoZnggLxRaGf5no+tu4o2CoLeEck8So0TB
 lPXm2oGn91pRKi0ZlJbj/iDPDEHZpoiAbGfgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=kGV7nRI+ldFoszJ+37oEautsjOmJKo+1cPryJs1EFgQ=;
 b=MlT7sM85fIIhdz3N+cmydvGV0sUUyShfW7JBaIBfjLJKTuE5dJzGnHlrM4hEZCBW6+
 6N31qqSw1jQXpA7gKpNrUHqAcfn3HzisgS/4DoE3s4FJQhEjvoN0CvURUFHdkxxP1267
 YzJwsHyyH31kW9VIdapM/ZWl0dynJJq0JKblXIvqhBK+WjrRIQIZNqvyp+mC++hBzllh
 j+seHOb9QI3/6vFYk2CChIUqyMqDLpjrWARyIKDm2h26/RLG1KK7bOCy+RnNEAWeYnCc
 gsOJ9ugvjhL9qWrErka3/kP8zx152X59oOOSgkGoX1rvirzWa3rB0zk4MNVoU9jeko+0
 9zTw==
X-Gm-Message-State: AHQUAuaau8WRU1zJY12hr+hTnuV201PbwNu35sEfWulV0Yp4hknRUsic
 93qV3AY/jbNs2MzX1N5FmKecNr5Qz44=
X-Google-Smtp-Source: AHgI3IaH564hW60QCaDfOKqRbtvkvcnT7BjZMXBng+ibg2jAbZcMuZBSDIeB+T4AiUkvj/99FT4lPw==
X-Received: by 2002:a17:902:6a3:: with SMTP id
 32mr6387291plh.319.1551336504376; 
 Wed, 27 Feb 2019 22:48:24 -0800 (PST)
Received: from localhost (203-59-50-226.dyn.iinet.net.au. [203.59.50.226])
 by smtp.gmail.com with ESMTPSA id d5sm24754909pfo.83.2019.02.27.22.48.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Feb 2019 22:48:23 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Jakub Drnec <jaydee@email.cz>, linuxppc-dev@lists.ozlabs.org
Subject: Re: PROBLEM: monotonic clock going backwards on ppc64
In-Reply-To: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
References: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
Date: Thu, 28 Feb 2019 17:48:19 +1100
Message-ID: <87y3601k98.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

> I think I observed a potential problem, is this the correct place to report it? (CC me, not on list)

Yes

> [1.] One line summary: monotonic clock can be made to decrease on ppc64
> [2.] Full description:
> Setting the realtime clock can sometimes make the monotonic clock go back by over a hundred years.
> Decreasing the realtime clock across the y2k38 threshold is one reliable way to reproduce.
> Allegedly this can also happen just by running ntpd, I have not managed to reproduce that other
> than booting with rtc at >2038 and then running ntp.
> When this happens, anything with timers (e.g. openjdk) breaks rather badly.

I can confirm this on a physical 64bit book3e system and powerpc/next
with the provided reproducer.

> [X.] Other notes, patches, fixes, workarounds:
> The problem seems to be in vDSO code in arch/powerpc/kernel/vdso64/gettimeofday.S.
> (possibly because some values used in the calculation are only 32 bit?)
> Slightly silly workaround: 
> nuke the "cmpwi cr1,r3,CLOCK_MONOTONIC" in __kernel_clock_gettime
> Now it always goes through the syscall fallback which does not have the same problem.

I'll look at the asm but I'm no expert here so we might need to defer to
someone with real expertise. Falling back to the syscall sadly ruins
the performance gain of having a vDSO.

Regards,
Daniel

