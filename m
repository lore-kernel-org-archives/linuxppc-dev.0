Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1F6ADE13C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 13:27:02 +1100 (EST)
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine <vbarshak@ru.mvista.com>
In-Reply-To: <49B7167C.9000004@ru.mvista.com>
References: <20090310195013.GA27835@ru.mvista.com>
	<49B6D427.5050600@lebon.org.ua>  <49B7167C.9000004@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 13:26:51 +1100
Message-Id: <1236738411.7086.38.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Mikhail Zolotaryov <lebon@lebon.org.ua>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yes, you could phrase it that way. According to the PPC440EPx manual, 
> the total memory size is calculated based on the following formula:
> memsize = cs * (1 << (col+row)) * bank * dpath;
> So, if both chipselects are used, we add an extra bit to the memory 
> address to distinguish between these chipselects.
> There's nothing wrong with this part of the code.
> The problem is that the controller is hardwired to use only one 
> chipselect, even if both are enabled in the DDR0_10 on PPC440EPx/GRx 
> processors.
> So, the patch provides a workaround to always use single cs for 
> 440EPx/GRx (use predefined value instead of reading DDR0_10).

Mikhail, can you verify that Valentine's patch works for you ?

Cheers,
Ben.
