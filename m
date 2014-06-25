Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35A3C1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:03:13 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 10:03:11 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CB0C73578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:03:07 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P02pch3080614
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:02:51 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P036ud021880
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:03:06 +1000
Date: Wed, 25 Jun 2014 10:03:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
Message-ID: <20140625000305.GA5742@shangw>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <53A91819.1010900@linux.vnet.ibm.com>
 <1403591761.4587.161.camel@pasglop>
 <53A9216C.8050904@linux.vnet.ibm.com>
 <1403593252.4587.163.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403593252.4587.163.camel@pasglop>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 05:00:52PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2014-06-24 at 14:57 +0800, Mike Qiu wrote:
>> Is that mean *host* side error injection should base on 
>> "CONFIG_IOMMU_API" ? If it is just host side(no guest, no pass through), 
>> can't we do error inject?
>> 
>> Maybe I misunderstand :)
>
>Ah no, make different patches, we don't want to use IOMMU group ID, just
>PE numbers. Maybe we should expose in sysfs the PEs from the platform
>code with the error injection files underneath ... 
>

Yeah, "errinjct" needs grab PCI_domain_nr+PE number from sysfs. We
already had PE number sysfs file:

[root@ltcfbl8eb 0000:01:00.1]# pwd
/sys/bus/pci/devices/0000:01:00.1
[root@ltcfbl8eb 0000:01:00.1]# cat eeh_pe_config_addr 
0x1

For guest support, we will rely on VFIO group ioctl command, which
naturally depends on pass-through.

---

We probably implement it like this. If there're anything wrong, please
correct me:

- Introduce EEH callback struct eeh_ops::err_inject(), which will be
  implemented for PowerNV (NULL for pSeries) by calling the PCI error
  injection dedicated OPAL API (opal_pci_err_inject()).
- Introduce global function eeh.c::eeh_err_inject(), which calls to
  eeh_ops::err_inject() and newly introduced VFIO EEH operation
  will be implemented based on this function.
- Introduce debugfs /sys/kernel/debug/powerpc/PCIxxxx/errinjct, which
  receives PCI error injection parameters from "errinjct". It could
  have format: "ei_token:addr:mask:PCI_domain_nr:PE_num:function".
  Eventually, eeh_err_inject() is invoked to call the corresponding
  OPAL API.

Thanks,
Gavin
