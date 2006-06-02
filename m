Return-Path: <segher@kernel.crashing.org>
Received: from vmx55.multikabel.net (vmx55.multikabel.net [212.127.254.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D53667A3A
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 22:51:56 +1000 (EST)
Received: from vmx30.multikabel.net ([212.127.254.138])
	by vmx55.multikabel.net with esmtp (Exim 4.44) id 1Fm91M-0001Ll-Kp
	for linuxppc-dev@ozlabs.org; Fri, 02 Jun 2006 14:44:56 +0200
In-Reply-To: <20060602040426.GA28528@pb15.lixom.net>
References: <20060602040426.GA28528@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <61e1e9d0ada7e9648b8590cfac2b67b9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [2.6.18] U4 DART improvements
Date: Fri, 2 Jun 2006 14:44:50 +0200
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olof,

Looks good.  One request:

> +static inline void dart_tlb_invalidate_one(unsigned long bus_rpn)
> +{
> +	unsigned int reg;
> +	unsigned int l, limit;
> +
> +	reg = DART_CNTL_U4_ENABLE | DART_CNTL_U4_IONE |
> +		(bus_rpn & DART_CNTL_U4_IONE_MASK);
> +	DART_OUT(DART_CNTL, reg);
> +	mb();

Could you please comment the memory barriers, to say exactly _why_ a
certain barrier is needed?  I can't see why wmb() wouldn't work here,
for example (note I'm not saying it would -- I just don't see why it
wouldn't).

Same goes for every single memory barrier in the whole kernel source
code, but I have to start somewhere, heh.


Segher
