Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A408ADDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 14:56:26 +1100 (EST)
Message-ID: <47A13EEB.8030806@am.sony.com>
Date: Wed, 30 Jan 2008 19:22:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: build error with kdump shutdown hook support
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

It seems something is missing in the current
linux-2.6.git (8af03e782cae1e0a0f530ddd22301cdd12cf9dc0).

  CC      arch/powerpc/kernel/crash.o
arch/powerpc/kernel/crash.c: In function 'default_machine_crash_shutdown':
arch/powerpc/kernel/crash.c:388: error: '__debugger_fault_handler' undeclared (first use in this function)
arch/powerpc/kernel/crash.c:388: error: (Each undeclared identifier is reported only once
arch/powerpc/kernel/crash.c:388: error: for each function it appears in.)


commit 496b010e1e70a9b4286fa34f19523f24a194f119
Author: Michael Neuling <mikey@neuling.org>
Date:   Fri Jan 18 15:50:30 2008 +1100

    [POWERPC] kdump shutdown hook support

    This adds hooks into the default_machine_crash_shutdown so drivers can
    register a function to be run in the first kernel before we hand off
    to the second kernel.  This should only be used in exceptional
    circumstances, like where the device can't be reset in the second
    kernel alone (as is the case with eHEA).  To emphasize this, the
    number of handles allowed to be registered is currently #def to 1.

    This uses the setjmp/longjmp code around the call out to the
    registered hooks, so any bogus exceptions we encounter will hopefully
    be recoverable.

    Tested with bogus data and instruction exceptions.

    Signed-off-by: Michael Neuling <mikey@neuling.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
