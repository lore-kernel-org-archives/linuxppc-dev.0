In-Reply-To: <38431D61.4977E59B@netx4.com>
Date: Tue, 30 Nov 1999 16:44:39 +0100
To: Dan Malek <dan@netx4.com>, paulus@linuxcare.com,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: dmasound problems
Message-Id: <19991130164439.032538@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 29, 1999, Dan Malek <dan@netx4.com> wrote:

>If these are actually a power and reset to the audio codec, there
>are timing constraints.  Usually, you have to power up and hold
>reset at least 50 milliseconds before releasing reset (Crystal
>codec specs).
>
>This is why it may work with XMON if you set/clear bits
>individually, but not work when you run the code.

This was indeed a couple of timing issue (not only with those FCR bits
BTW). I traced MacOS and it sets both bits almost at the same time, so I
beleive this is not a reset issue, but I have to wait 1 sec
(mdelay(1000)) after setting the power bit and before programming the
chip if I want it to work. I tried various smaller delays, but 1s seems
the correct value. (with lower delays, I could still access the chip
registers and read the revision number, but I had no sound).

I still have one problem with the console beep not coming back after
sleep (if I launch mpg123, it plays fine and my beep is back. Also,
sleeping while mpg123 is playing correctly resume the play). This chip
seems to be very sensitive to timings in general.

A fix will be with my other patches (ibook, ...). Also, the sound chip is
now correctly powered off when the machine goes to sleep (or when
dmasound module is removed).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
