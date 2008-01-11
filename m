Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1F647DE224
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 04:48:35 +1100 (EST)
Date: Fri, 11 Jan 2008 09:41:52 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH 0/2] [PPC 4xx] L2-cache synchronization for ppc44x
Message-ID: <20080111174152.GA17240@gate.ebshome.net>
References: <7310408706.20071107014010@emcraft.com>
	<20071128195037.GB22325@gate.ebshome.net>
	<200801111824.46920.yur@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200801111824.46920.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 11, 2008 at 06:24:46PM +0300, Yuri Tikhonov wrote:
> 
>  Hello, Eugene,
> 
>  The h/w snooping mechanism you are talking about is limited to the Low 
> Latency (LL) segment of the PLB bus in ppc440sp and ppc440spe chips (see 
> section "7.2.7 L2 Cache Coherency" of the ppc440spe spec), whereas DMA and 
> XOR engines use the High Bandwidth (HB) segment of PLB bus (see 
> section "1.1.2 Internal Buses" of the ppc440spe spec).
> 
>  Thus, the h/w snooping mechanism is not able to trace the results of 
> operations performed by DMA and XOR engines and keep L2-cache coherent with 
> SDRAM, because the data flow through the HB PLB segment. This leads to, for 
> example, incorrect results of RAID-parity calculations if one uses the h/w 
> accelerated ppc440spe ADMA driver with L2-cache enabled.
> 
>  The s/w synchronization algorithms proposed in my patches has no LL PLB 
> limitations as opposed to h/w snooping, but, probably, this is not the best 
> way of how it might be implemented. Even though with these patches the h/w 
> accelerated RAID starts to operate correctly (with L2-cache enabled) there is 
> a performance degradation (induced by loops in the L2-cache synchronization 
> routines) observed in the most cases. So, as a result, there is no benefit 
> from using L2-cache for these, RAID, cases at all.

Thanks a lot for explanation, Yuri. I'd never imagine they were so 
stupid to make new chips with such behaviour.

-- 
Eugene
