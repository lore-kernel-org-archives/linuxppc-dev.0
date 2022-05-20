Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37720C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 May 2022 10:36:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L4NSn26SXz3btn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 May 2022 20:36:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Epz1EkAK;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L4NS73y06z300x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2022 20:36:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Epz1EkAK; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L4NS711vlz4xD1;
 Fri, 20 May 2022 20:36:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1653042983;
 bh=mOny+jRhEaRnlfdwnGQUh3XIIubOWXX0swGgQfN04Ig=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=Epz1EkAK4joUHQoQy2ceozj8EBSp4i6hj5hdv0JtpNS/z1nID2UCCBchc9svUNdCi
 jbfTjb289XKvQylgM4njkgd0Iq52Ba/sqVeS3yBeyoyoC0P/flmTCfB1w4Fdr5QLwX
 /XZycTBFDGtbFTknK7x3K5s1PWa8GaZHCz3k5zmOAVJb9SeAQFK46AQ5vItbKUdFhC
 3cd/d6cHv7P8900UGkXT8gxYY1V0KttJObSWVOVuQr+ieeE25+kyrPkbBFaZpeePAZ
 dJ7tTS7t2Gsjpt2LMVDuP+9YlZibyL5yzEvh6ard44Oq2pqTye+wzTxQUGr4CkVgI5
 pEFpJSFdFiVvw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Brian W Hart <hartb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix all occurences of "the the"
In-Reply-To: <YoZHQOWiMNRTvaXP@li-1555b84c-276a-11b2-a85c-f09ab184f67f.ibm.com>
References: <20220518142629.513007-1-mpe@ellerman.id.au>
 <YoZHQOWiMNRTvaXP@li-1555b84c-276a-11b2-a85c-f09ab184f67f.ibm.com>
Date: Fri, 20 May 2022 20:36:22 +1000
Message-ID: <87r14omqxl.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Brian W Hart <hartb@linux.vnet.ibm.com> writes:
> On Thu, May 19, 2022 at 12:26:29AM +1000, Michael Ellerman wrote:
>> Rather than waiting for the bots to fix these one-by-one, fix all
>> occurences of "the the" throughout arch/powerpc.
...
>> diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
>> index ef4c2b15f9dd..5d237da43b64 100644
>> --- a/arch/powerpc/platforms/chrp/setup.c
>> +++ b/arch/powerpc/platforms/chrp/setup.c
>> @@ -253,7 +253,7 @@ static void __noreturn briq_restart(char *cmd)
>>   * Per default, input/output-device points to the keyboard/screen
>>   * If no card is installed, the built-in serial port is used as a fallback.
>>   * But unfortunately, the firmware does not connect /chosen/{stdin,stdout}
>> - * the the built-in serial node. Instead, a /failsafe node is created.
>> + * the built-in serial node. Instead, a /failsafe node is created.
>>   */
>>  static __init void chrp_init(void)
>>  {
>
> Maybe this one should be "to the"?

You're right. Darn it, I've already applied the patch.

Given how old this code is it will probably not last many more years, so
I'll just leave it as-is. Hopefully no one writes a bot that looks for
missing "to"s.

Thanks for reviewing.

cheers
