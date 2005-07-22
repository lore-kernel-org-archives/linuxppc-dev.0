Return-Path: <bantonovici@priority.mb.ca>
From: bogdan antonovici <bantonovici@priority.mb.ca>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <1a928a85f53f5dcd972161356611a312@embeddededge.com>
References: <1121959795.800.18.camel@rd-lab>
	<1a928a85f53f5dcd972161356611a312@embeddededge.com>
Content-Type: text/plain
Message-Id: <1122047198.6726.13.camel@rd-lab>
Mime-Version: 1.0
Date: 22 Jul 2005 10:46:38 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, ppckernel <ppckernel@ppckernel.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: swap_dup: Bad swap file entry 00480020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dan,

I checked the driver code. I found a pointer that was in my opinion
initialized too late and i corrected that but other than that i haven't
found anything.
I ran the driver alone, enabling the interrupts and the interrupt
routine doesn't cause any trouble.
I started my application and i haven't seen any sign of trouble.
But once i started also the snmpd after few interrupts i got the
message:

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process sectionmond

sectionmond being my application.
My read and write driver operation are requesting a page for a buffer
but they also release it. Should i declare the buffer pointer with
volatile attribute?
Do you know what may cause that message?
Thanks
Bogdan



On Thu, 2005-07-21 at 12:59, Dan Malek wrote:
> On Jul 21, 2005, at 11:29 AM, bogdan antonovici wrote:
> 
> > At the time of swap messages i was running a proprietary driver, my
> > application and few daemons.
> 
> Looks like your driver may have written over some of the page
> tables in the kernel space.
> 
> > I look on the net for some clues but it's quite confusing, i noticed
> > many emails on swap_dup/swap_free error messages but i couldn't figure
> > out what should i search for.
> 
> Those messages are likely due to a bug with swapping to disk
> that has been in some 2.4 kernels, but I don't believe that is
> the case here, since you don't have a disk or swapping enabled.
> 
> 
> 	-- Dan
> 
