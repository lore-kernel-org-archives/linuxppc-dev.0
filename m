Return-Path: <linuxppc-dev+bounces-20302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207F0FF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 01:31:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5c8S308xz2xMW;
	Thu, 30 Apr 2026 11:31:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777512696;
	cv=none; b=eTEDi/burUd3Z4TVNSDUu+3U43J25YCd2+co8KbmEq2pjrNk3O2fsdZRGBHsPDAR4Wd6tJHdx/hFUNTr6+j1oT6PROcNeT7MVf3IXlWaAMEkJFNKEptndGyrEMjO42+0im9RMBpgsT1lY/hgEifnHS7kZZZmS/oYUl5HykqVP0SWSUpfy3NgPSRSbUvm7pmoXMSiDggzWW1S+9V2vYmo2I15rWibrAIq1XNgP2j497bVkawjub+spGsw9Q3jOGhkFshKbR0yjkMabhagnjhCyeJv8H6tK6TnLxznSlR+XN5qxhEyJBlOnqjSZaSiwCoAZyLgX6kqQuJlZU691DjyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777512696; c=relaxed/relaxed;
	bh=Y/21gJ0pvsCplUm+Sf2dm4acnT1wieEtpryyciyTRls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSHHlOfysXfdVuBHfZ2cvbmx8guz8eizrNh97DzLV5xIEbYN6tc08hvvsl+54Oky+BITeBbYZ8llT8KWs51hwfoKH1YbABHFLDK1S6unBQENXPK5w5srjvopxa6J9aKq4FLUGoYB0kpOYNwtKWRHYnbvghaOJyirB0TgCfRCOEXByVoM852uf/SlyPnVDHIqKS16UauFA0sW0fQQCucn/XbE2UmantF+8ZVzmnv0lnVdSTCETCEQpxp13maIkCWK0obCDik0RnmGcC7HQE8EY8b0ZLqhCI4F/fr/epmngXZwOmOKr/CVieymTfgXsRdvWZJaBTgDo3j4cUCwaYKJOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dlwoye1h; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dlwoye1h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5c8R1Rl7z2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 11:31:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 83775443C8;
	Thu, 30 Apr 2026 01:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C56CC19425;
	Thu, 30 Apr 2026 01:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777512692;
	bh=+6AI1AIMBVhMSxwAA+CFoyVM0Rm3EFPwFg6gwl9zXno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dlwoye1hKVvQsM62tnha105SiLWaxrmgMPjEBT2QZOgXqFKo8bi+z5yjr1dhx5MMe
	 yp0qMjc7HBwO6rkSyhpEf0xF2HeDI+6nQeMyqkvDxOIHDGQl7CVlLasnMPLZBLSQZW
	 Z5ycRyFsxB9ZvPoQ0KDQPxb6bjt+r9ifzkwpeEH1uTfHaF2CRMMZVZ/aCvl30r8/8N
	 ZLygWI7AgEsh5w67hzwL4YrLMVFKSBwMnJiHbB/mVbJh7aXhWfhb2EDIisUkRchwWM
	 C8BQs6jwWQSNJjWDEWM3VSLZlInVhFF+AcYOjsQU3r1IsjiL3pLeK/M7R7PO6QpZRr
	 vAxh0v+dU+xow==
Date: Thu, 30 Apr 2026 10:31:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Lukas Wunner <lukas@wunner.de>, 
	Oliver O'Halloran <oohall@gmail.com>, Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Shuan He <heshuan@bytedance.com>, Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, moubingquan <moubingquan@h-partners.com>, 
	Ian <4dark@outlook.com>, Koba Ko <kobak@nvidia.com>, 
	Koen Vandeputte <koen.vandeputte@citymesh.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Artem Savkov <artem.savkov@gmail.com>, Korneliusz Osmenda <korneliuszo@gmail.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260430005931.GA3872993@rocinante>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
 <20260429200439.GA313340@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429200439.GA313340@bhelgaas>

Hello,

> > This has been reported a few times:
> > 
> >   - https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com/
> >   - https://lore.kernel.org/linux-pci/b51519d6-ce45-4b6d-8135-c70169bd110e@h-partners.com/
> >   - https://lore.kernel.org/linux-pci/1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com/
> >   - https://lore.kernel.org/linux-pci/SY0P300MB04687548090B73E40AF97D8897B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM/
> >   - https://lore.kernel.org/linux-pci/20230105174736.GA1154719@bhelgaas/
> >   - https://lore.kernel.org/linux-pci/m3eebg9puj.fsf@t19.piap.pl/
> >   - https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
> >   - https://lore.kernel.org/linux-pci/1366196798-15929-1-git-send-email-artem.savkov@gmail.com/
> >   - https://bugzilla.kernel.org/show_bug.cgi?id=215515
> >   - https://bugzilla.kernel.org/show_bug.cgi?id=216888
> 
> Seems like some or all of these should be mentioned in the relevant
> patch as "Closes:" tags?

Bugzilla would makes sense.  As for the lore.kernel.org links, then if you
find these useful when included, then add these too.  Surprisingly, not as
popular to do so, as I thought, per:

  $ git log | grep -E 'Closes: (http?://)?lore' | wc -l
  43

Having said that, the following bug looks like it might be out of scope
for us, for this series aims to fix, after having a second look at it:

  https://bugzilla.kernel.org/show_bug.cgi?id=216888

Thank you!

	Krzysztof

