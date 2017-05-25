Return-Path: <fengguang.wu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYNnP0g0VzDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 19:12:08 +1000 (AEST)
Date: Thu, 25 May 2017 17:11:07 +0800
From: kbuild test robot <lkp@intel.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com, rashmica.g@gmail.com
Subject: Re: [PATCH v1 1/8] powerpc/lib/code-patching: Enhance code patching
Message-ID: <201705251713.98vCNztd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <20170525033650.10891-2-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Balbir,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.12-rc2 next-20170525]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Balbir-Singh/Enable-STRICT_KERNEL_RWX/20170525-150234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/lib/code-patching.c: In function 'kernel_map_addr':
>> arch/powerpc/lib/code-patching.c:57:8: error: implicit declaration of function 'map_kernel_page' [-Werror=implicit-function-declaration]
     err = map_kernel_page((unsigned long)text_poke_area->addr,
           ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/map_kernel_page +57 arch/powerpc/lib/code-patching.c

    51	
    52		if (is_vmalloc_addr(addr))
    53			pfn = vmalloc_to_pfn(addr);
    54		else
    55			pfn = __pa_symbol(addr) >> PAGE_SHIFT;
    56	
  > 57		err = map_kernel_page((unsigned long)text_poke_area->addr,
    58				(pfn << PAGE_SHIFT), _PAGE_KERNEL_RW | _PAGE_PRESENT);
    59		pr_devel("Mapped addr %p with pfn %lx\n", text_poke_area->addr, pfn);
    60		if (err)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VS++wcV0S1rZb1Fb--
