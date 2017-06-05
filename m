Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whHl45g5ZzDqKr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 00:49:04 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55Emx2t133068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 10:49:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aw99gra3r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 10:49:00 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 08:48:30 -0600
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v55EmRUt17695202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 07:48:27 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF0A313603C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 08:48:27 -0600 (MDT)
Received: from oc1554177480.ibm.com (unknown [9.53.92.157])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP id A00F113603A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 08:48:27 -0600 (MDT)
Subject: Re: [PATCH V3 1/2] powerpc/numa: Update CPU topology when VPHN enabled
To: linuxppc-dev@lists.ozlabs.org
References: <201706041107.Ri5JRxir%fengguang.wu@intel.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Mon, 5 Jun 2017 09:48:27 -0500
MIME-Version: 1.0
In-Reply-To: <201706041107.Ri5JRxir%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <82db34cc-7bb4-00cd-a8c8-ef1143e09d02@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This build appears to be using V3 of the patch.  V4 of the patch corrected the placement
of the local variables with respect to '#ifdef CONFIG_PPC_SPLPAR'.

On 06/03/2017 10:13 PM, kbuild test robot wrote:
> Hi Michael,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.12-rc3 next-20170602]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Michael-Bringmann/powerpc-numa-Update-CPU-topology-when-VPHN-enabled/20170527-052650
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-cell_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/powerpc/mm/numa.c:47:12: error: 'topology_update_needed' defined but not used [-Werror=unused-variable]
>     static int topology_update_needed;
>                ^~~~~~~~~~~~~~~~~~~~~~
>>> arch/powerpc/mm/numa.c:46:12: error: 'topology_inited' defined but not used [-Werror=unused-variable]
>     static int topology_inited;
>                ^~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +/topology_update_needed +47 arch/powerpc/mm/numa.c
> 
>     40	#include <asm/paca.h>
>     41	#include <asm/hvcall.h>
>     42	#include <asm/setup.h>
>     43	#include <asm/vdso.h>
>     44	
>     45	static int numa_enabled = 1;
>   > 46	static int topology_inited;
>   > 47	static int topology_update_needed;
>     48	
>     49	static char *cmdline __initdata;
>     50	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
