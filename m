Return-Path: <SRS0=sHkL=Q6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA54C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 14:39:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294EF20684
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 14:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldeiozMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294EF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4469pP5jCzzDqW7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Feb 2019 01:39:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldeiozMw"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4469mb2FKvzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Feb 2019 01:38:06 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id h8so1934076pgp.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 06:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n6FUQSYQvUFEycWA5KwWZpSsaRLlBroz3IlvJU3oqWw=;
 b=ldeiozMw5Dv/aPnge0ahHdfu2zXrCzwVQvoCUE3DUbUL27J8OQE7AnMnb4KA1yK5Pe
 dVVz2+VfONQ/jeM6oh4j7Iv/KX9hbAtoVVGIbeQjwi0CgsICN+4xrfB5Je/4obJQZR8e
 eOfvaAmYUU2mrcRIKNg0rST8n5SowV1JDN5doew4JXUNNQ1/2f/8M9EmglhSoxfJC6xb
 0rdulcsTRW+bQ7+I8JwakOLxSY3WHCBxEFxIB2AjWYHrMfFaOIwhwr9tcM3tTxa/Nlre
 IdpjtNJ2Jl+34UAz3CZeBJxdEzUywBml6WZF3X+fr7TJrQMYqmxUOqAEK3umJLWC220C
 XeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n6FUQSYQvUFEycWA5KwWZpSsaRLlBroz3IlvJU3oqWw=;
 b=d7v9cJ6eC+HR7TDWZj/Xi88yRtBrLqj/F+9CT9jmnBqnDXYuMfVCiZCDhVCnC0J/fb
 8C1p4kqYSoDPWtkjV1UApMm9GmPvrFHVF2zzCk2gUbAovTJ+ixGh8UxCUjlMPyqPgY7j
 NtfAzADQyWJnndStkIogdvXgdis1qxhpAJ9csBKFKxWZgmWN9tQVvfNBd8lDL7al5PNK
 Q8QqBJFhRU0X3BIN42NdzP5TWGBR+ophRdaVBGiz5tEjwxsFtds6d9rWylthPZRSQB6C
 Z6dmaPmv3tq1hnVjISIauRI5uepwKhvCeJok4eECJiD1DjZY5Opo9Uj95molIQRnTfTW
 9sVQ==
X-Gm-Message-State: AHQUAuYm13byJeaeOP78rlpcXDgmCX5xXTUqAGRVqDI6+6s+5OwoF9dD
 kYDQOQqTy+AtJLeWhA1dbgKRIn7eenHQnbNBzc4=
X-Google-Smtp-Source: AHgI3IaTEs9wR2DkVIfSbPR8akoMBe5TzeNXZfOrzZslm6+igFUCmJYaI9AtkqFeHn9T6UXb3i7TENBXyvdFEYmCsJo=
X-Received: by 2002:a62:b502:: with SMTP id y2mr1993591pfe.212.1550932684655; 
 Sat, 23 Feb 2019 06:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
 <75e9238a-f168-b90d-e1f1-89938e6df57a@redhat.com>
In-Reply-To: <75e9238a-f168-b90d-e1f1-89938e6df57a@redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Sat, 23 Feb 2019 22:37:53 +0800
Message-ID: <CAOLK0pzvtO6Aj0T7uKwOHdNcsnM_Fq_wPL1VUTwF347fYA5Vdw@mail.gmail.com>
Subject: Re: [PATCH V3 00/10] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>,
 will.deacon@arm.com, christoffer.dall@arm.com,
 "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, Sasha Levin <sashal@kernel.org>,
 sthemmin@microsoft.com, the arch/x86 maintainers <x86@kernel.org>,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com, jhogan@kernel.org,
 linux-mips@vger.kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>,
 marc.zyngier@arm.com, haiyangz@microsoft.com, kvm-ppc@vger.kernel.org,
 bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 ralf@linux-mips.org, paul.burton@mips.com, devel@linuxdriverproject.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Feb 23, 2019 at 2:26 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 22/02/19 16:06, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > This patchset is to introduce hv ept tlb range list flush function
> > support in the KVM MMU component. Flushing ept tlbs of several address
> > range can be done via single hypercall and new list flush function is
> > used in the kvm_mmu_commit_zap_page() and FNAME(sync_page). This patchset
> > also adds more hv ept tlb range flush support in more KVM MMU function.
> >
> > This patchset is based on the fix patch "x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT".
> > (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1939455.html)
>
> Note that this won't make it in 5.1 unless Linus releases an -rc8.
> Otherwise, I'll get to it next week.
Hi Paolo:
      Sure. Thanks for your review.

-- 
Best regards
Tianyu Lan
