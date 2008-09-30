Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D6FCDDF01
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Oct 2008 02:54:31 +1000 (EST)
Message-ID: <48E2589D.8090406@freescale.com>
Date: Tue, 30 Sep 2008 11:49:33 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: embedded <embedded@akb.net>
Subject: Re: FCC1 failing on large packet PINGS, while FCC2 is successful
References: <bfa0697f0809261600p7e1af4a6va360d0782cec8257@mail.gmail.com>	
	<48E0E981.60703@freescale.com>
	<bfa0697f0809300946m3509f8b6r9720f38dde3e2ce1@mail.gmail.com>
In-Reply-To: <bfa0697f0809300946m3509f8b6r9720f38dde3e2ce1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

embedded wrote:
> Actually, it may have been a simple fix.  Looking at the clocks. We
> noticed something a little awry;  Just rechecking the RM and the code
> we found that within ep8248.c, the clock setup code had the RX and TX
> clocks flipped.
> 
> FCC1 RX CLK should be Clock 10
> FCC1 TX CLK should be Clock 11

D'oh!  Thanks for finding that.

> in: arch/powerpc/platforms/82xx/ep8248.c
> static void __init init_ioports(void)
> 
> -	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_RX);
> -	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);
> 
> +	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_RX);
> +	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_TX);

Acked-by: Scott Wood <scottwood@freescale.com>

Post to linuxppc-dev@ozlabs.org and galak@kernel.crashing.org with a 
Signed-off-by.

-Scott
