To: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: apmd and other archs
Message-ID: <975078692.3a1e8524619b1@imp.free.fr>
Date: Fri, 24 Nov 2000 16:11:32 +0100 (MET)
From: Bastien Nocera <hadess@writeme.com>
Cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
References: <974986581.3a1d1d55698b0@imp.free.fr> <19341019072246.27236@192.168.1.2>
In-Reply-To: <19341019072246.27236@192.168.1.2>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Quoting Benjamin Herrenschmidt <bh40@calva.net>:

> >Hi,
> >
> >Seems like I missed a good part of the discussion... First reason I
> >wanted apmd
> >marked as x86 only, is because it is useless _now_ on power-pc. We have
> a PMU,
> >not an APM BIOS (ugh!), we have pmud not apmd. What is the point
> compiling it
> >for powerpc if it's not working and will probably never ?
>
> Don't mix PowerPC and PowerMac. PowerMacs rely on pmud. But PReP and

I try not to...

> CHRP
> machines can be more PC-like that you'd like them to in some cases :)
> They don't really have an apm bios, but who knows... They certainly
> don't
> have a PMU and don't use pmud.
>
> I've been told there's an IBM PReP thinkpad out there. What does this
> box
> use for power management ? It's own mecanism ?

So, I made the incorrect assumption that the only PowerPC laptops out there were
Apple's. Blamme.

I have one question: desktops need to use the PMU for sleep as well, don't they
? Does pmud work on a desktop ? It would be nice if pmud was used as a gateway
between user-land applications (like a little sleep application, or a battery
monitor), and the kernel, in fact the PMU device.
AFAIK, apmd already does that, and apps (should) rely on libapm to avoid changes
on the underlying kernel.

We need at some point to make a decision. Right now we have:
1) PMU, handled by the kernel
2) pmud, giving a pseudo APM interface
3) apps using this pseudo interface

or
2) pmud, giving a PMU interface
3) apps using the directly the PMU

What I was trying to do with this libapm4pmud was:
2) pmud, giving a PMU interface
3) libapm sitting on top of pmud (either via the pmu or the apm interface)
4) Any application using libapm

What has been talked in this thread was:
2) having a /proc interface in the kernel for apm compatibility. I don't think
this is a good idea. Transforming data of this kind could be done in user-land
(like in a library).
1) APM interface for everything directly in the kernel. No good for me either.
The APM interface on PCs is pretty simple because you have the hardware (well
the BIOS) that gives away all the proper information. This is not the way to go,
like it's been said, Linux/PowerMac doesn't have a VGA emulation in the kernel,
so why an APM ?

I still think a libapm library for power macs is the way to go. If some day
somebody proves me wrong by providing an APM interface to the kernel, you'd just
have to recompile your application.
What I'd like to change is pmud to use a FIFO or a Unix Socket for advertising
its status, the TCP socket is just damn slow. Remove the apm interface. Use the
libapm library or directly the PMU interface. I like the idea of an event queue
for the newer Macs, APM already behaves like that, better than polling the
interface every second.

My 2 pennies.

/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
