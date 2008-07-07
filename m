Return-Path: <mohan@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83F79DE655
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 03:26:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67HQ6WZ008300
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 13:26:06 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67HQ6fe231658
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 13:26:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67HQ54v028490
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 13:26:06 -0400
Date: Mon, 7 Jul 2008 22:56:00 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [RFC v2 PATCH 0/4] Relocatable kernel support for PPC64
Message-ID: <20080707172600.GE11470@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, michaele@au1.ibm.com, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Following four patches enable the "relocatable kernel" feature for
PPC64 kernels.
        1. extract_relocation_info.patch
        2. relocation_build.patch
        3. apply_relocation.patch
        4. relocation_support.patch

With the patchset, vmcore image of a crashed system can be captured
using the same kernel binary.

Still the kernel is not a fully relocatable kernel. It can either run at
0 or 32MB based on which address its loaded. If its loaded by 'kexec
-p',
it behaves as a relocatable kernel and runs at 32MB(even though its
compiled for 0). If the same kernel is loaded by yaboot or kexec -l, it
will behave as a normal kernel and will run at the compiled address.

Issues:
* During kdump kernel boot, all secondary processors are stuck up. But
  during yaboot all secondary processors are brought online.
* Relocatable kernel build process is not yet integrated with the kernel
  build.
* Kdump kernel boot fails on some specific systems because exception vectors
  are overwritten (When I tested the same kernel binary on an another
  machine kdump kernel boots). No issues in OpenPower and Power6 machines. I
  have faced exception overwritten problem in one Power5 lpar.

Building relocatable kernel support:
Enable "Build a kdump crash kernel" option and "Build relocatable
kernel"
options to build the kernel as relocatable.

After the kernel build, build the relocatable kernel by running
        make -f make.reloc

Copy the vmlinux.reloc to /boot, build initrd and update yaboot.conf to
include the entry for 'vmlinux.reloc' and corresponding initrd

Please give me your comments and suggestions to fix the above issues and
improve this feature.

Regards,
Mohan.
