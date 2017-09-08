Return-Path: <fengguang.wu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpPfc5YQQzDrYn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 14:36:37 +1000 (AEST)
Date: Fri, 8 Sep 2017 12:36:02 +0800
From: kbuild test robot <lkp@intel.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 andrew.donnellan@au1.ibm.com, arbab@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 2/2] powerpc/powernv/npu: Don't explicitly flush nmmu tlb
Message-ID: <201709081201.0KTtjfCD%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <1504583864-8169-2-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alistair,

[auto build test ERROR on powerpc/next]
[also build test ERROR on next-20170907]
[cannot apply to v4.13]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alistair-Popple/powerpc-npu-Use-flush_all_mm-instead-of-flush_tlb_mm/20170908-072908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/powernv/npu-dma.c: In function 'mmio_invalidate':
   arch/powerpc/platforms/powernv/npu-dma.c:555:3: error: implicit declaration of function 'flush_all_mm' [-Werror=implicit-function-declaration]
      flush_all_mm(npu_context->mm);
      ^~~~~~~~~~~~
   arch/powerpc/platforms/powernv/npu-dma.c: In function 'pnv_npu2_init_context':
>> arch/powerpc/platforms/powernv/npu-dma.c:744:3: error: implicit declaration of function 'inc_mm_active_cpus' [-Werror=implicit-function-declaration]
      inc_mm_active_cpus(mm);
      ^~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/powernv/npu-dma.c: In function 'pnv_npu2_release_context':
