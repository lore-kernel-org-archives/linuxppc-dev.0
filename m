Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 031B4B7CF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 13:57:39 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3F3sCMB027791
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Apr 2010 13:54:12 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3F3p5te651340
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Apr 2010 13:51:05 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3F3vbMM009225
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Apr 2010 13:57:37 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] perf: Split out arch specific code & improve PowerPC perf
	probe support
Date: Thu, 15 Apr 2010 13:57:00 +1000
Message-Id: <1271303822-11542-1-git-send-email-imunsie@au.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add the required mappings to use perf probe on PowerPC.

Part 1 of the patch series moves the arch dependent x86 32 and 64 bit DWARF
register number mappings out into a separate arch directory and adds the
necessary Makefile foo to use it.

Part 2 of the patch series adds the PowerPC mappings -
Functionality wise it requires the patch titled "powerpc: Add kprobe-based
event tracer" from the powerpc-next tree to provide the
HAVE_REGS_AND_STACK_ACCESS_API required for CONFIG_KPROBE_EVENT. The code will
still compile cleanly without it and will fail gracefully at runtime on the
missing CONFIG_KPROBE_EVENT support as before as well as printing a warning
message during compilation.


Changes since v2: From Masami Hiramatsu's feedback DWARF support is disabled
altogether if the architecture specific Makefile does not define
PERF_HAVE_DWARF_REGS - ie, DWARF register mappings are missing for the
architecture. A message indicating this is printed out during compilation.
