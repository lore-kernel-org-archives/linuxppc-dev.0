Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F384B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:19 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9171Y3Y007004
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:01:34 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176HYq1175572
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:18 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176Hu5024625
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:17 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: Introduce support for little endian PowerPC
Date: Fri,  1 Oct 2010 17:05:53 +1000
Message-Id: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some PowerPC processors can be run in either big or little endian modes, some
others can map selected pages of memory as little endian, which allows the same
thing. Until now we have only supported the default big endian mode in Linux.
This patch set introduces little endian support for the 44x family of PowerPC
processors.

This patch set in combination with a patched GCC, binutils, uClibc and
buildroot has allowed for a full proof of concept little endian environment on
a 440 Taishan board, which was able to successfully run busybox, OpenSSH and a
handful of other userspace programs without problems.

I am not currently in a position to release my patches for the toolchain, but
in the meantime I thought I would send my patches on the kernel side for review
and feedback.

While my toolchain patches are necessary to support the powerpcle-linux target,
the kernel can still be built with an unpatched toolchain using the
powerpcle-elf target instead. Userspace programs, however, do require the
patched toolchain to build.

Since the processor still starts as big endian, the boot wrapper must still be
compiled with a big endian 32bit toolchain. This can be passed into the build
as CROSSBE_COMPILE in the same manner as the CROSS_COMPILE variable. When the
boot wrapper is finished it runs some platform specific assembly to switch to
little endian and execute the kernel.

This is not yet complete support for little endian PowerPC, some outstanding
issues that I am aware of are:
 * We only support 32bit PowerPC for now (and indeed, only 44x)
 * The vdso has not been fixed to be endian agnostic - any userspace program
   accessing it will get an unexpected result.
 * I have not touched PCI at all
 * Remaining device tree accesses still need to be examined to ensure they are
   correctly handling the endianess of the device tree.
 * Any other driver that uses the device tree is likely be broken for the same reason.
 * I've included a patch for the alignment handler, however it is as yet
   completely untested due to a property of the hardware I've been using for
   testing.
