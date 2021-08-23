Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A73C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 02:12:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C3F61371
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 02:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4C3F61371
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gtt146RQ6z2yPn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 12:12:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20161025 header.b=ieObiuqz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::132;
 helo=mail-il1-x132.google.com; envelope-from=bgardon@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=ieObiuqz; dkim-atps=neutral
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gtpmk20nxz2xfx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 09:46:44 +1000 (AEST)
Received: by mail-il1-x132.google.com with SMTP id j15so18791398ila.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Aug 2021 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DoLC1EF3mIR0GlW76GBSt/BwmQNgwhehtB+DBCRZ1+A=;
 b=ieObiuqzWjKenmS5fhA2KlEkngO02xDQilv8lvyC4D+Pum4HGeAM9YxrBJ5RPaEH5c
 PGwcQsuTYK9YcMbFvagX/tRluioVmxc7JQ/E+ZVw74iOQ6LsUBKtpPK4jaP5BXHtEL4x
 SmlfHvpixi+DllUCXuPzWjk6zA/bHNc5X7kKlPwDC7KYnYUitdlnuKoubqVwn2cV7gOG
 ulU1tZsjuJop5z0MpLhwF91iwokwJU9Z3bomsD5Bk6Y7d8MArYcUfNpo8XIx8Hi+8Kxs
 KqiQ43yho6JDD+dtIDSv50yTeg4macRVXUgyVaAuhZWmWsa290Q1RghpXqQhiy4RJxzC
 WFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DoLC1EF3mIR0GlW76GBSt/BwmQNgwhehtB+DBCRZ1+A=;
 b=DIzfboDfZZ3AsumTj2cMRMTUoJSA20x1KBOkZBrr89yOF4M1AGR3cL/+VuHMLPjHjV
 0ghzwYXWWwzi5P8tdKmf6PxQaInsHeMMwMCM8gQ7gqpBcymKhCsuLBWJPk30zexSrgG8
 sVm5X9thaoQeXgqsGmiXyIFJeZmsAvCvr7w79kZOOre4VI6s8zXOIiSm7IQyC9YUZS+S
 loYiYTQsIbFFEYb4HuIgJMmsTc2kQHb6er02XbcxhPU2elFyTj+TypouUTNm0FAXZ6aN
 coN16QWYYZEBkviU52mkhg2XLQ62ZLblagnkPNd0FiLT/qIkO0G6yRIjy0Gq7R6tYFoI
 ikgg==
X-Gm-Message-State: AOAM530kFzkHO3DJWLEiR++DmFRsLMo5Z34OrpfyjuJZJrIZhcpju7Tr
 J8fYfkviM1q8ZBHAZ1DDNEM5gmkAeLE8THsHFuniwQ==
X-Google-Smtp-Source: ABdhPJyUnfiO2iZsMzYl0bECsz2yA5wsBXuFbRA5eIkM+UStG915jCcxL3fRugWbjAHUfvQrnihJ/kDPcNr29FpWrqY=
X-Received: by 2002:a05:6e02:524:: with SMTP id
 h4mr24801438ils.203.1629762401039; 
 Mon, 23 Aug 2021 16:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com>
 <20210820225002.310652-6-seanjc@google.com>
In-Reply-To: <20210820225002.310652-6-seanjc@google.com>
From: Ben Gardon <bgardon@google.com>
Date: Mon, 23 Aug 2021 16:46:30 -0700
Message-ID: <CANgfPd_Vh52oWyMMcqL2iTVgcXQp3QDsM5MrAZxr=xe33rPMhg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] KVM: selftests: Remove __NR_userfaultfd syscall
 fallback
To: Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 24 Aug 2021 12:12:03 +1000
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
Cc: kvm <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
 Shakeel Butt <shakeelb@google.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 linux-mips@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Foley <pefoley@google.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Oleg Nesterov <oleg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 20, 2021 at 3:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Revert the __NR_userfaultfd syscall fallback added for KVM selftests now
> that x86's unistd_{32,63}.h overrides are under uapi/ and thus not in
> KVM sefltests' search path, i.e. now that KVM gets x86 syscall numbers
> from the installed kernel headers.
>
> No functional change intended.
>
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/arch/x86/include/uapi/asm/unistd_64.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
> index 4205ed4158bf..cb52a3a8b8fc 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> @@ -1,7 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __NR_userfaultfd
> -#define __NR_userfaultfd 282
> -#endif
>  #ifndef __NR_perf_event_open
>  # define __NR_perf_event_open 298
>  #endif
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>
