Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A828CC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 07:56:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00982082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 07:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00982082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fffh2MwszDqV7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ffcw6B69zDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 18:54:56 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id k98so5751739otk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 23:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RWsiSaftMEBKmmywsi2EkXVXmbS3OnzSZBL07Cn3ls8=;
 b=D2ubwhouY9J/EPuMbZjAnaF8JOvVvquAzRxiB9p3ptBCRr3itmOyw7fMLyss+aP5pK
 yonxfwvg7OSN4ypyzsp3d4on7QSLFNF6UcSqk0dcoyo00IcAfuNLVXIIEN3zoTlxhYl1
 +HXKrm58krCfJpOYhtGFdcEFUZmDe2rHrGqYKYeXuAQG5Vi5FQiYjPJ1IdCWRbJx1spL
 0SXhTJ9b4ayj0KnoeZD6vsxif+p8/5jvnpVazf4GqagPtLS8ZGne+9eX1vrlL4GngzwD
 1jher6nsddlVEOUhnVU54Eg3CrrqgjrQy+doTFIqNOzvmlR1eODUMAQ7tu1Z1EPCFIwv
 +yIw==
X-Gm-Message-State: AJcUukc58bUtvwrFheA8l7lyXRvWf1ZsZ1GFe9FuUZlijhBjIQ+EKjqv
 O3IFdvwlC1O/GKWijJKZwHJvRO4rHmPqQ1dZCUg=
X-Google-Smtp-Source: ALg8bN7XJ6QMAbHUDIdjLNXizJatFEwChjGNmTRv/giEQsIPcEemi1VLHVhMBwsLhK9gIRaHzwJrN1yJRdtlMvyjvyk=
X-Received: by 2002:a05:6808:13:: with SMTP id
 u19mr4333137oic.57.1547625294429; 
 Tue, 15 Jan 2019 23:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20190115042017.13342-1-andrew.donnellan@au1.ibm.com>
 <CA+7wUsy5xbp_t4fiEUw9C0HKQ8GohcBJZkj8qZnna5990Gm1-w@mail.gmail.com>
 <ea8a051c-481d-ef97-7d1d-8621f194e41e@c-s.fr>
 <87tvi9xk7s.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvi9xk7s.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 16 Jan 2019 08:54:43 +0100
Message-ID: <CA+7wUswdOrD9w-j1ohXDnCTOoO7z2anf5YsJXAw6NjJJ8oC4vg@mail.gmail.com>
Subject: Re: gcc 6.3 vs 8.2 Re: [RFC PATCH] powerpc: Enable kcov
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 16, 2019 at 6:09 AM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
>
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > Le 15/01/2019 =C3=A0 08:26, Mathieu Malaterre a =C3=A9crit :
> ...
> >>
> >> I did check that `custom_defconfig` is the minimal defconfig generated
> >> by `savedefconfig` in both cases.
> >>
> >> Hints or comments welcome, thanks much.
> >
> > I think you should do:
> >
> > make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu- custom_defconfig
> > make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu-
>
> Yep, you definitely need to use the same compiler for configuring and
> building.

<facepalm>
That was it. Thanks for the help !
