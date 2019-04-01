Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5814C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:13:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB6F20870
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB6F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XqTJ5d17zDqMy
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 22:13:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XqRQ0mYkzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 22:11:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44XqRP64BXz9sRJ; Mon,  1 Apr 2019 22:11:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44XqRP0wNTz9sR0;
 Mon,  1 Apr 2019 22:11:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
In-Reply-To: <20190327115745.GA11404@sirena.org.uk>
References: <20190326133349.3d9427dc@canb.auug.org.au>
 <20190326131550.GB10898@sirena.org.uk>
 <87pnqdndmk.fsf@concordia.ellerman.id.au>
 <20190327115745.GA11404@sirena.org.uk>
Date: Mon, 01 Apr 2019 22:11:44 +1100
Message-ID: <87tvfiou8f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
 Liam Girdwood <lgirdwood@gmail.com>, Annaliese McDermond <nh6z@nh6z.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, Linux Next Mailing List <linux-next@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mark Brown <broonie@kernel.org> writes:
> On Wed, Mar 27, 2019 at 03:29:55PM +1100, Michael Ellerman wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > Hrm, seems PowerPC is still not using the common clock API - is there
>> > any plan for that?  There are some ASoC PowerPC uses so it's going to be
>> > a bit of an issue as we expand our use of the clock API.
>
>> I don't know anything about the common clock API. What would it involve
>> for powerpc to use it?
>
> It's what's in drivers/clk - you'd have to provide clock drivers for all
> the clocks that are current supported by arch-specific code, make sure
> that those drivers can be instantiated and then remove the custom
> implementation of the clock API in arch/powerpc in favour of those.

OK. I realise we do have some support for the common clock API, but only
on certain sub-platforms (PPC_MPC512x, PPC_MPC52xx, PPC_E500MC).

On other platforms we have nothing at all AFAICS.

Seems Ben posted an RFC to support it in 2009, but nothing since:
  http://patchwork.ozlabs.org/patch/31551/


Anyway I think what you've done in next, make the code depend on
COMMON_CLOCK, is the best option. If anyone cares about that driver on
powerpc platforms that don't support COMMON_CLOCK they should speak up.

cheers
