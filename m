Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC2606A881
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gu6AQ4Cr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTQvj21pnz2xqJ;
	Wed, 18 Nov 2026 00:44:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794923089;
	cv=none; b=TDK47fjtemzv9d+4EWj0ajr4Vnh+SJ7wcT3krZnNHWWQ+qSzIwtHCp3hdgfJIrlt+8ZBY4+CmjCLqzvnNEkIcokiZhZNYW434riO5UJurXQC53mIQMum5hbJ/6DLO3XbCyfasQ0vqsG2wpdDvX5fAa2ngghNmtLqYdjgyHFM3qKO0/svuzegWQK4cAje8bUqfVLYyl694zC2mABd4IbB3l/UvwXZF0164bLQ8xqhBpXA9NjnpQy+8zIoSxCtM7JJhHTX+ysFeukjNpatA6bKbS2Jl2Xslw6+uvJ6n+SK+dEOfSgTcfFyoAdkgGXHfz0/VjknSYbvCQJWeq4N9SC8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794923089; c=relaxed/relaxed;
	bh=BmDrLi2pcPmmicbvGZOk7xz6dC3kD9mXgbhjrRNLcYE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=R3dbWYXg0Kb0ZbbB1IgV8a6QXjP28X7HsSNY83mgar1ZOhcGVAYEmCh5SdKZKs+py1A5LmtgUMSH27/eE19ZI/SVYLFp/2yxqKu3taFtO1BS4ZiUEOBABuJQkOPS9+3zge2lMU4UomElj2IGZVofW5nFTPMrP1HslSqvzAh/tRBCJim4EXcBfq/+pihNUJxS54cGxq1rV1ZD7fxQCU2t6RmuWAgdYNXlw7swHVWeo7ErlS31CkpzgQtXKFFnHqYVmcY5oh4kZWQ7rE+GaOEc3Rq8rYrYY43N7628z4xT5yZBW9Zyg3jITH1bchWpizCyjGvIn6Hlm5nlfiSI8OsMMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gu6AQ4Cr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gu6AQ4Cr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTQvh4Z9Hz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:44:48 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-33fb4680717so11768758eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 05:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923086; x=1795527886; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BmDrLi2pcPmmicbvGZOk7xz6dC3kD9mXgbhjrRNLcYE=;
        b=gu6AQ4CrAYz/bJVQtv+Cj0syCFnGseibPM43nPc/TYr0JHdQ0dmx1KWUiGdk1McX0L
         NTbDeIosBISowvgDpx8K8JmbXqFcSNHE0HwCcGn0huPuldcIPZyatIQVHauvi/0mJUes
         qzxP0xYOSajoKbGUjByX1/ToeD4PSWGWzoh/vaRDiC9M9cVKuxewHncntSRKvq3UPphb
         a4Nmv+Ow4sOzx/o+NuMTmV/TuokKK1UpUyKjJEuKT27wJV5QpE7ouYEI0bPjRc55vG5N
         FfRi6AdApoPbXyNcmT5xTPJZfA/qAHGP7ynT8XjvH6zV9O2A9GGdKt2SjlNOZnwbnKi6
         XmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923086; x=1795527886;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmDrLi2pcPmmicbvGZOk7xz6dC3kD9mXgbhjrRNLcYE=;
        b=DbPk7bcXcxtmfhNKi4JKVq5ekgh+nR6uIt6APKgqdtptISC3VwWbQkL4vSRqx8Pl2I
         gJAeYwqijfmiPY8jnN5xua4OYgQ9+GqVrcg00ooLpkUFrA4YXxBQKvhh1dArYZkChASQ
         8aFCMNw7WFZghIGW1dozhGArr7z1uCn0PIDvAeIM8Tj9moa79KoPml82uhOEI6zQVZXN
         DtUlbEo6OVuveWbS58y45vg3HzvsE234+avtvXF0RPGsjvXVo08goYi2o6lPk9S3yHy9
         CC/j9/YHe1PS5bMnttKL+GaPCmFBbmnR6vG5HFmj+zFtSr3evwzKplBpNpuCXbI94hOG
         wLVQ==
X-Forwarded-Encrypted: i=1; AL+hErEMajxKtpp24InoejwSuWETX6rr3L/XhhSTj8t0Ajn9oJWkMZXDxaekuv5KGcH/tTbqWineDIsJiVz9Jeo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/+fzq6ZUfiHxBf0Q/t0RFH69Z/L1dZYyclWeSpVqVpGkxvB+W1
	S6cE56Ryk1A9MoPxMF87BrHFXScr8WENr3zc4PUCQroDbHAakHoyI43I
