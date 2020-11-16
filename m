Return-Path: <SRS0=L4jv=EW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0BC4742C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 20:48:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E262223D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 20:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E262223D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZh4c1zc4zDqP5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 07:48:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
X-Greylist: delayed 1011 seconds by postgrey-1.36 at bilbo;
 Tue, 17 Nov 2020 07:44:49 AEDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZh015w5MzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 07:44:49 +1100 (AEDT)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <oss@buserror.net>)
 id 1kel5l-0005ry-Lt; Mon, 16 Nov 2020 14:27:13 -0600
Message-ID: <e19e3a9f47c988b30a19316ee3de2b588e20a641.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Segher Boessenkool <segher@kernel.crashing.org>, 
 =?UTF-8?Q?F=C4=81ng-ru=C3=AC_S=C3=B2ng?= <maskray@google.com>
Date: Mon, 16 Nov 2020 14:27:12 -0600
In-Reply-To: <20201114005015.GZ2672@gate.crashing.org>
References: <202011131146.g8dPLQDD-lkp@intel.com>
 <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
 <20201113190824.GA1477315@ubuntu-m3-large-x86>
 <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
 <20201113200444.GA1496675@ubuntu-m3-large-x86>
 <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com>
 <20201114002037.GW2672@gate.crashing.org>
 <CAFP8O3+NowYwhMAywd=R23HgOYnroWV9ZRkdyAejd08qsOF=6w@mail.gmail.com>
 <20201114005015.GZ2672@gate.crashing.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: segher@kernel.crashing.org, maskray@google.com,
 arnd@kernel.org, kbuild-all@lists.01.org, lkp@intel.com, bcain@codeaurora.org,
 amodra@gmail.com, masahiroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com, natechancellor@gmail.com,
 torvalds@linux-foundation.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: Error: invalid switch -me200
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
 Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-11-13 at 18:50 -0600, Segher Boessenkool wrote:
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
> > > > > Hmmm, looks like this flag does not exist in mainline binutils?
> > > > > There is
> > > > > a thread in 2010 about this that Segher commented on:
> > > > > 
> > > > > 
https://lore.kernel.org/linuxppc-dev/9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org/
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
> doesn't exist (in mainline binutils).  Perhaps -me5500 will work for it
> instead.

According to Wikipedia e200 is from mpc55xx (for which I don't see any
platform support having ever been added).  e5500 is completely different (64-
bit version of e500mc).

-Scott


