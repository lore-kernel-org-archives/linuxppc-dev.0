Message-ID: <391C3945.9E0A439F@charter.net>
Date: Fri, 12 May 2000 12:03:01 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Richard Hendricks <richard.hendricks@motorola.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Hendricks wrote:
> What do you mean, exactly?  How to get it to run stand-alone?  The
> way I understand it, the 8xxROM code is designed to work stand-alone.

Yes, I understand the 8xxROM code works that way.
Ok, I'll try to explain more clearly...

The 8xxROM code runs nicely with the ADI&mpc8bug connected.
No problems at all.

However, the 8xxROM code does not run *at all* without the ADI &
mpc8bug.
In fact, I'm pretty sure that no instruction at all are being
executed...
(I've modified 8xxrom code to setup IMMR, BR1/OR1 to point at BCSR;
 and then can toggle the AUX LAMP led - all this as about the first
 thing in the reset code).
(And, the above does toggle the AUX led just nicely - *WITH* adi &
mpc8bug).

But, when I exit mpc8bug95 and disconnect the ADI ribbon cable from the
FADS and toggle the power on the FADS; about all I get is the RUN, 5V,
SDRAM, DRAM, and FLASH leds on.  No toggling AUX; nothing else for
as long as I leave it on.  Kind of like its in a constant reset
condition.

Like I mentioned in my previous post, at one point in time I did indeed
see the AUX lamp blinking (*without* the ADI connected) and RS232 light
come on after powering on the FADS.  But, that was several weeks ago
and I'm not sure how this happened.  I'd like to be able to reliably
reproduce that state (ok - I know; according to previous posts, when
one is using a FADS you throw out any chance of reliability).

About at that time, I was wondering what the power up configuration
is set to, and how it gets changed.  I understand that the hardware
asserts something on the bus at power-up (reset?) time to help the
powerpc initialize itself.  I'm wondering if this is correct, and
if it is possible to change this via mpc8bug.  Perhaps mpc8bug puts
this word into a state such that it won't go (Freeze mode or something).
So, I was hoping someone would have the answer to this question.
I'll be working on this tomorrow.

Ok, looking at the users manual now...
It's the Hard Reset Configuration Word (11.3.1.1) that gets put on
the data bus.  It has all sorts of interesting things in it that
presumably can help or hinder the powerpc in getting through a reset.

> Do you mean running with the ADI&MPC8bug connected?  In that case,
> you could try reseting the ADS board without letting MPC8bug run its
> default configuration scripts (type "reset :ni" I believe).  This will
> not initialize any of the on-chip registers.  You might have to turn
> on the ADS board, start MPC8bug, shut off the ADS board, turn the
> ADS board back on again, then run "reset :ni" in order for this to
> work properly, since MPC8bug does a reset when it starts.  This will
> make sure the registers are in their default state.  Once you do that,
> you should be able to do a "go", and the CPU should start automatically
> at 0x0100.

I haven't tried the above, but will do so.

>  Remember though, MPC8bug doesn't do address translation, so
> it will have problems displaying memory locations once the MMU's have
> been enabled.

Yes, I'm aware of that.

Richard, thanks for your reply.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
