Cc: zzh <david-1z@263.net>, linuxppc-embedded@lists.linuxppc.org
Message-ID: <39037636.B3350172@lucent.com>
Date: Sun, 23 Apr 2000 16:16:22 -0600
From: Steve Tarr <tarr@lucent.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
Subject: Re: memory map
References: <3903BE73.04522@mta2> <3903C55C.DBC66391@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks ---

This IMMR  for the MPC8260 is VERY  tricky, especially with respect to the
Hardware  Configuration Word.
Note that the ADS comes with the HWCW in flash setting the IMMR to
0x0f00_0000. However
the documentation for the ADS  memory map says it should be 0x0470_0000.
Now one of the really screwy parts of this
is that if you hose up your flash, such that the HWCW is scrogged, you can't
get at the processor, even
with the JTAG. You have to go with the default config by tying the RSTCONF to
Vcc.
Actually the PILOT boards have documentation on how to wire one of the
SoftwareSwtiches to
connect RSTCONF to Vcc. Just a warning from one poor soul who had to deal with
it.

Cheers --
tarr


Dan Malek wrote:

> zzh wrote:
>
> > In fact,i am hacking with a motorola 8260 ads board.
>
> I just checked in all of my 8260 changes.  You may find them
> helpful.
>
> > ....I download the
> > mpc8xx to start with.I find it is in fact quite different.
>
> Yes, it is quite different.....It is just a 603 with a bigger
> CPM.
>
> > my board's IMMR=0f000000,so change this to f0000000 in ROM code
>
> That's a good thing.  The current configuration assumes the
> IMMR at 0xf0000000.  Map the board BCSRs up in that range and get
> all of it with one BAT.
>
>         -- Dan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
