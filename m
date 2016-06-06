Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0b-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNSNH1htXzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 18:21:51 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u568JFxu010784
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jun 2016 04:21:49 -0400
Message-Id: <201606060821.u568JFxu010784@mx0a-001b2d01.pphosted.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23d4rbtv78-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jun 2016 04:21:47 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 6 Jun 2016 13:51:43 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E7B79125804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 13:54:05 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u568LERL11272632
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jun 2016 13:51:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u568LUoM008191
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jun 2016 13:51:39 +0530
Subject: Re: [RESEND PATCH v2 2/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI
 controller enables IRQ remapping
To: kbuild test robot <lkp@intel.com>
References: <201606060406.lSpseFnO%fengguang.wu@intel.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 will.deacon@arm.com, paulus@samba.org, eric.auger@linaro.org,
 joro@8bytes.org, kevin.tian@intel.com, nikunj@linux.vnet.ibm.com,
 alistair@popple.id.au, gwshan@linux.vnet.ibm.com,
 alex.williamson@redhat.com, bhelgaas@google.com,
 zhong@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, David.Laight@ACULAB.COM,
 kbuild-all@01.org, warrier@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Mon, 6 Jun 2016 16:21:35 +0800
MIME-Version: 1.0
In-Reply-To: <201606060406.lSpseFnO%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/6/6 4:10, kbuild test robot wrote:

> Hi,
>
> [auto build test ERROR on vfio/next]
> [also build test ERROR on v4.7-rc1 next-20160603]
> [cannot apply to pci/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Yongji-Xie/PCI-Add-a-new-PCI_BUS_FLAGS_MSI_REMAP-flag/20160530-215348
> base:   https://github.com/awilliam/linux-vfio.git next
> config: arm-sa1100 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>     drivers/built-in.o: In function `pci_set_bus_msi_domain':
>>> arm_pmu.c:(.text+0x5c58): undefined reference to `pci_bus_msi_isolated'

Sorry for this fault. I will fix it in next version.  The 
pci_bus_msi_isolated() should not
depend on CONFIG_PCI_MSI, I would move this function from 
drivers/pci/msi.c to
drivers/pci/probe.c.

Thanks,
Yongji
