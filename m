Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E6C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 16:00:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA29205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 16:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="laTLb0pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA29205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m8zp6vBJzF3Nh
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 03:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="laTLb0pa";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="laTLb0pa"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m8x64s2qzF3Hm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 02:57:46 +1100 (AEDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8ECE920833
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541087864;
 bh=dSJCI9kE3qlgUTmBWO4YVagMCHYUBBnirKIyof1dfps=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=laTLb0paqRoDWv5D7uguyobFglasgGw8oHoQKLvFJcAwOetkPNpKMWDD0SmKO+fRk
 szyBKDeK+5p8BzbeVfCrZeyV0jBqxj/YVRT5UKZVYrRFSrtQDTCd6EwiOKpWeV+lo5
 kSmrM0H/nKVp6siKQbAZyVB5Rj8G6xhwrsFKQlc4=
Received: by mail-qt1-f173.google.com with SMTP id z2-v6so21665985qts.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 08:57:44 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLqrKxcvm1GLQ7To5tlsKnDidi5ftyix8NHfRcMzwNmcOiwxx15
 d8l8dbZGtM9pRb1RgGPfI/uva+EsFZWJTsRjvQ==
X-Google-Smtp-Source: AJdET5cIOgMr5VYSgCTTegF1kAIR3sj2pwcA6iOD1hzovWzrmYVsT73EOZ+ZBxRSKBG/EisUkD7uf52DX1IKqYqLYY0=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr7435448qts.144.1541087863786; 
 Thu, 01 Nov 2018 08:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-2-robh@kernel.org>
 <874ld3jz6v.fsf@concordia.ellerman.id.au>
 <871s87jz3g.fsf@concordia.ellerman.id.au>
 <CABGGisw_bd+bJedZ_T2e-dxmRnXf2N_gGBZj8u+QVGQxj_gc+Q@mail.gmail.com>
 <87tvl1dq7q.fsf@concordia.ellerman.id.au>
 <20181101151201.GJ5994@gate.crashing.org>
In-Reply-To: <20181101151201.GJ5994@gate.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Nov 2018 10:57:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmx_vjQfYMTFc5K4Sy4hEVXJi5p2PNL8uCpiyTdSir3A@mail.gmail.com>
Message-ID: <CAL_JsqJmx_vjQfYMTFc5K4Sy4hEVXJi5p2PNL8uCpiyTdSir3A@mail.gmail.com>
Subject: Re: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
To: segher@kernel.crashing.org
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
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 1, 2018 at 10:12 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Thu, Nov 01, 2018 at 09:52:57PM +1100, Michael Ellerman wrote:
> > Rob Herring <robh@kernel.org> writes:
> > > Yes, I was aware at least older powerpc DTs don't use 'cpu' for node names.
> >
> > Actually newer ones too, see below :)
>
> Good, because that is required by the Open Firmware standard (the PowerPC
> binding, to be exact):
>
> http://www.openbios.org/data/docs/ppc-2_1.ps
>
> (see 5.1.4, "name").

Yes. I should say I only expect systems following ePAPR (3.7) or DT
Spec will use 'cpu' node names. Those specs also require 'device_type'
which is supposed to indicate what OF methods are available for a node
which doesn't exist on FDT.

Rob
