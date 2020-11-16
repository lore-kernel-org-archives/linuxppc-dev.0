Return-Path: <SRS0=L4jv=EW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813F3C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 20:57:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBBD2078D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 20:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBBD2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZhGD63bvzDqLD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 07:57:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CZhCx6MxWzDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 07:55:08 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0AGKlkSd011280;
 Mon, 16 Nov 2020 14:47:47 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 0AGKlk5a011279;
 Mon, 16 Nov 2020 14:47:46 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 16 Nov 2020 14:47:46 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Scott Wood <oss@buserror.net>
Subject: Re: Error: invalid switch -me200
Message-ID: <20201116204746.GC2672@gate.crashing.org>
References: <202011131146.g8dPLQDD-lkp@intel.com>
 <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
 <20201113190824.GA1477315@ubuntu-m3-large-x86>
 <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
 <20201113200444.GA1496675@ubuntu-m3-large-x86>
 <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com>
 <20201114002037.GW2672@gate.crashing.org>
 <CAFP8O3+NowYwhMAywd=R23HgOYnroWV9ZRkdyAejd08qsOF=6w@mail.gmail.com>
 <20201114005015.GZ2672@gate.crashing.org>
 <e19e3a9f47c988b30a19316ee3de2b588e20a641.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19e3a9f47c988b30a19316ee3de2b588e20a641.camel@buserror.net>
User-Agent: Mutt/1.4.2.3i
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
 kernel test robot <lkp@intel.com>, Brian Cain <bcain@codeaurora.org>,
 Alan Modra <amodra@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 16, 2020 at 02:27:12PM -0600, Scott Wood wrote:
> On Fri, 2020-11-13 at 18:50 -0600, Segher Boessenkool wrote:
> > All the others work fine (and are needed afaics), it is only -me200 that
> > doesn't exist (in mainline binutils).  Perhaps -me5500 will work for it
> > instead.
> 
> According to Wikipedia e200 is from mpc55xx (for which I don't see any
> platform support having ever been added).  e5500 is completely different (64-
> bit version of e500mc).

Ah yes, confusing processor numbers :-(  That explains, sorry.


Segher
