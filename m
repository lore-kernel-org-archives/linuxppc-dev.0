Return-Path: <SRS0=5fv2=YV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A14CA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Oct 2019 08:48:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D367E20B7C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Oct 2019 08:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D367E20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 471pJk2532zDqlm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Oct 2019 19:48:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 471pGc234BzDqPw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2019 19:46:16 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9S8jY59019523;
 Mon, 28 Oct 2019 03:45:35 -0500
Message-ID: <47e67f44f5e955108759fe32400d2622c4a5ba3f.camel@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robh+dt@kernel.org>, Russell King - ARM Linux admin
 <linux@armlinux.org.uk>
Date: Mon, 28 Oct 2019 19:45:34 +1100
In-Reply-To: <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
 <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
 <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
 <20191023143159.GB25745@shell.armlinux.org.uk>
 <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, mad skateman <madskateman@gmail.com>,
 linux-mmc <linux-mmc@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <chzigotzky@xenosoft.de>,
 "contact@a-eon.com" <contact@a-eon.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-10-25 at 17:28 -0500, Rob Herring wrote:
> This doesn't work?:
> 
>         if (IS_ENABLED(CONFIG_PPC) || of_dma_is_coherent(dev-
> >of_node))
>                 value |= ESDHC_DMA_SNOOP;
>         else
>                 value &= ~ESDHC_DMA_SNOOP;

CONFIG_PPC is restrictive. What about sparc64 ? There could be others
.. .we can't suddenly requests people to add new properties for what
was implied behaviours before hand, esp since it's not in the base 1275
spec, no ?

I would suggest of_dma_is_coherent is *true* by default unless
overriden to do something else.

Cheers,
Ben.


