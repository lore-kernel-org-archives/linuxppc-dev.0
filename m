To: Pantelis Antoniou <panto@intracom.gr>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>, joakim.tjernlund@lumentis.se,
	acurtis@directvinternet.com, Paul Mackerras <paulus@au1.ibm.com>,
	Matt Porter <porter@cox.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Dec 2002 10:00:10 +0200."
             <3DF8420A.4040409@intracom.gr>
Date: Thu, 12 Dec 2002 09:18:36 +0100
Message-Id: <20021212081841.390C7C613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3DF8420A.4040409@intracom.gr> you wrote:
>
> They only reason that I considered the consistent() routines was
> that the 8xx routines are unsuitable for use in modules.

This  is  trivial  to  fix  -  just  add  the  missing  EXPORT_SYMBOL
statements  to  arch/ppc/kernel/ppc_ksyms.c  ;  but be aware that the
current implementation will leak CPM resources upon module  unload  -
which  is probably the main reason that these symbols are not expoted
for use in modules.

> I will prepare a patch that deals with the inefficiencies
> of the 8xx routines.

Don't re-invent the wheel. There is an implementation  of  this  code
available  in  our  kernel  source tree (linux-2.4 module in our CVS)
which for example provides both m8xx_cpm_dpalloc / m8xx_cpm_dpfree

I sent the patches to Tom Rini. Several times. I don't know why  they
never  made  it into the official kernel source tree. [This is why we
have to maintain our own source tree.]


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The C-shell doesn't parse. It adhoculates.
    - Casper.Dik@Holland.Sun.COM in <3ol96k$b2j@engnews2.Eng.Sun.COM>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
