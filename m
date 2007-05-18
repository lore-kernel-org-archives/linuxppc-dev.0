Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17418DDEF4
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 00:34:58 +1000 (EST)
Message-ID: <464DB986.20205@freescale.com>
Date: Fri, 18 May 2007 09:34:46 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Wade Farnsworth <wfarnsworth@mvista.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
	<1179417813.8132.250.camel@rhino>
	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
	<1179421139.8132.256.camel@rhino> <464CA302.9060707@freescale.com>
	<20070518005641.GA27350@localhost.localdomain>
In-Reply-To: <20070518005641.GA27350@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
> Erm... how would you encode such conditionals in the dtb?  

We'll propose a spec once we have everything figured out.  Our current idea is to allow 
any node or property to have a conditional attached to it.  U-Boot will then scan the 
device tree, evaluate the conditional, and if it's false, delete the particular node/property.

U-Boot will be also be expanded to include the concept of "hardware options", whether the 
user and/or board-specific code can tell U-Boot that hardware option X is set to value Y. 
  The conditions in the device tree will be of the form "X == Y" (or X != Y, X > Y, etc).

For instance, on some board, if jumper 22 is on, then it means that the USB port is 
enabled.  If it's possible for software to scan the status of J22, then the board-specific 
code will do that, and it will create an environment variable "J22=ON".  The USB node in 
the device tree will have the conditional "J22 = ON".

> I really
> don't like the idea of having a generalized conditional
> parser/evaluator built into the bootwrapper.

Well, let us present the full proposal with our reasonings when we're ready.  I don't want 
to engage in speculative debate.

> What I'd been thinking for situations like this is to fold two dtbs
> into the bootwrapper and have it select between them based on on board
> revision (assuming that can be deduced from registers somehow).

Our idea is very similar, but just more standardized and more granular.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