X-Gm-Gg: AZFdTZe9H8bxpUwvF6X2uojCskHD4PtnlfuFdeXM+67f9JE3mZyuXsyvJkaPNpe7lpY
	JC+xPng6AwOAk6FlzHaPjFPveuDYh084Igu+OfzawOqkVz21SiFLN4MQXCuTO81yGwTlxPTRTIt
	jjd9x7aNMVrgyQvY0UK8FvMqpL7uMf8NG4q3tSyIqJSnF8ZY8Q02xcbjgxzURZ61lNkWd+OQaw3
	bMJNIPN1P/j4b/alHhSnbbtVsVNYy9sIf1Y4ZzOrpqnVaJucdPAiYNU8neiduWqsaMHvqUZ4rA+
	qjzlJrHytO6PrTPyddoDWwFvItJD9fxYMFlSNYQj9mf74rGDq9W0N8UR/3vEAOgF+eDoSoKxZnk
	PeU1oC2Gv7T4Uwn2+lFUP2o+fnOeH0Zy69RfjpFOLb8lpEAEvlWGvw4W9eLcnJdvCsrnbl9Dubb
	WVn2RAFOwkk707v4I4wp+mX8AQtWYqWfRbS4RGdH8zCjx6vNolOIRAB2hUKpjerS8Asd5Th+L0Z
	fFsrmR/VcIbI6IFfHlfJPOesjI+8jwII78TX1crpZ/rdNVI0mFlPsk7g8ik+hTTNKBEHnxja6jw
	KqDvYNaCuit1DD2biim6isccOj8U
X-Received: by 2002:a05:693c:65c4:b0:381:dbde:dae1 with SMTP id 5a478bee46e88-381dbdedbf5mr1079702eec.38.1794923086299;
        Tue, 17 Nov 2026 05:44:46 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm39085303eec.4.2026.11.17.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:44:45 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v4 3/3] KVM: PPC: Hard disable interrupts before guest entry
In-Reply-To: <20261117131612.707038-4-sshegde@linux.ibm.com>
Date: Tue, 17 Nov 2026 19:11:16 +0530
Message-ID: <wlqb7eyr.ritesh.list@gmail.com>
References: <20261117131612.707038-1-sshegde@linux.ibm.com> <20261117131612.707038-4-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> After applying preempt disable patch, i.e PATCH 2/3, Christian reported
> a subsequent warning stopping his board to boot properly.
>
> WARNING: at .kvmppc_fix_ee_before_entry+0x10/0x28, CPU#0: qemu-system-ppc/4667
> CPU: 0 UID: 1000 PID: 4667 Comm: qemu-system-ppc Tainted: G        W           7.3.0-rc4-2-powerpc64-smp #1 PREEMPT
> Tainted: [W]=WARN
> Hardware name: varisys,CYRUS5040 e5500 0x80240012 CoreNet Generic
> NIP [c00000000005dc3c] .kvmppc_fix_ee_before_entry+0x10/0x28
> LR [c00000000005f298] .kvmppc_handle_exit+0x5b4/0x5e8
> Call Trace:
> [c000000086587780] [c00000000005ee10] .kvmppc_handle_exit+0x12c/0x5e8 (unreliable)
> [c000000086587830] [c000000000062068] .kvmppc_resume_host+0xb8/0x10c
>
> It triggers below warning...
>
> static inline void kvmppc_fix_ee_before_entry(void)
> {
>         trace_hardirqs_on();
>
>         /*
>          * To avoid races, the caller must have gone directly from having
>          * interrupts fully-enabled to hard-disabled.
>          */
>         WARN_ON(local_paca->irq_happened != PACA_IRQ_HARD_DIS);
>
> This happens since kvmppc_prepare_to_enter does first local_irq_disable
> followed by hard_irq_disable. This leaves a small window where interrupt
> may occur and it could set the irq pending bit in PACA.
>
> That local_irq_disable was necessary for PPC32 to track the lockdep
> state etc. On PPC64 hard_irq_disable is good enough. There is no need to
> do both. With now hard_irq_disable, doing local_irq_disable for PPC32,
> just calling that is enough.
>
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reviewed-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/kvm/booke.c   | 1 -
>  arch/powerpc/kvm/powerpc.c | 8 --------
>  2 files changed, 9 deletions(-)
>

LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


