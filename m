Return-Path: <lkp@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41htpF6xRXzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 03:10:11 +1000 (AEST)
Date: Sat, 4 Aug 2018 01:09:34 +0800
From: kbuild test robot <lkp@intel.com>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Pingfan Liu <kernelfans@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/cpu: post the event cpux add/remove instead
 of online/offline during hotplug
Message-ID: <201808040002.nbukBtoh%fengguang.wu@intel.com>
References: <1533217359-11420-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <1533217359-11420-2-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pingfan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.18-rc7 next-20180802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/powerpc-cpuidle-dynamically-register-unregister-cpuidle_device-during-hotplug/20180803-151916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/sysfs.c: In function 'unregister_ppc_cpu':
>> arch/powerpc/kernel/sysfs.c:1052:2: error: implicit declaration of function 'unregister_cpu'; did you mean 'register_cpu'? [-Werror=implicit-function-declaration]
     unregister_cpu(container_of(get_cpu_device(cpu),
     ^~~~~~~~~~~~~~
     register_cpu
   cc1: all warnings being treated as errors

vim +1052 arch/powerpc/kernel/sysfs.c

  1047	
  1048	int unregister_ppc_cpu(int cpu)
  1049	{
  1050		device_remove_file(&per_cpu(cpu_devices, cpu).dev,
  1051			&dev_attr_physical_id);
> 1052		unregister_cpu(container_of(get_cpu_device(cpu),
  1053			struct cpu, dev));
  1054		return 0;
  1055	}
  1056	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
eEZh7BcBAIS/D+k6TQAA

--J/dobhs11T7y2rNN--
