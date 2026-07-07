Return-Path: <linuxppc-dev+bounces-23720-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53615C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:35:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvmzg3x5Fz2xWY;
	Wed, 08 Jul 2026 02:35:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.18.0.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783442111;
	cv=none; b=a4tIstwcBiCOU6vwWIj4NFDSWrF4SXDwl7WIezNKkOOYC05ErBWx5Gdlbnh9X/EAuhYV6WnjVo+6OdeHw3dI/B/EDG8qTgF/r9QC58znCqtUk/5HfRDG764e6g5nHadpK77hQRIXYUmFQKR6BXLWdTW9rdwZAMlGENx9Dt4wGPVtnyqVfB65UgFCxG6TZQWxylarti7byu0Lb+pSp/VjC3lwZLTorA4047W4lDufbXmnZpuBsqSgI9bnDIj7j8VqnxPUVGrosvOtMZPnRu/oC8++jTNRVcEQpamJFYZweaBAxRFMxJ0ZLCPZSN/63GRS+CjFXQYRTumqgmFh0Pi+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783442111; c=relaxed/relaxed;
	bh=e4Suikc9Du36b12fhitRStEw54yxIuK4FWQmK9vNKyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QD9bHnDT94uaYDEs+B9pdFtVmtIKqBPjLbicA1q20OQqJYKRomSF889sdCi7XnaSssEvSoDEHRd3mpmTsqg8ICGVBxOIJFvHW6Tn4h1C/OB+Qu/p/0Ikfu251iw7rev0H0sisLmChkkMwqqziGMsHCQgR4rHbmrg5o4DNi/8Dlm5lUEyFuSMJKOo5UeoILYhErJ3+ihXaBhbVlS44+32n5ztwBh4UjoiG7pDh/CLFcDSMVZ1nNExtNuy/+oV5jaMvOI9aZQI6mtimKKGytlzLCtGe+5dvGww2PrF8GtVTLcXV/5csNnv4OnOZQ6Wy6z2yRu0Zw4FMgJfzCxwStvnaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=212.18.0.9; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org) smtp.mailfrom=nefkom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nefkom.net (client-ip=212.18.0.9; helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net; receiver=lists.ozlabs.org)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvmzf2P3Nz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 02:35:09 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gvmzY6Tmdz1r6RW;
	Tue,  7 Jul 2026 18:35:05 +0200 (CEST)
Received: from frontend04.mail.m-online.net (unknown [192.168.6.183])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gvmzG5557z1r6R0;
	Tue,  7 Jul 2026 18:34:50 +0200 (CEST)
Received: from localhost (dynscan4.mnet-online.de [192.168.6.88])
	by mail.m-online.net (Postfix) with ESMTP id 4gvmzG1DbMz1qqlR;
	Tue,  7 Jul 2026 18:34:50 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan4.mail.m-online.net [192.168.6.88]) (amavis, port 10024)
 with ESMTP id kJKRVuiU1jub; Tue,  7 Jul 2026 18:34:46 +0200 (CEST)
X-Auth-Info: Y+4plMtLHRkNw3dtBnoz0w3GIcHXk+/2CL/apTnD9OFXK3ANubt/TudTefKyxyOF
Received: from igel.home (aftr-62-216-202-200.dynamic.mnet-online.de [62.216.202.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue,  7 Jul 2026 18:34:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id B873B2C0AF2; Tue, 07 Jul 2026 18:34:45 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
  maddy@linux.ibm.com,  mpe@ellerman.id.au,  npiggin@gmail.com,
  ryabinin.a.a@gmail.com,  glider@google.com,  andreyknvl@gmail.com,
  dvyukov@google.com,  vincenzo.frascino@arm.com,  oleg@redhat.com,
  kees@kernel.org,  luto@amacapital.net,  wad@chromium.org,
  mchauras@linux.ibm.com,  sshegde@linux.ibm.com,  thuth@redhat.com,
  ruanjinjie@huawei.com,  akpm@linux-foundation.org,  macro@orcam.me.uk,
  ldv@strace.io,  charlie@rivosinc.com,  deller@gmx.de,
  kevin.brodsky@arm.com,  ritesh.list@gmail.com,  yeoreum.yun@arm.com,
  agordeev@linux.ibm.com,  segher@kernel.crashing.org,
  mark.rutland@arm.com,  ryan.roberts@arm.com,  pmladek@suse.com,
  feng.tang@linux.alibaba.com,  peterz@infradead.org,
  linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
  kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
In-Reply-To: <akyWi0a69Az59X5Z@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
	<87wlvazrdy.fsf@igel.home>
	<1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
	<87wlv9tiyy.fsf@igel.home>
	<akyWi0a69Az59X5Z@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Date: Tue, 07 Jul 2026 18:34:45 +0200
Message-ID: <875x2qu5ay.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
MIME-Version: 1.0
Content-Type: text/plain

On Jul 07 2026, Mukesh Kumar Chaurasiya wrote:

> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index fc636c42e89a..b6373bae4524 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -286,14 +286,6 @@ static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
>  
>  static inline void arch_interrupt_async_exit_prepare(struct pt_regs *regs)
>  {
> -       /*
> -        * Adjust at exit so the main handler sees the true NIA. This must
> -        * come before irq_exit() because irq_exit can enable interrupts, and
> -        * if another interrupt is taken before nap_adjust_return has run
> -        * here, then that interrupt would return directly to idle nap return.
> -        */
> -       nap_adjust_return(regs);
> -
>         arch_interrupt_exit_prepare(regs);
>  }
>  
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index fb42a664ae54..1b45a49e9bed 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -246,6 +246,7 @@ interrupt_handler void func(struct pt_regs *regs)                   \
>         instrumentation_begin();                                        \
>         irq_enter_rcu();                                                \
>         ____##func (regs);                                              \
> +       nap_adjust_return(regs);                                        \
>         irq_exit_rcu();                                                 \
>         instrumentation_end();                                          \
>         arch_interrupt_async_exit_prepare(regs);                        \

This allows the system to boot normally.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

