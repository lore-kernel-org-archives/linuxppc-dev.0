Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3462C4743C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 06:02:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549F561186
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 06:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549F561186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8t2m6f7jz3c0v
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 16:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m8KQZw6U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::632;
 helo=mail-pl1-x632.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=m8KQZw6U; dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8t216QqHz30G7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 16:01:45 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id y21so598509plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0eD2NKzR92krNnSCAEqt3EN7AElb1rlw5uXmc6X1m0I=;
 b=m8KQZw6Ur1ZiTHKJ/vEdrdcpgTcd39VYmDcf9nHZVdCmN5oh5mXieYh2xJMKVyzF8B
 6RmHjE+UgMakMuNUE4/0BDh9kz3JMP0am2MFxfi3dDK2MOftOig/MyT31BM4Ji3WpmhM
 QY4Mfjmq1iubygVVb/KNSroMQPQDavBkVmLiw0/XMAjQnFRCVIKqbtFX6JacQo4Tss6m
 YWhubLF7358Jz2ZO6q5lcP/llnus3BrZgge/0UFQ2HW68GZfrphwMyl+16pl1Wv+yiu5
 6+TDJMhhKJO/7snEu8w3R9ISBR496y9OLfWO+682RmQipNOrUjD2RdILXbq39SR1pina
 grOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0eD2NKzR92krNnSCAEqt3EN7AElb1rlw5uXmc6X1m0I=;
 b=AHwOVTKHD1CuhlBbru7h8I8bjlJghIZzDXEGEkQ0DQU3DGVigF1TLpZPEbZ4PEljCE
 xDtP/TqT7Q7h5JO05/sPh8CjyiqXLL9a+oDi3oyy3IyokdcVWU3vo4SgH++kPfO2EAie
 SOlUTz0rnlpgTYypeNfYDK4jFzHeRJ9ICxtkJwNTKutRz/LdR1YDosz0oy6mhAPPUP+9
 soU7ae10vtz4BPQqOtEscpyQ8gvlytLC5J4Ln4YPv6QOCNHV/T9OpQ814Cyl6KrHZf+S
 iNRWSN8Eo8xdpN4oEQpwzSPiARMEWQ6IvjVATmYZ8QJp2nK+hgPrq7M3MSF83oa2c+Ly
 INow==
X-Gm-Message-State: AOAM5338kmF0DcO/GlP0J/xWzsfEXsikS5aDLaA0tHzQlK+7Tya9n9x6
 ueXt1YXD+uil59xvKWsI7I3VVw==
X-Google-Smtp-Source: ABdhPJzgZD7Ut0KQSWuTsx2q+526QSQy+cqtMp4zyuBW2ebISqTBxiJGMb+5BE0Iagm05/cmP38YvA==
X-Received: by 2002:a17:90a:17e7:: with SMTP id
 q94mr7708393pja.117.1624428102352; 
 Tue, 22 Jun 2021 23:01:42 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id g18sm1063642pfi.199.2021.06.22.23.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 23:01:41 -0700 (PDT)
Date: Wed, 23 Jun 2021 11:31:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback
 instead of ->stop_cpu()
Message-ID: <20210623060140.2mtivaxuiemgg7ug@vireshk-i7>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
 <e40e57a97735614941e9ca7fa2f221f8db9a12b2.1624421816.git.viresh.kumar@linaro.org>
 <87v96516d9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96516d9.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716-391-311a52
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 23-06-21, 15:45, Michael Ellerman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> >
> > Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback instead of ->stop_cpu()
> 
> Typo in subject should be "powernv".

Thanks for noticing it :)

-- 
viresh
