Return-Path: <mopsfelder@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk8ZQ38jzzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:33:02 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id o21so8913458qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:33:02 -0700 (PDT)
Subject: Re: [PATCH] include/linux/vfio.h: Guard powerpc-specific functions
 with CONFIG_VFIO_SPAPR_EEH
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
References: <201706080005.vXjRK5G3%fengguang.wu@intel.com>
 <a0d62075-cb00-c69b-7f39-95a3b53f4061@ozlabs.ru>
 <871squemf2.fsf@concordia.ellerman.id.au>
 <e426fff2-ad3e-64c6-7c6b-2c37c16c00c1@gmail.com>
 <dc26bfd2-9ba6-b3bd-afa9-ed0d801757b7@ozlabs.ru>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <mopsfelder@gmail.com>
Message-ID: <edf52bc1-977d-27bc-de8d-a5721e1c3f59@gmail.com>
Date: Thu, 8 Jun 2017 12:32:54 -0300
MIME-Version: 1.0
In-Reply-To: <dc26bfd2-9ba6-b3bd-afa9-ed0d801757b7@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/08/2017 10:10 AM, Alexey Kardashevskiy wrote:
[...]
> The config you attached in the first mail has CONFIG_VFIO_SPAPR_EEH=m, here
> is my confusion. The config from the link below does not have KVM_BOOK3S_64
> which selects SPAPR_TCE_IOMMU and which in turn selects VFIO_IOMMU_SPAPR_TCE.
> 
> So
> https://github.com/0day-ci/linux/commit/36ed1ddb05e132aa3cfbb610f0f8402a0774da12
> looks correct.

It wasn't me that attached the .config.gz, it was this 0dayci robot.

When CONFIG_VFIO_SPAPR_EEH=m, there is no definition of it in autoconf.h, only
CONFIG_VFIO_SPAPR_EEH_MODULE is defined:

    $ grep 'VFIO_SPAPR_EEH' ./include/generated/autoconf.h
    #define CONFIG_VFIO_SPAPR_EEH_MODULE 1

In this case, `#ifdef CONFIG_VFIO_SPAPR_EEH` will be false. That's why my v1
patch failed with the 0dayci .config and robot reported back.

This was addressed in my v2 patch using the IS_ENABLED() macro, which checks for
both CONFIG_<name> and CONFIG_<name>_MODULE definitions.

-- 
Murilo
