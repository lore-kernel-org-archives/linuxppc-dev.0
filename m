Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C0C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 15:18:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90192081B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPQD/mTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90192081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434knB55ntzDqBV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 02:18:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPQD/mTm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=radu.rendec@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPQD/mTm"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434kkM75mZzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 02:15:55 +1100 (AEDT)
Received: by mail-ot1-x343.google.com with SMTP id f18so22228725otl.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 07:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KeXQOHrwI1qnVcz4RCMmqmBxEFqkPfrI1P2vYoZKDj4=;
 b=hPQD/mTmeWw5Jwp+5LOYyw4uEIqShrum4326eXtwTAExQw0nL+fLAMfi5xw7qLuiZS
 Sfb25Op4/TzfjsgEyPApgPDlsHJkaQMheem8pFIhYa2jKfs6d3wb9k7+CB0bB4e1xvkB
 H4w1S24SGZR5KUqvjfUz55RKHdJLuu4cGo+ned6sS78yFeeAvnhB/jG6jH/mgdykUHYS
 GxRKllxSlKkEAWrCzPIOQLx/IAs6EiWr+zS/nJ1BIdTyc7SGZay42BZtuS4Mageesut5
 A9/D1YsVbmYI8Z/F6n+XTujGbZfb0t3yU6WEQNZR+0TPV8ipwgfOir221RhERVWFb/MN
 5JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KeXQOHrwI1qnVcz4RCMmqmBxEFqkPfrI1P2vYoZKDj4=;
 b=TpsKn7EB97WvTrNC/7cAkPCsgbUg35oZXkrEnmGwMde5XB3hNXkvzZXJxV6FTvnY1Q
 l5tMNNyZqPkOCMwaRaCcqCzrchy2ivrZXFxZjqMp3FA8bNwRHoApszUssyvE4MMRAQXY
 JPdP0TqKIqGTh3BZNeqYus67zM3ROYpfQChR967ij0zZQsOagrV5qw5BJBomu8RViEI3
 vjrfSIekb4fHiIL4A1Gm70l1o8rtvWckULhrItAhLsXh1QSvrliJDyvUgvlaZJ22LiKb
 TADJrv2HODzx4AMDMxKhX3+4kRoO16j+KnqqLHlbxv59mOyxw3f1D6Y4V7hRi7gi6UVi
 Zxng==
X-Gm-Message-State: AA+aEWbGQZ6PDvVxj/X3b7J0F4z+y3oZYWHUsyBIquTY1UifVkNb/4YE
 oPSYZZ1/BmdW86x4NjWlxcW6TFRWlgzJub+VcZA=
X-Google-Smtp-Source: AFSGD/UBufZpLHJJ3C2IP/dodDD/rSitiGl5J21+A0TlEsW/Ga9KbT9W2jK73wH/ayEz8fTPq/2RUp/aup9G0VbFmlY=
X-Received: by 2002:a9d:6191:: with SMTP id g17mr21417980otk.56.1543418153663; 
 Wed, 28 Nov 2018 07:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20181128032048.11665-1-radu.rendec@gmail.com>
 <8736rlh3g1.fsf@concordia.ellerman.id.au>
In-Reply-To: <8736rlh3g1.fsf@concordia.ellerman.id.au>
From: Radu Rendec <radu.rendec@gmail.com>
Date: Wed, 28 Nov 2018 10:15:42 -0500
Message-ID: <CAD5jUk8gZuq8THDOLPgCPxs1Ss3zTPFJvdXbCn=PzMBUZwwHXQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fix NULL pointer access in PowerPC MSI teardown code
To: mpe@ellerman.id.au
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
Cc: agordeev@redhat.com, paulus@samba.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

On Wed, Nov 28, 2018 at 6:00 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Radu Rendec <radu.rendec@gmail.com> writes:
> >
> > The assumption in arch_teardown_msi_irqs() is wrong and results in a
> > function call on a NULL pointer. An example of how this can happen is
> > included in the actual patch header. In my case, it happens when the PCI
> > hardware is configured during kernel start-up, because my controller
> > doesn't support MSI and the ops are NULL.
>
> What hardware are you on?

I'm on Freescale MPC8378 - old stuff, but still going strong :)
The MSI capable device is a Broadcom PEX 8613 (a 3-port PCIe switch).

> > I'm proposing the attached patch to fix the problem. It basically just
> > checks the pointer before the function call.
>
> Yeah that patch looks good to me.
>
> I suspect this bug was introduced in:
>
>   6b2fd7efeb88 ("PCI/MSI/PPC: Remove arch_msi_check_device()")
>
> Previously we had that check routine which would run before any of the
> MSI setup had been done, and so if there were no MSI ops then we bailed
> out early and didn't call teardown.
>
> I guess since then (2014) we haven't tested an MSI capable device on a
> system that isn't MSI capable?

Thanks for looking into this. You're probably right, it really looks like
that patch could have introduced this bug.

Cheers,
Radu
