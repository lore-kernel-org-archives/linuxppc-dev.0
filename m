Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9E7DB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 11:51:30 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 25 Apr 2012 01:43:31 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3P1pGjC33620214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 11:51:16 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3P1pFHg005996
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 11:51:16 +1000
Date: Wed, 25 Apr 2012 09:50:44 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Ryan Wang <openspace.wang@gmail.com>
Subject: Re: 3.4-rc3 compile failed on IBM Power6
Message-ID: <20120425015044.GA4637@shangw>
References: <CAPxxNQmfkJLPHq0BvzxOnLFO-e0FRmaF1VqLhP-jMqF-ziM2tA@mail.gmail.com>
 <20120425005432.GA14663@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120425005432.GA14663@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nish,

>> # gcc --version
>> gcc (GCC) 4.4.6 20110731 (Red Hat 4.4.6-3)
>> Copyright (C) 2010 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> 
>> platform    : pSeries
>> model        : IBM,9117-MMA
>> machine        : CHRP IBM,9117-MMA
>
><snip>
>
>>   CC      arch/powerpc/platforms/pseries/iommu.o
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c: In function
>> ?query_ddw?:
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:823: error:
>> implicit declaration of function ?pci_dev_to_eeh_dev?
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:823: warning:
>> assignment makes pointer from integer without a cast
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:824: error:
>> dereferencing pointer to incomplete type
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:825: error:
>> dereferencing pointer to incomplete type
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:826: error:
>> dereferencing pointer to incomplete type
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:827: error:
>> dereferencing pointer to incomplete type
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c: In function
>> ?create_ddw?:
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:852: warning:
>> assignment makes pointer from integer without a cast
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:853: error:
>> dereferencing pointer to incomplete type
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:854: error:
>> dereferencing pointer to incomplete type
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:855: error:
>> dereferencing pointer to incomplete type
>> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:856: error:
>> dereferencing pointer to incomplete type
>> make[3]: *** [arch/powerpc/platforms/pseries/iommu.o] Error 1
>> make[2]: *** [arch/powerpc/platforms/pseries] Error 2
>> make[1]: *** [arch/powerpc/platforms] Error 2
>> make: *** [sub-make] Error 2
>
>Do you have CONFIG_EEH set in your .config? I'm guessing not, and that
>causes pci.h to not define pci_dev_to_eeh_dev().
>
>Gavin, I think this is broken by your
>39baadbf36cee3ede5fdb8a34006d9109e5e2570. Probably need a wrapper for
>pci_dev_to_eeh_dev() when !CONFIG_EEH?
>
>Actually, looking at it more, eeh_dev, which is protected by CONFIG_EEH
>in arch/powerpc/include/asm/eeh.h won't be defined in such situations
>and is the type of the return from pci_dev_to_eeh_dev(). So that's going
>to be broken completely if !CONFIG_EEH as above.
>

I think it's because iommu.c depends on CONFIG_EEH heavily anyway with
or without the fix 39baadbf36cee3ede5fdb8a34006d9109e5e2570. That means
without CONFIG_EEH, iommu.c won't work properly even it can be compiled
successfully :-)

The story behind is that the PCI device is expected to be PE sensitive.
While setting up its DMA (through IOMMU), the number of the PE to which
the PCI device belongs to is passed to the related RTAS call. So the
PE number of the PCI device is expected if possible. As I knew, the PE
number of the PCI device is -ONLY- figured out by EEH.
 
>So maybe the callers should be EEH-unaware (as they were before) and the
>callee becomes of the EEH variety (at compile-time) if CONFIG_EEH is
>set?
>

In order to make iommu.c irrelative to CONFIG_EEH, we might figure out
the PE number of the PCI device during PCI probe time. Here're some
rough thoughts about the rework.

	- Introduce additional field "int pe_num" to "struct dev_archdata".
	  That would be traced like: (struct pci_dev)->(struct device dev)
	  ->(struct dev_archdata archdata).
	- During the PCI probe time (maybe pci_fixup_early), we can figure
	  out the PE number.

Then we can retrieve the PE number of PCI device from "int pe_num" and needn't
care CONFIG_EEH has been turned on or off. I'm not sure Ben has any comments
on the idea? 

Thanks,
Gavin
 
