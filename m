Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C474FB7BA9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 06:48:21 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nA5Jm2l6012732
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 12:48:12 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nA5JpCoK021507
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 13:51:12 -0600 (CST)
Message-ID: <4AF32C0B.4010109@freescale.com>
Date: Thu, 05 Nov 2009 13:48:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/83xx/suspend: Clear deep_sleeping
	after	devices resume
References: <20090923190041.GA18944@oksana.dev.rtsoft.ru>	<20090923190113.GA19932@oksana.dev.rtsoft.ru>	<043A102D-9F70-4287-B34E-17FF9AE90EE1@kernel.crashing.org>	<4AF30406.3080101@freescale.com>
	<2F8E2E66-8398-4ACD-9697-6C2AB6E39CD3@kernel.crashing.org>
In-Reply-To: <2F8E2E66-8398-4ACD-9697-6C2AB6E39CD3@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Nov 5, 2009, at 10:57 AM, Scott Wood wrote:
> 
>> Kumar Gala wrote:
>>> On Sep 23, 2009, at 2:01 PM, Anton Vorontsov wrote:
>>>> Currently 83xx PMC driver clears deep_sleeping variable very early,
>>>> before devices are resumed. This makes fsl_deep_sleep() unusable in
>>>> drivers' resume() callback.
>>>>
>>>> Sure, drivers can store fsl_deep_sleep() value on suspend and use
>>>> the stored value on resume. But a better solution is to postpone
>>>> clearing the deep_sleeping variable, i.e. move it into finish()
>>>> callback.
>>>>
>>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>>> ---
>>>> arch/powerpc/platforms/83xx/suspend.c |    4 ++--
>>>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>> Scott, any comments or an ack?
>>
>> ACK
> 
> thanks, is that an ACK for all 3?

The first.  Patch 2 looks OK as well.

As for patch 3, Ben objected to the sleep-nexus stuff on IRC.

-Scott
