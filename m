Return-Path: <fengguang.wu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3twGhj4lNwzDqWT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jan 2017 07:43:00 +1100 (AEDT)
Date: Sat, 7 Jan 2017 04:41:56 +0800
From: kbuild test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, mpe@ellerman.id.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/perf: Cleanup of PM_BR_CMPL vs. PM_BRU_CMPL
 in power9 event list
Message-ID: <201701070408.gC2fqDMn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
In-Reply-To: <1483616075-11262-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Madhavan,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.10-rc2 next-20170106]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Madhavan-Srinivasan/Cleanup-and-fix-PM_BR_CMPL-event-code-in-power9/20170107-023212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/perf/isa207-common.h:16:0,
                    from arch/powerpc/perf/power9-pmu.c:16:
>> arch/powerpc/perf/power9-pmu.c:113:42: error: 'PM_BRU_CMPL' undeclared here (not in a function)
    GENERIC_EVENT_ATTR(branch-instructions,  PM_BRU_CMPL);
                                             ^
   include/linux/perf_event.h:1359:11: note: in definition of macro 'PMU_EVENT_ATTR'
     .id   =  _id,       \
              ^~~
   arch/powerpc/include/asm/perf_event_server.h:152:40: note: in expansion of macro 'EVENT_ATTR'
    #define GENERIC_EVENT_ATTR(_name, _id) EVENT_ATTR(_name, _id, _g)
                                           ^~~~~~~~~~
   arch/powerpc/perf/power9-pmu.c:113:1: note: in expansion of macro 'GENERIC_EVENT_ATTR'
    GENERIC_EVENT_ATTR(branch-instructions,  PM_BRU_CMPL);
    ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/perf/power9-pmu.c:347:27: error: initializer element is not constant
       [ C(RESULT_ACCESS) ] = PM_BRU_CMPL,
                              ^~~~~~~~~~~
   arch/powerpc/perf/power9-pmu.c:347:27: note: (near initialization for 'power9_cache_events[5][0][0]')

vim +/PM_BRU_CMPL +113 arch/powerpc/perf/power9-pmu.c

