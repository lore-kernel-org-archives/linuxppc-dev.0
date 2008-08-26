Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37950DEA66
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 03:25:12 +1000 (EST)
Message-ID: <48B43C42.5040407@freescale.com>
Date: Tue, 26 Aug 2008 12:24:18 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: skepper@ukf.net
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>	<48AEF220.7080506@freescale.com>	<Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>	<20080826140324.GB3783@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.62.0808261742270.5064@chara.vm.bytemark.co.uk>
In-Reply-To: <Pine.LNX.4.62.0808261742270.5064@chara.vm.bytemark.co.uk>
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

Chris Skepper wrote:
> On Tue, 26 Aug 2008, Scott Wood wrote:
> 
>> On Tue, Aug 26, 2008 at 01:00:05PM +0100, Chris Skepper wrote:
>>
>>> I'm triggering an LED which is connected to port A.  Are you saying that
>>> wouldn't work once the caching is enabled?
>>
>> It's quite possible.  What other registers are in the same cache line as
>> the LED, and are any of them non-memory-like?
> 
> There are some ethernet signals, a compact flash card detect, other LEDs 
> and a push button also on port A.  Are those what you'd call 
> non-memory-like?

Would any of them object to spurious reads, and writebacks of the value 
that was read?

>> It's usually easiest to just trust that that part of the code works (in
>> my experience, that's rarely where a hang actually occurs when bringing
>> up a new board), and resume tracing after the MMU is on and you've
>> inserted a caching-inhibited BAT entry.
> 
> Where can I find out how to do that?  Since I have this board working 
> with the old ARCH=ppc, can I copy anything from there?

See setup_cpm_bat in arch/powerpc/kernel/head_32.S.

> Also, where would be a good place in the code to resume tracing?

As soon as you can set up a BAT -- though first, I would try just 
enabling the CPM debug console and see if you get anything from that.

-Scott
