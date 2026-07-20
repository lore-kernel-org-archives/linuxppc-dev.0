Return-Path: <linuxppc-dev+bounces-24501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E43C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 14:35:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3jjd2ghFz2yWK;
	Tue, 21 Jul 2026 00:35:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784558133;
	cv=none; b=hHUBskBkvL+FY9vjGoEOdq9ZK9zFTkA5K3TzvNb8HDdnL+BPClKYoBJITVYPKkLnzq7dPVzeiDCv1YLm/r6RM78sKpob5Mzh06YxhtjWq9mENy+ciRFa9HrCc0swPCXgLIGF/G6nqNjcjp8ELNubFvoHTgub5Lc0PN/tLesExaVgG0IoE7zAcR+FCFJvZB0+BUdG5ARwql9rcjhd04GPQVZm/EmLL0dD1D3ks7ILNYTnbsV8HJGulZgM67bgfMd3RLg73Bzq7E9/krVOP2vDI5m4JIEZ438uEugXaKbc/Xb6l5V01gtlrU7gHTSihttorREDPAoWcVDL10RCEfrX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784558133; c=relaxed/relaxed;
	bh=6Tb8wqtR9ryTgh1xvi0oAMEHAbHL0B/dENMN0HrupOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3KN/HTNkDdW6x6YUgpjHh7Ea7X/VAJxPqTKEwHk7Kr58MtQ7mhlz2JBHMx7JC6mpvm4iIXHGQuOOT/K2qKLPvwBBT3tuoOk03AQLTue8rPe1IWhGoxBBBzn3s8M85x3JVYvOF9JajJUWZV/DtHyynCnlDvqACDdJ5jIodx1wiB5hhQKsV5CEmloP1in2AS/1nFu52PEwZE1ZBuRht004tr/zZSS0hxpcJOnnxJXGv/9PbHlU0wbOPNkOK5I+lmgc4DErdQd8P6LxkOBy2Afm9GU8WPjutpxJ0r29LJ6ujX2FoOfFe/v1M4Au/7Z+AUiEYgGouvWNqylQt+NAi8Hkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uKnkz66y; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uKnkz66y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3jjZ5lF7z2yYf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 00:35:29 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091DA143D;
	Mon, 20 Jul 2026 07:34:53 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 434DC3F99C;
	Mon, 20 Jul 2026 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784558097; bh=ZVkkZ18OLSNZOkiVP1mnO/iPf2y1oqZNLduNfGDfsQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uKnkz66yIGd6UFYKjma27WX+h7RPQeiRRY0BIkl83q7LK9tzwmzAAWB3CpaLYSzSz
	 VAxrUqtdfHOxDU8UxXIgyQsQayXrfIiI6OfEhRpfdwO6iv7Qhs9TT/YU8rXJMUgOSF
	 KUIcW53yHOX72MUF2MwWNytURigfff8YrvkHQEak=
Message-ID: <c4abec80-2f8d-4070-aee4-76152f6f20cc@arm.com>
Date: Mon, 20 Jul 2026 15:34:36 +0100
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
Subject: Re: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
 <e4f9b266-8d9e-48fe-99c0-58b61e02c9bd@arm.com>
 <CAMRc=MefqCMgVv-o5hWoRwS2iXPQNs5nH2qHiz55+ew162LfSA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAMRc=MefqCMgVv-o5hWoRwS2iXPQNs5nH2qHiz55+ew162LfSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/07/2026 2:39 pm, Bartosz Golaszewski wrote:
> On Mon, 20 Jul 2026 14:58:27 +0200, Robin Murphy <robin.murphy@arm.com> said:
>> On 20/07/2026 10:24 am, Bartosz Golaszewski wrote:
>>> Prefer the higher-level platform_device_set_fwnode() over the
>>> OF-specific platform_device_set_of_node() for dynamically allocated
>>> platform devices.
>>
>> This is very much non-portable code specific to OF-only platforms, but
>> if the intention is to remove platform_device_set_of_node() again
>> already, then FWIW,
>>
> 
> Providing platform_device_set_of_node() and using it was done to make the
> transision to expanding reference counting to all firmware nodes possible.
> I don't think we'll remove it just yet as it doesn't make sense to convert
> the code under drivers/of/ to using the fwnode variant.

OK, but in that case why convert these users either? If the OF helper 
does continue to exist then I'd imagine the static checker brigade will 
eventually end up sending patches to "simplify" these open-coded 
equivalents back to using it. And frankly, if drivers do know for sure 
they're exclusively dealing with of_nodes, rather than doing something 
conditional under an is_of_node() check, then I see little justification 
for them *not* using the dedicated helper.

If the complaint is that there are no *public* users to justify 
exporting platform_device_set_fwnode(), then as I say AFAICS that's much 
more neatly addressed with the static inline approach, such that we 
still get to unify the public APIs, actively eliminate something from 
the symbol table and save a bit of source and object code, but without 
any need to churn the truly OF-based callers at all.

Thanks,
Robin.

> 
>> Acked-by: Robin Murphy <robin.murphy@arm.com>
>>
>> (Although I'm slightly puzzled by the cover letter - AFAICS in -next,
>> platform_device_set_of_node() is itself very much a user of
>> platform_device_set_fwnode(), however in terms of symbol exports,
>> perhaps the former could now just be a static inline wrapper?)
>>
> 
> Sure that can be done independently later.
> 
> Bart


