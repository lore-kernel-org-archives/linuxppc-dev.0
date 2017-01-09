Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txj843N6xzDqVc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 15:38:12 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v094Yb4W033027
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Jan 2017 23:38:09 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27ureckrun-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jan 2017 23:38:09 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 9 Jan 2017 14:38:06 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7ACB03578057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 15:38:04 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v094c5i23276914
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 15:38:05 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v094c3Sp007850
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 15:38:04 +1100
Subject: Re: [PATCH 1/2] powerpc/perf: Cleanup of PM_BR_CMPL vs. PM_BRU_CMPL
 in power9 event list
To: kbuild test robot <lkp@intel.com>
References: <201701070408.gC2fqDMn%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 9 Jan 2017 10:07:59 +0530
MIME-Version: 1.0
In-Reply-To: <201701070408.gC2fqDMn%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d91e8c53-a035-ed95-4245-f5723135d293@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Saturday 07 January 2017 02:11 AM, kbuild test robot wrote:
> Hi Madhavan,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.10-rc2 next-20170106]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Madhavan-Srinivasan/Cleanup-and-fix-PM_BR_CMPL-event-code-in-power9/20170107-023212
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=powerpc
>
> All errors (new ones prefixed by >>):
>
>     In file included from arch/powerpc/perf/isa207-common.h:16:0,
>                      from arch/powerpc/perf/power9-pmu.c:16:
>>> arch/powerpc/perf/power9-pmu.c:113:42: error: 'PM_BRU_CMPL' undeclared here (not in a function)
>      GENERIC_EVENT_ATTR(branch-instructions,  PM_BRU_CMPL);
>                                               ^
>     include/linux/perf_event.h:1359:11: note: in definition of macro 'PMU_EVENT_ATTR'
>       .id   =  _id,       \

My bad. Sent out wrong version of the patchset.
Will resend it.

Thanks
Maddy

