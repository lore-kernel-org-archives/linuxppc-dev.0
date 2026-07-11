Return-Path: <linuxppc-dev+bounces-24040-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C23C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 03:32:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxvQM0qyWz2yN8;
	Sat, 11 Jul 2026 13:32:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783740731;
	cv=none; b=HJUrdKKFRyDIoQHU5/Jw3m1QYh/byBHrEmFyGcscwVepS8r0qSQa6BYPTRz/YLstTq/E5ek+qJNxAccmu0uQFK6y1w57YPCTOHxzTQHlvhRgaD0//rBBI1taLdvbrWJJDA//fuIRJ3njvww8/wF42jVRa1K341BFHaALUZqf3lGny7MGlcdwjQ5jY4BdYDoakdaCSHhSHtf+RmwBVUKKiJOFmSVD14HhTGZA3iPl7hLWhXljvsvCkm2S75p1hU57SvbgVXo9WfKK6z6OyNS9euVzj+t6UsXX1obmx5Op6JX4EOqgayCz5Pu9a72094U9lm9uRWelNgjOVDNcTe9iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783740731; c=relaxed/relaxed;
	bh=QRUA0T/6rJLjJGZRSGfGUI1p1QAMGmjUm39A81E0yZA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=UKFaBBmELBA+L/7e31SRrs4Mgyrjj6WdZvkkJILKXYlq1i7OWFBNQWN+VG5dEQCUvXjx9H//cFCU2naBjDcMMhGPzccDqCLS9dT3mGEw86lPFs18HkEo4cKjVRlh9Cufh6tFDM+tmhKw5Z+qcAUQzOPcOqy1hzO+mugJFBeq4zh4RLTfh2zZBsJJBm0hK0mj3E9nedDiapVLgCkcyETdv5G0SilQyt65faw7SjpBxrXUXVFEPNcwtUB7BsH8UF9w8FenOrMsMWK5JEbwDj9jR4kBLUnPOyH3VNLagBzm8vQhNPxif6+qszQGDcGoOeq6uCVo3RV1F3ATl7MMZBmh8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qJaaBH9a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qJaaBH9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxvQJ3HsMz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 13:32:08 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-381891a9525so1924192a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783740725; x=1784345525; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QRUA0T/6rJLjJGZRSGfGUI1p1QAMGmjUm39A81E0yZA=;
        b=qJaaBH9aEbbNJDr2PMlEAqqcTDgsT48gSvKQ8ukMKV5lb2d1rSiWU+MeJCKd1rI6M0
         x7lc5QCo2WTKwimAjECkrjHmU4HG+KEi58g1KTkllUBYeGYp72aW9LN+StuZsynfJ95B
         gWQ+7FJx5Eqql+CJKgrrSewbT8Ahsu2AtsRxt/83nZ2cshnglZ3Kt17Hfo0jWW1nKtlc
         Ab1rlXmSchS94zMqLOqNf1FOO+2eFM81m/pO0s87zamT4sdkEHk9eggoSWOmChevnf+W
         6/YLjNFF2YoCAlcd0GBgn19PcOrMdh6PUh5fduJ6vzTJQtunSSPVyjQlAaEgopq3VSCe
         kTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783740725; x=1784345525;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRUA0T/6rJLjJGZRSGfGUI1p1QAMGmjUm39A81E0yZA=;
        b=MlTOV4mWm3BTHSDrq/sSr2jQkVWmuZ6lF1ojGzrcbVQBy2ZM6iBcXCEz6he5t3Rh/R
         6TzRlRVlKeO3rj5eT6gJBwiK6ybPr8uXKaPR1O90z+kBnLlhBqHc5wuLaMepuBovJdWV
         voPpX20Y/KuZLUv+eKX5a3cPKeLFjJTaRkExyReIz7fEaKgYm9I4FLa8cd7165R9RXC/
         kR581YLQsMMnMilFy0JhjFvFe5IhovA6ndiImdnaotHeXJLfDtdrAXvKDA6aNJGpXUfU
         ysmzInvseGhuLKbABQDWlMaDP5KHfI7pbcScr+c10e/3RXFpiDmRQxpEvMof2F7tALge
         5gMg==
