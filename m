Date: Thu, 26 Jun 2003 11:33:02 -0600 (MDT)
From: Terry Greeniaus <tgree@phys.ualberta.ca>
To: Chris Studholme <cvs@cs.utoronto.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: how to setup PLL1 on 750FX
In-Reply-To: <Pine.LNX.4.44.0306261242570.31017-100000@stoa.dhs.org>
Message-ID: <Pine.LNX.4.10.10306261126040.7619-100000@pneuma.phys.ualberta.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 26 Jun 2003, Chris Studholme wrote:

> I know HID1 is 0x92000000 after boot and except for my twiddling of a bit
> to detect the 750FX, it is not changed.  This value is slightly confusing.
> It indicates that PLL0 is in use, and its config is external.  PLL_CFG is
> 18 (decimal) which indicates a multiplier of 9x.  That's fine as my cpu
> speed is 900MHz on a 100MHz bus.  But PLL_RNG appears to be 01 (binary),
> which is labeled as a reserved value in the IBM docs.  What is the purpose
> of PLL_RNG (range bits) anyway?

In our code we use the following:

PLL_RNG			CPU freq
------------------------------------------
0b10			less than 600 MHz
0b00			between 600 and 750 MHz
0b01			above 750 MHz
------------------------------------------

I don't recall exactly where I got that last PLL_RNG setting from, it
may have been from an email from an IBM engineer or something.  Last
time I checked it indeed wasn't documented anywhere.

> I'm trying to set PLL1 to 4x using the code:
>
>   mtspr(HID1,(mfspr(HID1)&~0xFE)|0x44);
>
> This should set PLL_CFG to a value of 8 (for a multiplier of 4x) and
> PLL_RNG to 10 (binary) which the IBM docs say should be used when the
> frequency is below 600MHz.  Note that I've also tried 00 and 01 as values
> of PLL_RNG and they all fail.  I've tried this both with and without a
> delay afterwards.  My delay is simply:

This code all looks fine to me.  You do need to put in a delay so that
the PLL can stabilize before using it.  We use a 0.5 second delay, which
is probably waaaay overkill.

Also, switching between two half-integer ratios is considered a
programming error, but you don't seem to be doing that and AFAICT this
code should not cause you to hang, especially if you aren't even
switching over to PLL1 yet.

TG


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