8c002dbd Madhavan Srinivasan 2016-06-26   10   * as published by the Free Software Foundation; either version
8c002dbd Madhavan Srinivasan 2016-06-26   11   * 2 of the License, or later version.
8c002dbd Madhavan Srinivasan 2016-06-26   12   */
8c002dbd Madhavan Srinivasan 2016-06-26   13  
8c002dbd Madhavan Srinivasan 2016-06-26   14  #define pr_fmt(fmt)	"power9-pmu: " fmt
8c002dbd Madhavan Srinivasan 2016-06-26   15  
8c002dbd Madhavan Srinivasan 2016-06-26  @16  #include "isa207-common.h"
8c002dbd Madhavan Srinivasan 2016-06-26   17  
8c002dbd Madhavan Srinivasan 2016-06-26   18  /*
18201b20 Madhavan Srinivasan 2016-12-02   19   * Raw event encoding for Power9:
18201b20 Madhavan Srinivasan 2016-12-02   20   *
18201b20 Madhavan Srinivasan 2016-12-02   21   *        60        56        52        48        44        40        36        32
18201b20 Madhavan Srinivasan 2016-12-02   22   * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
18201b20 Madhavan Srinivasan 2016-12-02   23   *   | | [ ]                       [ ] [      thresh_cmp     ]   [  thresh_ctl   ]
18201b20 Madhavan Srinivasan 2016-12-02   24   *   | |  |                         |                                     |
18201b20 Madhavan Srinivasan 2016-12-02   25   *   | |  *- IFM (Linux)            |    thresh start/stop OR FAB match -*
18201b20 Madhavan Srinivasan 2016-12-02   26   *   | *- BHRB (Linux)              *sm
18201b20 Madhavan Srinivasan 2016-12-02   27   *   *- EBB (Linux)
18201b20 Madhavan Srinivasan 2016-12-02   28   *
18201b20 Madhavan Srinivasan 2016-12-02   29   *        28        24        20        16        12         8         4         0
18201b20 Madhavan Srinivasan 2016-12-02   30   * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
18201b20 Madhavan Srinivasan 2016-12-02   31   *   [   ] [  sample ]   [cache]   [ pmc ]   [unit ]   []    m   [    pmcxsel    ]
18201b20 Madhavan Srinivasan 2016-12-02   32   *     |        |           |                          |     |
18201b20 Madhavan Srinivasan 2016-12-02   33   *     |        |           |                          |     *- mark
18201b20 Madhavan Srinivasan 2016-12-02   34   *     |        |           *- L1/L2/L3 cache_sel      |
18201b20 Madhavan Srinivasan 2016-12-02   35   *     |        |                                      |
18201b20 Madhavan Srinivasan 2016-12-02   36   *     |        *- sampling mode for marked events     *- combine
18201b20 Madhavan Srinivasan 2016-12-02   37   *     |
18201b20 Madhavan Srinivasan 2016-12-02   38   *     *- thresh_sel
18201b20 Madhavan Srinivasan 2016-12-02   39   *
18201b20 Madhavan Srinivasan 2016-12-02   40   * Below uses IBM bit numbering.
18201b20 Madhavan Srinivasan 2016-12-02   41   *
18201b20 Madhavan Srinivasan 2016-12-02   42   * MMCR1[x:y] = unit    (PMCxUNIT)
18201b20 Madhavan Srinivasan 2016-12-02   43   * MMCR1[24]   = pmc1combine[0]
18201b20 Madhavan Srinivasan 2016-12-02   44   * MMCR1[25]   = pmc1combine[1]
18201b20 Madhavan Srinivasan 2016-12-02   45   * MMCR1[26]   = pmc2combine[0]
18201b20 Madhavan Srinivasan 2016-12-02   46   * MMCR1[27]   = pmc2combine[1]
18201b20 Madhavan Srinivasan 2016-12-02   47   * MMCR1[28]   = pmc3combine[0]
18201b20 Madhavan Srinivasan 2016-12-02   48   * MMCR1[29]   = pmc3combine[1]
18201b20 Madhavan Srinivasan 2016-12-02   49   * MMCR1[30]   = pmc4combine[0]
18201b20 Madhavan Srinivasan 2016-12-02   50   * MMCR1[31]   = pmc4combine[1]
18201b20 Madhavan Srinivasan 2016-12-02   51   *
18201b20 Madhavan Srinivasan 2016-12-02   52   * if pmc == 3 and unit == 0 and pmcxsel[0:6] == 0b0101011
18201b20 Madhavan Srinivasan 2016-12-02   53   *	# PM_MRK_FAB_RSP_MATCH
18201b20 Madhavan Srinivasan 2016-12-02   54   *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
18201b20 Madhavan Srinivasan 2016-12-02   55   * else if pmc == 4 and unit == 0xf and pmcxsel[0:6] == 0b0101001
18201b20 Madhavan Srinivasan 2016-12-02   56   *	# PM_MRK_FAB_RSP_MATCH_CYC
18201b20 Madhavan Srinivasan 2016-12-02   57   *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
18201b20 Madhavan Srinivasan 2016-12-02   58   * else
18201b20 Madhavan Srinivasan 2016-12-02   59   *	MMCRA[48:55] = thresh_ctl   (THRESH START/END)
18201b20 Madhavan Srinivasan 2016-12-02   60   *
18201b20 Madhavan Srinivasan 2016-12-02   61   * if thresh_sel:
18201b20 Madhavan Srinivasan 2016-12-02   62   *	MMCRA[45:47] = thresh_sel
18201b20 Madhavan Srinivasan 2016-12-02   63   *
18201b20 Madhavan Srinivasan 2016-12-02   64   * if thresh_cmp:
18201b20 Madhavan Srinivasan 2016-12-02   65   *	MMCRA[9:11] = thresh_cmp[0:2]
18201b20 Madhavan Srinivasan 2016-12-02   66   *	MMCRA[12:18] = thresh_cmp[3:9]
18201b20 Madhavan Srinivasan 2016-12-02   67   *
18201b20 Madhavan Srinivasan 2016-12-02   68   * if unit == 6 or unit == 7
18201b20 Madhavan Srinivasan 2016-12-02   69   *	MMCRC[53:55] = cache_sel[1:3]      (L2EVENT_SEL)
18201b20 Madhavan Srinivasan 2016-12-02   70   * else if unit == 8 or unit == 9:
18201b20 Madhavan Srinivasan 2016-12-02   71   *	if cache_sel[0] == 0: # L3 bank
18201b20 Madhavan Srinivasan 2016-12-02   72   *		MMCRC[47:49] = cache_sel[1:3]  (L3EVENT_SEL0)
18201b20 Madhavan Srinivasan 2016-12-02   73   *	else if cache_sel[0] == 1:
18201b20 Madhavan Srinivasan 2016-12-02   74   *		MMCRC[50:51] = cache_sel[2:3]  (L3EVENT_SEL1)
18201b20 Madhavan Srinivasan 2016-12-02   75   * else if cache_sel[1]: # L1 event
18201b20 Madhavan Srinivasan 2016-12-02   76   *	MMCR1[16] = cache_sel[2]
18201b20 Madhavan Srinivasan 2016-12-02   77   *	MMCR1[17] = cache_sel[3]
18201b20 Madhavan Srinivasan 2016-12-02   78   *
18201b20 Madhavan Srinivasan 2016-12-02   79   * if mark:
18201b20 Madhavan Srinivasan 2016-12-02   80   *	MMCRA[63]    = 1		(SAMPLE_ENABLE)
18201b20 Madhavan Srinivasan 2016-12-02   81   *	MMCRA[57:59] = sample[0:2]	(RAND_SAMP_ELIG)
18201b20 Madhavan Srinivasan 2016-12-02   82   *	MMCRA[61:62] = sample[3:4]	(RAND_SAMP_MODE)
18201b20 Madhavan Srinivasan 2016-12-02   83   *
18201b20 Madhavan Srinivasan 2016-12-02   84   * if EBB and BHRB:
18201b20 Madhavan Srinivasan 2016-12-02   85   *	MMCRA[32:33] = IFM
18201b20 Madhavan Srinivasan 2016-12-02   86   *
18201b20 Madhavan Srinivasan 2016-12-02   87   * MMCRA[SDAR_MODE]  = sm
18201b20 Madhavan Srinivasan 2016-12-02   88   */
18201b20 Madhavan Srinivasan 2016-12-02   89  
18201b20 Madhavan Srinivasan 2016-12-02   90  /*
8c002dbd Madhavan Srinivasan 2016-06-26   91   * Some power9 event codes.
8c002dbd Madhavan Srinivasan 2016-06-26   92   */
8c002dbd Madhavan Srinivasan 2016-06-26   93  #define EVENT(_name, _code)	_name = _code,
8c002dbd Madhavan Srinivasan 2016-06-26   94  
8c002dbd Madhavan Srinivasan 2016-06-26   95  enum {
8c002dbd Madhavan Srinivasan 2016-06-26   96  #include "power9-events-list.h"
8c002dbd Madhavan Srinivasan 2016-06-26   97  };
8c002dbd Madhavan Srinivasan 2016-06-26   98  
8c002dbd Madhavan Srinivasan 2016-06-26   99  #undef EVENT
8c002dbd Madhavan Srinivasan 2016-06-26  100  
8c002dbd Madhavan Srinivasan 2016-06-26  101  /* MMCRA IFM bits - POWER9 */
8c002dbd Madhavan Srinivasan 2016-06-26  102  #define POWER9_MMCRA_IFM1		0x0000000040000000UL
8c002dbd Madhavan Srinivasan 2016-06-26  103  #define POWER9_MMCRA_IFM2		0x0000000080000000UL
8c002dbd Madhavan Srinivasan 2016-06-26  104  #define POWER9_MMCRA_IFM3		0x00000000C0000000UL
8c002dbd Madhavan Srinivasan 2016-06-26  105  
60b00025 Madhavan Srinivasan 2016-12-02  106  /* PowerISA v2.07 format attribute structure*/
60b00025 Madhavan Srinivasan 2016-12-02  107  extern struct attribute_group isa207_pmu_format_group;
60b00025 Madhavan Srinivasan 2016-12-02  108  
f1fb60bf Madhavan Srinivasan 2016-06-26  109  GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
f1fb60bf Madhavan Srinivasan 2016-06-26  110  GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_ICT_NOSLOT_CYC);
f1fb60bf Madhavan Srinivasan 2016-06-26  111  GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
f1fb60bf Madhavan Srinivasan 2016-06-26  112  GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
f1fb60bf Madhavan Srinivasan 2016-06-26 @113  GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_CMPL);
f1fb60bf Madhavan Srinivasan 2016-06-26  114  GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
f1fb60bf Madhavan Srinivasan 2016-06-26  115  GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
f1fb60bf Madhavan Srinivasan 2016-06-26  116  GENERIC_EVENT_ATTR(cache-misses,		PM_LD_MISS_L1_FIN);

:::::: The code at line 113 was first introduced by commit
:::::: f1fb60bfde65fe4c4372d480d1b5d57bdba20367 powerpc/perf: Export Power9 generic and cache events to sysfs

:::::: TO: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wac7ysb48OaltWcw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--wac7ysb48OaltWcw--
