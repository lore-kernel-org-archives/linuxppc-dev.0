Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75F1DDDFCB
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 01:33:17 +1000 (EST)
Message-Id: <AB49B020-E993-4107-A97B-E41FD0272BCA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Randy Vinson <rvinson@mvista.com>
In-Reply-To: <47F509CC.9010205@mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] E500 Make steal_context SMP-safe.
Date: Thu, 10 Apr 2008 10:31:08 -0500
References: <47F509CC.9010205@mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2008, at 11:46 AM, Randy Vinson wrote:
> When steal_context is used on SMP systems, it can steal a context in
> use by one of the other processors. This patch adds context tracking  
> to
> prevent this as suggested by BenH.

Can we be more descriptive in the problem/bug symptom in the  
description.

otherwise this looks ok to me.  I'd like BenH to ack as well since  
he's been look at this code recently.

>
> Signed-off-by: Randy Vinson <rvinson@mvista.com>
> ---
> The previous version of this patch had some unnecessary code which  
> has been
> removed in this version.
>
> Note: This is a proof-of-concept patch. This isn't my area of  
> expertise,
> so I'd greatly appreciate any guidance I can get. I'm considering the
> use of for_each_online_cpu() instead of for_each_possible_cpu() and
> possibly putting the changes under a CONFIG_SMP switch to prevent  
> unnecessary
> overhead in the non-SMP case.

for_each_online_cpu() is probably better.  I'm guessing this optimizes  
pretty well in the !CONFIG_SMP case.

- k
