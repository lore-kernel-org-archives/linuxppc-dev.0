Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22BE9DDF63
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 10:01:21 +1100 (EST)
Message-Id: <065FAE64-D239-41A5-AA04-192DA4BC6038@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081216191419.GA31928@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Fix few build errors with
	CONFIG_QUICC_ENGINE=n
Date: Tue, 16 Dec 2008 16:57:43 -0600
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
	<6C14C18C-D709-4E69-8B47-C8A13380D713@kernel.crashing.org>
	<20081216184451.GA6959@oksana.dev.rtsoft.ru>
	<4947FABD.8090209@freescale.com>
	<20081216191419.GA31928@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 16, 2008, at 1:14 PM, Anton Vorontsov wrote:

> On Tue, Dec 16, 2008 at 01:00:13PM -0600, Scott Wood wrote:
>> Anton Vorontsov wrote:
>>>  GCC can still issue the of_find_node_by_name() call. (I wonder if
>>>  there is any way to tell gcc that particular function doesn't
>>>  produce any side-effects so that gcc can optimize it away too).
>>
>> __attribute__((pure))
>
> Ah, thanks!
>
> But I forgot that of_find_node_by_name() and friends aren't
> actually "pure", they're getting the node. :-(

Looking at include/linux/compiler-gcc.h I'm guessing the proper way to  
use it is __pure & inclusion of compiler.h

- k
