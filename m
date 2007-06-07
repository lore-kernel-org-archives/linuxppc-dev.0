Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 7E385DDF69
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 05:54:53 +1000 (EST)
Message-ID: <4668628A.30401@mvista.com>
Date: Thu, 07 Jun 2007 12:54:50 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC] 85XX: Allow 8259 cascade to share an MPIC interrupt line.
References: <466755AC.40201@mvista.com> <46683D12.1050204@ru.mvista.com>
	<46685B9C.10501@mvista.com> <46685F77.7050901@ru.mvista.com>
In-Reply-To: <46685F77.7050901@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
[snippage]
>> The threaded interrupt system has threaded routines for the 4 standard
>> interrupts types used by the generic IRQ system (fasteoi, edge, level
>> and simple), plus a handler for non-generic interrupts (the ones that
>> still use __do_IRQ.) When interrupts are being threaded and a
>> non-cascaded MPIC interrupt occurs, desc->handler normally points to
>> handle_fasteoi_irq which masks the interrupt source, schedules the
>> corresponding IRQ thread, issues an EOI and returns to the interrupted
>> context. At a later time, the scheduler dispatches the IRQ thread which
>> calls a threaded version of the fasteoi handler. The threaded fasteoi
>> routine processes the action chain and calls .unmask to re-enable the
>> interrupt before returning to the calling thread. Once the interrupt has
>> been unmasked, the entire process is free to repeat as needed.
> 
>    Oh, you could have really skipped the basics. ;-)
Maybe not. See below.

> 
>> After processing a possible 8259 interrupt, the 8259 cascade handler
>> calls handle_fasteoi_irq to perform the actions noted above. However,
>> with the 8259 cascade handler hooked to the interrupt, the threaded IRQ
>> handler doesn't recognize it as one of the 4 standard generic IRQ types
>> and calls the threaded version of do_irq instead of the threaded fasteoi
>> handler.
> 
>    Ah, that's it!
> 
>> Once the threaded do_irq handler completes the action list, it
>> uses the .end routine to restart the interrupt flow. Pointing .end to
>> the standard MPIC unmask routine allows it to balance the interrupt mask
>> operation performed by handle_fasteoi_irq before it scheduled the IRQ
>> thread.
> 
>    Well, but when MPIC's eoi() method is called then? :-O
It's called from handle_fasteoi_irq as I described in the "basics" ;)

Randy V.
