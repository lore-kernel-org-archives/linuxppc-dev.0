Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A9C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:32:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4342085A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlW1M+f3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4342085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Kny74chzDqMB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 01:32:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rlW1M+f3"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444Km43RN7zDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 01:31:15 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id d25so3652096pfn.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
 :message-id:content-transfer-encoding;
 bh=r5aiFZMDOJD+ghCvqiv50PT7tb+oSSFn/A2Ia2QiwR4=;
 b=rlW1M+f37455V1ZMSKxHgNkOz2tG0zOmk6G7CcFiihR4LHoKN9t5fwtXX3AghBEcd+
 LmgIAye/bVNHLNrqu8++vGd4EvXaj/2vHbMYzklLutaqyLB77W2vV6ZBOnifroP5It1G
 gFSWvzn5YwFJKpd4WbXrdATBzYjnJO5D5N0JuFl3opyiMsrBdvJy/Vc1pG6c8XvtW9gx
 hrUYaKA9kd8iaK7+JgB3+3J1LpyEav9lkJkMoNDZAFBehK59Nwj7pGCihbVK6BXZnr3E
 KOmh6p7ClXcQA6sgc76+ZRCADTwo7kYWNdqBJlK0t9Ilxjv5KhZx5QRxKaN8G7kO5q/e
 ft1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=r5aiFZMDOJD+ghCvqiv50PT7tb+oSSFn/A2Ia2QiwR4=;
 b=KVySM6eJ4h+L7xyYNLBC0kyjkV7zBk9xqPS4TNHsOeuREJAhSQ+WIpk87x1r+wtGgw
 P/9u5uyz7+zs7zAwOE/Zp+/7yIuEDONSLHm10PWu3Zb9VCc2Eo9CEjy+AhR3lVFKBXdu
 XhgHZAOi13CyzIS2xOTkB8MF3B8YquLdZhN7yQdIB0wgVhBPo8T8aXU0DsdhtAUh3NXq
 4DmwM2Xcu3algnsfr/h1SBG4TGHIYEGJpwh7WtZCmo67UGjNKgFjTvlonxgqLqPrGYDj
 8jHWU5rYRuLtszyKWpDvxw9ILCYqM9khv9BquM4/x0lZOCBEmBk/gPyl4pU3/7SD2K3Y
 OXgg==
X-Gm-Message-State: AHQUAuZt1Md3plifbvqvusGVDYJ/fiWomj4qyrzi09peotz/8ISSgNXK
 ZvkfTyjD8yC9+K9znsNe8B1fQ2N1
X-Google-Smtp-Source: AHgI3IaLddFgm+A4tlowLsyKrKPA0J4PFG3ATkzAjYfudyzh4jm9QeBLq8y4j9IPZBbPNmrBKaOJsA==
X-Received: by 2002:a63:374e:: with SMTP id g14mr30016550pgn.59.1550673073737; 
 Wed, 20 Feb 2019 06:31:13 -0800 (PST)
Received: from localhost (60-240-166-206.tpgi.com.au. [60.240.166.206])
 by smtp.gmail.com with ESMTPSA id c4sm20795268pgq.85.2019.02.20.06.31.12
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 20 Feb 2019 06:31:13 -0800 (PST)
Date: Thu, 21 Feb 2019 00:31:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/4] powerpc/64s: Fix HV NMI vs HV interrupt
 recoverability test
To: linuxppc-dev@lists.ozlabs.org
References: <20190122064618.1510-1-npiggin@gmail.com>
 <20190122064618.1510-2-npiggin@gmail.com>
In-Reply-To: <20190122064618.1510-2-npiggin@gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550672893.su6y10x0gg.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin's on January 22, 2019 4:46 pm:
> HV interrupts that use HSRR registers do not clear MSR[RI], but
> NMI entry code is not recoverable early on due to both using HSPRG
> for a scratch register.
>=20
> This bug means that a system reset or machine check can cause silent
> data corruption (due to loss of r13 register) if it hits in a small
> window when taking an HV interrupt.
>=20
> Fix this by marking NMIs non-recoverable if they land in HV interrupt
> ranges.

Hum, I had a v2 that I didn't send properly with a small compile fix,
but I've also just noticed this:

> +void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
> +{
> +#ifdef CONFIG_POWERNV
> +	unsigned long kbase =3D (unsigned long)_stext;
> +	unsigned long nip =3D regs->nip;
> +
> +	if (!(regs->msr & MSR_RI))
> +		return;
> +	if (!(regs->msr & MSR_HV))
> +		return;
> +	if (regs->msr & MSR_PR)
> +		return;
> +again:
> +	if (nip >=3D 0x500 && nip < 0x600)
> +		goto nonrecoverable;
> +	if (nip >=3D 0x980 && nip < 0xa00)
> +		goto nonrecoverable;
> +	if (nip >=3D 0xe00 && nip < 0xec0)
> +		goto nonrecoverable;
> +	if (nip >=3D 0xf80 && nip < 0xfa0)
> +		goto nonrecoverable;
> +	/* Trampolines are not relocated. */
> +	if (nip >=3D real_trampolines_start - kbase &&
> +			nip < real_trampolines_end - kbase)
> +		goto nonrecoverable;
> +	if (nip >=3D virt_trampolines_start - kbase &&
> +			nip < virt_trampolines_end - kbase)
> +		goto nonrecoverable;
> +	if (nip >=3D 0xc000000000000000ULL) {
> +		nip -=3D 0xc000000000000000ULL;
> +		goto again;

Tried to be a bit too clever here. The 0xc... vectors also have a=20
+0x4000 offset so this won't catch them properly. I'll respin.

Thanks,
Nick

=
