To: Dan Malek <dan@embeddededge.com>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx parameter RAM clashes 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Dec 2001 11:11:44 EST."
             <3C2C99C0.1020502@embeddededge.com>
Date: Wed, 28 Nov 2001 17:36:07 +0100
Message-Id: <20011128163612.69675F9BB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C2C99C0.1020502@embeddededge.com> Dan Malek wrote:
>
> Alex Zeffertt wrote:
>
> > I appreciate that there may not be anyone in a position to fix this problem - but I think it's worth
> > mentioning anyway so that future drivers don't make the problem worse.
>
> You need to load the appropriate CPM microcode patches that relocate the
> I2C, SPI, SMC space in the parameter ram and use the new addresses.
> Again, the infrastructure for all of this is in the PowerPC 2_4_devel
> kernels.

Right, Dan, but Alex has a valid point:

There is a lot of potential overlap in parameter RAM that  cannot  be
fixed  by microcode patches (at least I don't know of any uCode-patch
for the SMC1 = UART and SCC3 = ESAR collision mentioned by Alex), and
it would be nice if the drivers would  register  the  locations  they
use,  and  actually  CHECK for collisions, instead of silently let us
run into strange and often hard to debug error conditions.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Where shall I begin, please your Majesty?" he asked. "Begin  at  the
beginning,"  the  King said, gravely, "and go on till you come to the
end: then stop."    - Alice's Adventures in Wonderland, Lewis Carroll

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
