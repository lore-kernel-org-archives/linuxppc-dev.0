Date: Thu, 17 Oct 2002 15:58:28 -0400
From: Patrick Mahoney <pmahoney@8d.com>
To: Conn Clark <clark@esteem.com>
Cc: Cameron Rich <CameronR@nulec.com.au>,
	Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx - power save modes - PIT
Message-ID: <20021017195828.GA25234@segfault.usine.8d.com>
References: <1072F1A27E99D3119747005004B9A380016F9573@MAIL> <20021016132208.GA16734@segfault.usine.8d.com> <3DADC571.AF3050F4@esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DADC571.AF3050F4@esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello people,

First of all, this might help some...

HW: rpxlite_dw mpc850
SW: linux 2.4 monta vista

I cut my board's consumption by 800mW by
1) taking off the power leds (100mA)
2) bypassing the power regulator (700mA)

I give 2 sources of current to the board: a 5V and a 3.3V, hence
modelising an ideal regulator. Turns out that the board regulator has
a 66% efficiency.

> > Well the 2.4 Linux kernel does not support runtime modifications to
> > the clock rate. So what's the point of playing with CSCR?
>
> If the CPU is dozing The kernel will never know we changed it as long as
> we change it back when the CPU wakes up.

I 100% agree with you... But it doesn't work... Here are the results I
get:

SCCR[DFHL]:SCCR[DFNL]	| Results
(clock divisers)	|
________________________|_______________________

2x:2x			Works fine

1x:2x			Never wakes up

1x:64x			Kernel oopses
output: "Caused by (from SRR1=40001000): Transfer error ack signal"

SCCR[PRQEN] was '1' for all these tests.


Conn: could you give me the complete values of SCCR and PLPRCR registers?


Thanks again,


Pat Mahoney

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
