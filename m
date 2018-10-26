Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F93C46475
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 00:51:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8B02075D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 00:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ADP880Wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8B02075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h56W6H3DzF3G1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 11:51:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ADP880Wy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=amacapital.net
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=luto@amacapital.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amacapital.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=amacapital-net.20150623.gappssmtp.com
 header.i=@amacapital-net.20150623.gappssmtp.com header.b="ADP880Wy"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h53p00gXzDrbV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 11:49:24 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id a5-v6so3923134pgt.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Sv6/dgbgZQO89MjwuWBRRku3O6sl1WCVn+jdvSnnNSc=;
 b=ADP880WyUnApYPY6zDqljhPcrumXetnmn96CkDryH1xYF5Clws2UZ4QmLHNdSqmX+c
 YnOlg+FBPEaNxFnH9ufze+vaDrY33KShAfVqgvbm3jntIXeX6sjbElpC5y3o5vZ9hK6M
 1QzuKs/uu+OU6NC9uBzkpd+gvG8Wbgp/9QeLGXfn5pW7V5dPVcn1DQbjrKYwzsiUNZa3
 wlR+c4wl4dhJhDnmyidBclA/lOM7c3LfUQEgqb9YLIrT14ysfHAXh0RYc/KSUf2ITSZH
 3/XFlGEInl7dVuLKFJv989mOk+LUD01itu6bV6E1xGulTnTTmZDLjqhylWWOVsz2fXD8
 RgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Sv6/dgbgZQO89MjwuWBRRku3O6sl1WCVn+jdvSnnNSc=;
 b=IEEKDoUnZoFPnQvPNyyUI6xi2Ty6KvNvJ2BvIBtqEbz4vW3Otxwk5ZqLU4de7k54aU
 Y9xrzVly2IiiyhHpVUhOHaLeRz6ng7iZMiEttvtMZhfY+GwPHPojtayu6lmDzoBHOB97
 9OxO7tvE9q/Hp7fhHOyzlNS3z0gf14+JF72fCgf+kZiJCL2ufO9TfwJaBiieEUOtVbSx
 8xLbO0u+VFnVl9Yqo+0XSMWpLhocPE+M8U5zbnVlZ/CR6VZ1zeVMUsW+4k8nW7kPn67v
 JQnjtImGgEXzLPFjhzESUnk7PS35tkkxUnJlcRQAbUp8M0YIlReZ4L9S7qYXL0yZQtFr
 0jpQ==
X-Gm-Message-State: AGRZ1gJmBljMfqya8klIu/fpQF12339OuyU0N0nci7VMr6kSQWP0xqje
 2GkTbD0lDjnvr4HLvxdFrz4UUw==
X-Google-Smtp-Source: AJdET5dkhy08KkZjCXCAGdZjtBpWvim/38mypJAzRUsyM1AoOYp60WHQzxM2ohtZJ+BbbAiVgP6YFA==
X-Received: by 2002:a63:b801:: with SMTP id
 p1-v6mr1327664pge.327.1540514962772; 
 Thu, 25 Oct 2018 17:49:22 -0700 (PDT)
Received: from ?IPv6:2600:1010:b05c:3179:787a:b0d3:85f0:a03b?
 ([2600:1010:b05c:3179:787a:b0d3:85f0:a03b])
 by smtp.gmail.com with ESMTPSA id w63-v6sm14519250pgw.60.2018.10.25.17.49.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Oct 2018 17:49:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] seccomp: Add pkru into seccomp_data
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAGXu5jLE2VBqo_rkBJ+BJkp1==WLLg=N=-3gjTCCjcN1=bodSg@mail.gmail.com>
Date: Thu, 25 Oct 2018 17:49:20 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DC76493-28C9-4CAA-9262-E809F52459DB@amacapital.net>
References: <20181024153523.10974-1-msammler@mpi-sws.org>
 <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
 <11a706bd-060f-41de-118b-bababfd83b3d@mpi-sws.org>
 <875zxqo0ee.fsf@oldenburg.str.redhat.com>
 <c4d3f5c1-a2dc-5b44-4d12-1fae829a372c@mpi-sws.org>
 <CALCETrX_E5_p1-MjCcdtRQbziCCzXcOCfxRBckZx_zbO1QX=Dw@mail.gmail.com>
 <CAGXu5jLE2VBqo_rkBJ+BJkp1==WLLg=N=-3gjTCCjcN1=bodSg@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
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
Cc: Florian Weimer <fweimer@redhat.com>, Will Drewry <wad@chromium.org>,
 Linux API <linux-api@vger.kernel.org>, linuxram@us.ibm.com,
 Michael Sammler <msammler@mpi-sws.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> On Oct 25, 2018, at 5:35 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
>> On Fri, Oct 26, 2018 at 12:00 AM, Andy Lutomirski <luto@amacapital.net> w=
rote:
>> You could bite the bullet and add seccomp eBPF support :)
>=20
> I'm not convinced this is a good enough reason for gaining the eBPF
> attack surface yet.
>=20
>=20

Is it an interesting attack surface?  It=E2=80=99s certainly scarier if you=E2=
=80=99re worried about attacks from the sandbox creator, but the security in=
side the sandbox should be more or less equivalent, no?=
