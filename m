Date: Wed, 8 Jan 2003 18:21:27 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI-2000
In-Reply-To: <DF2B720CF774D21189EE00805FA7FA22051782FD@nmrusdunsx3.nielsenmedia.com>
Message-ID: <Pine.LNX.4.40.0301081809190.10130-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 8 Jan 2003, Wells, Charles wrote:

> When I read Cecilia's post, I assumed what the statement "proven hardware
> platform" meant was that the vxworks O/S and user tasks exercised all the
> peripheral hardware; i.e., the SDRAM works, the ROM works, the FLASH works,
> the console works, etc.  So, that statement made sense to me.  While Linux

vxWorks doesn't use the MMU as much as Linux does. On Linux, the kernel and
all processes run in their own address space. The memory accesses involved
for cache or tlb refills are quite different to what's happening in a
vxWorks setup. Again, I'm probably overly pessimistic here, but we _have_
seen HW problems that just didn't show up when running vxWorks (AFAIR it was
a burst access on some early G4 based system.)

On a related matter, the following might also be interesting, especially
regarding the question of what firmware to use. The vxWorks boot-loader
tends to initialise _a lot_ of things you don't necessarily need. For
instance, on IBM405 based systems it sets up the on-chip RAM at address
0x70000000. Not a good idea when switching to user-mode the first time. Took
me quite some time to find this one... ;-)

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
