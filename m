Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52C08DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 03:38:35 +1100 (EST)
Message-Id: <C4191E6E-314F-4971-82B4-12ADD1891243@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Johns Daniel <johns.daniel@gmail.com>
In-Reply-To: <ba5d9360801230706n47ad71bapd1820488f823736f@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: CONFIG_PCI interaction with pata_platform driver on MPC834x board
Date: Wed, 23 Jan 2008 10:38:22 -0600
References: <ba5d9360712210737h133fd831vbfb7c9f996c6df7c@mail.gmail.com>
	<ba5d9360801230706n47ad71bapd1820488f823736f@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 23, 2008, at 9:06 AM, Johns Daniel wrote:

> I am asking this question once more since my previous try -- right
> before the Christmas break -- did not elicit any responses!   ;~)
>
> Without PCI support configured in the kernel, the CompactFlash card is
> discovered and configured by the kernel. With PCI support configured
> in the kernel, it fails to discover the CF card through the
> pata_platform driver.
>
> (Note that both PCI and CF work fine on this same board with the
> generic IDE driver!)
>
> There are only two differences that I notice between the two kernel
> setups that might be significant:
> 1.) The libata virq changes from 19 to 20.
> 2.) The isa_io_base changes from 0x0 to 0xfcfff000.
> Are either of these two changes significant?
>
> I am using the "arch/powerpc" kernel, version 2.6.20.21. The CF is
> wired directly to the local bus in True IDE mode.
>
> I have some debug info included in my previous message at:
>
> http://www.nabble.com/CONFIG_PCI-interaction-with-pata_platform-driver-on-MPC834x-board-tc14457502.html

I suggest putting some prints in the driver to see if the addresses  
that are ioremap() are the same.

then I'd track down if/where actual register read/writes are occurring  
and see if the same address is being used.

- k
