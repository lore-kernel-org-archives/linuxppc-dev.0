Return-Path: <SRS0=hRxk=V3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC6C32750
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E4B20659
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E4B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ypMl2XBpzDq9Z
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 06:40:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ypKd1ScYzDqQj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2019 06:38:12 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6UKbpqf027328;
 Tue, 30 Jul 2019 15:37:51 -0500
Message-ID: <ea83e4d6227b70ae4731c2bfcd727e3afeac3bf8.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch fall-through
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 30 Jul 2019 13:37:50 -0700
In-Reply-To: <201907301005.0661E63CF@keescook>
References: <20190730143704.060a2606@canb.auug.org.au>
 <878ssfzjdk.fsf@concordia.ellerman.id.au> <201907301005.0661E63CF@keescook>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-07-30 at 10:07 -0700, Kees Cook wrote:
> 
> > Why do we think it's an expected fall through? I can't really
> > convince
> > myself from the surrounding code that it's definitely intentional.
> 
> Yeah, good question. Just now when I went looking for who
> used SMU_I2C_TRANSFER_COMBINED, I found the only caller in
> arch/powerpc/platforms/powermac/low_i2c.c and it is clearly using a
> fall-through for building the command for "stdsub" and "combined",
> so I think that's justification enough:

Yes, sorry for the delay, the fall through is intentional.

Cheers,
Ben.


