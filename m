Return-Path: <ralf@linux-mips.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8479AB6FA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 05:47:28 +1000 (EST)
Message-Id: <20110601180456.801265664@duck.linux-mips.net>
Date: Wed, 01 Jun 2011 19:04:56 +0100
From: ralf@linux-mips.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mips@linux-mips.org
Subject: [patch 00/14] Sort out i8253 and PC speaker locking and headers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No longer terribly relevant these days but still broken and just an eyesore
mess of neglience just as I've already raised it a few days ago.  Time to
sort this.

drivers/input/misc/pcspkr.c:

#if defined(CONFIG_MIPS) || defined(CONFIG_X86)
/* Use the global PIT lock ! */
#include <asm/i8253.h>
#else
#include <asm/8253pit.h>
static DEFINE_RAW_SPINLOCK(i8253_lock);
#endif

sound/drivers/pcsp/pcsp.h:

#if defined(CONFIG_MIPS) || defined(CONFIG_X86)
/* Use the global PIT lock ! */
#include <asm/i8253.h>
#else
#include <asm/8253pit.h>
static DEFINE_RAW_SPINLOCK(i8253_lock);

$ git grep -F pcsp.h sound/drivers/pcsp
sound/drivers/pcsp/pcsp.c:#include "pcsp.h"
sound/drivers/pcsp/pcsp_input.c:#include "pcsp.h"
sound/drivers/pcsp/pcsp_lib.c:#include "pcsp.h"
sound/drivers/pcsp/pcsp_mixer.c:#include "pcsp.h"
$ git grep -w i8253_lock sound/drivers/pcsp/
sound/drivers/pcsp/pcsp.h:static DEFINE_RAW_SPINLOCK(i8253_lock);
sound/drivers/pcsp/pcsp_input.c:        raw_spin_lock_irqsave(&i8253_lock, flags
sound/drivers/pcsp/pcsp_input.c:        raw_spin_unlock_irqrestore(&i8253_lock, 
sound/drivers/pcsp/pcsp_lib.c:          raw_spin_lock_irqsave(&i8253_lock, flags
sound/drivers/pcsp/pcsp_lib.c:          raw_spin_unlock_irqrestore(&i8253_lock, 
sound/drivers/pcsp/pcsp_lib.c:  raw_spin_lock(&i8253_lock);
sound/drivers/pcsp/pcsp_lib.c:  raw_spin_unlock(&i8253_lock);
sound/drivers/pcsp/pcsp_lib.c:  raw_spin_lock(&i8253_lock);
sound/drivers/pcsp/pcsp_lib.c:  raw_spin_unlock(&i8253_lock);

Locks are great, everybody should have their own lock!

$ find . -name 8253pit.h
./arch/powerpc/include/asm/8253pit.h
./arch/alpha/include/asm/8253pit.h
$ cat arch/*/include/asm/8253pit.h
/*
 * 8253/8254 Programmable Interval Timer
 */
/*
 * 8253/8254 Programmable Interval Timer
 */
$

Eh...

$ git grep -w PCSPKR_PLATFORM 
arch/mips/Kconfig:      select PCSPKR_PLATFORM
arch/mips/Kconfig:      select PCSPKR_PLATFORM
arch/mips/Kconfig:      select PCSPKR_PLATFORM
arch/powerpc/platforms/amigaone/Kconfig:        select PCSPKR_PLATFORM
drivers/input/misc/Kconfig:     depends on PCSPKR_PLATFORM
init/Kconfig:config PCSPKR_PLATFORM
sound/drivers/Kconfig:  depends on PCSPKR_PLATFORM && X86 && HIGH_RES_TIMERS

So the status is:

 Alpha:		There is no PCSPKR_PLATFORM so while a platform device is
		being installed no drivers will be built.  I don't know
		which Alpha platforms or even if all of Alpha should be
		doing a PCSPKR_PLATFORM so I haven't even tried to sort
		this.
 ARM:		No PC speaker supported, yeah :)
 PowerPC:	Should compile but the locking is wrong but only the AmigaOne
   		platforms should be affected.
 MIPS:		Ok.
 x86:		Ok.
 All others:	No PC speaker supported

Also only the plain old IBM PC XT was using a i8253; every later system
had i8254.  So maybe this is the time for renaming the support code?

  Ralf
