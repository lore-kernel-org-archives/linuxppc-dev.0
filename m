Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A82D5DDF5F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 19:02:01 +1000 (EST)
In-Reply-To: <46725411.3080002@ru.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<20070614222620.GA17382@mag.az.mvista.com>
	<c6cd3a9fe7713f081354cca9b4306811@kernel.crashing.org>
	<46725411.3080002@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a849b0caedb72f3799c095d3ab6cebd1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Date: Fri, 15 Jun 2007 11:01:55 +0200
To: "Vladislav D. Buzov" <vbuzov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hrm. I don't think that cache invalidation should be skipped. It is 
> done after _set_L2CR() explicitly disabled the cache, in part of cache 
> enabling procedure. Note that cache is flushed only if _set_L2CR() is 
> called for already enabled cache. So, to skip cache invalidation there 
> is a need to somehow track whether the cache has been 
> flushed/invalidated before disabling or not. Since the manual 
> invalidation does not break anything I think it is better to leave it 
> as is rather than overload a _set_L2CR() logic.

Yeah just leave it, it definitely is the safer thing to do.
Do fix the comment though ;-)


Segher
