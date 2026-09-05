Return-Path: <linuxppc-dev+bounces-26581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1290C624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 04:34:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcL825CqPz2xlJ;
	Sat, 05 Sep 2026 14:34:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788582850;
	cv=none; b=M6lIzJ+PMDOb9zzAGhwWhyoZBSnPL+3IBviPsZd7tnxb7YNKS+e32WVGquI+PjDtrRggPzY2fJ6iJ3UWJRxE8zsjtZJok/OFk42vOgKjculHznvHHuIggwI5Pr55EFrbo5GASwiFi3pCrunSD8ZPk3Iyczrqgijt7WsL2fwO/e++hSs/YvYIq8zk4PYTOzvexbKUrlR1hSTjeZxjExNNQnwOsxRAFfuzjNNGzk9o39e+JerkaUWjxGoWA66KxGu08nxDnPv4E70HEuyIAl/v+KP473M8FPWcfM56B48xSuahbwoB0NFksZqS6nDDy0b7PeRp1Uj5e0GqixZ3BykWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788582850; c=relaxed/relaxed;
	bh=7HIfRyXPFfY53dpCllCwbDTWA+5luzyqK8OcV2My+DA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=EMTof71z2rdr/Uy+icV7kpi8RfbKKOE50nmWpPbM29EYLEjJgSv9ge4ZQrxJb0IPthJFMNJfjQ/756IPKrAh090Ro2YSlHeyNFf+oXyDR36DtoZCX4u2ByYzBzCZH5lz6E9BnjM1QbkH0Ymiy13OuUT9lTaYlf8EiKqCLk7+HrBypWN4eevDwIOmVy1DP89aY2cf99QDDeVovTcJLmR5PPaPXsQE4fiwvRFciyJYNhk2DlEq1CdDEE9aYdTBwYaSf060uEe1Y02Y619TpMkpSuvh7aiPY68NyRbzf99MMc5653ojpS+zOtQnnWXgjxCS7i9jwsmUiFTXRZGVoNcAPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GpipUXRu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GpipUXRu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcL8102Kxz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 14:34:08 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1634410a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 21:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788582846; x=1789187646; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7HIfRyXPFfY53dpCllCwbDTWA+5luzyqK8OcV2My+DA=;
        b=GpipUXRuLH4YgR3hNWS2YA2H9lXCAz380oZBR9sV749NLniYEbCRzcfR4qcTM+AapB
         Iage2YTLO3kLerNhWnWdwKGnng1RmqwW0uaxM9YvgEetZzq5FhD8z0FncZFWrIBJ24vN
         iVtIejK88Zwf2iInJsG9x5vHeY58DXbtwjOS550I8U5piDmizPL+pGf4A0zVlZ2gCQxW
         H0ZGIvJRGVU5TK8OzQE20yfJXGgUBnYQCB038zXnIaTKYEZRKS2XMD2qw20mRiTYwMg1
         nN8Hwt8bTV3uQ0eodKUR8mzGxg6SBVr0ZkhS/XB3/jVoGgw8KmrzJM3MbmqdoJiw9BaB
         7lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788582846; x=1789187646;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HIfRyXPFfY53dpCllCwbDTWA+5luzyqK8OcV2My+DA=;
        b=Gk2rwcqSlsG8ezsrZ/EQ6gpBeOqdDjPpaWxdYo2rxbN/WhbTJLVZx7J/1yPMKbhd9I
         rlSWE1kia+cN2P+CA1eGrh6uKDzsKRBk2IGrG2PYHuLYF1IRCCEtILEb/jg+aB8y6Uvn
         5ERWD+CBiAqlp4+NltBgT3CnIRNfjJGcF0JkVH4TseP6Pia1nTliKanEJhJFYyTXfaoC
         ODDwHgV1k1X1+sY+jFNTNfsj/OakpvPD7aDz+OoAX7KAha1p53WRQphg9Skw3MKumGgi
         BTrcwN32JLh68UOb4vSwP4dNWlPUaFbTZMsb3nMzuAjnbeCqkPXnvwRYKbspBlgu0OLW
         zgrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBYky3oQ1qlEgTQ0IeJYRimFRH11ub5cDVd5uKQdJxhYILc+mQDGcBbHcd+lRrOPxiTuSwnqPrTzbF1V8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kHsuuLl8Xbg4hFMKu34pjOnKMv1Eqnfx8PW9JLe5gDiZWB0wtp
	J5GOiXMO9hQaX7V67DHGy2Rf89i0Dh4G+uKv0z8DR/RcH7erS1lA1uWK
