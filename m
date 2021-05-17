Return-Path: <SRS0=r+Zg=KM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B10C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 11:00:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEEA611C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 11:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEEA611C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FkGQ303bVz301N
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 21:00:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VI5Jgnrg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=VI5Jgnrg; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FkGPR0C2Hz2yWJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2021 21:00:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FkGPL2v7fz9sRK;
 Mon, 17 May 2021 21:00:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1621249208;
 bh=2Y30Sqquhl/9Xg91SIhYLicrc/NfN9wZV7c3dBixuaM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VI5JgnrgZ4xyeV2fG6OMRkRLi9t+nx0yM9RE5QaorROoFyOWMK4Ia15ckRi54qvrV
 M+w6tLOpjdtpqYyR1YjTNAeSnVWRR5RIXgDzrQsPQt1nWa9Y9ev6r0llmCCwpRp9u5
 tukI4W67KVjdGfCTlUB5kG8MvJKR3kFs+hSRt4D/EmpGx3efFAQOpCyG2JyaKPFkMy
 t9NVJ2TggtS98H21zmNkHIxEfdtrweokHsKipNrE4CwK0s04IJEEuV0a8YFGlXvec8
 FIQmJTzYp/lViFdUAP3QE4RTv9nQWCfzHBBAdqoMSj7x75+zdb+N43yN/oAtcQOUQd
 lnqc/+sEjPGQA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ondrej Mosnacek <omosnace@redhat.com>,
 linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
In-Reply-To: <20210517092006.803332-1-omosnace@redhat.com>
References: <20210517092006.803332-1-omosnace@redhat.com>
Date: Mon, 17 May 2021 21:00:04 +1000
Message-ID: <87o8d9k4ln.fsf@mpe.ellerman.id.au>
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
Cc: selinux@vger.kernel.org, netdev@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Casey Schaufler <casey@schaufler-ca.com>,
 Ingo Molnar <mingo@redhat.com>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ondrej Mosnacek <omosnace@redhat.com> writes:
> Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> lockdown") added an implementation of the locked_down LSM hook to
> SELinux, with the aim to restrict which domains are allowed to perform
> operations that would breach lockdown.
>
> However, in several places the security_locked_down() hook is called in
> situations where the current task isn't doing any action that would
> directly breach lockdown, leading to SELinux checks that are basically
> bogus.
>
> Since in most of these situations converting the callers such that
> security_locked_down() is called in a context where the current task
> would be meaningful for SELinux is impossible or very non-trivial (and
> could lead to TOCTOU issues for the classic Lockdown LSM
> implementation), fix this by modifying the hook to accept a struct cred
> pointer as argument, where NULL will be interpreted as a request for a
> "global", task-independent lockdown decision only. Then modify SELinux
> to ignore calls with cred == NULL.
>
> Since most callers will just want to pass current_cred() as the cred
> parameter, rename the hook to security_cred_locked_down() and provide
> the original security_locked_down() function as a simple wrapper around
> the new hook.
>
> The callers migrated to the new hook, passing NULL as cred:
> 1. arch/powerpc/xmon/xmon.c
>      Here the hook seems to be called from non-task context and is only
>      used for redacting some sensitive values from output sent to
>      userspace.

It's hard to follow but it actually disables interactive use of xmon
entirely if lockdown is in confidentiality mode, and disables
modifications of the kernel in integrity mode.

But that's not really that important, the patch looks fine.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