>                ^~~
>     arch/powerpc/include/asm/perf_event_server.h:152:40: note: in expansion of macro 'EVENT_ATTR'
>      #define GENERIC_EVENT_ATTR(_name, _id) EVENT_ATTR(_name, _id, _g)
>                                             ^~~~~~~~~~
>     arch/powerpc/perf/power9-pmu.c:113:1: note: in expansion of macro 'GENERIC_EVENT_ATTR'
>      GENERIC_EVENT_ATTR(branch-instructions,  PM_BRU_CMPL);
>      ^~~~~~~~~~~~~~~~~~
>>> arch/powerpc/perf/power9-pmu.c:347:27: error: initializer element is not constant
>         [ C(RESULT_ACCESS) ] = PM_BRU_CMPL,
>                                ^~~~~~~~~~~
>     arch/powerpc/perf/power9-pmu.c:347:27: note: (near initialization for 'power9_cache_events[5][0][0]')
>
> vim +/PM_BRU_CMPL +113 arch/powerpc/perf/power9-pmu.c
>
> 8c002dbd Madhavan Srinivasan 2016-06-26   10   * as published by the Free Software Foundation; either version
> 8c002dbd Madhavan Srinivasan 2016-06-26   11   * 2 of the License, or later version.
> 8c002dbd Madhavan Srinivasan 2016-06-26   12   */
> 8c002dbd Madhavan Srinivasan 2016-06-26   13
> 8c002dbd Madhavan Srinivasan 2016-06-26   14  #define pr_fmt(fmt)	"power9-pmu: " fmt
> 8c002dbd Madhavan Srinivasan 2016-06-26   15
> 8c002dbd Madhavan Srinivasan 2016-06-26  @16  #include "isa207-common.h"
> 8c002dbd Madhavan Srinivasan 2016-06-26   17
> 8c002dbd Madhavan Srinivasan 2016-06-26   18  /*
> 18201b20 Madhavan Srinivasan 2016-12-02   19   * Raw event encoding for Power9:
> 18201b20 Madhavan Srinivasan 2016-12-02   20   *
> 18201b20 Madhavan Srinivasan 2016-12-02   21   *        60        56        52        48        44        40        36        32
> 18201b20 Madhavan Srinivasan 2016-12-02   22   * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
> 18201b20 Madhavan Srinivasan 2016-12-02   23   *   | | [ ]                       [ ] [      thresh_cmp     ]   [  thresh_ctl   ]
> 18201b20 Madhavan Srinivasan 2016-12-02   24   *   | |  |                         |                                     |
> 18201b20 Madhavan Srinivasan 2016-12-02   25   *   | |  *- IFM (Linux)            |    thresh start/stop OR FAB match -*
> 18201b20 Madhavan Srinivasan 2016-12-02   26   *   | *- BHRB (Linux)              *sm
> 18201b20 Madhavan Srinivasan 2016-12-02   27   *   *- EBB (Linux)
> 18201b20 Madhavan Srinivasan 2016-12-02   28   *
> 18201b20 Madhavan Srinivasan 2016-12-02   29   *        28        24        20        16        12         8         4         0
> 18201b20 Madhavan Srinivasan 2016-12-02   30   * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
> 18201b20 Madhavan Srinivasan 2016-12-02   31   *   [   ] [  sample ]   [cache]   [ pmc ]   [unit ]   []    m   [    pmcxsel    ]
> 18201b20 Madhavan Srinivasan 2016-12-02   32   *     |        |           |                          |     |
> 18201b20 Madhavan Srinivasan 2016-12-02   33   *     |        |           |                          |     *- mark
> 18201b20 Madhavan Srinivasan 2016-12-02   34   *     |        |           *- L1/L2/L3 cache_sel      |
> 18201b20 Madhavan Srinivasan 2016-12-02   35   *     |        |                                      |
> 18201b20 Madhavan Srinivasan 2016-12-02   36   *     |        *- sampling mode for marked events     *- combine
> 18201b20 Madhavan Srinivasan 2016-12-02   37   *     |
> 18201b20 Madhavan Srinivasan 2016-12-02   38   *     *- thresh_sel
> 18201b20 Madhavan Srinivasan 2016-12-02   39   *
> 18201b20 Madhavan Srinivasan 2016-12-02   40   * Below uses IBM bit numbering.
> 18201b20 Madhavan Srinivasan 2016-12-02   41   *
> 18201b20 Madhavan Srinivasan 2016-12-02   42   * MMCR1[x:y] = unit    (PMCxUNIT)
> 18201b20 Madhavan Srinivasan 2016-12-02   43   * MMCR1[24]   = pmc1combine[0]
> 18201b20 Madhavan Srinivasan 2016-12-02   44   * MMCR1[25]   = pmc1combine[1]
> 18201b20 Madhavan Srinivasan 2016-12-02   45   * MMCR1[26]   = pmc2combine[0]
> 18201b20 Madhavan Srinivasan 2016-12-02   46   * MMCR1[27]   = pmc2combine[1]
> 18201b20 Madhavan Srinivasan 2016-12-02   47   * MMCR1[28]   = pmc3combine[0]
> 18201b20 Madhavan Srinivasan 2016-12-02   48   * MMCR1[29]   = pmc3combine[1]
> 18201b20 Madhavan Srinivasan 2016-12-02   49   * MMCR1[30]   = pmc4combine[0]
> 18201b20 Madhavan Srinivasan 2016-12-02   50   * MMCR1[31]   = pmc4combine[1]
> 18201b20 Madhavan Srinivasan 2016-12-02   51   *
> 18201b20 Madhavan Srinivasan 2016-12-02   52   * if pmc == 3 and unit == 0 and pmcxsel[0:6] == 0b0101011
> 18201b20 Madhavan Srinivasan 2016-12-02   53   *	# PM_MRK_FAB_RSP_MATCH
> 18201b20 Madhavan Srinivasan 2016-12-02   54   *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
> 18201b20 Madhavan Srinivasan 2016-12-02   55   * else if pmc == 4 and unit == 0xf and pmcxsel[0:6] == 0b0101001
> 18201b20 Madhavan Srinivasan 2016-12-02   56   *	# PM_MRK_FAB_RSP_MATCH_CYC
> 18201b20 Madhavan Srinivasan 2016-12-02   57   *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
> 18201b20 Madhavan Srinivasan 2016-12-02   58   * else
> 18201b20 Madhavan Srinivasan 2016-12-02   59   *	MMCRA[48:55] = thresh_ctl   (THRESH START/END)
> 18201b20 Madhavan Srinivasan 2016-12-02   60   *
> 18201b20 Madhavan Srinivasan 2016-12-02   61   * if thresh_sel:
> 18201b20 Madhavan Srinivasan 2016-12-02   62   *	MMCRA[45:47] = thresh_sel
> 18201b20 Madhavan Srinivasan 2016-12-02   63   *
> 18201b20 Madhavan Srinivasan 2016-12-02   64   * if thresh_cmp:
> 18201b20 Madhavan Srinivasan 2016-12-02   65   *	MMCRA[9:11] = thresh_cmp[0:2]
> 18201b20 Madhavan Srinivasan 2016-12-02   66   *	MMCRA[12:18] = thresh_cmp[3:9]
> 18201b20 Madhavan Srinivasan 2016-12-02   67   *
> 18201b20 Madhavan Srinivasan 2016-12-02   68   * if unit == 6 or unit == 7
> 18201b20 Madhavan Srinivasan 2016-12-02   69   *	MMCRC[53:55] = cache_sel[1:3]      (L2EVENT_SEL)
> 18201b20 Madhavan Srinivasan 2016-12-02   70   * else if unit == 8 or unit == 9:
> 18201b20 Madhavan Srinivasan 2016-12-02   71   *	if cache_sel[0] == 0: # L3 bank
> 18201b20 Madhavan Srinivasan 2016-12-02   72   *		MMCRC[47:49] = cache_sel[1:3]  (L3EVENT_SEL0)
> 18201b20 Madhavan Srinivasan 2016-12-02   73   *	else if cache_sel[0] == 1:
> 18201b20 Madhavan Srinivasan 2016-12-02   74   *		MMCRC[50:51] = cache_sel[2:3]  (L3EVENT_SEL1)
> 18201b20 Madhavan Srinivasan 2016-12-02   75   * else if cache_sel[1]: # L1 event
> 18201b20 Madhavan Srinivasan 2016-12-02   76   *	MMCR1[16] = cache_sel[2]
> 18201b20 Madhavan Srinivasan 2016-12-02   77   *	MMCR1[17] = cache_sel[3]
> 18201b20 Madhavan Srinivasan 2016-12-02   78   *
> 18201b20 Madhavan Srinivasan 2016-12-02   79   * if mark:
> 18201b20 Madhavan Srinivasan 2016-12-02   80   *	MMCRA[63]    = 1		(SAMPLE_ENABLE)
> 18201b20 Madhavan Srinivasan 2016-12-02   81   *	MMCRA[57:59] = sample[0:2]	(RAND_SAMP_ELIG)
> 18201b20 Madhavan Srinivasan 2016-12-02   82   *	MMCRA[61:62] = sample[3:4]	(RAND_SAMP_MODE)
> 18201b20 Madhavan Srinivasan 2016-12-02   83   *
> 18201b20 Madhavan Srinivasan 2016-12-02   84   * if EBB and BHRB:
> 18201b20 Madhavan Srinivasan 2016-12-02   85   *	MMCRA[32:33] = IFM
> 18201b20 Madhavan Srinivasan 2016-12-02   86   *
> 18201b20 Madhavan Srinivasan 2016-12-02   87   * MMCRA[SDAR_MODE]  = sm
> 18201b20 Madhavan Srinivasan 2016-12-02   88   */
> 18201b20 Madhavan Srinivasan 2016-12-02   89
> 18201b20 Madhavan Srinivasan 2016-12-02   90  /*
> 8c002dbd Madhavan Srinivasan 2016-06-26   91   * Some power9 event codes.
> 8c002dbd Madhavan Srinivasan 2016-06-26   92   */
> 8c002dbd Madhavan Srinivasan 2016-06-26   93  #define EVENT(_name, _code)	_name = _code,
> 8c002dbd Madhavan Srinivasan 2016-06-26   94
> 8c002dbd Madhavan Srinivasan 2016-06-26   95  enum {
> 8c002dbd Madhavan Srinivasan 2016-06-26   96  #include "power9-events-list.h"
> 8c002dbd Madhavan Srinivasan 2016-06-26   97  };
> 8c002dbd Madhavan Srinivasan 2016-06-26   98
> 8c002dbd Madhavan Srinivasan 2016-06-26   99  #undef EVENT
> 8c002dbd Madhavan Srinivasan 2016-06-26  100
> 8c002dbd Madhavan Srinivasan 2016-06-26  101  /* MMCRA IFM bits - POWER9 */
> 8c002dbd Madhavan Srinivasan 2016-06-26  102  #define POWER9_MMCRA_IFM1		0x0000000040000000UL
> 8c002dbd Madhavan Srinivasan 2016-06-26  103  #define POWER9_MMCRA_IFM2		0x0000000080000000UL
> 8c002dbd Madhavan Srinivasan 2016-06-26  104  #define POWER9_MMCRA_IFM3		0x00000000C0000000UL
> 8c002dbd Madhavan Srinivasan 2016-06-26  105
> 60b00025 Madhavan Srinivasan 2016-12-02  106  /* PowerISA v2.07 format attribute structure*/
> 60b00025 Madhavan Srinivasan 2016-12-02  107  extern struct attribute_group isa207_pmu_format_group;
> 60b00025 Madhavan Srinivasan 2016-12-02  108
> f1fb60bf Madhavan Srinivasan 2016-06-26  109  GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
> f1fb60bf Madhavan Srinivasan 2016-06-26  110  GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_ICT_NOSLOT_CYC);
> f1fb60bf Madhavan Srinivasan 2016-06-26  111  GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
> f1fb60bf Madhavan Srinivasan 2016-06-26  112  GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
> f1fb60bf Madhavan Srinivasan 2016-06-26 @113  GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_CMPL);
> f1fb60bf Madhavan Srinivasan 2016-06-26  114  GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
> f1fb60bf Madhavan Srinivasan 2016-06-26  115  GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
> f1fb60bf Madhavan Srinivasan 2016-06-26  116  GENERIC_EVENT_ATTR(cache-misses,		PM_LD_MISS_L1_FIN);
>
> :::::: The code at line 113 was first introduced by commit
> :::::: f1fb60bfde65fe4c4372d480d1b5d57bdba20367 powerpc/perf: Export Power9 generic and cache events to sysfs
>
> :::::: TO: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> :::::: CC: Michael Ellerman <mpe@ellerman.id.au>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
