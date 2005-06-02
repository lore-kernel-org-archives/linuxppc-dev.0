Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5B1E67A2C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2005 09:23:52 +1000 (EST)
Message-ID: <429F94FE.1070900@am.sony.com>
Date: Thu, 02 Jun 2005 16:23:42 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1117753618.31082.99.camel@gaston>
In-Reply-To: <1117753618.31082.99.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc@lists.debian.org, "Levand,
	Geoffrey" <Geoffrey.Levand@am.sony.com>
Subject: Re: [PATCH] ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2005-06-02 at 15:33 -0700, Geoff Levand wrote:
> 
>>I had a problem when building for ppc440 (gcc -m405).  I wonder if we 
>>need some conditionals on the DSSALL statement as below, or is DSSALL 
>>intended to be a perprocessor macro that would expand to a blank line
>>in this case?
> 
> 
> No, but the cpu feature bit will make the dssall be nop'ed out on your
> CPU. I though we were passing -many to gas in all cases, don't we ?
> 

sorry...

egrep -r '\-Wa' arch/ppc
arch/ppc/boot/simple/Makefile:extra-aflags-$(CONFIG_REDWOOD_4)  := -Wa,-m405
arch/ppc/Makefile:cpu-as-$(CONFIG_PPC64BRIDGE)  += -Wa,-mppc64bridge
arch/ppc/Makefile:cpu-as-$(CONFIG_4xx)          += -Wa,-m405
arch/ppc/Makefile:cpu-as-$(CONFIG_6xx)          += -Wa,-maltivec
arch/ppc/Makefile:cpu-as-$(CONFIG_POWER4)               += -Wa,-maltivec
arch/ppc/Makefile:cpu-as-$(CONFIG_E500)         += -Wa,-me500

So I get an invalid instruction error.

-Geoff
