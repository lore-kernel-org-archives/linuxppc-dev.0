From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PMU panic in 2.4bk
Date: Tue, 30 Jan 2001 10:45:51 +0100
Message-Id: <19341225031735.27091@mailhost.mipsys.com>
In-Reply-To: <01012916552001.05635@momiji>
References: <01012916552001.05635@momiji>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Symptoms:  upon heavy access to video (fb console or ati/XF4) like scrolling
>or netscape full screen, or heavy access to the hard drive (fsck or huge
>copy), I get 'LCD fire' (melting as some call it).  On once instance, the
>system just powered off after a brief burn/melt.   I know this is what
>happens when the PMU is ignored for too long.
>
>System: standard WallstreetII(PDQ) 300MHz, 384M RAM,  IBM 30G drive (4200rpm
>type)
>
>Anyone know more about this or how it might be fixed?

The PMU driver is interrupt driven. So the only thing supposed to be able
to cause this problem is if interrupts are turned off too long while the
PMU is in the middle of transmitting (or receiving) a message.

One this that may help is to turn ON the IDE "unmask" option with hdparm.
There's no reason to mask interrupts during transfers on recent
controllers (anything more recent than old buggy x86 stuffs), however
this option is OFF by default.

Another possible cause is a kernel crash or hang. If the PMU was
communicating at that time, then you are dead. If you can reproduce the
problem, try running without pmud (thus lowevering the frequency of PMU
requests).

I've seen this problem happening once or twice (with screen melt) on a
friend's machine, and the LCD "melting" is _not_ caused by the PMU
crashing. It's caused by the ATI chip crashing (FIFO issue in the driver
?). Now, it's possible that if xmon tries to display something in the
middle of an XFree accelerated operation, that would cause the ATI chip
to crash.

So my diagnositc is that something is crashing your box, possibly XF4 ATI
driver or atyfb, and this tend to happen while the PMU is talking or
beeing talked to.

If it was a PMU timeout, all you would get would be a brutal shutdown,
not a melting screen.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
