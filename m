Return-Path: <linuxppc-dev+bounces-21444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C8FCD5BBF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 07:08:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP6RW3w58z2xk7;
	Mon, 25 May 2026 17:08:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779692903;
	cv=none; b=HWhGJabMmqB0e0RkghxGiKrRDoyIDptD8HFuR6iN2UlPdKVbolqk30ArVZNc2UiQ55OnW+aXUmJyvLlPtaoZRJykso+JQ/NjkrUPnekJZsbhaVMUFrj9FAHfbDHm770LNPOWXItoJVw1Q9GDS4U44hXP5wg6q9EECO/IsZSBY/H9SkP4r49YE4U4N4PuQf7tKOw4HWCes74y9e+S3uNb5ezlO/j5Zqmls2Z9ussanFF/uXcLDoxRjIxHUmaP+cLAoH4y2U6Hd83RgtKdhYRxSoiX2nyI76wvctSyYgZBIgL4P5bHboVqndnsLSBMPHjjcZHsLZOGZtCpPMugYIGOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779692903; c=relaxed/relaxed;
	bh=eVPR0LLrILDMdBwjLVToivXpWGkmk5WE/EIyPpANZys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLR3M7/MYtNq5bKTJc63QUk1BQUjB6VYeGysEAkd6yKF4So9fIapfRhvxvzZBFSmgtvKGX1juF3qfMeX6tutMmIv9bLeJbjvlCneUpgq2z8X0PyDeAIAEEu0zuoWtJhIFN1+nm3eSQkTmiq9GVANl5IBNlpH0d+VWw72AN1OQryL4lfOmLmJNnAaw+HVkk9/wk8wWtXVZav8SOCed+GUQHF9dP3GOg/g+Hta1+KzOqaUBhXEAjY6TFMNyg6J1rRa48l62duXjmLmcZHnoYJa5nm1gVlSwn1nTW/qa9whM18dawIE3OxhiZA+ptXNzbr6FDrvWMD6fU6WeV67TljfvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org) smtp.mailfrom=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP6RV12L8z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 17:08:20 +1000 (AEST)
Received: from [192.168.2.212] (p5dc55c87.dip0.t-ipconnect.de [93.197.92.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 721DC4C1A2DF81;
	Mon, 25 May 2026 09:07:44 +0200 (CEST)
Message-ID: <84448a84-1c96-45a9-9ba8-1e058d0bf8a5@molgen.mpg.de>
Date: Mon, 25 May 2026 09:07:42 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: eeprom: at24: Make VCC supply description
 requirement optional
To: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
 <ahN2m3kCbyTUNXzZ@sirena.org.uk>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ahN2m3kCbyTUNXzZ@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mark,


Thank you for taking the time to review and respond.


Am 25.05.26 um 00:07 schrieb Mark Brown:
> On Sun, May 24, 2026 at 10:05:33AM +0200, Paul Menzel wrote:
> 
>> Some platforms (e.g. IBM Power System S822LC (8335-GCA POWER8)) do not
>> describe the EEPROM’s VCC supply in firmware-provided device trees.
>> Using `devm_regulator_get()` on such systems falls back to a dummy
>> regulator with a kernel warning:
> 
>> Switch to `devm_regulator_get_optional()` and treat -ENODEV as “no
>> supply described”. When `vcc_reg` is NULL, skip all
>> regulator_enable/disable calls; the hardware is assumed to be always
>> powered. Linux now logs:
> 
> This is not appropriate unless the device can actually operate without
> power, any driver could be used in a system where the firmware does not
> describe the regultors and it'd obviously be pointless and error prone
> to scatter bodges like this on every single call to a regulator API
> function.

How should the warning on the POWER server be addressed then?


Kind regards,

Paul

