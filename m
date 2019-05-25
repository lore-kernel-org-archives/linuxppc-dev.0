Return-Path: <SRS0=7t1b=TZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B726C07542
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 May 2019 18:19:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E329A20815
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 May 2019 18:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kkcebdla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E329A20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45BBN65Fg4zDqNS
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 May 2019 04:19:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="kkcebdla"; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45BBLp4LsQzDqKh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 May 2019 04:18:23 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id v9so415151pgr.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 May 2019 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pwUwT3IH5HpGo/L8sP6//cCZtClp5/ip6vUnZdkkz+4=;
 b=kkcebdlaAxI4tg4ycJmEqrzHnyewgh+jjzD8JuWykQMD1lxIZbs14DxRaS3JzJWrkx
 D3zUk40qEzDf9b4/+3m3e4ZQvAeZltgNBFxxlJjzMPDywJcvPdcoFqhPgZYDwqU6gPKo
 ZKBP/5ISTo1G00dTfWL1Nmxp2HkYKifVw8IVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pwUwT3IH5HpGo/L8sP6//cCZtClp5/ip6vUnZdkkz+4=;
 b=YVac02ovCth1008MuHn0BCTMWoIbjcr4YNq+jJlssKKPupktZdLVZovT6szlQo9pUx
 nXHpPcFEap9y1F2h7cj6GS7XoD1VKqzqF+fUiFQWTG8qrS3kgn3SoSAhW24TLHGYHbr3
 hfHXJoUesA0zu6d//ZVOmGeWj1Ir+GrCuMU88gKncaX/PdyeihsJ42wzrmwH5jLsT9FD
 ahhgDFyjHgqdr5kx/IxyTyo8NvJNjWE4l/YckiNcZ6stXePzJ4dTmDKixK12HPyFcC+g
 +ZYcSKfGmsDXWeRfxa42huryl1/3h8+njLQTATSakrReYePJj28oPZKRgeaWWauqX80X
 qdaA==
X-Gm-Message-State: APjAAAUrM/KvEGgRdH2K2o9ugsDhbQbhppnqBBAGTRGrUEub2vExVh8E
 GVMuHiwxYRDzogFahse6NzumLw==
X-Google-Smtp-Source: APXvYqx/tYCXEdllU2F4/1JetbgrhH8TFsHxXRye9Amlmvbkp4RD4ve2+88VYqD+upEJsBYYCIqDXw==
X-Received: by 2002:aa7:8554:: with SMTP id
 y20mr121952964pfn.258.1558808300867; 
 Sat, 25 May 2019 11:18:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
 by smtp.gmail.com with ESMTPSA id s24sm6537148pfe.57.2019.05.25.11.18.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 25 May 2019 11:18:20 -0700 (PDT)
Date: Sat, 25 May 2019 14:18:18 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC 0/5] Remove some notrace RCU APIs
Message-ID: <20190525181818.GA225569@google.com>
References: <20190524234933.5133-1-joel@joelfernandes.org>
 <20190524232458.4bcf4eb4@gandalf.local.home>
 <20190525081444.GC197789@google.com>
 <20190525070826.16f76ee7@gandalf.local.home>
 <20190525141954.GA176647@google.com>
 <20190525155035.GE28207@linux.ibm.com>
 <20190525181407.GA220326@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525181407.GA220326@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: rcu@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 25, 2019 at 02:14:07PM -0400, Joel Fernandes wrote:
[snip]
> > That aside, if we are going to change the name of an API that is
> > used 160 places throughout the tree, we would need to have a pretty
> > good justification.  Without such a justification, it will just look
> > like pointless churn to the various developers and maintainers on the
> > receiving end of the patches.
> 
> Actually, the API name change is not something I want to do, it is Steven
> suggestion. My suggestion is let us just delete _raw_notrace and just use the
> _raw API for tracing, since _raw doesn't do any tracing anyway. Steve pointed
> that _raw_notrace does sparse checking unlike _raw, but I think that isn't an
> issue since _raw doesn't do such checking at the moment anyway.. (if possible
> check my cover letter again for details/motivation of this series).

Come to think of it, if we/I succeed in adding lockdep checking in _raw, then
we can just keep the current APIs and not delete anything. And we can have
_raw_notrace skip the lockdep checks. The sparse check question would still
be an open one though, since _raw doesn't do sparse checks at the moment
unlike _raw_notrace as Steve pointed.

Thanks,

 - Joel

