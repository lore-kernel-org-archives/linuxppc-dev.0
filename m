Message-ID: <3AF6FC60.D5FE49D9@mvista.com>
Date: Mon, 07 May 2001 15:49:52 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tania Oka <tania@centurysys.co.jp>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: power saving
References: <3AF638AC.659C8A1F@centurysys.co.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tania Oka wrote:
>
> I would like to reduce power consumption on a custom MPC855T board.

This has been asked before, and you can read about it in mailing
list archives.

Basically, the MPC8xx processors have a dynamic power management
system that doesn't gain much from just doing something in the idle()
loop.  The majority of the power is consumed by peripherals.  If they
are not enabled, they automatically power down.  All of the MPC8xx
drivers "do the right thing" on open and close to power up/down
peripherals.

If you have some very low power standby requirement, you need to add
lots of power management software to do things like power down/up
any external peripherals on your board, put DRAM in autorefresh
mode, shut down the clocks and put the processor into a deep sleep.
You could look at some of the PowerMac power management code for
design ideas.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
