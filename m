Return-Path: <SRS0=6dJf=FJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B4C4361A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 16:30:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50142333F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 16:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50142333F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CpFRg3nd2zDqft
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Dec 2020 03:30:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=amacapital.net (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=luto@amacapital.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amacapital.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=amacapital-net.20150623.gappssmtp.com
 header.i=@amacapital-net.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=DhL2umox; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CpF2V1rZQzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Dec 2020 03:12:01 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id h7so5156513pjk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Dec 2020 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=Mz/7Yi61thJ88HE692aK3MZiSQS4EROkVabvy/8vXTw=;
 b=DhL2umoxMynanfmyKr00u4At2reQZYap7bLysS7iO2w5j378kBnpkqTo925b1AMXV9
 GfnmqNtET9W86zssaaOutcBbaatQqvIuT0cFpK/81Z7C+e8JNbfIu0fT5XUcH3GNcfdc
 TB+RF64MfXALrRuW3BwDZoBwlIBtNKpXrKm5Y0/qTBIU331wiDfW9P9m9Ss4s+Q3hmKj
 IbLQSoUJ7xJOh7w9Sws/9AcCKZ+1eQgOt1ThRR6L9HNeFOZO+EVk2vhjr0XajH5/mYrN
 BMTdOzYSYOvXdJvjmZaBKKSwrzDg8IwR22EhWuj7sLHF1rrlBKjTfwBTm4b8Mzs0E+Hn
 xxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=Mz/7Yi61thJ88HE692aK3MZiSQS4EROkVabvy/8vXTw=;
 b=RfWhBbntWGiHEPNZK/IdZxDZUDjLvvopnNqtKqbR4TZSF2wbj70MejE0QuLVzlm9uL
 zVJCbQEqKCfQWPFtKsTx3DXVXljauTnYO4zpatOjZlaGKkL6IuxXpQOnwECRtXxxSSBF
 tsxFgrzMp2PEktQMoGdCWF3gwPUgneWJvdNMPmdoN0cYrGAgQOuoM1GpC6sRS3PBIqcS
 JXe0QInlR/IPcM9iLrpcnmiw6UHtPGYhFFgf//GnLA9kDDI4Gw8N3xInF6XDKS0SbYLF
 aGAyMayaz3Jq80RyYupl0KiaO3iwU67MeyZJdIhyht4fHq5DELy6g7cb3xPdtmuJr/Wv
 Peuw==
X-Gm-Message-State: AOAM533pvKsWjL4+V9N0SdEeFjDuYuec7TUvCag+sUwebPRCCVrbVAw/
 jIkXWsF9+C7A0QE7jXLapeBMzQ==
X-Google-Smtp-Source: ABdhPJwZpG0woeNrtDGe9OhzFE0RR6dieb9MhtJVWcHQn4MXBKdlSYP/d9e6WoDZV96QQKI0PbKqlA==
X-Received: by 2002:a17:902:bd4c:b029:d8:fd6a:6ca2 with SMTP id
 b12-20020a170902bd4cb02900d8fd6a6ca2mr8830175plx.53.1607184717112; 
 Sat, 05 Dec 2020 08:11:57 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:c541:6c6c:97fe:790?
 ([2601:646:c200:1ef2:c541:6c6c:97fe:790])
 by smtp.gmail.com with ESMTPSA id mr7sm5466394pjb.31.2020.12.05.08.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Dec 2020 08:11:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Sat, 5 Dec 2020 08:11:54 -0800
Message-Id: <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
References: <1607152918.fkgmomgfw9.astroid@bobo.none>
In-Reply-To: <1607152918.fkgmomgfw9.astroid@bobo.none>
To: Nicholas Piggin <npiggin@gmail.com>
X-Mailer: iPhone Mail (18B121)
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> On Dec 5, 2020, at 12:00 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>=20
> I disagree. Until now nobody following it noticed that the mm gets
> un-lazied in other cases, because that was not too clear from the
> code (only indirectly using non-standard terminology in the arch
> support document).

> In other words, membarrier needs a special sync to deal with the case=20
> when a kthread takes the mm.

I don=E2=80=99t think this is actually true. Somehow the x86 oddities about C=
R3 writes leaked too much into the membarrier core code and comments. (I dou=
bt this is x86 specific.  The actual x86 specific part seems to be that we c=
an return to user mode without syncing the instruction stream.)

As far as I can tell, membarrier doesn=E2=80=99t care at all about laziness.=
 Membarrier cares about rq->curr->mm.  The fact that a cpu can switch its ac=
tual loaded mm without scheduling at all (on x86 at least) is entirely besid=
e the point except insofar as it has an effect on whether a subsequent switc=
h_mm() call serializes.  If we notify membarrier about x86=E2=80=99s asynchr=
onous CR3 writes, then membarrier needs to understand what to do with them, w=
hich results in an unmaintainable mess in membarrier *and* in the x86 code.

I=E2=80=99m currently trying to document how membarrier actually works, and h=
opefully this will result in untangling membarrier from mmdrop() and such.

A silly part of this is that x86 already has a high quality implementation o=
f most of membarrier(): flush_tlb_mm().  If you flush an mm=E2=80=99s TLB, w=
e carefully propagate the flush to all threads, with attention to memory ord=
ering.  We can=E2=80=99t use this directly as an arch-specific implementatio=
n of membarrier because it has the annoying side affect of flushing the TLB a=
nd because upcoming hardware might be able to flush without guaranteeing a c=
ore sync.  (Upcoming means Zen 3, but the Zen 3 implementation is sadly not u=
sable by Linux.)
