Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6606EDDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 15:18:54 +1000 (EST)
In-Reply-To: <1191535520.28239.2.camel@pasglop>
References: <20071004130454.GA15448@localhost.localdomain>
	<1191535520.28239.2.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E6B4F79B-254F-4273-8E49-D15BCFF6955A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH][POWERPC] QEIC: Implement pluggable handlers,
	fix MPIC cascading
Date: Fri, 5 Oct 2007 00:18:58 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 4, 2007, at 5:05 PM, Benjamin Herrenschmidt wrote:

>
>> From: Anton Vorontsov <avorontsov@ru.mvista.com>
>> Subject: [PATCH] [POWERPC] QEIC: Implement pluggable handlers, fix  
>> MPIC cascading
>>
>> set_irq_chained_handler overwrites MPIC's handle_irq function
>> (handle_fasteoi_irq) thus MPIC never gets eoi event from the
>> cascaded IRQ. This situation hangs MPIC on MPC8568E.
>>
>> To solve this problem efficiently, QEIC needs pluggable handlers,
>> specific to the underlaying interrupt controller.
>>
>> Patch extends qe_ic_init() function to accept low and high interrupt
>> handlers. To avoid #ifdefs, stack of interrupt handlers specified in
>> the header file and functions are marked 'static inline', thus
>> handlers are compiled-in only if actually used (in the board file).
>> Another option would be to lookup for parent controller and
>> automatically detect handlers, but this will waste text size because
>> of never used handlers.
>>
>> qe_ic_init() also changed in regard to support multiplexed high/low
>> lines as found in MPC8568E-MDS, plus qe_ic_cascade_muxed_mpic()
>> handler implemented appropriately.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
> Looks allright, if it also works, then ship it :-)
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Now that this has been ack'd by Ben if you can respin the patch set  
we can get these in for 2.6.24

(I assume you are using a UCC as ethernet for test some of the QE  
support on 8568?)

- k
