Return-Path: <SRS0=fJvf=KW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69061C4707F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 May 2021 14:19:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2D3613B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 May 2021 14:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2D3613B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FrVLw4DB3z30H2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 00:19:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=oL8+TZNn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20150623.gappssmtp.com
 header.i=@paul-moore-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=oL8+TZNn; dkim-atps=neutral
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FrVLQ4kXFz2yZ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 May 2021 00:19:08 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id b9so284050ejc.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2021 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0KMicP7dPruhWbetN8SS8Qn8WRBhDpCdjlUFYTYIPQY=;
 b=oL8+TZNnSedYZxnjK4DI9LSvARM8ndmpxlxh6MbE8xc+bzPwC15R8Oe7BjBHBNDZJU
 TNJP8Tt8TyG1DmWC33rk+d5R2TN/mvP/gK0UeOcVkgdELmghktfHLYP8jQjpCHsvmX2b
 DhFL94mzDwpgYjyGSpg4J/rAkkNxNjR97srQQgHxVbtNcfz5kQ/cblTw8NQzxSMLaOrY
 G1r+90PQY64rR4qLSENwuRJU1aPtfVkjFCNY2D6JqIUDBKPVcJCgfP8G2hKezSwWEDi4
 apxq9vHVNpXDgfq28VM6AgmXZQSXQY5PyR5QvKTo1urmbFatACON7BQ19GUEX0119z5i
 Scww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0KMicP7dPruhWbetN8SS8Qn8WRBhDpCdjlUFYTYIPQY=;
 b=KO2CSWPmK3M6I6z4x8GXBXRu6Hmzi0MXnjq+3pqAuTdxjO4IW6uTa4NiKir9xvVYXM
 IF8ppszaey4T/RPItT+kfUo1kUcdhKRxAE6lI2M7oPLOHiw+50xgQvlLrlu9eKkPAxkx
 jFiDexGFefgHo00U2ldYN51/plf9td46B02HhjB+S7601HT2qBFRlbOKzM2lMaVNcaqQ
 E2bGrIwJhQnED63mcGdUgUMfqW2x3Ghujr98Cp68ORhwKkiSaYh2D4EA4oQsPpfVKu49
 0T24Us62MQM1hblS793dEHYleNJtLTjmi32O1ujjRZdAQrXQozoq8dickRZpR9cchsW9
 KrtQ==
X-Gm-Message-State: AOAM5301ROvpWBWEfFkbgoLbBlMXcR/jBYEXRBNrEwoYu9plTQzPn7Ev
 w7VF5N8aL7vLyJVs6RCwhVfhOWHt4xNtjGrRAZ5c
X-Google-Smtp-Source: ABdhPJxNY45Rvc2vrfaQ2IL4Eku6yyHzxMbb+NaSgzTa9DTK2YgRMf8cywVg6CWuAUNioudc7Sfjin2qWfEjUKkshxk=
X-Received: by 2002:a17:906:f283:: with SMTP id
 gu3mr4078724ejb.91.1622125143443; 
 Thu, 27 May 2021 07:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com>
 <87o8d9k4ln.fsf@mpe.ellerman.id.au>
 <CAFqZXNtUvrGxT6UMy81WfMsfZsydGN5k-VGFBq8yjDWN5ARAWw@mail.gmail.com>
 <3ad4fb7f-99f3-fa71-fdb2-59db751c7e2b@namei.org>
In-Reply-To: <3ad4fb7f-99f3-fa71-fdb2-59db751c7e2b@namei.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 May 2021 10:18:52 -0400
Message-ID: <CAHC9VhSSZzDeM1bcOjVBN6u5KPAvMysg3sLcSniq+cLr65WFqg@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To: James Morris <jmorris@namei.org>
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
Cc: SElinux list <selinux@vger.kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, network dev <netdev@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 27, 2021 at 12:33 AM James Morris <jmorris@namei.org> wrote:
> On Wed, 26 May 2021, Ondrej Mosnacek wrote:
>
> > Thanks, Michael!
> >
> > James/Paul, is there anything blocking this patch from being merged?
> > Especially the BPF case is causing real trouble for people and the
> > only workaround is to broadly allow lockdown::confidentiality in the
> > policy.
>
> It would be good to see more signoffs/reviews, especially from Paul, but
> he is busy with the io_uring stuff.

Yes, it's been a busy week with various things going on around here.
I looked at the v1 posting but haven't had a chance yet to look at v2;
I promise to get to it today, but it might not happen until later
tonight.

> Let's see if anyone else can look at this in the next couple of days.

-- 
paul moore
www.paul-moore.com
