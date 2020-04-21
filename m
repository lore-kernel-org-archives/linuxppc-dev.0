Return-Path: <SRS0=D6Rn=6F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E48C54FC9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 12:24:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481302076A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 12:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mj8zd2Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481302076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4962n109bpzDqnD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 22:24:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4962jw4fXJzDqdn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 22:21:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=mj8zd2Bc; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4962jv5dWGz9sSX;
 Tue, 21 Apr 2020 22:21:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1587471700;
 bh=6AnWnGkFluzkSI2k6s2Dlzn0etAG7pQy+cxV3FfTTNE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mj8zd2BcbqZBEZyIIp6ov+OCxWK5buhQe93A1G0c/tMOaj0/oAwLBYteFPeeESXw7
 JkUSMdUcS0Xt0ou2r3QTOnHWCrCy8UX23lGDeQteT7Me2l+miZcvweG7MZeLsh1FPa
 KWpQ4KEUt5r/5LCk1YU8S2Evsuti73i0thTQtJ/LvAB1uvHBARSxDHNGkVAXL6gCQl
 1PbO3wUF9jFtA94vldsI08B5mU26yvBoNQNC6igaOpIrKtkcLkD1BsQVoNiysC+1i5
 uE1XtHVxUFOxAUWNVdL4ySvjlxhytonV4vZeEn22/PiA7QnkBC1PnMK7deC/B8eEyz
 am0IkdX6o9zgg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: crash in cpuidle_enter_state with 5.7-rc1
In-Reply-To: <20200420194132.GM25468@kitsune.suse.cz>
References: <20200417160348.GE25468@kitsune.suse.cz>
 <871roiisxg.fsf@mpe.ellerman.id.au> <20200420065030.GL25468@kitsune.suse.cz>
 <20200420194132.GM25468@kitsune.suse.cz>
Date: Tue, 21 Apr 2020 22:21:52 +1000
Message-ID: <87sggxghb3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Mon, Apr 20, 2020 at 08:50:30AM +0200, Michal Such=C3=A1nek wrote:
>> On Mon, Apr 20, 2020 at 04:15:39PM +1000, Michael Ellerman wrote:
>> > Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> ...
>> >=20
>> >=20
>> > And I've just hit it with your config on a machine here, but the crash
>> > is different:
>> That does not look like it.
>> You don't have this part in the stack trace:
>> > [    1.234899] [c000000007597420] [0000000000000000] 0x0
>> > [    1.234908] [c000000007597720] [0000000000000a6d] 0xa6d
>> > [    1.234919] [c000000007597a20] [0000000000000000] 0x0
>> > [    1.234931] [c000000007597d20] [0000000000000004] 0x4
>> which is somewhat random but at least on such line is always present in
>> the traces I get. Also I always get crash in cpuidle_enter_state
> ..
>> > I'm going to guess it's STRICT_KERNEL_RWX that's at fault.
>> I can try without that as well.
>
> Can't reproduce without STRICT_KERNEL_RWX either.

I've reproduced something similar all the way back to v5.5, though it
seems harder to hit - sometimes 5 boots will succeed before one fails.

Are you testing on top of PowerVM or KVM?

cheers
