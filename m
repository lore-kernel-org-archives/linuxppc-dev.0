Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C218EB7D16
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Apr 2010 15:07:28 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3E53goE004605
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 15:03:42 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3E50uuY1577212
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 15:00:56 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3E57RK0031305
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 15:07:27 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: perf: Split out arch specific code & improve PowerPC perf probe
	support
Date: Wed, 14 Apr 2010 15:06:37 +1000
Message-Id: <1271221600-25533-1-git-send-email-imunsie@au.ibm.com>
Cc: Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add the required mappings to use perf probe on PowerPC.

Functionality wise it requires the patch titled "powerpc: Add kprobe-based
event tracer" from the powerpc-next tree to provide the
HAVE_REGS_AND_STACK_ACCESS_API required for CONFIG_KPROBE_EVENT. The code will
still compile cleanly without it and will fail gracefully at runtime on the
missing CONFIG_KPROBE_EVENT support as before.

Part 1 of the patch series moves the arch dependent x86 32 and 64 bit DWARF
register number mappings out into a separate arch directory and adds the
necessary Makefile foo to use it.

Part 2 of the patch series adds the PowerPC mappings.


Changes since v1: From Masami Hiramatsu's suggestion, I added a check in the
Makefile for if the arch specific Makefile defines PERF_HAVE_DWARF_REGS,
printing a message during build if it has not. This simplifies the code
removing the odd macro from the previous version and the need for an arch
specific arch_dwarf-regs.h. I have not entirely disabled DWARF support for
architectures that don't implement the register mappings, so that they can
still add a probe based on a line number (they will be missing the ability to
capture the value of a variable from a register).


Thanks,
-Ian
