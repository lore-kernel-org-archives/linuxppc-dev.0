Message-Id: <200009122127.XAA00922@piglet.grunz.lu>
Date: Tue, 12 Sep 2000 23:27:34 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: sysctl support for ICTC
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000912205547.30777@192.168.1.10>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Found something else re. power management...

On  12 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>As an exercise ;-), I've added sysctl support for controlling and
>>displaying the contents of the G3 (and G4?) ICTC register.
>
> Heh ! Nice ;) That's something I've wanted to do for years and never
> ended up actually coding ;)

I know that feeling ;-))

>>So, managing ICTC could be part of an intelligent apmd-style daemon
>>specifically for PPC.
>
> Well, I didn't think about that aspect of things with DPM.
>
> The Darwin code has complete temperature control and uses the ICTC to
> regulate it. That could be done from userland too on linux, by also
> adding some support for the temp. registers.

Ah, temp registers. That's good, since IIRC there were a few atempts
long ago in this place to add temperature monitoring, but none ever
ended up with something useful. Finally, that 0 in the cpuinfo could be
replaced with something meaningful ;-)

Now, about conserving power on portable machines, there's another thing.
In the idle task, the processor (if supporting sleep) is put to either
NAP or DOZE mode (see arch/ppc/kernel/idle.c). NAP mode seems to save
more power, but there's no snooping. Don't know whether that would be a
problem... but I guess it could. Anyway, if somebody wants to
experiment, NAP can be enabled with
/proc/sys/kernel/powersave-nap.

Also, if the G4 supports power management, its PVR should be added to
power_save() in arch/ppc/kernel/idle.c, in preparation for G4 Powerbooks
;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
