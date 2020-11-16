Return-Path: <SRS0=3gej=EX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D1C388F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 00:01:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1492B2463F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 00:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTvN2Gpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1492B2463F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZmMH4x3jzDqQW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 11:01:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532;
 helo=mail-pg1-x532.google.com; envelope-from=amodra@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QTvN2Gpg; dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZmJv1h34zDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 10:59:37 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 34so11406317pgp.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2020 15:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=O1xH7v6ktQVn3E0/2gxoBsc75hXO4ialu92ExENyQt8=;
 b=QTvN2GpguC2hbzUk3PxCdzFk0C629djU1wo3x2Ibd6wdD3lYckzgDEYrHVBmZ6QMZ9
 p1ta4LmrHOLI/f8Xh0cbAni39HLqnF6n4HQ32i5tHvB27Wt+5U6ZywQ9YAG19OHm8jSj
 BaCx+PqZQxMVwWq0eNhpgzbNh+DnPskF3ZnN4yacpOJx3K4MymTRijUz4Bz1JLU8mg5q
 QxeBBhtHY10iMYjtYYTvP9nLkndBrArsf8OFcIXqyigNYJ+IsINks4k3AuOoYcCZwEll
 K2ZefLTEbe5W5ra3dOklddEszevKbLqQ4okBDaFC10hBHppyWr4ttQ6OSr8CMVnU1pi/
 NKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=O1xH7v6ktQVn3E0/2gxoBsc75hXO4ialu92ExENyQt8=;
 b=h/9eoZzKFDyhj2y2pUu8B6YF5ajqDaDbeDSOTDOgBeqAWouLWCom98RDB7SW4ud/Dr
 N6mON0h3tdAqLefLD/k3oxqas/op9BNqAHV/bXcBvp1RD3WH/lN/1IA4SRZsyFfGvMiW
 FzaDpUesyYFf3BABj8sbsD55GWzejG5aiLHweQMnFvcwenxeoeVVFchS0ZnQf5VrRdVX
 NfUjFHEHhBW56yxv+XNqJKEvg2PnxlYJS9jLITFYkzNKtlBmIDSxSDeVP1xrGJFiQnce
 wu/fm0AxxW8e7C60yPx8AQkyvWtVaek1dtJKbWIalqFFRWDqSmbczUD8JMtHPtXw93J/
 3nRA==
X-Gm-Message-State: AOAM5325ZErC+7N8uxkWI3NCegzFQD56DoAFpfjyw67bpCz2v/RQgK2t
 KoA2kjcnzEhiRxj7zztAU1Y=
X-Google-Smtp-Source: ABdhPJzmOqkplqffAvi8zciJP+9vijXcBirX83BuorVnt/LrPJjmeIByYbr/7xfEAWl5K2if3H7noA==
X-Received: by 2002:a17:90a:5d93:: with SMTP id
 t19mr1437516pji.220.1605571174368; 
 Mon, 16 Nov 2020 15:59:34 -0800 (PST)
Received: from bubble.grove.modra.org
 ([2406:3400:51d:8cc0:2b49:d8db:361d:de4a])
 by smtp.gmail.com with ESMTPSA id m3sm19708513pfd.217.2020.11.16.15.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 15:59:33 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
 id DFD9B85935; Tue, 17 Nov 2020 10:29:29 +1030 (ACDT)
Date: Tue, 17 Nov 2020 10:29:29 +1030
From: Alan Modra <amodra@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Error: invalid switch -me200
Message-ID: <20201116235929.GT15956@bubble.grove.modra.org>
References: <202011131146.g8dPLQDD-lkp@intel.com>
 <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
 <20201113190824.GA1477315@ubuntu-m3-large-x86>
 <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
 <20201113200444.GA1496675@ubuntu-m3-large-x86>
 <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com>
 <20201114002037.GW2672@gate.crashing.org>
 <CAFP8O3+NowYwhMAywd=R23HgOYnroWV9ZRkdyAejd08qsOF=6w@mail.gmail.com>
 <20201114005015.GZ2672@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201114005015.GZ2672@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Arnd Bergmann <arnd@kernel.org>, kbuild-all@lists.01.org,
 Brian Cain <bcain@codeaurora.org>,
 =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 13, 2020 at 06:50:15PM -0600, Segher Boessenkool wrote:
> On Fri, Nov 13, 2020 at 04:37:38PM -0800, Fāng-ruì Sòng wrote:
> > On Fri, Nov 13, 2020 at 4:23 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > On Fri, Nov 13, 2020 at 12:14:18PM -0800, Nick Desaulniers wrote:
> > > > > > > Error: invalid switch -me200
> > > > > > > Error: unrecognized option -me200
> > > > > >
> > > > > > 251 cpu-as-$(CONFIG_E200)   += -Wa,-me200
> > > > > >
> > > > > > Are those all broken configs, or is Kconfig messed up such that
> > > > > > randconfig can select these when it should not?
> > > > >
> > > > > Hmmm, looks like this flag does not exist in mainline binutils? There is
> > > > > a thread in 2010 about this that Segher commented on:
> > > > >
> > > > > https://lore.kernel.org/linuxppc-dev/9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org/
> > > > >
> > > > > Guess this config should be eliminated?
> > >
> > > The help text for this config options says that e200 is used in 55xx,
> > > and there *is* an -me5500 GAS flag (which probably does this same
> > > thing, too).  But is any of this tested, or useful, or wanted?
> > >
> > > Maybe Christophe knows, cc:ed.
> > 
> > CC Alan Modra, a binutils global maintainer.
> > 
> > Alan, can the few -Wa,-m* options deleted from arch/powerpc/Makefile ?
> 
> All the others work fine (and are needed afaics), it is only -me200 that
> doesn't exist (in mainline binutils).

Right, and a quick check says it never existed.  There is e200z4,
added to binutils with dfdaec14b0d, 2016-08-01, but the kernel -me200
was added in 2005.  I suspect the toolchain support only existed
inside Freescale and pushing it upstream was too difficult.

-- 
Alan Modra
Australia Development Lab, IBM
