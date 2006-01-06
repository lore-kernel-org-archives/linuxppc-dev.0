Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C84F68974
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 01:14:33 +1100 (EST)
Date: Fri, 6 Jan 2006 13:47:35 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: batsayan.das@tcs.com
Message-Id: <20060106134735.14fabd86.ajz@cambridgebroadband.com>
In-Reply-To: <OF114C07C5.7CED9F64-ON652570EE.00481B82-652570EE.00489CCF@tcs.com>
References: <OF114C07C5.7CED9F64-ON652570EE.00481B82-652570EE.00489CCF@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to enable PHY
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 6 Jan 2006 18:43:08 +0530
batsayan.das@tcs.com wrote:

> 
> Hi,
> 
> I found that ADS8260 board enables PHY by the following lines of
> code
> 
> #ifndef CONFIG_ADS8260
>         /* Enable the PHY.
>         */
>         *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_FETHIEN;
>         *(volatile uint *)(BCSR_ADDR + 4) |=  BCSR1_FETH_RST;
> #endif
> 
> 
> Our board does not have BCSR. My question is how to enable PHY for
> MPC8260 based customs board without BCSR? 

You have to take your PHY out of reset.  How to do this depends on
your board.  On the ADS8260 the PHY reset line goes to the BCSR and
you must write the above to BCSR register 1 to tell it to change the
pin level.

On your board you may need to use GPIO, or you may need to do nothing
at all. Read your schematics!

Regards,

Alex
