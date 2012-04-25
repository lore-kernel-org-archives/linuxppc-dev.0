Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40739B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 10:54:43 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 24 Apr 2012 18:54:40 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E428F3E40047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 18:54:37 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3P0scSW233616
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 18:54:38 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3P0sbVH006733
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 18:54:37 -0600
Date: Tue, 24 Apr 2012 17:54:32 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Ryan Wang <openspace.wang@gmail.com>
Subject: Re: 3.4-rc3 compile failed on IBM Power6
Message-ID: <20120425005432.GA14663@linux.vnet.ibm.com>
References: <CAPxxNQmfkJLPHq0BvzxOnLFO-e0FRmaF1VqLhP-jMqF-ziM2tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPxxNQmfkJLPHq0BvzxOnLFO-e0FRmaF1VqLhP-jMqF-ziM2tA@mail.gmail.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ryan,

Thanks for the report!

On 25.04.2012 [08:22:19 +0800], Ryan Wang wrote:
> # gcc --version
> gcc (GCC) 4.4.6 20110731 (Red Hat 4.4.6-3)
> Copyright (C) 2010 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> platform    : pSeries
> model        : IBM,9117-MMA
> machine        : CHRP IBM,9117-MMA

<snip>

>   CC      arch/powerpc/platforms/pseries/iommu.o
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c: In function
> ?query_ddw?:
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:823: error:
> implicit declaration of function ?pci_dev_to_eeh_dev?
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:823: warning:
> assignment makes pointer from integer without a cast
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:824: error:
> dereferencing pointer to incomplete type
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:825: error:
> dereferencing pointer to incomplete type
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:826: error:
> dereferencing pointer to incomplete type
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:827: error:
> dereferencing pointer to incomplete type
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c: In function
> ?create_ddw?:
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:852: warning:
> assignment makes pointer from integer without a cast
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:853: error:
> dereferencing pointer to incomplete type
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:854: error:
> dereferencing pointer to incomplete type
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:855: error:
> dereferencing pointer to incomplete type
> /usr/src/kernels/linux/arch/powerpc/platforms/pseries/iommu.c:856: error:
> dereferencing pointer to incomplete type
> make[3]: *** [arch/powerpc/platforms/pseries/iommu.o] Error 1
> make[2]: *** [arch/powerpc/platforms/pseries] Error 2
> make[1]: *** [arch/powerpc/platforms] Error 2
> make: *** [sub-make] Error 2

Do you have CONFIG_EEH set in your .config? I'm guessing not, and that
causes pci.h to not define pci_dev_to_eeh_dev().

Gavin, I think this is broken by your
39baadbf36cee3ede5fdb8a34006d9109e5e2570. Probably need a wrapper for
pci_dev_to_eeh_dev() when !CONFIG_EEH?

Actually, looking at it more, eeh_dev, which is protected by CONFIG_EEH
in arch/powerpc/include/asm/eeh.h won't be defined in such situations
and is the type of the return from pci_dev_to_eeh_dev(). So that's going
to be broken completely if !CONFIG_EEH as above.

So maybe the callers should be EEH-unaware (as they were before) and the
callee becomes of the EEH variety (at compile-time) if CONFIG_EEH is
set?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
