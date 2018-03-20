Return-Path: <fengguang.wu@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404zrv5D61zF1cH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 15:06:35 +1100 (AEDT)
Date: Tue, 20 Mar 2018 12:05:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 9/9] powerpc/eeh: Add eeh_state_active() helper
Message-ID: <201803201145.icNdRfQw%fengguang.wu@intel.com>
References: <c7cc2334ac3a7c88cc68b45337de890bcdcc80f7.1521427331.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <c7cc2334ac3a7c88cc68b45337de890bcdcc80f7.1521427331.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc4]
[also build test ERROR on next-20180319]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sam-Bobroff/EEH-refactoring-1/20180320-024729
config: powerpc-ppc64_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:14:0,
                    from include/linux/delay.h:22,
                    from arch/powerpc/kernel/eeh_driver.c:25:
   arch/powerpc/kernel/eeh_driver.c: In function 'eeh_reset_device':
>> arch/powerpc/kernel/eeh_driver.c:692:5: error: 'eeh_aware_driver' undeclared (first use in this function); did you mean 'eeh_state_active'?
       (eeh_aware_driver ? "partial" : "complete"));
        ^
   include/linux/printk.h:308:34: note: in definition of macro 'pr_info'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                     ^~~~~~~~~~~
   arch/powerpc/kernel/eeh_driver.c:692:5: note: each undeclared identifier is reported only once for each function it appears in
       (eeh_aware_driver ? "partial" : "complete"));
        ^
   include/linux/printk.h:308:34: note: in definition of macro 'pr_info'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                     ^~~~~~~~~~~

vim +692 arch/powerpc/kernel/eeh_driver.c