X-Forwarded-Encrypted: i=1; AHgh+RqI35lIxezxBPKqtNRmePv8kOuf47/QqgP0XEOBrsRDkW+xGucFEjZkjAy8v0x/IbtutGCAW2OEo/9h5wo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxS9Er2xTdksICdqd2ZgAQm2MdSfVMXOWn+cmsWjdEtx+QzVOU4
	G6e9c7d3pQRTzHIWyTxmS5cBQY9rTkLW0CbAVimZOuGpu9I/xWliL3Tq
X-Gm-Gg: AfdE7cn1WzyUK8VyXfE7WPLMBmMHEK2lB+ozY41ENMPJCls6Vb3xP9ui4kBpZp8/NoL
	bqJZX+dE6ceM9BSCe6HVI9jSPYYKR81xnTsTa7DFAbHd9A9RBn2Kil7ePxIHS7vFXQdO2wLthu0
	PHSfLslIAkJh+Ee9ZTBDusEhSmVbkIe5NPs3WcQPmGeyWpV7a1zI9U9EHbqCQFTB0T630wBYajo
	Ew7hP0aFOxJj8mT0+FSzDRraQueOm41DpVEuHBbwYITztbzo2X+FkCnUCU6NKM5p7Ne8pkQvmPW
	iXSBmw2c53bOyTt1CAbvWfEj8N46wgfPOV+d0hT5CHXqC2PoOgD8FuTLBuB8/yWxn7CuOkeTlFt
	ozcREc86UpgJT41NHsSXh4gIxK0dYbARcQttQQqUQVNimAUg1iQxg5vQUvaRD8JmwKLADopS5l1
	xlu1x9hgLME6Q=
X-Received: by 2002:a17:90b:1c05:b0:387:e0bb:57f8 with SMTP id 98e67ed59e1d1-38dc77b46camr1413183a91.41.1783740725360;
        Fri, 10 Jul 2026 20:32:05 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483dec6sm46717596eec.11.2026.07.10.20.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 20:32:04 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/crash: stop watchdogs before booting kdump kernel
In-Reply-To: <094c3b8d-8ec7-4358-8bd7-f1b7eaa3a0c8@linux.ibm.com>
Date: Sat, 11 Jul 2026 08:45:26 +0530
Message-ID: <tsq6ushd.ritesh.list@gmail.com>
References: <20260603070217.483696-1-sourabhjain@linux.ibm.com> <20260603070217.483696-2-sourabhjain@linux.ibm.com> <4ii8w2ex.ritesh.list@gmail.com> <094c3b8d-8ec7-4358-8bd7-f1b7eaa3a0c8@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

>> Looking at the code, we already have a mechanism to register a crash
>> shutdown handler which anyways is getting called from
>> default_machine_crash_shutdown(). So, I think we could use this generic
>> crash handler register mechanism and keep the wdt specific calls within
>> pseries/setup.c file...
>
> That's a good idea. I wasn't aware of this crash handler.
>
> The main reason I wanted to stop the watchdog as soon as the kernel
> enters the architecture-specific crash code is that, on PowerPC, the
> crash path sends IPIs to all other CPUs and waits for their response
> before continuing. Because of this, I thought it would be better to
> stop the watchdog as early as possible.
>
> I knew there was an IPI timeout, but I just checked and it's set to
> 10 seconds. See crash_kexec_prepare_cpus() in crash.c.
>

That's just the max worst case timeout value, which is unlikely to be
hit. FWIW, the watchdog timeout value in the example usage for
sbd.8.pod.in file seems to be 15sec.

> The crash handler is called after the IPI wait. So, in theory, the watchdog
> timeout could occur before the IPI timeout. But I think that's a very 
> unlikely
> scenario, though.

I agree.

> So I think disabling the watchdog from the crash handler
> is a reasonable approach.
>
> Please share your thoughts.
>

yup! I agree, the crash handler looks to be a much better approach
since it avoids, hcall definitions scattered in common
powerpc/kexec/crash.c file. This also provides setjmp/longjmp for
recovering from any bogus exceptions during crash handling.

But we will know more when you will give it a try!

-ritesh

