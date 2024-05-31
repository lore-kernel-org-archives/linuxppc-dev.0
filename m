Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79738C27C44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2024 09:03:52 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=M989URgs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VrHGt4njQz30Vm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2024 19:03:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=M989URgs;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VrHG53CM1z30Tt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2024 19:03:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1717146185;
	bh=Be/Bo5uim5k47lx+ZGvRVOozMX8CnKvGj91vH0atq8A=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=M989URgsfci4Jdp2BHeZUnZ9yFkUR0iWWi4MNayDECIqWKak+rJ16iZxVtKb02Czx
	 q+676B0Gs5q2bWhFdKhstlmwEfvWKENQ3z9EG9DQOqeut+a2EIgJ+bILE5NNejmD0e
	 S9sLyfEQoDDbt7Pvvlf1SJgZEenfur4CWVZZxeNa6GBFgMZhaEwHucBgDWXDq87eUq
	 C/KYKUBS7rR9esyvtwmkKSO6JtDfsClqFulmWTm14EcDioVafvzA2/Qtoxg3nboNtc
	 Ut9V/c56ZD+EFXuxJglRBh6Hnm/OpRyXXD9cJ7aeurdj4NoQfmjavCzCKuR9+JNkzj
	 p455NIevWEZrw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VrHG05QpYz4wcq;
	Fri, 31 May 2024 19:03:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, mad skateman <madskateman@gmail.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: Xorg doesn't start and some other issues with the RC1 of kernel
 6.10
In-Reply-To: <87zfs731jn.fsf@mail.lhotse>
References: <34d848f4-670b-4493-bf21-130ef862521b@xenosoft.de>
 <93f42bc8-f0ae-4f7f-8f25-a4e9faf8664b@xenosoft.de>
 <87zfs731jn.fsf@mail.lhotse>
Date: Fri, 31 May 2024 19:03:03 +1000
Message-ID: <87plt22w1k.fsf@mail.lhotse>
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>> On 28.05.24 22:00, Christian Zigotzky wrote:
>>> Hi All,
>>>
>>> Xorg doesn't start anymore since the RC1 of kernel 6.10. We tested it 
>>> with the VirtIO GPU and with some Radeon cards.
>>>
>>> Another error message: Failed to start Setup Virtual Console.
>>>
>>> Maybe this is the issue: + CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=y
>>>
>>> Tested with FSL P5040, FSL P5020, and PASEMI boards.
>>>
>>> Could you please test Xorg on your PowerPC machines?
>>>
>>> Thanks,
>>> Christian
>> I tested the RC1 in a virtual e5500 QEMU PowerPC machine with Bochs VGA 
>> (-device VGA,vgamem_mb=256) and Xorg doesn't start either.
>>
>> Error message: xf86OpenConsole: KDSETMODE KD_GRAPHICS failed 
>> Inappropriate ioctl for device.
>
> That is presumably because of this:
>   https://lore.kernel.org/all/0da9785e-ba44-4718-9d08-4e96c1ba7ab2@kernel.org/

Attempting to regzbot this.

#regzbot introduced: 8c467f330059
#regzbot monitor: https://lore.kernel.org/all/0da9785e-ba44-4718-9d08-4e96c1ba7ab2@kernel.org/

cheers
