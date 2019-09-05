Return-Path: <SRS0=2H2D=XA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AE3C3A5A5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 12:35:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DC72080C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 12:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DC72080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46PKsB3Q6BzDr3N
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 22:35:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46PKnY3wcgzDr0w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 22:32:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46PKnY11lYz8tC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 22:32:01 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46PKnY0MHDz9sN1; Thu,  5 Sep 2019 22:32:01 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nayna@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46PKnX2H1pz9s4Y;
 Thu,  5 Sep 2019 22:32:00 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x85CUxp6072330; Thu, 5 Sep 2019 08:31:51 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uu23511x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 08:31:50 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x85CVL6n002239;
 Thu, 5 Sep 2019 12:31:49 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma04dal.us.ibm.com with ESMTP id 2uqgh79bj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 12:31:49 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x85CVl8C46989710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Sep 2019 12:31:47 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEBE26A054;
 Thu,  5 Sep 2019 12:31:47 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C11B36A04D;
 Thu,  5 Sep 2019 12:31:45 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.196.15])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Sep 2019 12:31:45 +0000 (GMT)
Subject: Re: [PATCH v5 2/2] powerpc: Add support to initialize ima policy rules
To: Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1566218108-12705-1-git-send-email-nayna@linux.ibm.com>
 <1566218108-12705-3-git-send-email-nayna@linux.ibm.com>
 <87sgpesynl.fsf@mpe.ellerman.id.au>
From: Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <de10425d-4d63-29e1-63be-1566099a5ab6@linux.vnet.ibm.com>
Date: Thu, 5 Sep 2019 08:31:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87sgpesynl.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-05_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050122
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, Elaine Palmer <erpalmer@us.ibm.com>,
 George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 09/02/2019 07:52 AM, Michael Ellerman wrote:
> Hi Nayna,

Hi Michael,

>
> Some more comments below.
>
> Nayna Jain <nayna@linux.ibm.com> writes:
>> POWER secure boot relies on the kernel IMA security subsystem to
>> perform the OS kernel image signature verification.
> Again this is just a design choice we've made, it's not specified
> anywhere or anything like that. And it only applies to bare metal secure
> boot, at least so far. AIUI.

Yes. I will make it consistent to use "PowerNV".

>> Since each secure
>> boot mode has different IMA policy requirements, dynamic definition of
>> the policy rules based on the runtime secure boot mode of the system is
>> required. On systems that support secure boot, but have it disabled,
>> only measurement policy rules of the kernel image and modules are
>> defined.
> It's probably worth mentioning that we intend to use this in our
> Linux-based boot loader, which uses kexec, and that's one of the reasons
> why we're particularly interested in defining the rules for kexec?

Yes. Agreed. I will update patch description to add this.

>
>> This patch defines the arch-specific implementation to retrieve the
>> secure boot mode of the system and accordingly configures the IMA policy
>> rules.
>>
>> This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
>> config is enabled.
>>
>> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig           |  2 ++
>>   arch/powerpc/kernel/Makefile   |  2 +-
>>   arch/powerpc/kernel/ima_arch.c | 50 ++++++++++++++++++++++++++++++++++
>>   include/linux/ima.h            |  3 +-
>>   4 files changed, 55 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/powerpc/kernel/ima_arch.c
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index c902a39124dc..42109682b727 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -917,6 +917,8 @@ config PPC_SECURE_BOOT
>>   	bool
>>   	default n
>>   	depends on PPC64
>> +	depends on IMA
>> +	depends on IMA_ARCH_POLICY
>>   	help
>>   	  Linux on POWER with firmware secure boot enabled needs to define
>>   	  security policies to extend secure boot to the OS.This config
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index d310ebb4e526..520b1c814197 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -157,7 +157,7 @@ endif
>>   obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
>>   obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
>>   
>> -obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o
>> +obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o ima_arch.o
>>   
>>   # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>>   GCOV_PROFILE_prom_init.o := n
>> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
>> new file mode 100644
>> index 000000000000..ac90fac83338
>> --- /dev/null
>> +++ b/arch/powerpc/kernel/ima_arch.c
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 IBM Corporation
>> + * Author: Nayna Jain <nayna@linux.ibm.com>
>> + *
>> + * ima_arch.c
>> + *      - initialize ima policies for PowerPC Secure Boot
>> + */
>> +
>> +#include <linux/ima.h>
>> +#include <asm/secboot.h>
>> +
>> +bool arch_ima_get_secureboot(void)
>> +{
>> +	return get_powerpc_secureboot();
>> +}
>> +
>> +/*
>> + * File signature verification is not needed, include only measurements
>> + */
>> +static const char *const default_arch_rules[] = {
>> +	"measure func=KEXEC_KERNEL_CHECK",
>> +	"measure func=MODULE_CHECK",
>> +	NULL
>> +};
> The rules above seem fairly self explanatory.
>
>> +
>> +/* Both file signature verification and measurements are needed */
>> +static const char *const sb_arch_rules[] = {
>> +	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
>> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>> +#if IS_ENABLED(CONFIG_MODULE_SIG)
>> +	"measure func=MODULE_CHECK",
>> +#else
>> +	"measure func=MODULE_CHECK template=ima-modsig",
>> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>> +#endif
> But these ones are not so obvious, at least to me who knows very little
> about IMA.
>
> Can you add a one line comment to each of the ones in here saying what
> it does and why we want it?

Sure.

>
>> +	NULL
>> +};
>> +
>> +/*
>> + * On PowerPC, file measurements are to be added to the IMA measurement list
>> + * irrespective of the secure boot state of the system.
> Why? Just because we think it's useful? Would be good to provide some
> further justification.

Sure. I will clarify this in the next version.

Thanks & Regards,
         - Nayna
