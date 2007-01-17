Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 018EFDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 20:45:54 +1100 (EST)
Date: Wed, 17 Jan 2007 10:24:54 +0100 (MET)
Message-Id: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jeff@garzik.org
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 Jan 2007 17:04:27 -0500, Jeff Garzik wrote:
>Alan wrote:
>> Jeff - at some point we could eliminate a lot of the NULL checks like
>> these by having the registration code fill in the defaults where
>> appropriate ?
>
>libata policy up until this point has been to require all drivers fill 
>in the hook, either with the commonly-used default, or with their own 
>variant.  Thus, no NULL checks for required hooks, and you get an oops 
>if you fail this requirement.  I like that better than defaults buried 
>inside libata-core, where it is easier for programmers to forget them.
>
>But actually, it's an open question for the compiler guys whether this 
>case is preferred:
>
>	if (ap->ops->hook)
>		ap->ops->hook(foo, bar);
>	else
>		commonly_used_default(foo, bar);
>
>or this:
>
>	ap->ops->hook(foo, bar);
>
>With advanced branch prediction in modern CPUs, ISTR the first case may 
>be worth considering, even with the branch.

Indirect function calls incur at least two main costs:
- the 'call *' instruction itself suffers from poor branch
  prediction unless the HW is clever and the call patterns
  are highly biased -- most machines have worse branch
  predictors for indirect jumps than for direct jumps
- the compiler must generate code for setting up parameters
  and spilling the caller's registers, and for reloading the
  caller's registers after the call

If there is a highly common case, the code for that case
is available, and the code is cheap to execute (doesn't
require too many additional variables), then having an
explicit test + inline code is preferred. If any of these
conditions isn't met, then I wouldn't bother converting
the call to the if/inline/call combo.

There are compilers for OOP languages that routinely use
rewrites like the one above in order to optimise method calls.

/Mikael
