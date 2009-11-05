Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0CB23B7B9C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 05:36:21 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc/83xx/suspend: Clear deep_sleeping after
	devices resume
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4AF30406.3080101@freescale.com>
Date: Thu, 5 Nov 2009 12:36:13 -0600
Message-Id: <2F8E2E66-8398-4ACD-9697-6C2AB6E39CD3@kernel.crashing.org>
References: <20090923190041.GA18944@oksana.dev.rtsoft.ru>
	<20090923190113.GA19932@oksana.dev.rtsoft.ru>
	<043A102D-9F70-4287-B34E-17FF9AE90EE1@kernel.crashing.org>
	<4AF30406.3080101@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 5, 2009, at 10:57 AM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Sep 23, 2009, at 2:01 PM, Anton Vorontsov wrote:
>>> Currently 83xx PMC driver clears deep_sleeping variable very early,
>>> before devices are resumed. This makes fsl_deep_sleep() unusable in
>>> drivers' resume() callback.
>>>
>>> Sure, drivers can store fsl_deep_sleep() value on suspend and use
>>> the stored value on resume. But a better solution is to postpone
>>> clearing the deep_sleeping variable, i.e. move it into finish()
>>> callback.
>>>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>> ---
>>> arch/powerpc/platforms/83xx/suspend.c |    4 ++--
>>> 1 files changed, 2 insertions(+), 2 deletions(-)
>> Scott, any comments or an ack?
>
> ACK

thanks, is that an ACK for all 3?

- k
