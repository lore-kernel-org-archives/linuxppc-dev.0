Return-Path: <SRS0=7n8X=KI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C606AC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 00:34:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BBE61406
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 00:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BBE61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FgXhp4RYLz303X
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 10:34:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cxJwWeyy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=mhiramat@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cxJwWeyy; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FgXhH2L4kz2yXL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2021 10:33:35 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4422B613EE;
 Thu, 13 May 2021 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620866013;
 bh=j1TT0ANIkRMFsZn/IbX3nZaVo3XI7UKE1sCWQW0d0hA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cxJwWeyyvxzjigHt8FlbGBoPE5WrIeuZAYjOXa5ZNPvSLWWKYQFFmzaIiTFt2VRgX
 iN1RnvFiyJqqKPSmTj/iOgw0AYlJiW+nHsoYcKaAwZ+ZelrNExHRX+DKeiw4AXiSds
 tCOwBFFesOVcLtLE3+mqUzwLtI6YOS14UWdpvl2sOUbLYGaim++kZ0/ChzeOdF3MqG
 Nhu1Qkg0UJVbK2rVQQwwgq8kpPkTXnSXg3M8KRdtooOYotUT16i/yIdLaLOUm+HzcP
 p8/utyVZrfJn3/eWoYW8A6vN6T2P/KPutXP/A1Lq1ZjiE8tUPNdJpnIYoTMxBlLQOe
 67OcKLht/VxQw==
Date: Thu, 13 May 2021 09:33:28 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] kprobes: Allow architectures to override optinsn
 page allocation
Message-Id: <20210513093328.2e4c6da04bd285e0ac688a5d@kernel.org>
In-Reply-To: <202105130218.8xHlehr7-lkp@intel.com>
References: <472c597cc8cc8f74f037acf971f7799fb381a647.1620829724.git.christophe.leroy@csgroup.eu>
 <202105130218.8xHlehr7-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, naveen.n.rao@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, mhiramat@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 13 May 2021 03:04:51 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Christophe,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on linus/master v5.13-rc1 next-20210512]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/kprobes-Allow-architectures-to-override-optinsn-page-allocation/20210512-223121
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: i386-randconfig-r012-20210512 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/2a1f135a9ce3c4d86d3bdefed561aa17760f430f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Christophe-Leroy/kprobes-Allow-architectures-to-override-optinsn-page-allocation/20210512-223121
>         git checkout 2a1f135a9ce3c4d86d3bdefed561aa17760f430f
>         # save the attached .config to linux build tree
>         make W=1 W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/kprobes.c:324:14: warning: no previous prototype for 'alloc_optinsn_page' [-Wmissing-prototypes]
>      324 | void __weak *alloc_optinsn_page(void)
>          |              ^~~~~~~~~~~~~~~~~~
> >> kernel/kprobes.c:329:13: warning: no previous prototype for 'free_optinsn_page' [-Wmissing-prototypes]
>      329 | void __weak free_optinsn_page(void *page)
>          |             ^~~~~~~~~~~~~~~~~

Ah, we need a prototype for those in include/linux/kprobes.h
as same as alloc_insn_page() and free_insn_page().

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
