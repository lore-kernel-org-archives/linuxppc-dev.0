Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54597C282C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 01:02:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B292920873
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 01:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Jxc0uQKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B292920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ySF16MWfzDqJ7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 12:02:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="Jxc0uQKE"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ySCH2mw7zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 12:00:58 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id n22so1710123pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 17:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Gx5A7GJr+FgvxO0lRVTW2iTOQJERA70kJc7FJrpQPcs=;
 b=Jxc0uQKERYx40DZnElfeZueapK/o0OZIu0jpz6qeJ6Y5JEV+Gx8/hEoZ/dWL9fH2cp
 HllXwmjn/erYObjdwna87sX4x/GYA06JKBeQ5Z6U1m/cPOf/ScHJzu9Ra8RrSVPl2UiQ
 FGMXsDVw0daba5qO3XXC6ukmB5dIsrZlinJeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Gx5A7GJr+FgvxO0lRVTW2iTOQJERA70kJc7FJrpQPcs=;
 b=cyDw7Rdeq/7EZfvVtFD/yrpLcwvy5Y6rHSjShK7P/sZu0jeYHR/Zyfr7g85ufuLXSU
 AZzWeLLGd2SU1AgvPkjrdIHudA5ObypincOffrB7HWumgUsinsWaJeF3zLedqFvK+PWT
 itORSwCRFvFkb501iS895xUQao8sm1zIsFZD7+eI0r5iZX4qOhkvdInOvlcz+VourNNW
 RAxlqNOXxKOk+YnZbW6QbVeeOLddgrVnttlmNW4tLGBsOkcJ5SQMtnbqL4zMRWLYJra6
 mpLNxqsfVsx7SqU6bobN6R8xNSSa8X/TUyYanuV8IC3+xlp7Uu2fEJkb1FROal24s06D
 Uoww==
X-Gm-Message-State: AHQUAuakpqMBul9xTUMo7p73ZsrsRE7wy+BXFko9F1Mmznv8ZGnqm6Il
 d6y2DykH30Kji59q8tfnMUpQCQ==
X-Google-Smtp-Source: AHgI3IbIu85aj2C/pYVl+Y6mSugSYeT/ynugYAFFlOlUyHK6Zf/EpPIYdFRtY/N90061imwDIWZGWg==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr6782309pgh.206.1549846857304; 
 Sun, 10 Feb 2019 17:00:57 -0800 (PST)
Received: from localhost (124-171-97-196.dyn.iinet.net.au. [124.171.97.196])
 by smtp.gmail.com with ESMTPSA id s12sm5208143pfm.120.2019.02.10.17.00.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 17:00:56 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Sandipan Das <sandipan@linux.ibm.com>, mpe@ellerman.id.au
Subject: Re: [RFC PATCH 5/5] powerpc: sstep: Add selftests for addc[.]
 instruction
In-Reply-To: <9460deae6525f983b6ab44e3e35c1bbbd79d3ef5.1549253769.git.sandipan@linux.ibm.com>
References: <cover.1549253769.git.sandipan@linux.ibm.com>
 <9460deae6525f983b6ab44e3e35c1bbbd79d3ef5.1549253769.git.sandipan@linux.ibm.com>
Date: Mon, 11 Feb 2019 12:00:52 +1100
Message-ID: <878syn3zqz.fsf@dja-thinkpad.axtens.net>
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
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Sandipan,

> +			{
> +				.descr = "RA = LONG_MIN | INT_MIN, RB = LONG_MIN | INT_MIN",
> +				.instr = PPC_INST_ADDC | ___PPC_RT(20) | ___PPC_RA(21) | ___PPC_RB(22),
> +				.regs =
> +				{
> +					.gpr[21] = LONG_MIN | (uint) INT_MIN,
> +					.gpr[22] = LONG_MIN | (uint) INT_MIN,
> +				}
> +			}
I don't know what this bit pattern is supposed to represent - is it
supposed to be the smallest 32bit integer and the smallest 64bit
integer 8000000080000000 - so you test 32 and 64 bit overflow at the
same time? 


For the series:
Tested-by: Daniel Axtens <dja@axtens.net> # Power8 LE

I notice the output is quite verbose, and doesn't include a line when it
starts:

[    0.826181] Running code patching self-tests ...
[    0.826607] Running feature fixup self-tests ...
[    0.826615] nop     : R0 = LONG_MAX                                      [PASS]
[    0.826617] add     : RA = LONG_MIN, RB = LONG_MIN                       [PASS]

Maybe it would be good to include a line saying "Running single-step
emulation self-tests" and perhaps by default on printing when there is a
failure.

Finally, I think you might be able to squash patches 1 and 2 and patches
4 and 5, but that's just my personal preference.

Regards,
Daniel
