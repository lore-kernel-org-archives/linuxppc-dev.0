Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D615CDDFC2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 12:07:14 +1000 (EST)
Message-Id: <202DEFA2-B49B-4FBB-998C-550777C0EAC8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080521221115.GB5156@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] mpic: deal with bogus NIRQ in Feature Reporting
	Register
Date: Wed, 21 May 2008 21:06:59 -0500
References: <Pine.LNX.4.64.0805211557380.31707@blarg.am.freescale.net>
	<20080521221115.GB5156@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 21, 2008, at 5:11 PM, Scott Wood wrote:

> On Wed, May 21, 2008 at 03:57:55PM -0500, Kumar Gala wrote:
>> Some chips (like the SoCs from Freescale) report the wrong value in  
>> NIRQ
>> and this causes issues if its doesn't match or exceed the value of
>> irq_count.
>
> Is it really wrong, or just not accounting for the gap between  
> external
> and internal interrupts?

I consider it wrong by my interpretation of the open-pic spec.

The spec says:

Num IRQ Sources:  The number of highest IRQ source supported.  For  
instance, in a 32 source
implementation, this value will be 31.  This allows support of a  
maximum of 2048 interrupt sources.

(Interrupt Sources are in the 0x10000 to 0x1ffff range).

So for something like 8572, the top most interrupt source is at  
0x1CE0.  So I'd take that to mean NIRQs should be 231. (0x1CE0 / 0x20  
- 1).  NIRQS reports 107.

- k
