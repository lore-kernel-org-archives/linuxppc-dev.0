Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C693F67C26
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:24:54 +1100 (EST)
Message-ID: <4560BDF5.400@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:26:29 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>	
	<1163966437.5826.99.camel@localhost.localdomain>	
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
In-Reply-To: <1163967590.5826.104.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>>>Wait wait wait .... Can somebody (Ingo ?) explain me why the fasteoi 
>>>handler is being changed and what is the rationale for adding an ack 
>>>that was not necessary before ?

>>dont worry, it's -rt only stuff.

> Still, I'm curious :-) Besides, there have been people talking about
> having -rt work on ppc64 so ...

> What do you need an ack() for on fasteoi ? On all fasteoi controllers I
> have, ack is implicit by obtaining the vector number and all there is is
> an eoi...

    I must not that this whole ack() vs eoi() stuff is misleading. For example,
in 8259 driver, mask_ack() method actually sends EOI to PIC, not ACK's an IRQ 
-- the actual ACK is implicit on x86 and is used to read the interrupt vector 
form 8259 on PPC. So, IMO, there probably should only have been either ack() 
or eoi() method in the first place. Though I'm not familiar with ARM from 
which genirq stuff originated...

> Cheers,
> Ben.

WBR, Sergei
