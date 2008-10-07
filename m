Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 751A1DDE07
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 20:18:47 +1100 (EST)
Message-ID: <48EB296E.5050808@linux.net.cn>
Date: Tue, 07 Oct 2008 17:18:38 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
In-Reply-To: <48EABBD3.1010401@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Li Yang <leoli@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tejun Heo wrote:
> Anton Vorontsov wrote:
>> On Mon, Oct 06, 2008 at 03:41:19PM -0500, Matt Sealey wrote:
>>> There is a simple problem with the patch which is that an "IRQ 0" can and does
>>> actually exist on a bunch of platforms, at least to the best of my knowledge.
>>>
>>> Checking for -1 (which means for definite, no irq at all, because it is
>>> totally unambiguous, as a -1 IRQ numbering is "impossible") is more correct.
>> This was discussed years ago.
>>
>> http://lkml.org/lkml/2005/11/22/159
>> http://lkml.org/lkml/2005/11/22/227
>>
> 
> Would this break any existing platforms?  If so, can those be fixed
> together or does it become a much bigger problem that way?
> 

Pata_of_platform stacks upon pata_platform. This patch fixes problem
concerning definition of "no irq" without touch any other place.  So
far I can't see any new problem.
