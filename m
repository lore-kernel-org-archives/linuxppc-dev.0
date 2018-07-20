Return-Path: <tim@seoss.co.uk>
Received: from relay1.allsecuredomains.com (relay1.allsecuredomains.com
 [78.47.251.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41XCyw0sD0zDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2018 00:32:38 +1000 (AEST)
Subject: TP Link WDR4900 (was NXP p1010se device trees only correct for
 P1010E/P1014E, not P1010/P1014 SoCs).
To: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
References: <1ed6ce0c-f7df-615b-ffdb-8dab25b506f6@seoss.co.uk>
 <bdc2e385580cc08bcbf9d5b3595cbca5162314f8.camel@buserror.net>
 <0bec4690-992b-a6ef-3989-a1ce96da825d@seoss.co.uk>
 <9c74bcada9949792f83997195d4d365a850114a6.camel@buserror.net>
From: Tim Small <tim@seoss.co.uk>
Message-ID: <d8e6466a-0279-4c38-73ec-8de6397755a0@seoss.co.uk>
Date: Fri, 20 Jul 2018 15:32:32 +0100
MIME-Version: 1.0
In-Reply-To: <9c74bcada9949792f83997195d4d365a850114a6.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/18 23:21, Scott Wood wrote:

>> Thanks for your email.  The device in question ships an old uboot (a
>> vendor fork of U-Boot 2010.12-svn15934).
> 
> This was added by commit 6b70ffb9d1b2e, committed in July 2008... maybe
> there's a problem with the old U-Boot finding the crypto node on this
> particular chip?

Hi Scott,

Thanks for your response and the pointers...  I don't know my way around 
this code at all (I just got here when I hit a user space bug when 
trying to use 802.1AE), so I'm in the dark a bit here.

The device doesn't have mainline support, there is the original vendor 
patched uboot and kernel (linux 2.6.35 based) released here:

https://www.tp-link.com/us/download/TL-WDR4900.html#GPL-Code

The the vendor u-boot serial output identifies the board as a P1014RDB 
in its serial output, so I'd guess that TP-Link just made minimal 
changes from the NXP reference design.

The OpenWRT distro package, which has its own reasonably simple set of 
kernel patches (it's currently using 4.9.x on this platform) at:

https://git.openwrt.org/openwrt/openwrt.git

in:

target/linux/mpc85xx/files/arch/powerpc/platforms/85xx

It produces a cuImage for this board, but I don't know why that decision 
was made, maybe it's just what the vendor kernel did, or maybe it's 
difficult to differentiate a TL-WDR4900 from a P1010RDB reference board. 
  I couldn't find the P1010RDB BSP to see what TP-Link has done.

I could potentially work on getting those upstream if you think that 
would be worthwhile, but I don't really have a good feel for how good or 
hacky the code that's in OpenWRT is at the moment.  I'd probably need 
help getting it up and running.

I presume it'd mean switching from a cuImage to a uImage if practical?

Cheers,

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309