>> arch/powerpc/platforms/powernv/npu-dma.c:758:3: error: implicit declaration of function 'dec_mm_active_cpus' [-Werror=implicit-function-declaration]
      dec_mm_active_cpus(npu_context->mm);
      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/inc_mm_active_cpus +744 arch/powerpc/platforms/powernv/npu-dma.c

   534	
   535	/*
   536	 * Invalidate either a single address or an entire PID depending on
   537	 * the value of va.
   538	 */
   539	static void mmio_invalidate(struct npu_context *npu_context, int va,
   540				unsigned long address, bool flush)
   541	{
   542		int i, j;
   543		struct npu *npu;
   544		struct pnv_phb *nphb;
   545		struct pci_dev *npdev;
   546		struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
   547		unsigned long pid = npu_context->mm->context.id;
   548	
   549		if (npu_context->nmmu_flush)
   550			/*
   551			 * Unfortunately the nest mmu does not support flushing specific
   552			 * addresses so we have to flush the whole mm once before
   553			 * shooting down the GPU translation.
   554			 */
 > 555			flush_all_mm(npu_context->mm);
   556	
   557		/*
   558		 * Loop over all the NPUs this process is active on and launch
   559		 * an invalidate.
   560		 */
   561		for (i = 0; i <= max_npu2_index; i++) {
   562			mmio_atsd_reg[i].reg = -1;
   563			for (j = 0; j < NV_MAX_LINKS; j++) {
   564				npdev = npu_context->npdev[i][j];
   565				if (!npdev)
   566					continue;
   567	
   568				nphb = pci_bus_to_host(npdev->bus)->private_data;
   569				npu = &nphb->npu;
   570				mmio_atsd_reg[i].npu = npu;
   571	
   572				if (va)
   573					mmio_atsd_reg[i].reg =
   574						mmio_invalidate_va(npu, address, pid,
   575								flush);
   576				else
   577					mmio_atsd_reg[i].reg =
   578						mmio_invalidate_pid(npu, pid, flush);
   579	
   580				/*
   581				 * The NPU hardware forwards the shootdown to all GPUs
   582				 * so we only have to launch one shootdown per NPU.
   583				 */
   584				break;
   585			}
   586		}
   587	
   588		mmio_invalidate_wait(mmio_atsd_reg, flush);
   589		if (flush)
   590			/* Wait for the flush to complete */
   591			mmio_invalidate_wait(mmio_atsd_reg, false);
   592	}
   593	
   594	static void pnv_npu2_mn_release(struct mmu_notifier *mn,
   595					struct mm_struct *mm)
   596	{
   597		struct npu_context *npu_context = mn_to_npu_context(mn);
   598	
   599		/* Call into device driver to stop requests to the NMMU */
   600		if (npu_context->release_cb)
   601			npu_context->release_cb(npu_context, npu_context->priv);
   602	
   603		/*
   604		 * There should be no more translation requests for this PID, but we
   605		 * need to ensure any entries for it are removed from the TLB.
   606		 */
   607		mmio_invalidate(npu_context, 0, 0, true);
   608	}
   609	
   610	static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
   611					struct mm_struct *mm,
   612					unsigned long address,
   613					pte_t pte)
   614	{
   615		struct npu_context *npu_context = mn_to_npu_context(mn);
   616	
   617		mmio_invalidate(npu_context, 1, address, true);
   618	}
   619	
   620	static void pnv_npu2_mn_invalidate_page(struct mmu_notifier *mn,
   621						struct mm_struct *mm,
   622						unsigned long address)
   623	{
   624		struct npu_context *npu_context = mn_to_npu_context(mn);
   625	
   626		mmio_invalidate(npu_context, 1, address, true);
   627	}
   628	
   629	static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
   630						struct mm_struct *mm,
   631						unsigned long start, unsigned long end)
   632	{
   633		struct npu_context *npu_context = mn_to_npu_context(mn);
   634		unsigned long address;
   635	
   636		for (address = start; address < end; address += PAGE_SIZE)
   637			mmio_invalidate(npu_context, 1, address, false);
   638	
   639		/* Do the flush only on the final addess == end */
   640		mmio_invalidate(npu_context, 1, address, true);
   641	}
   642	
   643	static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
   644		.release = pnv_npu2_mn_release,
   645		.change_pte = pnv_npu2_mn_change_pte,
   646		.invalidate_page = pnv_npu2_mn_invalidate_page,
   647		.invalidate_range = pnv_npu2_mn_invalidate_range,
   648	};
   649	
   650	/*
   651	 * Call into OPAL to setup the nmmu context for the current task in
   652	 * the NPU. This must be called to setup the context tables before the
   653	 * GPU issues ATRs. pdev should be a pointed to PCIe GPU device.
   654	 *
   655	 * A release callback should be registered to allow a device driver to
   656	 * be notified that it should not launch any new translation requests
   657	 * as the final TLB invalidate is about to occur.
   658	 *
   659	 * Returns an error if there no contexts are currently available or a
   660	 * npu_context which should be passed to pnv_npu2_handle_fault().
   661	 *
   662	 * mmap_sem must be held in write mode.
   663	 */
   664	struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
   665				unsigned long flags,
   666				struct npu_context *(*cb)(struct npu_context *, void *),
   667				void *priv)
   668	{
   669		int rc;
   670		u32 nvlink_index;
   671		struct device_node *nvlink_dn;
   672		struct mm_struct *mm = current->mm;
   673		struct pnv_phb *nphb;
   674		struct npu *npu;
   675		struct npu_context *npu_context;
   676	
   677		/*
   678		 * At present we don't support GPUs connected to multiple NPUs and I'm
   679		 * not sure the hardware does either.
   680		 */
   681		struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
   682	
   683		if (!firmware_has_feature(FW_FEATURE_OPAL))
   684			return ERR_PTR(-ENODEV);
   685	
   686		if (!npdev)
   687			/* No nvlink associated with this GPU device */
   688			return ERR_PTR(-ENODEV);
   689	
   690		if (!mm || mm->context.id == 0) {
   691			/*
   692			 * Kernel thread contexts are not supported and context id 0 is
   693			 * reserved on the GPU.
   694			 */
   695			return ERR_PTR(-EINVAL);
   696		}
   697	
   698		nphb = pci_bus_to_host(npdev->bus)->private_data;
   699		npu = &nphb->npu;
   700	
   701		/*
   702		 * Setup the NPU context table for a particular GPU. These need to be
   703		 * per-GPU as we need the tables to filter ATSDs when there are no
   704		 * active contexts on a particular GPU.
   705		 */
   706		rc = opal_npu_init_context(nphb->opal_id, mm->context.id, flags,
   707					PCI_DEVID(gpdev->bus->number, gpdev->devfn));
   708		if (rc < 0)
   709			return ERR_PTR(-ENOSPC);
   710	
   711		/*
   712		 * We store the npu pci device so we can more easily get at the
   713		 * associated npus.
   714		 */
   715		npu_context = mm->context.npu_context;
   716		if (!npu_context) {
   717			npu_context = kzalloc(sizeof(struct npu_context), GFP_KERNEL);
   718			if (!npu_context)
   719				return ERR_PTR(-ENOMEM);
   720	
   721			mm->context.npu_context = npu_context;
   722			npu_context->mm = mm;
   723			npu_context->mn.ops = &nv_nmmu_notifier_ops;
   724			__mmu_notifier_register(&npu_context->mn, mm);
   725			kref_init(&npu_context->kref);
   726		} else {
   727			kref_get(&npu_context->kref);
   728		}
   729	
   730		npu_context->release_cb = cb;
   731		npu_context->priv = priv;
   732		nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
   733		if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
   734								&nvlink_index)))
   735			return ERR_PTR(-ENODEV);
   736		npu_context->npdev[npu->index][nvlink_index] = npdev;
   737	
   738		if (!nphb->npu.nmmu_flush) {
   739			/*
   740			 * If we're not explicitly flushing ourselves we need to mark
   741			 * the thread for global flushes
   742			 */
   743			npu_context->nmmu_flush = false;
 > 744			inc_mm_active_cpus(mm);
   745		} else
   746			npu_context->nmmu_flush = true;
   747	
   748		return npu_context;
   749	}
   750	EXPORT_SYMBOL(pnv_npu2_init_context);
   751	
   752	static void pnv_npu2_release_context(struct kref *kref)
   753	{
   754		struct npu_context *npu_context =
   755			container_of(kref, struct npu_context, kref);
   756	
   757		if (!npu_context->nmmu_flush)
 > 758			dec_mm_active_cpus(npu_context->mm);
   759	
   760		npu_context->mm->context.npu_context = NULL;
   761		mmu_notifier_unregister(&npu_context->mn,
   762					npu_context->mm);
   763	
   764		kfree(npu_context);
   765	}
   766	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--TB36FDmn/VVEgNH/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
jS671Kj6wbtZ5/8DIow4p3CAAQA=

--TB36FDmn/VVEgNH/--
