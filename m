Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF602C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 06:14:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0ABA204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 06:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mUJEb4l7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0ABA204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pMpg5kWSzDrMm
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 17:14:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="mUJEb4l7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="mUJEb4l7"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pMm630pCzDrMh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 17:12:37 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id 189so12829182qkj.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 22:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jBG46JR4xNz37Mn7QR5lrybxoMgJP7gD/2kUlhk5pzE=;
 b=mUJEb4l7WMOqQ1GeUBX0gqbQvZBBYPf+zHtHwLG+sLR9r01/e0mJ3If/pBtbz0vfBA
 sNEKEBJwKTRMN4Z1gRnaD1roRRAauwhSGkVu9aVzWqljnINt6YOtKa5c1MYqNohxLRV+
 bOdDmGDW5401llBZhU+1oQuRMSIjPolXCsijE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jBG46JR4xNz37Mn7QR5lrybxoMgJP7gD/2kUlhk5pzE=;
 b=EfHqE+STO1txmqyNSbcyhWqt9WvR1rxU8lYwJ+cb7r28EYDh48KyQpKoMcVqVEi89y
 0mFfnsuevKTpV6u258AKsNgH1hDBn3DcUT8IvYlacmtD8DyDVLd3dLf3LehhM0DsbEEX
 oOqOmlZvqCIHv58jjyKuLR9WLViIxdZVrjDtJqCH1iOfYN/tpKlYd64umIiQCH8+39L5
 TxI0CnPS7kc1ChPXFeL3MAy7bvooxkYj5aoe8Dm4WllNbAsU8G6VEIl09aOOqQQLtMRt
 Cb8Zs1ZMxrRzTY8SMs5KZJARdiVvoh5ksFJji3QcWZlgDsvy6Pu2o79ODh7v79OWdEJ8
 mgIw==
X-Gm-Message-State: AGRZ1gLx1I5y36SZHGlaFXGZvlvZXlzsWfvvq5Ax0gMviszghbFlhMwY
 MhPhSrx2Lp5ZeLI1V/BEMXS8FxYUSKXuyrSxW7quklOl
X-Google-Smtp-Source: AJdET5fAzEWJl6WU5JdfXzYXhWVSeFBSxR4ekGBtvO5xazP4Kgx7B9gAW5yKL1G9JL/KuU8zjoG4XKLiOmJ4NEAMxVA=
X-Received: by 2002:ae9:ef8a:: with SMTP id d132mr18999121qkg.11.1541398355385; 
 Sun, 04 Nov 2018 22:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20181102043904.2808-1-joel@jms.id.au>
 <87wopschge.fsf@concordia.ellerman.id.au>
In-Reply-To: <87wopschge.fsf@concordia.ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 5 Nov 2018 16:42:23 +1030
Message-ID: <CACPK8XeEksWNPoDXLs2DqqVPuQ6GU6_5-tTTLPeJM9QpMPJ1cw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Avoid unsupported flags with clang
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 5 Nov 2018 at 14:18, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > I considered putting these behind a cc-option test. If someone has an
> > opinion on that I'm happy to change.

> > -CFLAGS-$(CONFIG_PPC32)       := -ffixed-r2 $(MULTIPLEWORD)
> > +ifndef CONFIG_CC_IS_CLANG
> > +#CFLAGS-$(CONFIG_PPC32)      := -ffixed-r2 $(MULTIPLEWORD)
> > +endif
>
> I think using cc-option with a comment would be nicer, you could avoid
> the ifdef and it would also future-proof it against the option either
> appearing in a future clang or disappearing in a future gcc.

Thanks Nick and Michael. I agree, I'll re-spin using cc-option.

Cheers,

Joel
