Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slWcd2Vs3zDvHF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:53:53 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8TNqoAN125244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 19:53:50 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25s8suh4uv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 19:53:50 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 30 Sep 2016 09:53:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 92BC12CE805B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:53:44 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8TNri5W66977806
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:53:44 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8TNrhRq012129
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:53:44 +1000
Date: Fri, 30 Sep 2016 09:45:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, clsoto@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI: Add parameter @mmio_force_on to pci_update_resource()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1474242810-11530-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160927192003.GA14642@localhost>
 <1475012732.2857.293.camel@au1.ibm.com>
 <20160927233749.GA19797@gwshan>
 <1475021204.2857.302.camel@au1.ibm.com>
 <20160928011408.GA20356@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160928011408.GA20356@gwshan>
Message-Id: <20160929234502.GA5644@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 11:14:08AM +1000, Gavin Shan wrote:
>On Wed, Sep 28, 2016 at 10:06:44AM +1000, Benjamin Herrenschmidt wrote:
>>On Wed, 2016-09-28 at 09:37 +1000, Gavin Shan wrote:
>>> 
>>> Yeah, it's safe to update it with memory decoding on. As the function call
>>> flow I listed in the changelog (as below), nobody should access the IOV BAR
>>> when pci_update_resource() is called. However, the PF's memory BARs might
>>> be accessed that time and it's not safe to disable PF's memory decoding.
>>
>>The problem isn't so much whether anybody accesses the IOV BAR while
>>it's updated but whether the IOV BAR will decode at all.
>>
>>IE. The BAR is updated in two steps, 32-bit each. That means that there
>>is a window where it contains a "bogus" value.
>>
>>If that bogus value conflicts with another BAR (another BAR of the  PF
>>or another PF of the same device for example) then there is a risk of
>>something bad happening if the driver accesses that conflicting
>>resource during that window.
>>
>>On the other hand, if the IOV BAR doesn't decode at all while the
>>update is done, which I think is the case as I believe SR-IOV isn't
>>enabled during the update (please verify), then we are safe.
>>
>
>I assumed the SRIOV and its memory space aren't enabled when updating IOV
>BARs, but unfortunately they have been enabled at that point. I think
>pcibios_sriov_enable() should be moved before SRIOV is enabled. Note
>that pcibios_sriov_enable() is used by PowerNV only.
>
>static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>{
>		:
>        pci_iov_set_numvfs(dev, nr_virtfn);
>        iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>        pci_cfg_access_lock(dev);
>        pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);	/* SRIOV and its memory space enabled */
>        msleep(100);
>        pci_cfg_access_unlock(dev);
>
>        iov->initial_VFs = initial;
>        if (nr_virtfn < initial)
>                initial = nr_virtfn;
>
>        rc = pcibios_sriov_enable(dev, initial);				/* IOV BARs are updated inside it */
>
>		:
>}
>

I will add one patch in v2, to call pcibios_sriov_enable() before IOV BARs
are enabled. v2 will be posted shortly.

Thanks,
Gavin