5cfb20b96 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-09-30  619  
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  620  /**
29f8bf1b7 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-02-27  621   * eeh_reset_device - Perform actual reset of a pci slot
a10e51924 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  622   * @driver_eeh_aware: Does the device's driver provide EEH support?
9b3c76f08 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-07  623   * @pe: EEH PE
29f8bf1b7 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-02-27  624   * @bus: PCI bus corresponding to the isolcated slot
a10e51924 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  625   * @rmv_data: Optional, list to record removed devices
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  626   *
29f8bf1b7 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-02-27  627   * This routine must be called to do reset on the indicated PE.
29f8bf1b7 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-02-27  628   * During the reset, udev might be invoked because those affected
29f8bf1b7 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-02-27  629   * PCI devices will be removed and then added.
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  630   */
67086e32b arch/powerpc/kernel/eeh_driver.c            Wei Yang          2016-03-04  631  static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
a10e51924 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  632  			    struct eeh_rmv_data *rmv_data,
a10e51924 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  633  			    bool driver_eeh_aware)
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  634  {
edfd17ff3 arch/powerpc/kernel/eeh_driver.c            Arnd Bergmann     2017-11-04  635  	time64_t tstamp;
67086e32b arch/powerpc/kernel/eeh_driver.c            Wei Yang          2016-03-04  636  	int cnt, rc;
67086e32b arch/powerpc/kernel/eeh_driver.c            Wei Yang          2016-03-04  637  	struct eeh_dev *edev;
424054566 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2006-04-28  638  
424054566 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2006-04-28  639  	/* pcibios will clear the counter; save the value */
9b3c76f08 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-07  640  	cnt = pe->freeze_count;
5a71978e4 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-06-20  641  	tstamp = pe->tstamp;
424054566 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2006-04-28  642  
20ee6a970 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-11  643  	/*
20ee6a970 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-11  644  	 * We don't remove the corresponding PE instances because
20ee6a970 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-11  645  	 * we need the information afterwords. The attached EEH
20ee6a970 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-11  646  	 * devices are expected to be attached soon when calling
bd251b893 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2016-05-03  647  	 * into pci_hp_add_devices().
20ee6a970 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-11  648  	 */
807a827d4 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  649  	eeh_pe_state_mark(pe, EEH_PE_KEEP);
e723e4b42 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  650  	if (driver_eeh_aware || (pe->type & EEH_PE_VF)) {
e723e4b42 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  651  		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
67086e32b arch/powerpc/kernel/eeh_driver.c            Wei Yang          2016-03-04  652  	} else {
1c2042c83 arch/powerpc/kernel/eeh_driver.c            Rafael J. Wysocki 2014-01-15  653  		pci_lock_rescan_remove();
bd251b893 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2016-05-03  654  		pci_hp_remove_devices(bus);
1c2042c83 arch/powerpc/kernel/eeh_driver.c            Rafael J. Wysocki 2014-01-15  655  		pci_unlock_rescan_remove();
67086e32b arch/powerpc/kernel/eeh_driver.c            Wei Yang          2016-03-04  656  	}
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  657  
d0914f503 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-04-24  658  	/*
d0914f503 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-04-24  659  	 * Reset the pci controller. (Asserts RST#; resets config space).
b6495c0c8 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  660  	 * Reconfigure bridges and devices. Don't try to bring the system
29f8bf1b7 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-02-27  661  	 * up if the reset failed for some reason.
d0914f503 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-04-24  662  	 *
d0914f503 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-04-24  663  	 * During the reset, it's very dangerous to have uncontrolled PCI
d0914f503 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-04-24  664  	 * config accesses. So we prefer to block them. However, controlled
d0914f503 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-04-24  665  	 * PCI config accesses initiated from EEH itself are allowed.
29f8bf1b7 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-02-27  666  	 */
6654c9368 arch/powerpc/kernel/eeh_driver.c            Russell Currey    2016-11-17  667  	rc = eeh_pe_reset_full(pe);
28bf36f92 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-11-14  668  	if (rc)
b6495c0c8 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  669  		return rc;
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  670  
1c2042c83 arch/powerpc/kernel/eeh_driver.c            Rafael J. Wysocki 2014-01-15  671  	pci_lock_rescan_remove();
1c2042c83 arch/powerpc/kernel/eeh_driver.c            Rafael J. Wysocki 2014-01-15  672  
9b3c76f08 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-07  673  	/* Restore PE */
9b3c76f08 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-07  674  	eeh_ops->configure_bridge(pe);
9b3c76f08 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-07  675  	eeh_pe_restore_bars(pe);
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  676  
dc9c41bd9 arch/powerpc/kernel/eeh_driver.c            Andrew Donnellan  2015-12-08  677  	/* Clear frozen state */
5cfb20b96 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-09-30  678  	rc = eeh_clear_pe_frozen_state(pe, false);
409bf7f8a arch/powerpc/kernel/eeh_driver.c            Andrew Donnellan  2016-12-01  679  	if (rc) {
409bf7f8a arch/powerpc/kernel/eeh_driver.c            Andrew Donnellan  2016-12-01  680  		pci_unlock_rescan_remove();
789547006 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-04-24  681  		return rc;
409bf7f8a arch/powerpc/kernel/eeh_driver.c            Andrew Donnellan  2016-12-01  682  	}
789547006 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2014-04-24  683  
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  684  	/* Give the system 5 seconds to finish running the user-space
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  685  	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  686  	 * this is a hack, but if we don't do this, and try to bring
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  687  	 * the device up before the scripts have taken it down,
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  688  	 * potentially weird things happen.
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  689  	 */
e723e4b42 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  690  	if (!driver_eeh_aware || rmv_data->removed) {
e723e4b42 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  691  		pr_info("EEH: Sleep 5s ahead of %s hotplug\n",
e723e4b42 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19 @692  			(eeh_aware_driver ? "partial" : "complete"));
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  693  		ssleep(5);
f5c57710d arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  694  
f5c57710d arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  695  		/*
f5c57710d arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  696  		 * The EEH device is still connected with its parent
f5c57710d arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  697  		 * PE. We should disconnect it so the binding can be
f5c57710d arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  698  		 * rebuilt when adding PCI devices.
f5c57710d arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  699  		 */
67086e32b arch/powerpc/kernel/eeh_driver.c            Wei Yang          2016-03-04  700  		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
f5c57710d arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  701  		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
a3aa256b7 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2016-06-17  702  		if (pe->type & EEH_PE_VF) {
67086e32b arch/powerpc/kernel/eeh_driver.c            Wei Yang          2016-03-04  703  			eeh_add_virt_device(edev, NULL);
a3aa256b7 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2016-06-17  704  		} else {
e723e4b42 arch/powerpc/kernel/eeh_driver.c            Sam Bobroff       2018-03-19  705  			if (!eeh_aware_driver)
a3aa256b7 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2016-06-17  706  				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
bd251b893 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2016-05-03  707  			pci_hp_add_devices(bus);
a3aa256b7 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2016-06-17  708  		}
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  709  	}
f5c57710d arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-07-24  710  	eeh_pe_state_clear(pe, EEH_PE_KEEP);
5a71978e4 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-06-20  711  
5a71978e4 arch/powerpc/kernel/eeh_driver.c            Gavin Shan        2013-06-20  712  	pe->tstamp = tstamp;
9b3c76f08 arch/powerpc/platforms/pseries/eeh_driver.c Gavin Shan        2012-09-07  713  	pe->freeze_count = cnt;
b6495c0c8 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  714  
1c2042c83 arch/powerpc/kernel/eeh_driver.c            Rafael J. Wysocki 2014-01-15  715  	pci_unlock_rescan_remove();
b6495c0c8 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  716  	return 0;
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  717  }
77bd74156 arch/powerpc/platforms/pseries/eeh_driver.c Linas Vepstas     2005-11-03  718  

:::::: The code at line 692 was first introduced by commit
:::::: e723e4b4269eefe9c70fbb6c378a26ab202662e2 powerpc/eeh: Factor out common code eeh_reset_device()

:::::: TO: Sam Bobroff <sam.bobroff@au1.ibm.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zDr/H3DNjx4siQEA

--mP3DRpeJDSE+ciuQ--
