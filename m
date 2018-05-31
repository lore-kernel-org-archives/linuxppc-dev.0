Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF3856FGzDsC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:33:56 +1000 (AEST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w4V4Xoo2016834
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 23:33:51 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: 
Date: Thu, 31 May 2018 14:33:38 +1000
Message-Id: <20180531043349.24783-1-benh@kernel.crashing.org>
Reply-To: [RFC.PATCH.00/11]prom_init.cleanups.and.sanitization@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

prom_init is a rather "special" bit of code. Run once when booting
from Open Firmware as pretty much the very first thing we do, it
will perform all communications with OF before it gets killed and
extract the device-tree for the kernel use. It will then re-enter
the kernel at its main entry point but this time with an FDT.

Future secure VM support will require that entry to happen in the
form of a call to the Ultravisor, which will check the integrity
of the kernel image.

Thus it's critical that prom_init doesn't actually write to the
portions of the kernel potentially being checked, or if it does,
undoes it.

This series is a set of a cleanup and a first step in that direction.

All of prom_init static (it shares no globals with the rest of the
kernel appart from some rodata stuff) are moved to a separate ELF
section placed in .bss if they are writeable, or .rodata if not.

We can later move that section elsewhere if necessary or re-clear
the .bss before entering the kernel.

prom_init already takes care of restoring relocs to their original
state.
