Return-Path: <SRS0=Jq0w=TK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F48C04A6B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 10:52:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E882070D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 10:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E882070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450n940rgmzDqTy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 20:52:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450n7J6WsnzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 20:50:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 450n7J5k3rz9sML; Fri, 10 May 2019 20:50:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 450n7J1Wj0z9s4V;
 Fri, 10 May 2019 20:50:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
In-Reply-To: <20190509180220.GH17053@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au>
 <20190506065045.GA3901@x250> <20190508101238.GB19015@zn.tnic>
 <87o94bvfxm.fsf@concordia.ellerman.id.au> <20190509145534.GD17053@zn.tnic>
 <20190509180220.GH17053@zn.tnic>
Date: Fri, 10 May 2019 20:50:52 +1000
Message-ID: <87bm0avb03.fsf@concordia.ellerman.id.au>
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
Cc: Johannes Thumshirn <morbidrsa@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, james.morse@arm.com, mchehab@kernel.org,
 linux-edac@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Borislav Petkov <bp@alien8.de> writes:

> On Thu, May 09, 2019 at 04:55:34PM +0200, Borislav Petkov wrote:
>> On Fri, May 10, 2019 at 12:52:05AM +1000, Michael Ellerman wrote:
>> > Thanks. It would be nice if you could send it as a fix for 5.2, it's the
>> > last thing blocking one of my allmodconfig builds. But if you don't
>> > think it qualifies as a fix that's fine too, it can wait.
>> 
>> Sure, no problem. Will do a pull request later.
>
> Hmm, so looking at this more, I was able to produce this config with my
> ancient cross-compiler:
>
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=m
> CONFIG_EDAC_LEGACY_SYSFS=y
> CONFIG_EDAC_MPC85XX=y

Oh yeah good point.

> Now, mpc85xx_edac is built-in and edac_core.ko is a module
> (CONFIG_EDAC=m) and that should not work - i.e., builtin code calling
> module functions. But my cross-compiler is happily building this without
> complaint. Or maybe I'm missing something.

That's weird.

> In any case, I *think* the proper fix should be to do:
>
> config EDAC_MPC85XX
>         bool "Freescale MPC83xx / MPC85xx"
>         depends on FSL_SOC && EDAC=y
>
> so that you can't even produce the above invalid .config snippet.
>
> Hmmm?

Yeah that looks better to me. I didn't think about the case where EDAC
core is modular.

Do you want me to send a new patch?

cheers
