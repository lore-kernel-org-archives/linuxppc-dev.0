Subject: Re: 4xx critical exceptions
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021204230047.98430.qmail@web40912.mail.yahoo.com>
References: <20021204230047.98430.qmail@web40912.mail.yahoo.com>
Content-Type: text/plain
Date: 06 Dec 2002 10:22:33 +0100
Message-Id: <1039166553.24797.44.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2002-12-05 at 00:00, Brian Kuschak wrote:
>
> I'm interested in using the watchdog interrupt as a
> critical exception.  I have somthing that sort-of
> works, in that I get wdt interrupts and service them
> appropriately, but I'm getting panics on a regular
> basis.

I thought this was strange as I had seen a watchdog driver in the kernel
for 405 but after reading the source of said driver I no longer think
that:(

I have not tried the driver but from the look of it I would say it's not
doing anything useful.

> I'm guessing we don't have any unused SPRGx registers
> to use here.  I was thinking about temporarily
> disabling CE until saving SPRG0,1, but that can't be
> done without using at least one register, and none of
> them are saved at that point.
>
> Any ideas?

Not really. Do you want to try to set up a c environment or do you plan
on just doing the thing in asm directly? The code in the exception
handler do not have to do much something like

if(wdt_count++ < max_wdt_loops)
	clear_wdt_ENW();
return

should do. Then if userspace or whatever it is that kicks the dog has
not reset the wdt_count we let the hardware just do the reset.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
