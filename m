Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE85667A45
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 09:26:55 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <41EC29A8.1040703@mvista.com>
References: <41EC29A8.1040703@mvista.com>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 09:25:56 +1100
Message-Id: <1106259956.18397.10.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-17 at 14:10 -0700, Mark A. Greer wrote:
> All,
> 
> I have a platform with an i2c rtc chip.  Since much of the code for an 
> rtc driver is already in drivers/char/genrtc.c, I would like to reuse 
> that code and directly implement get_rtc_time(), et. al. in the rtc 
> driver.  The problem is that include/asm-ppc/rtc.h assumes that 
> get_rtc_time(), et. al. should be mapped to ppc_md.get_rtc_time() et. 
> al.  To work around this, I made an option to turn off that assumption.  
> The patch is included.
> 
> There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. interfaces:
> 1) They are called before the i2c driver is initialized and even loaded 
> if its a module.
> 2) Its ppc-specific.  Implementing get_rtc_time() et. al. directly makes 
> it generic across all architectures.
> 
> Is there a better way to do this?

The patch is going backward since it disables the ability to have
runtime selection of the RTC chip.

</me deletes some sarcastic comments about embedded companies not
caring about anything but gross hacks for every board>
