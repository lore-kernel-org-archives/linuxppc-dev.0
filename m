Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id D23EC67A64
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 03:15:18 +1100 (EST)
Date: Tue, 18 Jan 2005 09:15:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050118161515.GI28724@smtp.west.cox.net>
References: <41EC29A8.1040703@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41EC29A8.1040703@mvista.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 17, 2005 at 02:10:00PM -0700, Mark A. Greer wrote:

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

But they check if it's set, so they can be assigned later and this is
OK.

> 2) Its ppc-specific.  Implementing get_rtc_time() et. al. directly makes 
> it generic across all architectures.

Guessing, this is for a marvell chipset that's found on MIPS too.

> Is there a better way to do this?

How about we try borrowing the MIPS abstraction and force todc_time,
pmac_time (any others?) to directly define (and EXPORT_SYMBOL)
get_rtc_time / set_rtc_time / etc.

-- 
Tom Rini
http://gate.crashing.org/~trini/
