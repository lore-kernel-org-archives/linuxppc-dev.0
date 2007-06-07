Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B2753DDF3C
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 06:02:31 +1000 (EST)
Message-ID: <466864C3.2000303@ru.mvista.com>
Date: Fri, 08 Jun 2007 00:04:19 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Randy Vinson <rvinson@mvista.com>
Subject: Re: [RFC] 85XX: Allow 8259 cascade to share an MPIC interrupt line.
References: <466755AC.40201@mvista.com> <46683D12.1050204@ru.mvista.com>
	<46685B9C.10501@mvista.com> <46685F77.7050901@ru.mvista.com>
	<4668628A.30401@mvista.com>
In-Reply-To: <4668628A.30401@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randy Vinson wrote:

>>>After processing a possible 8259 interrupt, the 8259 cascade handler
>>>calls handle_fasteoi_irq to perform the actions noted above. However,
>>>with the 8259 cascade handler hooked to the interrupt, the threaded IRQ
>>>handler doesn't recognize it as one of the 4 standard generic IRQ types
>>>and calls the threaded version of do_irq instead of the threaded fasteoi
>>>handler.

>>   Ah, that's it!

>>>Once the threaded do_irq handler completes the action list, it
>>>uses the .end routine to restart the interrupt flow. Pointing .end to
>>>the standard MPIC unmask routine allows it to balance the interrupt mask
>>>operation performed by handle_fasteoi_irq before it scheduled the IRQ
>>>thread.

>>   Well, but when MPIC's eoi() method is called then? :-O

> It's called from handle_fasteoi_irq as I described in the "basics" ;)

    Indeed, I somehow thought eoi() is out of the threaded exit path of 
handle_fasteoi_irq() -- but it hasn't always been that way!  So, it's probably 
a painful memories of my past quarrel with Ingo over fasteoi breakage that 
played a trick with me here. ;-)

> Randy V.

WBR, Sergei
