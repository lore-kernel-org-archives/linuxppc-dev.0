Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EF54DE063
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 21:40:15 +1000 (EST)
Message-Id: <5430DEC7-39DB-4316-8E7E-949CA4280403@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <48B28C62.2000600@hypersurf.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 1/4] Add low level PLL config register interface module
Date: Mon, 25 Aug 2008 06:40:00 -0500
References: <48B28C62.2000600@hypersurf.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 25, 2008, at 5:41 AM, Kevin Diggs wrote:

> This adds a small module to handle the low level details of dealing  
> with the
> PLL config register (HID1) found in the IBM 750GX. It provides 2  
> possible
> interfaces, both selectable via kernel config options. One is a  
> sysfs attribute
> and the other is a normal function API. It is called pll_if.
>
> The determination of the bus frequency is what worked on a PowerMac  
> 8600. Any
> suggestions on a more general solution are welcome.
>
> WARNING - I used some #ifdefs - Let the fur fly!
>
> My name is Kevin Diggs and I approve this patch.

This really should be split into two patches.  One for the perl script  
and one for the actual kernel code.

Scanning the actual kernel code you have a lot of #ifdef's that should  
be cleaned up:

Can't #ifdef CONFIG_PPC_750GX_DUAL_PLL_IF_SYSFS just be #ifdef  
CONFIG_SYSFS and the same for CONFIG_PPC_750GX_DUAL_PLL_IF_HRTIMER &  
CONFIG_PPC_750GX_DUAL_PLL_IF_CPU_FREQ?

#ifdef CONFIG_PPC_OF seems unnecessary as all PPC always has this set.

What's up with #define MULFIRST and the #if 0?

- k
