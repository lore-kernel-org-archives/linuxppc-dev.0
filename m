Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id BEF36679E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 17:24:35 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j527TY8X001419
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 2 Jun 2005 10:29:39 +0300 (EEST)
Message-ID: <429EAF88.8040507@intracom.gr>
Date: Thu, 02 Jun 2005 10:04:40 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20050601165054.GA2607@logos.cnet>
	<1117680392.31082.16.camel@gaston>
In-Reply-To: <1117680392.31082.16.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] handle access to non-present IO ports on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2005-06-01 at 13:50 -0300, Marcelo Tosatti wrote:
> 
> Hrm... removing a PCMCIA card triggers mchecks ? that is bad... With
> "proper" PCMCIA controllers, those are swallowed properly when the card
> is removed. The eating of the machine check is a bit too hackish to my
> taste... Better is to "not do that" by making sure the legacy crap isn't
> trying  to tap unexisting ports, but then, if PCMCIA is also a
> problem...
> 

8xx is not proper in any way whatsoever :)

There's no way to fix this thing with simple software hacks.

For example take a PCMCIA driver that's minding it's own businees,
when someone yanks the card out.

cli()
...
inb(xxx)
...
<----- card is yanked here
...
inb(yyy)
...
<----- MCE here
sti()

> 
>>1) why does the current PowerMac version covers only inb() and not outb() ?  
>>I had to add outb() exception table entries for 8xx.
> 
> 
> Not sure, maybe historical loss ? :) You should CC paulus
> 
> 
>>2) Is the same wanted for other embedded PPC's? 
> 
> 
> It's up to you. It slows down those IOs, but on the other hand, inX/outX
> aren't supposed to be very common anymore, at least not with "fast"
> devices, and the IO itself is usually an order of magnitude slower than
> doing those syncs...
> 

Fast ISA I/O. :)

> 
>>3) How to make the misc.S exception entries and additional instructions 
>>selectable only on the platform who need it? #ifdef does not sound 
>>a good idea. 

I wouldn't mind...

>>
>>Nevermind the "#ifdef CONFIG_ALL_PPC" crap - that needs to be done
>>properly.
>>
>>

Regards

Pantelis

P.S. Good job marcello :)
