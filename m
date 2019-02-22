Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD0C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 05:16:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593B52086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 05:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgcoVYCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593B52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445KMH0zxWzDqQ4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 16:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cgcoVYCB"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445KK74Fj5zDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 16:14:51 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id 101so542988pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 21:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=UwGRrNYqSp+7D8FhrHB70Y9Kd/LoH9J8frW17JEkkZA=;
 b=cgcoVYCBYFqD0IG6hkGBuU8dHbAgle9Ntz0rHLkLC2/7uigl82iXtqbuMjIFY5MbJH
 pjAcTK9kAjIvvVIRFcuScePZbb2Yp/kagvPC0bsKGglxEj1AiUHR+maCpZaHmUNQojTI
 43KQCTcLJZteMKSou7KfIOHD0itNBxaaP5fdaG0ost++g10r4I0Td/aBLbn0CJpVoP70
 EXz9SPVoUnCuiAxjzB9Zg7sYMuPGpoAnVt9nlMHugknrsPw8Rt69GvPiwJSR1yh2kBfi
 Qgb12dDJ1Jvi3UxYEGfByY3125qJeowtwMzoRpiN5r0bRf/9oIf0Cb6DEk2u7kJ9iROf
 JAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=UwGRrNYqSp+7D8FhrHB70Y9Kd/LoH9J8frW17JEkkZA=;
 b=JHkOdG4p9/yDzQDh1jKLgW60claZiQk1UDpFJwEw45WxFzjzKV9ylfoLxyMMvQLobl
 LKPKtu7EsG+oNigMGTb4HGr7wQMU0jSp+oEcP5hwNCQhll7gGxdfRPjx8lDEL+NKJRWX
 R5IzvaqPS269P4r+XOgXeUWyb8SIKrVEyxPzo7lZ62+QFDo7h6J7+G79NJS9vp5eVFQf
 mEq9UFbCDWTLj1UlzDJvEfMEMZ+ft0CVFJRjxUcxep1zF0wtlKu4JHPNn8nB3wmaKnMS
 8qevE0CxGabRGpn0f0zICdO9btlDsBzoDx9hn9QgKBy70lAHG29/JfVC7uJAaHDW6tmp
 G0yQ==
X-Gm-Message-State: AHQUAuZELQZYMDRBgNOXgQGgruu+/4tWi0cRx/Hxeejb3UBcpeeNWXrl
 lOgJD/IXcFQP5EDEKUdyLzfI/JSP
X-Google-Smtp-Source: AHgI3IYjRaJbYOIGwzJcexgzf0pwQwWSwp/JfXb4EEvcwZmsHygfSFM78X2eRTWlAEHVyKHZkhYfWQ==
X-Received: by 2002:a17:902:f302:: with SMTP id
 gb2mr2400827plb.51.1550812489021; 
 Thu, 21 Feb 2019 21:14:49 -0800 (PST)
Received: from localhost ([210.185.74.20])
 by smtp.gmail.com with ESMTPSA id f67sm657178pff.29.2019.02.21.21.14.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 21:14:46 -0800 (PST)
Date: Fri, 22 Feb 2019 15:14:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 7/7] powerpc/64s: Implement KUAP for Radix MMU
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>
References: <20190221093601.27920-1-ruscur@russell.cc>
 <20190221093601.27920-8-ruscur@russell.cc>
In-Reply-To: <20190221093601.27920-8-ruscur@russell.cc>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550811470.v0q5r976xq.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: kernel-hardening@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russell Currey's on February 21, 2019 7:36 pm:
> Kernel Userspace Access Prevention utilises a feature of the Radix MMU
> which disallows read and write access to userspace addresses. By
> utilising this, the kernel is prevented from accessing user data from
> outside of trusted paths that perform proper safety checks, such as
> copy_{to/from}_user() and friends.
>=20
> Userspace access is disabled from early boot and is only enabled when
> performing an operation like copy_{to/from}_user().  The register that
> controls this (AMR) does not prevent userspace from accessing other
> userspace, so there is no need to save and restore when entering and
> exiting userspace.
>=20
> This feature has a slight performance impact which I roughly measured
> to be 3% slower in the worst case (performing 1GB of 1 byte
> read()/write() syscalls), and is gated behind the CONFIG_PPC_KUAP
> option for performance-critical builds.
>=20
> This feature can be tested by using the lkdtm driver (CONFIG_LKDTM=3Dy)
> and performing the following:
>=20
>   # (echo ACCESS_USERSPACE) > [debugfs]/provoke-crash/DIRECT
>=20
> If enabled, this should send SIGSEGV to the thread.
>=20
> A big limitation of the current implementation is that user access
> is left unlocked if an exception is taken while user access is unlocked
> (i.e. if an interrupt is taken during copy_to_user()). This should be
> resolved in future, and is why the state is tracked in the PACA even
> though nothing currently uses it.

Did you have an implementation for this in an earlier series?
What's happened to that? If the idea is to add things incrementally
that's fine.

> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  .../powerpc/include/asm/book3s/64/kup-radix.h | 36 +++++++++++++++++++
>  arch/powerpc/include/asm/kup.h                |  4 +++
>  arch/powerpc/include/asm/mmu.h                |  9 ++++-
>  arch/powerpc/include/asm/reg.h                |  1 +
>  arch/powerpc/mm/pgtable-radix.c               | 16 +++++++++
>  arch/powerpc/mm/pkeys.c                       |  7 ++--
>  arch/powerpc/platforms/Kconfig.cputype        |  1 +
>  7 files changed, 71 insertions(+), 3 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerp=
c/include/asm/book3s/64/kup-radix.h
> new file mode 100644
> index 000000000000..5cfdea954418
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_KUP_RADIX_H
> +#define _ASM_POWERPC_KUP_RADIX_H
> +
> +#ifndef __ASSEMBLY__
> +#ifdef CONFIG_PPC_KUAP
> +#include <asm/reg.h>
> +/*
> + * We do have the ability to individually lock/unlock reads and writes r=
ather
> + * than both at once, however it's a significant performance hit due to =
needing
> + * to do a read-modify-write, which adds a mfspr, which is slow.  As a r=
esult,
> + * locking/unlocking both at once is preferred.
> + */
> +static inline void unlock_user_access(void __user *to, const void __user=
 *from,
> +				      unsigned long size)
> +{
> +	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
> +		return;
> +
> +	mtspr(SPRN_AMR, 0);
> +	isync();
> +	get_paca()->user_access_allowed =3D 1;

I think this is going to get corrupted when you context switch isn't
it? I would have thought a per thread flag would be easier, but maybe=20
that's difficult in your exception code... If you've got more code to=20
deal with it in a later patch, might be worth just moving all the
user_access_allowed stuff there.

Possibly you could add some debug warnings to catch double lock or=20
unpaired unlock? That could be removed or put under a CONFIG option=20
after it gets more testing.

> +}
> +
> +static inline void lock_user_access(void __user *to, const void __user *=
from,
> +				    unsigned long size)
> +{
> +	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
> +		return;
> +
> +	mtspr(SPRN_AMR, RADIX_AMR_LOCKED);
> +	get_paca()->user_access_allowed =3D 0;

Without the isync here gives you some small window to execute user=20
accesses without faulting I think. If that's for performance I won't=20
complain, but a comment would be good.

Looks good though, no real complaints about the series.

Thanks,
Nick

=
