Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 04C1E67C48
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:30:04 +1100 (EST)
Message-ID: <4560BF28.8010406@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:31:36 +0300
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
In-Reply-To: <20061119202348.GA27649@elte.hu>
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

>>What do you need an ack() for on fasteoi ? On all fasteoi controllers 
>>I have, ack is implicit by obtaining the vector number and all there 
>>is is an eoi...

> it's a compatibility hack only. Threaded handlers are a different type 
> of flow, but often the fasteoi handler is not changed to the threaded 
> handler so i changed it to be a threaded handler too.

   The fasteoi flow seem to only had been used for x86 IOAPIC in the RT patch 
only *before* PPC took to using them in the mainline...

> threaded handlers need a mask() + an ack(), because that's the correct

    Not all of them. This could be customized on type-by-type basis. I.e. we 
could call eoi() instead of ack() for fasteoi chips without having to resort 
to the duplicated ack/eoi handlers.

> model to map them to kernel threads - threaded handlers can be delayed 
> for a long time if something higher-prio is preempting them.
> 
> 	Ingo

WBR, Sergei
