Date: Fri, 24 May 2002 13:47:31 -0700
From: Matt Porter <porter@cox.net>
To: Roland Dreier <roland@topspin.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ZMII Code Panics on 440GP Ebony
Message-ID: <20020524134731.A21503@home.com>
References: <20020524155815.98552.qmail@web21402.mail.yahoo.com> <52y9e9ebxm.fsf@topspin.com> <20020524122024.B21309@home.com> <52lma9e4o4.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52lma9e4o4.fsf@topspin.com>; from roland@topspin.com on Fri, May 24, 2002 at 12:17:47PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 24, 2002 at 12:17:47PM -0700, Roland Dreier wrote:
> >>>>> "Matt" == Matt Porter <porter@cox.net> writes:
>
>     Matt> I started some things but have been busy with functionality
>     Matt> for some time now.  I'd be interested in any cleanup patches
>     Matt> you would produce.  The idea is to separate ibm440.h,
>     Matt> ibm440gp.h, and <board>.h as appropriate.  As you've
>     Matt> noticed, I took some shortcuts in the interest of getting
>     Matt> the core code in front of everybody quickly. :)
>
> OK, I will send you some trivial stuff soon.  I do have one question:
> what belongs in ibm440.h (as opposed to ibm440gp.h)?  The only
> documentation I have is specifically for the 440GP (other than a
> presentation on the 440GX) -- how do we know what is common to the 440
> family?

Well, as a starting point, most of what is in ibm440.h should be
in ibm440gp.h.  The board stuff will go to ebony.h, the dcr macros
to ibm440.h, and all the on-chip defs (UIC, MEM controller, MAL,
PLB, PCI-X, and peripheral nums) go to ibm440gp.h.  You can
look at the 440 core UM to see what is part of the core.  Considering
the nature of a Book E part, the core defines the existence of
DCRs, but they will vary between implementations.  Looking at
the 405 implementations should give a clue as to what kind
of 440 implementations we can expect to see.

For now, we can ignore the 440GX except keeping in mind that it
is a different set of peripherals.  It's safe to assume that
things like the UIC and memory controller will have similar
if not identical definitions in ibm440gx.h but there's no
point worrying too much until the docs are available. :)
To start off we'll probably copy ibm440gp.h, make additions
and then try to abstract into a shared file later...that's
some time down the road yet though.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
