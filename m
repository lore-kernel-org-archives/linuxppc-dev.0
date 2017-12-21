Return-Path: <jjalvare@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2Gh80j0NzF07X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 14:04:23 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBL2x8a9063673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 22:04:21 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eyxhmf1en-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 22:04:20 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jjalvare@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 20:04:19 -0700
Subject: Re: [PATCH v2 2/7] powerpc/kernel: Add uevents in EEH error/resume
To: Russell Currey <ruscur@russell.cc>, Bjorn Helgaas <helgaas@kernel.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 seroyer@linux.vnet.ibm.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com,
 Keith Busch <keith.busch@intel.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Dongdong Liu <liudongdong3@huawei.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
 <20171218223808.83928-3-bryantly@linux.vnet.ibm.com>
 <20171219045009.GC14941@bhelgaas-glaptop.roam.corp.google.com>
 <1513659576.2151.6.camel@russell.cc>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 21:04:10 -0600
MIME-Version: 1.0
In-Reply-To: <1513659576.2151.6.camel@russell.cc>
Content-Type: text/plain; charset=utf-8
Message-Id: <cb6afad3-b0f9-f60c-eeaf-7f0aec88f7ef@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/18/17 10:59 PM, Russell Currey wrote:

> On Mon, 2017-12-18 at 22:50 -0600, Bjorn Helgaas wrote:
>> [+cc Keith, Gabriele, Dongdong]
>>
>> On Mon, Dec 18, 2017 at 04:38:03PM -0600, Bryant G. Ly wrote:
>>> Devices can go offline when EEH is reported. This patch adds
>>> a change to the kernel object and lets udev know of error.
>>> When device resumes a change is also set reporting device as
>>> online. Therefore, EEH events are better propagated to user
>>> space for devices in powerpc arch.
>> I'm on vacation and can't review this in detail, but I wonder if you
>> can compare this with the uevents we emit for DPC, AER, and hotplug
>> events (if any).  I hope we don't end up with userspace having to be
>> aware of the differences between EEH, DPC, AER, etc.
>>
>> From a very quick look, I only see a few uevents even mentioned in
>> drivers/pci: KOBJ_ADD in __pci_hp_register() and KOBJ_CHANGE in the
>> SR-IOV code.  I'm worried that we're missing some important uevents
>> in
>> the PCI core.  

The only place where I see the KOBJ_REMOVE being used is when the device is 
removed in pci_destroy_dev -> device_del whic will be called implicitly
in permanent failure path of EEH code

>> That's not an argument against what you're doing here;
>> it just would be nice to fill in any missing pieces in the core also,
>> and hopefully make them consistent with these EEH events.
> I don't think this needs to be particularly complex, could we get away
> with events for when devices do the following?
>
> - begin recovery
> - successfully recover
> - fail recovery

If there are no objections in the on going review of this patch 
I can change them to these names:

  - BEGIN_RECOVERY
  - SUCCESSFUL_RECOVERY
  - FAILED_RECOVERY

>
> It might be worthwhile sorting out some consistent, non-EEH-specific
> naming, and then other device error recovery systems can do the same
> later.
>
Do you have a more consistent naming in mind for these events? 

- Juan
