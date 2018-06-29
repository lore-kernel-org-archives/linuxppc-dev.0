Return-Path: <srs0=ztko=jp=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H41S1FW3zF1BP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 14:49:16 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41H41S03b1z8t4B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 14:49:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41H41R3hGdz9ryk
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2018 14:49:15 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5T4iSE5065812
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2018 00:49:13 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jw8mbbnsu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2018 00:49:13 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 05:49:11 +0100
Subject: Re: [PATCH v4 1/6] powerpc/pseries: Defer the logging of rtas error
 to irq work queue.
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, stable@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <153018423713.31589.14195888319570120941.stgit@jupiter.in.ibm.com>
 <201806290421.wmb85tYm%fengguang.wu@intel.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 10:19:04 +0530
MIME-Version: 1.0
In-Reply-To: <201806290421.wmb85tYm%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <c43f4da4-6989-86dd-5104-ac73ae60b19f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2018 02:35 AM, kbuild test robot wrote:
> Hi Mahesh,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.18-rc2 next-20180628]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Mahesh-J-Salgaonkar/powerpc-pseries-Defer-the-logging-of-rtas-error-to-irq-work-queue/20180628-224101
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
> 
> Note: the linux-review/Mahesh-J-Salgaonkar/powerpc-pseries-Defer-the-logging-of-rtas-error-to-irq-work-queue/20180628-224101 HEAD 3496ae1afd6528103d508528e25bfca82c60f4ee builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/platforms/pseries/ras.c: In function 'mce_process_errlog_event':
>>> arch/powerpc/platforms/pseries/ras.c:433:8: error: implicit declaration of function 'fwnmi_get_errlog'; did you mean 'fwnmi_get_errinfo'? [-Werror=implicit-function-declaration]
>      err = fwnmi_get_errlog();
>            ^~~~~~~~~~~~~~~~
>            fwnmi_get_errinfo
>>> arch/powerpc/platforms/pseries/ras.c:433:6: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>      err = fwnmi_get_errlog();
>          ^
>    cc1: all warnings being treated as errors

Ouch... Looks like I pushed down the function definition while
rearranging the hunks. Will fix it in next revision. Thanks for catching
this.

Thanks,
-Mahesh.
