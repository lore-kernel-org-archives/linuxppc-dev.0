Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 45C6767AB0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Mar 2005 09:43:02 +1100 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 25 Mar 2005 17:42:59 -0500
Date: Fri, 25 Mar 2005 17:41:25 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.61.0503251733170.18399@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: why is entire 8xx architecture defined as "broken"?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


  after i looked at the Kconfig setup for 2.6.11-5, i'm a bit puzzled
-- why is the entire 8xx architecture defined as "BROKEN"?  follow the
logic along:

arch/ppc/Kconfig:

	config 8xx
		depends on BROKEN
		bool "8xx"

  and what means "BROKEN"?

init/Kconfig:

	config BROKEN
		bool
		depends on !CLEAN_COMPILE
		default y

  ok, and "CLEAN_COMPILE"?  defined just above that:

	config CLEAN_COMPILE
		bool "Select only drivers expected to compile cleanly" if
			EXPERIMENTAL
		default y

  ok, and "EXPERIMENTAL"?

	config EXPERIMENTAL
		bool "Prompt for development and/or incomplete code/drivers"

and *that* refers to the top-level menu entry regarding whether you
want to take a chance on "development and/or incomplete code/drivers",
not entire architectures.

  the above seems just a tad misleading, no?

rday