X-Gm-Gg: AYBFou3xtFUl203X8zkZ041+Ilir/KN8mjVxomHSs1APPW/1SsGQQ5jI7wzVwp2ZmQ0
	qJvyAcM8aVbTx/D5OvFcyr+vgSjacTcp/UBjhrIFGJDni00141HfuEyQX3cFAj0G1XYUYOwfCpV
	6kIqVVKkw56R3VmxPNn2SdJ+JQtPcw507X2fgo3gXNRfRjnvAm3pOHRYM8Y7FL1Y/g1DgDPSjIu
	4EmQum1zCwFyzQx9iiGg8w9dCP4OGIYFJ6RIaAzyKWeDY/7pcYNAw2gvsc7T06c0PK/L/G3QwoX
	LOc7OHMonsyvTR0fJ/3cgpg2mWdHTmmhih7KQmGuO28ar0KTUu4XAtrs8TkP+dF0YnLDWDHs6uw
	ScbQRhYj7w4qqA+MCQOUj7BLNqEygZNLDvo3D7zffL5PHsKR3ppJQ/1S25V1Jeyo87IT+jUUzwx
	aGYzEloX8eeN0b7evCUX0A4m/5cAyXyQrx7csFPkgevZe1jJSt7hmtpPogMzNyTKXcOcyanWsFC
	qEDmtoK03qOe5uOF0dPRsyalUiynBVnFJ/80piurIvn
X-Received: by 2002:a17:90b:580e:b0:398:c3c9:d0ae with SMTP id 98e67ed59e1d1-39b25ee242bmr14159129a91.0.1788582845678;
        Fri, 04 Sep 2026 21:34:05 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm9897983c88.14.2026.09.04.21.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 21:34:04 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org, "Nysal Jan K . A ." <nysal@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/entry: Fix double accounting of user time on interrupt entry
In-Reply-To: <20260904025831.3439809-1-aboorvad@linux.ibm.com>
Date: Sat, 05 Sep 2026 10:01:35 +0530
Message-ID: <cxustj2w.ritesh.list@gmail.com>
References: <20260904025831.3439809-1-aboorvad@linux.ibm.com>
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

Aboorva Devarajan <aboorvad@linux.ibm.com> writes:

> Since the switch to generic entry, an interrupt from user mode
> accounts user time twice: once in arch_interrupt_enter_prepare()
> and again in arch_enter_from_user_mode(), which irqentry_enter()
> invokes for the same interrupt:
>
> 	arch_interrupt_enter_prepare()
> 	  account_cpu_user_entry()		/* first */
> 	irqentry_enter()
> 	  arch_enter_from_user_mode()
> 	    account_cpu_user_entry()		/* second */
>
> The second call charges the same interval again, because
> account_cpu_user_entry() accumulates the time spent in user mode
> since the last return to user space.
>
> The two calls come from the GENERIC_ENTRY preparation series,
> where each step was a no-op on its own. Commit 09a9d3a8499d
> ("powerpc: introduce arch_enter_from_user_mode") added the hook
> with the user-time accounting in it, but nothing called it yet.
> Commit 893082ac769b ("powerpc: Prepare for IRQ entry exit")
> copied interrupt_enter_prepare() verbatim into entry-common.h as
> arch_interrupt_enter_prepare(); that copy was equally unused, as
> handlers still called interrupt_enter_prepare().
>
> Commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> made both live. On the syscall side it did the full conversion:
> system_call_exception() now accounts once through the hook via
> syscall_enter_from_user_mode(), rather than calling
> account_cpu_user_entry() directly. On the interrupt side it
> switched the handler macros to arch_interrupt_enter_prepare()
> followed by irqentry_enter(), which also runs the hook, but the
> accounting in arch_interrupt_enter_prepare() was not removed to
> match. The double accounting starts with that commit.
>
> With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y this roughly doubles the
> reported user time of any workload that takes interrupts. The
> other accounting modes compile account_cpu_user_entry() to an
> empty stub, so they are not affected.
>
> Remove the accounting from arch_interrupt_enter_prepare() and rely
> on arch_enter_from_user_mode(), which already runs for both
> syscalls and interrupts. The duplicate account_stolen_time() call
> is removed the same way.
>
> On a pseries LPAR a busy loop reports 6s user time in 3s elapsed
> (~210% CPU) before the fix, and 3s (~105% CPU) after it:
>
>   $ python3 -c 'while True: pass' &
>   $ sleep 3; ps -p $! -o etime,time,pcpu
>
>             ELAPSED     TIME  %CPU
>   Before      00:03 00:00:06   210
>   After       00:03 00:00:03   105
>
> A 50% load reports ~70% usr / 30% idle before the fix, and
> ~49% usr / 51% idle after it:
>
>   $ taskset -c 6 stress-ng --cpu 1 --cpu-load 50 &
>   $ mpstat -P 6 1
>
>             CPU    %usr   %idle
>   Before      6   69.74   30.26
>   After       6   48.51   50.50
>
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---

Looks good. Thanks for the descritive commit msg!

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

