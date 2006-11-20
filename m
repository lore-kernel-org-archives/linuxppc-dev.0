Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 2C9FD67C82
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 04:01:54 +1100 (EST)
Message-ID: <4561DFE1.4020708@ru.mvista.com>
Date: Mon, 20 Nov 2006 20:03:29 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	<20061120165621.GA1504@elte.hu>
In-Reply-To: <20061120165621.GA1504@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Ingo Molnar wrote:

>>>on PPC64, 'get the vector' initiates an ACK as well - is that done 
>>>before handle_irq() is done?

>>   Exactly. How else do_IRQ() would know the vector?

> the reason i'm asking is that in this case masking is a bit late at this 
> point and there's a chance for a repeat interrupt.

    How's that? Acknowledge != EOI on OpenPIC (as well as 8259).
    Acknoledging sets the bit in the in-service register preventing all the 
interrupts with same or lower prioriry from being accepted.

> 	Ingo

WBR, Sergei
