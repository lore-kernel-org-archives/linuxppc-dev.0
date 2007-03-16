Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AC05DDED2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 03:07:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Exception in kernel mode
Date: Fri, 16 Mar 2007 09:05:14 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B3F@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19B@MERCURY.inside.istor.com>
	<653893AD-CB60-4123-B4FC-FB9B886BD895@kernel.crashing.org>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B3C@MERCURY.inside.istor.com>
	<B6E0A97C-D5E5-4588-BD87-3B884C52DF88@kernel.crashing.org>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

#2 is inside the kernel as well.  Look at the System.map or objdump -
d vmlinux to see what exactly is at those instructions.

> I suspect the actual addresses are red-herrings and this exception=20
> can occur at any address. This certainly would tend to indicate=20
> some sort of memory setup issue.

I think it's useful to know if the instructions at the two offsets=20
C00DEE18 & C002CE68 are similar in some way before jumping to that=20
conclusion.

> Changing the Oops logic to printout the NextInstruction as well as=20
> the NIP might be helpful so I could discern the difference between=20
> what the program is trying to do and what it is really doing.
>
> Are there any other thoughts you might have on diagnosis techniques=20
> at this point?

Try turning on KALLSYMS, this should provide more info on the oops as=20
well.

- k

Dear Kumar:
=20
As always, your advice is appreciated. I will try turning on =
CONFIG_KALLSYMS in the .config file and see if additional info is =
obtained. Also, I will audit the MMU setup and see if I can see anything =
unusual.
=20
Charles
