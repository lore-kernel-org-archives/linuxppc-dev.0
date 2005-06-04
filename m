Return-Path: <ken@bitsko.slc.ut.us>
Received: from tara.bitsko.slc.ut.us (dsl.76.41.networkiowa.com
	[209.234.76.41]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1324C679F1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 13:48:46 +1000 (EST)
Received: from ken by tara.bitsko.slc.ut.us with local (Exim 4.34)
	id 1DeP76-0004Mu-LF
	for linuxppc-embedded@ozlabs.org; Fri, 03 Jun 2005 22:14:20 -0500
To: linuxppc-embedded@ozlabs.org
From: Ken MacLeod <ken@bitsko.slc.ut.us>
Date: 03 Jun 2005 22:14:19 -0500
Message-ID: <871x7i3jas.fsf@bitsko.slc.ut.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: cpm_uart initializes scm/scc for console only?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We're tracking down an issue trying to use both SMC1 and SMC2 as
ttyCPM devices.  SMC1 as console (and ttyCPM/0) is working fine,
but it appears that SMC2 is not being completely initialized.

It looks as though the cause is that cpm_uart_init_smc (or
cpm_uart_init_scc) is only called from cpm_uart_console_setup[1],
ie. only when CONFIG_SERIAL_CPM_CONSOLE is set, and then only for the
one port that is defined as the console.

It looks like cpu_uart_init_smc/scc should be called at some point for
all ports that are defined for use, but there's no other place it's
called from.

Before we try fixing the wrong thing, is this (using multiple SMC/SCC
ports "out of the box") known to work?  Is there a reason why calling
cpu_uart_init_smc/scc wouldn't have been implemented?

This was found with Linux 2.6.10 and I've reviewed the updates through
2.6.12-rc5 and the patch tracking system.

Sanity check much appreciated,

  -- Ken

[1] http://lxr.linux.no/source/drivers/serial/cpm_uart/cpm_uart_core.c#L1079
