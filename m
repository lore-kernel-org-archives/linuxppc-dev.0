Return-Path: <mohan@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CA1FBDDF3A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 05:08:21 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4TJ8IhN024533
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 15:08:18 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4TJ8Dwe061114
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 13:08:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4TJ8CFg001243
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 13:08:13 -0600
Date: Fri, 30 May 2008 00:38:09 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 0/4] Relocatable kernel support for PPC64
Message-ID: <20080529190809.GA15388@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
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

Issues:
* During kdump kernel boot, all secondary processors are stuck up. But
  during yaboot all secondary processors are brought online.
* Relocatable kernel build process is not yet integrated with the kernel
  build.
* Normal kexec'ing this kernel (kexec -l and -e) does not work. It hangs
  in early_init_devtree function while calling the early_init_dt_scan_xxxx
  functions (usually these functions are called by function pointers)
* Some times the exception vectors are overwritten in the kdump kernel.

Building relocatable kernel support:
Enable "Build a kdump crash kernel" option and "Build relocatable kernel"
options to build the kernel as relocatable.

After the kernel build, build the relocatable kernel by running
        make -f make.reloc

Copy the vmlinux.reloc to /boot, build initrd and update yaboot.conf to
include the entry for 'vmlinux.reloc' and corresponding initrd

Please give me your comments and suggestions to fix the above issues and
improve this feature.

Note:
Please ignore my previous mail as its subject was incorrect and the mail
contents are not aligned properly.

Regards,
Mohan.
