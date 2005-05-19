Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72871679FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 05:54:44 +1000 (EST)
In-Reply-To: <428CEA55.1040904@mrv.com>
References: <20050518170949.GA6766@gate.ebshome.net> <428CD40C.201@mrv.com>
	<2376d87e3df664106a6cf626f9575d90@embeddededge.com>
	<428CEA55.1040904@mrv.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5e493590088edcf959e30390363e798d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 19 May 2005 15:54:54 -0400
To: Guillaume Autran <gautran@mrv.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix cpm_uart_int() missing interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 19, 2005, at 3:34 PM, Guillaume Autran wrote:

> Is it better like this ?

Yes, but now I see one problem with it.  :-)

We have to clear all events even though we may not
handle all of them.  Your while loop filters only the events
we process, but there could be others causing the interrupt
which will never get cleared.  In this case we end up with
an infinite interrupt loop where we don't process anything,
but we don't make the interrupt go away, either.   It may be
easier to forget the loop, just read/clear the event register
up front, then process based on the events based upon
what we found. It's what we tend to do in the other drivers.

The functions called to do the rx/tx processing have loops
in them to process all of the data they find, so it isn't likely
you have left anything behind.  If you want to try to save
the interrupt overhead, change it to do/while, check again
at the end before the exit.

Thanks.


	-- Dan
