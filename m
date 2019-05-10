Return-Path: <SRS0=Jq0w=TK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD143C04A6B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 22:43:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4017F217D6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 22:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4017F217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4514xb0krQzDqT5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 May 2019 08:43:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4514w3705yzDqCV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2019 08:42:11 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4AMg8wi085470
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 18:42:08 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2sdfhqdp8f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 18:42:08 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 10 May 2019 23:42:01 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 10 May 2019 23:41:57 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4AMfuX44325720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 May 2019 22:41:56 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6760CC6055;
 Fri, 10 May 2019 22:41:56 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B014BC6057;
 Fri, 10 May 2019 22:41:54 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.222.100])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri, 10 May 2019 22:41:54 +0000 (GMT)
References: <20190507062559.20295-1-aik@ozlabs.ru>
 <20190507062559.20295-3-aik@ozlabs.ru>
User-agent: mu4e 1.0; emacs 26.2
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 2/2] powerpc/pseries/dma: Enable swiotlb
In-reply-to: <20190507062559.20295-3-aik@ozlabs.ru>
Date: Fri, 10 May 2019 19:41:50 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19051022-0020-0000-0000-00000EE68EC0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011083; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01201495; UDB=6.00630504; IPR=6.00982392; 
 MB=3.00026837; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-10 22:41:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051022-0021-0000-0000-000065C66A2E
Message-Id: <87zhnu0w5t.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-10_16:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100144
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hello Alexey,

Thanks!

I have similar changes in my "Secure Virtual Machine Enablement"
patches, which I am currently preparing for posting again real soon now.

This is the last version:

https://lore.kernel.org/linuxppc-dev/20180824162535.22798-1-bauerman@linux.ibm.com/

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> So far the pseries platforms has always been using IOMMU making SWIOTLB
> unnecessary. Now we want secure guests which means devices can only
> access certain areas of guest physical memory; we are going to use
> SWIOTLB for this purpose.
>
> This allows SWIOTLB for pseries. By default there is no change in behavior.
>
> This enables SWIOTLB when the "swiotlb" kernel parameter is set to "force".
>
> With the SWIOTLB enabled, the kernel creates a directly mapped DMA window
> (using the usual DDW mechanism) and implements SWIOTLB on top of that.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/pseries/setup.c | 5 +++++
>  arch/powerpc/platforms/pseries/Kconfig | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index e4f0dfd4ae33..30d72b587ac5 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -42,6 +42,7 @@
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
>  #include <linux/memblock.h>
> +#include <linux/swiotlb.h>
>
>  #include <asm/mmu.h>
>  #include <asm/processor.h>
> @@ -71,6 +72,7 @@
>  #include <asm/isa-bridge.h>
>  #include <asm/security_features.h>
>  #include <asm/asm-const.h>
> +#include <asm/swiotlb.h>
>
>  #include "pseries.h"
>  #include "../../../../drivers/pci/pci.h"
> @@ -797,6 +799,9 @@ static void __init pSeries_setup_arch(void)
>  	}
>
>  	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
> +
> +	if (swiotlb_force == SWIOTLB_FORCE)
> +		ppc_swiotlb_enable = 1;
>  }

Yep! I have this here, enabled when booting as a secure guest:

https://lore.kernel.org/linuxppc-dev/20180824162535.22798-6-bauerman@linux.ibm.com/

And also another patch which makes it so that if booting as a secure
guest it acts as if the swiotlb kernel parameter was set to force:

https://lore.kernel.org/linuxppc-dev/20180824162535.22798-11-bauerman@linux.ibm.com/

>  static void pseries_panic(char *str)
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 9c6b3d860518..b9e8b608de01 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -23,6 +23,7 @@ config PPC_PSERIES
>  	select ARCH_RANDOM
>  	select PPC_DOORBELL
>  	select FORCE_SMP
> +	select SWIOTLB
>  	default y
>
>  config PPC_SPLPAR

I put this in a PPC_SVM config option:

https://lore.kernel.org/linuxppc-dev/20180824162535.22798-3-bauerman@linux.ibm.com/

--
Thiago Jung Bauermann
IBM Linux Technology Center

