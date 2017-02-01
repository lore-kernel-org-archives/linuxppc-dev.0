Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vClL42kFYzDqBl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:05:32 +1100 (AEDT)
In-Reply-To: <147733331174.26684.12646675491489853468.stgit@jupiter.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [v2] powerpc/fadump: Fix the race in crash_fadump().
Message-Id: <3vClL36DFMz9tJD@ozlabs.org>
Date: Wed,  1 Feb 2017 12:05:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-10-24 at 18:21:51 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> There are chances that multiple CPUs can call crash_fadump() simultaneously
> and would start duplicating same info to vmcoreinfo ELF note section. This
> causes makedumpfile to fail during kdump capture. One example is,
> triggering dumprestart from HMC which sends system reset to all the CPUs at
> once.
> 
> makedumpfile --dump-dmesg /proc/vmcore
> read_vmcoreinfo_basic_info: Invalid data in /tmp/vmcoreinfoyjgxlL: CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971
> makedumpfile Failed.
> Running makedumpfile --dump-dmesg /proc/vmcore failed (1).
> 
> makedumpfile  -d 31 -l /proc/vmcore
> read_vmcoreinfo_basic_info: Invalid data in /tmp/vmcoreinfo1mmVdO: CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971CRASHTIME=1475605971
> makedumpfile Failed.
> Running makedumpfile  -d 31 -l /proc/vmcore failed (1).
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f2a5e8f0023eba847ad2adb145b2f6

cheers
