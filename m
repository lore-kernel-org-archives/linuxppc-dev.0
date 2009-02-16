Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC7D5DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 05:50:35 +1100 (EST)
Message-Id: <8330CA5E-0F3B-49D5-AB55-500CD37739C1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090216181241.GB18069@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: open-pic device tree node and subnodes for additional
	functionality?
Date: Mon, 16 Feb 2009 12:50:27 -0600
References: <59D5800B-309D-4A4E-AD1F-CEC8E2D1BE5B@kernel.crashing.org>
	<20090216181241.GB18069@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 16, 2009, at 12:12 PM, Scott Wood wrote:

> On Mon, Feb 16, 2009 at 10:58:42AM -0600, Kumar Gala wrote:
>> On Freescale open-pic controllers we have a number of additional
>> features not spec'd per openpic.  (additional timers, perf mon, PCIe
>> msi, message interrupts, ...).  The problem is how to identify these
>> features in the device tree.
>
> How about adding compatible = "fsl,CHIP-mpic", "fsl,mpic" (or  
> something
> similar) to the mpic node?
>
>> For example we have:
>>
>>                msi@41600 {
>>                        compatible = "fsl,mpc8572-msi", "fsl,mpic- 
>> msi";
>>                        reg = <0x41600 0x80>;
>>                        msi-available-ranges = <0 0x100>;
>>                        interrupts = <
>>                                0xe0 0
>>                                0xe1 0
>>                                0xe2 0
>>                                0xe3 0
>>                                0xe4 0
>>                                0xe5 0
>>                                0xe6 0
>>                                0xe7 0>;
>>                        interrupt-parent = <&mpic>;
>>                };
>
> How much of that node's content is going to differ from one Freescale
> MPIC to another?

For MSI I doubt any.  I think on some parts we might have two (or  
more) groups of MSIs.

However I want to be able to handle timers and the slightly more  
generic message interrupts.

- k
