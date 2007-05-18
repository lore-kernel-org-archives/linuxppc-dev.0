Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [216.148.227.152])
	by ozlabs.org (Postfix) with ESMTP id 93651DDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 13:49:44 +1000 (EST)
Message-ID: <464D2255.2090002@gmail.com>
Date: Thu, 17 May 2007 23:49:41 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>,
	Wade Farnsworth <wfarnsworth@mvista.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>
	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>
	<464CA302.9060707@freescale.com>
	<20070518005641.GA27350@localhost.localdomain>
In-Reply-To: <20070518005641.GA27350@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, May 17, 2007 at 01:46:26PM -0500, Timur Tabi wrote:
>> Wade Farnsworth wrote:
>>
>>> Yes.  On rev 1.0 boards, all of the devices on the south bridge are on
>>> bus 0, while on rev 1.02, the devices on the southbridge are on bus 2.
>>>
>>> I'd like to use the same dts for both rev's if possible.  But if there
>>> is a reason why they shouldn't, I suppose I could create a separate dts.
>> I think two DTS files is the best approach for now.  A few of us had
>> an idea to introduce conditional statements in to the DTS, and
> 
> Erm... how would you encode such conditionals in the dtb?  I really
> don't like the idea of having a generalized conditional
> parser/evaluator built into the bootwrapper.

I hear forth is a really neat language, and can do conditionals. ;-)

> What I'd been thinking for situations like this is to fold two dtbs
> into the bootwrapper and have it select between them based on on board
> revision (assuming that can be deduced from registers somehow).
> 
>> U-Boot would examine the board and/or environment variables and then
>> apply the conditions to the device tree before booting the kernel.
>> This would allow you to merge the two DTS files into one, but we're
>> quite a ways off from implementing this feature.  In the meantime,
>> two DTS files is okay.

WRT u-boot:

a) With the libfdt changes, we're making good progress on updating the 
fdt based on the board-specific information.  This gives us the 
capability of creating a semi-generic DTS and have u-boot augment the 
fdt with the necessary board-specific property settings.

b) I also have a dream of allowing the hush parser to test fdt 
properties, which would allow us to write u-boot/hush scripts that 
validate that a given fdt is a proper one for the board and/or select 
the proper one out of several in memory.  So many fun ideas, so little 
time...

Best regards,
gvb
