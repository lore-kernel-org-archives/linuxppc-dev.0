Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F608DE880
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 04:33:53 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6HIXj5j030241
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 14:33:45 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6HIXi6M231732
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 14:33:44 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6HIXiIF010727
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 14:33:44 -0400
Date: Fri, 18 Jul 2008 00:03:39 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [RFC v3 PATCH 0/4] Relocatable kernel support for PPC64
Message-ID: <20080717183339.GA25070@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, miltonm@bga.com
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
0 or 32MB based on which address its loaded. If its loaded by 'kexec -p',
it behaves as a relocatable kernel and runs at 32MB(even though its
compiled for 0). If the same kernel is loaded by yaboot or kexec -l, it
will behave as a normal kernel and will run at the compiled address.

Difference between v3 and v2
* Relocatable kernel build process is integrated with the kernel
  build.
* The problem kdump kernel boot fail on some specific systems is fixed now.

Issues:
* Relocatable vmlinux image is built in arch/powerpc/boot as
  vmlinux.reloc. But it should be built in top level directory of kernel
  source as vmlinux instead of vmlinux.reloc

* During kdump kernel boot, all secondary processors are stuck up. But
  during yaboot all secondary processors are brought online.

Tested on POWER5 systems.

Please send me your suggestions and feedbacks.

Regards,
Mohan.
