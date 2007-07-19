Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A69DDDF01
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:09:25 +1000 (EST)
In-Reply-To: <469E408F.1080300@freescale.com>
References: <20070718013538.GB15238@ld0162-tx32.am.freescale.net>
	<8DC2DA02-3D10-4D14-AC91-E34AEA68E04F@kernel.crashing.org>
	<469E408F.1080300@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4F42C14F-1636-4EF5-A3AE-EB7942FF9C82@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 30/61] fsl_soc: Update the way get_brgfreq() finds things
	in the device tree.
Date: Thu, 19 Jul 2007 17:09:13 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> -            device_type = "cpm";
>>> -            model = "CPM2";
>>> +            compatible = "fsl,mpc8272-cpm", "fsl,cpm2", "fsl,cpm";
>>
>> Does 'fsl,cpm' really mean anything useful?
>
> Yes.  It's can't be used on its own to show the complete programming
> model,

So please remove it.

> but there are lots of common things that it does indicate.

These common things can be detected differently; if all else
fails, just look for a few different "compatible" entries.

> The CPM binding is changed in so many other ways that are much  
> harder to
> make backward compatible that I don't really see much point in  
> doing so
> here.
>
>> Also, take a look at QE it has a similar concept.
>
> It'd be nice to extend this binding to include QE (and at some point
> down the road, merge the code)...  I just didn't have time this  
> time around.

If you think you'll have to seriously revise the binding again,
please mark that clearly in the documentation (there _is_
documentation, right?), so no one can complain if you break
compatibility later.


Segher
