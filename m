Return-Path: <marcelo.tosatti@cyclades.com>
Date: Fri, 22 Jul 2005 09:57:50 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: bogdan antonovici <bantonovici@priority.mb.ca>
Message-ID: <20050722125750.GA5950@dmt.cnet>
References: <1121959795.800.18.camel@rd-lab>
	<1a928a85f53f5dcd972161356611a312@embeddededge.com>
	<1122047198.6726.13.camel@rd-lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1122047198.6726.13.camel@rd-lab>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org,
	ppckernel <ppckernel@ppckernel.org>
Subject: Re: swap_dup: Bad swap file entry 00480020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 22, 2005 at 10:46:38AM -0500, bogdan antonovici wrote:
> Hi Dan,
> 
> I checked the driver code. I found a pointer that was in my opinion
> initialized too late and i corrected that but other than that i haven't
> found anything.
> I ran the driver alone, enabling the interrupts and the interrupt
> routine doesn't cause any trouble.
> I started my application and i haven't seen any sign of trouble.
> But once i started also the snmpd after few interrupts i got the
> message:
> 
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process sectionmond

Thats a different problem: you ran out of memory and the VM can't swap
out any data.

So its likely that the pagetable corruption is gone (it was indeed a bug
in the driver as Dan suspected).

> sectionmond being my application.
> My read and write driver operation are requesting a page for a buffer
> but they also release it. Should i declare the buffer pointer with
> volatile attribute?
> Do you know what may cause that message?

Out of memory condition. 
