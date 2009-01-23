Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 2306EDDF1A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 11:21:50 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LQ9nu-0001FO-L6
	for linuxppc-dev@ozlabs.org; Thu, 22 Jan 2009 16:21:46 -0800
Message-ID: <21616515.post@talk.nabble.com>
Date: Thu, 22 Jan 2009 16:21:46 -0800 (PST)
From: Daniel Ng99 <daniel_ng11@lycos.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
In-Reply-To: <20090122173622.GA18427@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>
	<21593750.post@talk.nabble.com>
	<20090122173622.GA18427@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Scott Wood-2 wrote:
> 
> On Wed, Jan 21, 2009 at 06:15:26PM -0800, Daniel Ng99 wrote:
>> Adding 'clock-frequency = <0>;' to the brg node doesn't seem to make a
>> difference to my board's behaviour.
> 
> Try setting it to the actual BRG clock.
> 

My console runs at a baud rate of 115,200, so that means a BRGCLK of 35 for
a 66-MHz input clock (according to the PQ2 Reference Manual).

Then I realised u-boot reports the brg clock to be 33Mhz at boot-up:

MPC8247 Clock Configuration
 - Bus-to-Core Mult 5x, VCO Div 2, 60x Bus Freq  20-60 , Core Freq 100-300
 - dfbrg 1, corecnf 0x1b, busdf 7, cpmdf 1, plldf 0, pllmf 7, pcidf 7
 - vco_out  528000000, scc_clk  132000000, brg_clk   33000000
 - cpu_clk  330000000, cpm_clk  264000000, bus_clk   66000000

So maybe 35 x 2 = 70 is the correct value?

Anyway, I tried all these but still they made no difference:

clock-frequency = <35>
clock-frequency = <0x23>
clock-frequency = <115200>
clock-frequency = <1c200>
clock-frequency = <70>
clock-frequency = <17>
clock-frequency = <66>
clock-frequency = <33>

Can you suggest any other values? 

What is the effect of just not calling set_brg()? I still get console
output, so am I setting myself up for some sort of problem in the future?

What is the effect of setting "fsl,cpm-brg = <0>" in the 'serial' device
tree node?

-- 
View this message in context: http://www.nabble.com/-MPC8272ADS-Cannot-start-my-Linux-Kernel-tp21476017p21616515.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
