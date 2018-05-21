Return-Path: <fengguang.wu@intel.com>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qYWZ14SjzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 08:35:17 +1000 (AEST)
Date: Tue, 22 May 2018 06:34:47 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc/64s/radix: do not flush TLB when relaxing
 access
Message-ID: <201805220447.FAnQpA8c%fengguang.wu@intel.com>
References: <20180520122857.24766-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
In-Reply-To: <20180520122857.24766-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.17-rc6]
[cannot apply to powerpc/next next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-64s-radix-do-not-flush-TLB-when-relaxing-access/20180522-024317
config: powerpc-bamboo_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/mm/pgtable.c: In function 'ptep_set_access_flags':
>> arch/powerpc/mm/pgtable.c:246:32: error: 'mm_context_t {aka struct <anonymous>}' has no member named 'copros'
       if (atomic_read(&mm->context.copros) > 0)
                                   ^

vim +246 arch/powerpc/mm/pgtable.c

   209	
   210	/*
   211	 * This is called when relaxing access to a PTE. It's also called in the page
   212	 * fault path when we don't hit any of the major fault cases, ie, a minor
   213	 * update of _PAGE_ACCESSED, _PAGE_DIRTY, etc... The generic code will have
   214	 * handled those two for us, we additionally deal with missing execute
   215	 * permission here on some processors
   216	 */
   217	int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
   218				  pte_t *ptep, pte_t entry, int dirty)
   219	{
   220		struct mm_struct *mm = vma->vm_mm;
   221		int changed;
   222	
   223		entry = set_access_flags_filter(entry, vma, dirty);
   224		changed = !pte_same(*(ptep), entry);
   225		if (changed) {
   226			if (!is_vm_hugetlb_page(vma))
   227				assert_pte_locked(mm, address);
   228			__ptep_set_access_flags(mm, ptep, entry, address);
   229			if (IS_ENABLED(CONFIG_PPC_BOOK3S_64)) {
   230				/*
   231				 * Book3S does not require a TLB flush when relaxing
   232				 * access restrictions because the core MMU will reload
   233				 * the pte after taking an access fault. However the
   234				 * NMMU on POWER9 does not re-load the pte, so flush
   235				 * if we have a coprocessor attached to this address
   236				 * space.
   237				 *
   238				 * This could be further refined and pushed out to
   239				 * NMMU drivers so TLBIEs are only done for NMMU
   240				 * faults, but this is a more minimal fix. The NMMU
   241				 * fault handler does a get_user_pages_remote or
   242				 * similar to bring the page tables in, and this
   243				 * flush_tlb_page will do a global TLBIE because the
   244				 * coprocessor is attached to the address space.
   245				 */
 > 246				if (atomic_read(&mm->context.copros) > 0)
   247					flush_tlb_page(vma, address);
   248			} else {
   249				flush_tlb_page(vma, address);
   250			}
   251		}
   252		return changed;
   253	}
   254	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--rwEMma7ioTxnRzrJ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
UQ4oHVsLBpSpojy9UPj/AdLjOc1sqAAA

--rwEMma7ioTxnRzrJ--
