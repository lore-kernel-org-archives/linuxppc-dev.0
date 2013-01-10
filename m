Return-Path: <fengguang.wu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 3198A2C032A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 21:55:19 +1100 (EST)
Date: Thu, 10 Jan 2013 18:55:13 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [powerpc:next 54/54] arch/powerpc/kernel/exceptions-64s.S:1204:
 Error: attempt to move .org backwards
Message-ID: <20130110105513.GA19224@localhost>
References: <50ee8554.VPKmpSyDNCfRKVZL%yuanhan.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50ee8554.VPKmpSyDNCfRKVZL%yuanhan.liu@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Benjamin,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
head:   61383407677aef05928541a00678591abea2d84c
config: make ARCH=powerpc allmodconfig

All error/warnings:

WARNING: arch/powerpc/mm/built-in.o(.cpuinit.text+0x292): Section mismatch in reference from the function .fake_numa_create_new_node() to the variable .init.data:cmdline
The function __cpuinit .fake_numa_create_new_node() references
a variable __initdata cmdline.
If cmdline is only used by .fake_numa_create_new_node then
annotate cmdline with a matching annotation.
--
arch/powerpc/kernel/kgdb.c: In function 'kgdb_arch_exit':
arch/powerpc/kernel/kgdb.c:492:2: error: '__debugger_breakx_match' undeclared (first use in this function)
arch/powerpc/kernel/kgdb.c:492:2: note: each undeclared identifier is reported only once for each function it appears in
--
arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1204: Error: attempt to move .org backwards
--
drivers/tty/synclink_gt.c:160:12: error: conflicting types for 'set_break'
arch/powerpc/include/asm/debug.h:49:5: note: previous declaration of 'set_break' was here
--
drivers/tty/synclinkmp.c:526:12: error: conflicting types for 'set_break'
arch/powerpc/include/asm/debug.h:49:5: note: previous declaration of 'set_break' was here

vim +1204 arch/powerpc/kernel/exceptions-64s.S

61383407 Benjamin Herrenschmidt 2013-01-10  1198  
61383407 Benjamin Herrenschmidt 2013-01-10  1199  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
61383407 Benjamin Herrenschmidt 2013-01-10  1200  /*
61383407 Benjamin Herrenschmidt 2013-01-10  1201   * Data area reserved for FWNMI option.
61383407 Benjamin Herrenschmidt 2013-01-10  1202   * This address (0x7000) is fixed by the RPA.
61383407 Benjamin Herrenschmidt 2013-01-10  1203   */
61383407 Benjamin Herrenschmidt 2013-01-10 @1204  	.= 0x7000
61383407 Benjamin Herrenschmidt 2013-01-10  1205  	.globl fwnmi_data_area
61383407 Benjamin Herrenschmidt 2013-01-10  1206  fwnmi_data_area:
61383407 Benjamin Herrenschmidt 2013-01-10  1207  

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
