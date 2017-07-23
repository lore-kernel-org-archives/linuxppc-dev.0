Return-Path: <fengguang.wu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xFnWM66qgzDrDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 00:51:05 +1000 (AEST)
Date: Sun, 23 Jul 2017 22:50:06 +0800
From: kbuild test robot <lkp@intel.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/2] powerpc/xmon: support dumping software pagetables
Message-ID: <201707232236.wg3qSrHj%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <20170721052406.28960-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Balbir,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.13-rc1 next-20170721]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Balbir-Singh/powerpc-xmon-support-dumping-software-pagetables/20170723-002848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-akebono_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/xmon/xmon.c: In function 'show_pte':
>> arch/powerpc/xmon/xmon.c:2929:6: error: implicit declaration of function 'pud_huge' [-Werror=implicit-function-declaration]
     if (pud_huge(*pudp)) {
         ^~~~~~~~
>> arch/powerpc/xmon/xmon.c:2942:6: error: implicit declaration of function 'pmd_huge' [-Werror=implicit-function-declaration]
     if (pmd_huge(*pmdp)) {
         ^~~~~~~~
   cc1: all warnings being treated as errors

vim +/pud_huge +2929 arch/powerpc/xmon/xmon.c

  2874	
  2875	static void show_pte(unsigned long tskv)
  2876	{
  2877		unsigned long addr = 0;
  2878		struct task_struct *tsk = NULL;
  2879		struct mm_struct *mm;
  2880		pgd_t *pgdp;
  2881		pud_t *pudp;
  2882		pmd_t *pmdp;
  2883		pte_t *ptep;
  2884	
  2885		tsk = (struct task_struct *)tskv;
  2886		if (tsk == NULL)
  2887			mm = &init_mm;
  2888		else
  2889			mm = tsk->active_mm;
  2890	
  2891		if (mm == NULL)
  2892			mm = &init_mm;
  2893	
  2894		if (!scanhex(&addr))
  2895			printf("need address to translate\n");
  2896	
  2897		if (setjmp(bus_error_jmp) != 0) {
  2898			catch_memory_errors = 0;
  2899			printf("*** Error dumping pte for task %p\n", tsk);
  2900			return;
  2901		}
  2902	
  2903		catch_memory_errors = 1;
  2904		sync();
  2905	
  2906		if (mm == &init_mm)
  2907			pgdp = pgd_offset_k(addr);
  2908		else
  2909			pgdp = pgd_offset(mm, addr);
  2910	
  2911		if (pgd_none(*pgdp)) {
  2912			printf("no linux page table for address\n");
  2913			return;
  2914		}
  2915	
  2916		if (pgd_huge(*pgdp)) {
  2917			format_pte(pgd_val(*pgdp));
  2918			return;
  2919		}
  2920		printf("G: 0x%8lx\t", pgd_val(*pgdp));
  2921	
  2922		pudp = pud_offset(pgdp, addr);
  2923	
  2924		if (pud_none(*pudp)) {
  2925			printf("No valid PUD\n");
  2926			return;
  2927		}
  2928	
> 2929		if (pud_huge(*pudp)) {
  2930			format_pte(pud_val(*pudp));
  2931			return;
  2932		}
  2933		printf("U: 0x%8lx\t", pud_val(*pudp));
  2934	
  2935		pmdp = pmd_offset(pudp, addr);
  2936	
  2937		if (pmd_none(*pmdp)) {
  2938			printf("No valid PMD\n");
  2939			return;
  2940		}
  2941	
> 2942		if (pmd_huge(*pmdp)) {
  2943			format_pte(pmd_val(*pmdp));
  2944			return;
  2945		}
  2946		printf("M: 0x%8lx\t", pmd_val(*pmdp));
  2947	
  2948		/* pte_offset_map is the same as pte_offset_kernel */
  2949		ptep = pte_offset_kernel(pmdp, addr);
  2950		if (pte_none(*ptep)) {
  2951			printf("no valid PTE\n");
  2952			return;
  2953		}
  2954	
  2955		format_pte(pte_val(*ptep));
  2956	
  2957		sync();
  2958		__delay(200);
  2959		catch_memory_errors = 0;
  2960	}
  2961	static void show_tasks(void)
  2962	{
  2963		unsigned long tskv;
  2964		struct task_struct *tsk = NULL;
  2965	
  2966		printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
  2967	
  2968		if (scanhex(&tskv))
  2969			tsk = (struct task_struct *)tskv;
  2970	
  2971		if (setjmp(bus_error_jmp) != 0) {
  2972			catch_memory_errors = 0;
  2973			printf("*** Error dumping task %p\n", tsk);
  2974			return;
  2975		}
  2976	
  2977		catch_memory_errors = 1;
  2978		sync();
  2979	
  2980		if (tsk)
  2981			show_task(tsk);
  2982		else
  2983			for_each_process(tsk)
  2984				show_task(tsk);
  2985	
  2986		sync();
  2987		__delay(200);
  2988		catch_memory_errors = 0;
  2989	}
  2990	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
a0QSP4yyWfwfHaW2lbf7AAA=

--RnlQjJ0d97Da+TV1--
