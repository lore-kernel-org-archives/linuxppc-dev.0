Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1A4BDE101
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 06:11:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7BKBakX011132
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 16:11:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7BKBO0i216734
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 16:11:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7BKBNm1013366
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2008 16:11:24 -0400
Date: Tue, 12 Aug 2008 01:41:20 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/5] Relocatable kernel support for PPC64
Message-ID: <20080811201120.GA25283@in.ibm.com>
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

Following five patches enable the "relocatable kernel" feature for
PPC64 kernels.
	1. Extract list of relocation offsets.patch
	2. Build files needed for relocation.patch
	3. Apply relocation.patch
	4. Relocation support.patch
	5. Relocation support for kdump kernel.patch

Paul, can you please merge these patches to the powerpc git tree?

With the patchset, vmcore image of a crashed system can be captured
using the same kernel binary.

Still the kernel is not a fully relocatable kernel. It can either run at
0 or 32MB based on which address its loaded. If its loaded by 'kexec -p',
it behaves as a relocatable kernel and runs at 32MB(even though its
compiled for 0). If the same kernel is loaded by yaboot or kexec -l, it
will behave as a normal kernel and will run at the compiled address.

Difference between previous patchset and current
* The problem kdump kernel boot fail on some specific systems is fixed now.
* Kdump kernel boot failed with git tree kernels, its fixed now.

Issues:
* Relocatable vmlinux image is built in arch/powerpc/boot as
  vmlinux.reloc. But it should be built in top level directory of kernel
  source as vmlinux instead of vmlinux.reloc

Limitation:

* During kdump kernel boot, all secondary processors are stuck up. But
  during yaboot all secondary processors are brought online.

Since relocatable kernel is used only for kdump kernels and kdump
kernel is always booted with "maxcpus=1" kernel parameter, there is no
significant difference. It can be marked as a known issue.
(I am trying to fix this issue)

Tested on POWER5 systems.

Regards,
Mohan.
