Date: Wed, 19 Sep 2001 16:31:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA8DF9E.FD235CF6@mvista.com> <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA9241B.4322817A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA9241B.4322817A@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 19, 2001 at 07:02:51PM -0400, Dan Malek wrote:
>
> Tom Rini wrote:
>
> > Er, yes.  But if there's nothing specific to the CPCI405, why add in an
> > empty file and the
>
> There _must_ be something in that file.  At a minimum it has
> to define the board information structure.

Okay.  Here's my latest thoughts.  Which might or might not make sense.  We
now define CONFIG_TREEBOOT and CONFIG_EMBEDDEDBOOT for 4xx.  Lets add in
CONFIG_PPCBOOT, and then in ppc4xx.h, and possibly mpc8xx.h (I haven't looked)
we can do
#ifdef CONFIG_TREEBOOT
#include <asm/treeboot.h> /* Tree board info struct */
#elif defined(CONFIG_EMBEDDEDBOOT)
#include <asm/embeddedboot.h> /* EP & others */
#elif defined(CONFIG_PPCBOOT)
#include <asm/ppcboot.h> /* PPCBoot */
#endif

Or not, 8xx currently does #include <asm/ppcboot.h> in lots of its files.

So, over-engineering or a good idea? :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
