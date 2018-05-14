Return-Path: <fengguang.wu@intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kwHh6gg6zF2Jr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 19:23:55 +1000 (AEST)
Date: Mon, 14 May 2018 17:22:50 +0800
From: kbuild test robot <lkp@intel.com>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/cpu: nr_cpu_ids should be aligned on
 threads_per_core
Message-ID: <201805141507.3e6SdmBE%fengguang.wu@intel.com>
References: <1526278438-10519-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
In-Reply-To: <1526278438-10519-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pingfan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.17-rc5 next-20180511]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/powerpc-cpu-nr_cpu_ids-should-be-aligned-on-threads_per_core/20180514-141629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/prom.c: In function 'early_init_dt_scan_cpus':
>> arch/powerpc/kernel/prom.c:370:14: error: lvalue required as left operand of assignment
      nr_cpu_ids = nr_cpus_aligned;
                 ^

vim +370 arch/powerpc/kernel/prom.c

   306	
   307	static int __init early_init_dt_scan_cpus(unsigned long node,
   308						  const char *uname, int depth,
   309						  void *data)
   310	{
   311		const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
   312		const __be32 *prop;
   313		const __be32 *intserv;
   314		int i, nthreads;
   315		int len;
   316		int found = -1;
   317		int found_thread = 0;
   318		unsigned int nr_cpus_aligned;
   319	
   320		/* We are scanning "cpu" nodes only */
   321		if (type == NULL || strcmp(type, "cpu") != 0)
   322			return 0;
   323	
   324		/* Get physical cpuid */
   325		intserv = of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
   326		if (!intserv)
   327			intserv = of_get_flat_dt_prop(node, "reg", &len);
   328	
   329		nthreads = len / sizeof(int);
   330	
   331		/*
   332		 * Now see if any of these threads match our boot cpu.
   333		 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
   334		 */
   335		for (i = 0; i < nthreads; i++) {
   336			/*
   337			 * version 2 of the kexec param format adds the phys cpuid of
   338			 * booted proc.
   339			 */
   340			if (fdt_version(initial_boot_params) >= 2) {
   341				if (be32_to_cpu(intserv[i]) ==
   342				    fdt_boot_cpuid_phys(initial_boot_params)) {
   343					found = boot_cpu_count;
   344					found_thread = i;
   345				}
   346			} else {
   347				/*
   348				 * Check if it's the boot-cpu, set it's hw index now,
   349				 * unfortunately this format did not support booting
   350				 * off secondary threads.
   351				 */
   352				if (of_get_flat_dt_prop(node,
   353						"linux,boot-cpu", NULL) != NULL)
   354					found = boot_cpu_count;
   355			}
   356	#ifdef CONFIG_SMP
   357			/* logical cpu id is always 0 on UP kernels */
   358			boot_cpu_count++;
   359	#endif
   360		}
   361	
   362		/* Not the boot CPU */
   363		if (found < 0)
   364			return 0;
   365		/* to work around p8 subcore mode */
   366		nr_cpus_aligned = _ALIGN_UP(nr_cpu_ids, nthreads);
   367		if (nr_cpus_aligned != nr_cpu_ids) {
   368			pr_info("nr_cpus is forced to align up on threads_per_core,"
   369				"from %u to %u\n", nr_cpu_ids, nr_cpus_aligned);
 > 370			nr_cpu_ids = nr_cpus_aligned;
   371		}
   372		DBG("boot cpu: logical %d physical %d\n", found,
   373		    be32_to_cpu(intserv[found_thread]));
   374		boot_cpuid = found;
   375	
   376		/*
   377		 * PAPR defines "logical" PVR values for cpus that
   378		 * meet various levels of the architecture:
   379		 * 0x0f000001	Architecture version 2.04
   380		 * 0x0f000002	Architecture version 2.05
   381		 * If the cpu-version property in the cpu node contains
   382		 * such a value, we call identify_cpu again with the
   383		 * logical PVR value in order to use the cpu feature
   384		 * bits appropriate for the architecture level.
   385		 *
   386		 * A POWER6 partition in "POWER6 architected" mode
   387		 * uses the 0x0f000002 PVR value; in POWER5+ mode
   388		 * it uses 0x0f000001.
   389		 *
   390		 * If we're using device tree CPU feature discovery then we don't
   391		 * support the cpu-version property, and it's the responsibility of the
   392		 * firmware/hypervisor to provide the correct feature set for the
   393		 * architecture level via the ibm,powerpc-cpu-features binding.
   394		 */
   395		if (!dt_cpu_ftrs_in_use()) {
   396			prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
   397			if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000)
   398				identify_cpu(0, be32_to_cpup(prop));
   399	
   400			check_cpu_feature_properties(node);
   401			check_cpu_pa_features(node);
   402		}
   403	
   404		identical_pvr_fixup(node);
   405		init_mmu_slb_size(node);
   406	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IJpNTDwzlM2Ie8A6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IJpNTDwzlM2Ie8A6--
