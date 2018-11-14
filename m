Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDBFC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 06:29:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C5E22360
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 06:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="GYzPUatR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C5E22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vvjF2ZDQzF3QG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 17:29:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="GYzPUatR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="GYzPUatR"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vvfl5TlFzF3Jy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 17:27:11 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id o125so23919544qkf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 22:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M7RAOeN6FEr4XBAIBlrRpPM1f7WSTBhdgXnq+tPszOg=;
 b=GYzPUatRXvQpma5Fk94Z5vfdtAGZYHyI4UwvJOO1WPviRpAyfOtjtlqAvaSIYScJHl
 1Yp3jwXwdXhzmx55JjkNx6gAy/5wbKf2tTzMX7cboCKUxTgGC8UOYvo7jlOOt3PTYeA0
 1+BsMNGzFlGo39UTO94P11oRuEKbZ6CYnNvcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M7RAOeN6FEr4XBAIBlrRpPM1f7WSTBhdgXnq+tPszOg=;
 b=Am6x6qWsXPy/gFDHCDmqWFUMbmrdgYb+AlTrj/btZTzqjWb9djNhfYQU+y+P6IcnSM
 +AQDTcb5DsvCEJ4ALC+CcqaA5x/bXXU3tMl3Y8jisEycMqg5ik1TR9N8F5hLlMxIw5lo
 vtbM/DyR+O7gkac/T+89cHFQxr+zYm4yyYcy2UsPSEGfF/9ffR9r2Pl1Cgk/ynDm76fe
 GrCWRNg1vZXoXmI3hWXnlenoZwkvRV5NfJrqKbf33uPm/CMSkpthWiTPQGUSwtIoLyDY
 2KHov4RzlicatjHc+nW6GQbOpYdDU+23E3l3JDxZS+AVmZkv9b7K/7iVuz4HsNHEXpQh
 JWig==
X-Gm-Message-State: AGRZ1gIO3k5oye53IsRskBFOH7XY6b/meJ7HcJVvRE+z9mSxfBTDWBRK
 89pAjAltBt9kf9OxXz3auNAS3KmKRyqnEgYdsnc=
X-Google-Smtp-Source: AJdET5doSdxLZOHdYL6svyOm+zSnskr72SAPIgpZbg2kgTHxVUQ7zmGUj1eQYDuSKBSgxvzvKCAHYg4tv+R0o3Z0e5o=
X-Received: by 2002:ac8:7308:: with SMTP id x8mr564486qto.284.1542176828960;
 Tue, 13 Nov 2018 22:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20181114061958.3462-1-oohall@gmail.com>
In-Reply-To: <20181114061958.3462-1-oohall@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Nov 2018 16:56:57 +1030
Message-ID: <CACPK8XdtCZFM1WC+Lnku5rZ5ZwNZRV9NnFc6nSJMdYiVsCqt2g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Remove PCI_MSI ifdef checks
To: "Oliver O'Halloran" <oohall@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 14 Nov 2018 at 16:50, Oliver O'Halloran <oohall@gmail.com> wrote:
>
> CONFIG_PCI_MSI was made mandatory by commit a311e738b6d8
> ("powerpc/powernv: Make PCI non-optional") so the #ifdef
> checks around CONFIG_PCI_MSI here can be removed entirely.
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Can we do the same to the CONFIG_PCI_MSI in
arch/powerpc/sysdev/xics/ics-opal.c ?

Cheers,

Joel
