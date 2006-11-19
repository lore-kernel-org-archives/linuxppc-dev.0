Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9995267C48
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:50:50 +1100 (EST)
Message-ID: <4560C409.9030709@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:52:25 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>	
	<1163966437.5826.99.camel@localhost.localdomain>	
	<20061119200650.GA22949@elte.hu>	
	<1163967590.5826.104.camel@localhost.localdomain>	
	<4560BDF5.400@ru.mvista.com>	
	<1163968376.5826.110.camel@localhost.localdomain>	
	<4560C121.30403@ru.mvista.com>
	<1163968885.5826.116.camel@localhost.localdomain>
In-Reply-To: <1163968885.5826.116.camel@localhost.localdomain>
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

>>>EOI is a more "high level" thing that some "intelligent" PICs that
>>>automatically raise the priority do to restore the priority to what it
>>>was before the interrupt occured.

>>    Thank you, I know. Even 8259 has the notion of priority and EOI works the 
>>same way here.

> Ok, so why would you need an ack there then while eoi is just what you
> need ? :-)

    Don't ask me, ask the genirq authors. :-)

> Also, that's interesting what you are saying about 8259... I should be
> able to convert ppc's i8259 to use fasteoi too...

    I'm not sure it's feasible. The idea behind level/edge flows is to 
eliminate the interrupt priority I think. That's why they EOI ASAP (with the 
level handler masking IRQ before that) -- this way the other interrupts may 
come thru.
    I used to think that fasteoi was intended for SMP PICs which are 
intelligent enough to mask off the interrupts pending delivery or handling on 
CPUs and unmask them upon receiving EOI -- just like x86 IOAPIC does. This 
way, the acceptance of the lower priority interrupts shouldn't be hindered on 
the other CPUs. Maybe the scheme is different for OpenPIC (I know it has the 
different interrupt distribution scheme from IOAPIC)?

> Ben.

WBR, Sergei
