Message-ID: <006f01c3847f$17943dd0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>,
	"Tom Rini" <trini@kernel.crashing.org>
Cc: "Jean-Denis Boyer" <jdboyer@m5t.com>,
	"Steffen Rumler" <Steffen.Rumler@siemens.com>,
	"linuxppc" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLEEGCFPAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se> <20030926212410.GB8927@ip68-0-152-218.tc.ph.cox.net> <3F74BBC5.3010302@embeddededge.com>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Date: Sat, 27 Sep 2003 00:39:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Tom Rini wrote:
>
> > KGDB still works for me.  Dan, any final thoughts / comments /
> > objections?
>
> In the last patch I saw, we are blocking interrupts for quite a while,
> across a copy_from_user(), in 8xx_write().

Yes, thats correct. I did try different ways around that but the only thing that
would work is to make copy_from_user() copy to i tmp buf and then copy the
tmp buf into the BD. Would that be better?

 Jocke

> This can cause large
> interrupt latencies due to page faults, it would be nice if could fix that.
>
> -- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
