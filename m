Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EAFC33CB1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 07:13:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E37820748
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 07:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqrRxq8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E37820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ywQN18kNzDqTW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 18:13:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ywMh1hvrzDq5n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 18:10:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=sqrRxq8y; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 47ywMg6t83z8tDZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 18:10:55 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 47ywMg6SjZz9sRR; Thu, 16 Jan 2020 18:10:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d42;
 helo=mail-io1-xd42.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=sqrRxq8y; dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47ywMg2wRpz9sNx
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jan 2020 18:10:54 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id t26so20644574ioi.13
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2020 23:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y4WPM7oPAIhxp0xp0soXNk9qMDGvHyhQqiJ5YsYVn20=;
 b=sqrRxq8yqk3e1VLm8m4cmK4+hWKAmhTVZZelJG5Er9PstlXqlI0PCoVqHNU8NC2cLE
 dSocDAjT07HXzqCKp0hJ4IWa4ImjKUq0oq1WL0syaE2UbVBnpdUPVZ97XklSFdvuhDuS
 WnRm45WsF1VgR+Uu3szcO7p0N0lrpf9LFsfec/cJSPi3VP6WZU2buxfpZTa8e8GtXotp
 Rz/p+pJdZAvcF6s51N3U6w7vr5uPrWlnZXfmDpWcDqy9AGuWwRra2xityEdeUamcapNt
 G4WTrWHras1aWZOVKL6ZIls6yqJJPX4ELrDYdsh9GkrwuW80MJbn3QBTjtId/kJHpub2
 QYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y4WPM7oPAIhxp0xp0soXNk9qMDGvHyhQqiJ5YsYVn20=;
 b=r8ngLpX+EHKO3gtpf8yByDR2Ud8e/ufgEY80XyVHl0SRsTpTKW1maYRZTCvj0RzJnZ
 wFG+amKD8Y2J4TI/3rV3/3cFDxDLH/2JtaI/50pbdiAoNigEvuT1d1QV0vhEVaK5zRCE
 l3LlY335aX6CLYfsCwzZRW3RbefChIeCRcwX03rlB0pnqY8OUFvWlcfY90OiALB7mSdE
 pidn5RWc1ekKJK/zUrmddrxCtoAvPNocRkE77UrleF41MKlRbgHNqm93qqTm/5P4VsPj
 HuxLcmLazFRhTXJSn6rShSuEZpvvWfWeELeVCVtCHV+je3k2DeJshDFDGW6zCSboO8YI
 pbAg==
X-Gm-Message-State: APjAAAU9THDP1MDZHoQVmeOf6k6V+x+gMSbDBsNLJNxJj1lhlxtatZ8Q
 6BDKaPBrpyoW6kP7UC6OLHm3hwioIZpzvnzLi8Q4DNIAe1c=
X-Google-Smtp-Source: APXvYqxU5weeP2xr4J//OwvNAkMKUQ/mHPhFBo5SF5+HQWed337nZulfGMrsE9Iw7g+N5cC3KCAvM+4oFEH2u6YAPpk=
X-Received: by 2002:a5e:970a:: with SMTP id w10mr25119092ioj.195.1579158651525; 
 Wed, 15 Jan 2020 23:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20200116014808.15756-1-mpe@ellerman.id.au>
 <20200116014808.15756-7-mpe@ellerman.id.au>
 <871rs0knbj.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <871rs0knbj.fsf@dja-thinkpad.axtens.net>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 16 Jan 2020 18:10:40 +1100
Message-ID: <CAOSf1CGnYqa7-QA-hK2OxymOQM8RS55xXq4cOvtou9nGfSWHgA@mail.gmail.com>
Subject: Re: [PATCH 7/9] powerpc/configs/skiroot: Enable security features
To: Daniel Axtens <dja@axtens.net>
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
Cc: Nayna Jain <nayna@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 16, 2020 at 4:00 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
> > From: Joel Stanley <joel@jms.id.au>
> >
> > This turns on HARDENED_USERCOPY with HARDENED_USERCOPY_PAGESPAN, and
> > FORTIFY_SOURCE.
> >
> > It also enables SECURITY_LOCKDOWN_LSM with _EARLY and
> > LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY options enabled.
> >
>
> As I said before, this will disable xmon entirely. If we want to set
> this, we should compile out xmon. But if we want xmon in read-only mode
> to be an option, we should pick integrity mode.
>
> I don't really mind, because I don't work with skiroot very
> much. Oliver, Joel, Nayna, you all do stuff around this sort of level -
> is this a problem for any of you?

Keep it enabled and force INTEGRITY mode. There are some cases where
xmon is the only method for debugging a crashing skiroot (hello SMC
BMCs) so I'd rather it remained available. If there's some actual
security benefit to disabling it entirely then someone should
articulate that.

Oliver
