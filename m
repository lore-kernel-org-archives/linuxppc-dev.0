To: Jan Damborsky <Jan.Damborsky@devcom.cz>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with data cache on MPC823E 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Jan 2003 17:28:12 +0100."
             <3E2D751C.7000001@devcom.cz>
Date: Tue, 21 Jan 2003 20:49:41 +0100
Message-Id: <20030121194946.43F24C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E2D751C.7000001@devcom.cz> you wrote:
>
> we have developed our board with MPC823E, FLASH memory
> DRAM memory for embedded Linux porting, but we have problem
> with data cache. From time to time when CPU wants load data from DRAM
> to data cache, it makes four burst-reads instead of one for loading one
> cache line.
> After this, all four words in cache line are loaded with the same first
> "critical word".
> We don't know, why CPU repeats this burst-read four times. May be it is
> because we have floating BI (burst inhibit) CPU singnal.
> We have set BIH bit in UPMA to zero.
> When setting this BIH bit to one (burst inhibit), all works well.
> Does anybody have any help ?

This pheomenon is typical for bad SDRAM initialization. Read the chip
manufacturer's manual and follow  the  steps  of  the  init  sequence
_to_the_letter_. It is _not_ sufficient to set up the UPM tables.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Committee, n.:  A group of men who individually can do nothing but as
a group decide that nothing can be done.                 - Fred Allen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
