Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9B711A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 15:13:28 +1000 (AEST)
In-Reply-To: <1442296114-16796-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@au1.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: cxl: Fix build failure due to -Wunused-variable behaviour change
Message-Id: <20150917051328.787D2140281@ozlabs.org>
Date: Thu, 17 Sep 2015 15:13:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-15-09 at 05:48:34 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> A recent change in gcc caused this build failure:
> 
> /var/lib/jenkins/workspace/gcc_kernel_build/linux/drivers/misc/cxl/cxl.h:72:27:
> error: ‘CXL_PSL_DLCNTL’ defined but not used [-Werror=unused-const-variable]
>  static const cxl_p1_reg_t CXL_PSL_DLCNTL  = {0x0060};
> 
> Because of this gcc commit:
> 
> Commit 1bca8cbd0c68366f07277f98ce6963e10c2aa617 by mark
> PR28901 -Wunused-variable ignores unused const initialised variables in C
> 12 years ago it was decided that -Wunused-variable shouldn't warn about
> static const variables because some code used const static char rcsid[]
> strings which were never used but wanted in the code anyway. But as the
> bug points out this hides some real bugs. These days the usage of
> rcsids is not very popular anymore. So this patch changes the default
> to warn about unused static const variables in C with
> -Wunused-variable. And it adds a new option -Wno-unused-const-variable
> to turn this warning off. For C++ this new warning is off by default,
> since const variables can be used as #defines in C++. New testcases for
> the new defaults in C and C++ are included testing the new warning and
> suppressing it with an unused attribute or using
> -Wno-unused-const-variable. gcc/ChangeLog
> 
> The cxl driver uses static consts in place of #defines in some cases
> for type safety, so this change causes the driver to fail to build on
> new copilers as these constants are not all used in every file that
> imports the header. Suppress the warning for this driver to return to
> the old behaviour of -Wunused-variable.
> 
> Reported-by: Anton Blanchard <anton@au1.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2cd55c68c0a49a75433b15c7

cheers
