Return-Path: <SRS0=Y17X=YK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25988FA3735
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2019 13:02:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9852320640
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2019 13:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9852320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46v8TV5Zn6zDqcS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 00:02:38 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46v8Pc0qdzzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2019 23:59:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46v8Pb1mT3z8sy4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2019 23:59:15 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 46v8Pb0rQwz9sPc; Thu, 17 Oct 2019 23:59:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nayna@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46v8PZ3s94z9sPW;
 Thu, 17 Oct 2019 23:59:14 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9HCqajx130707; Thu, 17 Oct 2019 08:58:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vprdx92pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 08:58:56 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9HCqeNS131031;
 Thu, 17 Oct 2019 08:58:56 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vprdx92nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 08:58:56 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9HCuGTX003724;
 Thu, 17 Oct 2019 12:58:55 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02dal.us.ibm.com with ESMTP id 2vk6f815ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 12:58:55 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9HCwroP31457722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2019 12:58:53 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 390AF13605E;
 Thu, 17 Oct 2019 12:58:53 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAA4013605D;
 Thu, 17 Oct 2019 12:58:50 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.165.227])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2019 12:58:50 +0000 (GMT)
Subject: Re: [PATCH v7 2/8] powerpc: add support to initialize ima policy rules
To: Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
 linux-integrity@vger.kernel.org
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
 <1570497267-13672-3-git-send-email-nayna@linux.ibm.com>
 <871rveuu0i.fsf@mpe.ellerman.id.au>
From: Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <fbd8ca54-19ff-b77b-9e15-d900168bbdb3@linux.vnet.ibm.com>
Date: Thu, 17 Oct 2019 08:58:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <871rveuu0i.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-17_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170119
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Matthew Garret <matthew.garret@nebula.com>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 Elaine Palmer <erpalmer@us.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 10/15/2019 07:29 AM, Michael Ellerman wrote:
> Nayna Jain <nayna@linux.ibm.com> writes:
>> PowerNV systems uses kernel based bootloader, thus its secure boot
>> implementation uses kernel IMA security subsystem to verify the kernel
>> before kexec. Since the verification policy might differ based on the
>> secure boot mode of the system, the policies are defined at runtime.
>>
>> This patch implements the arch-specific support to define the IMA policy
>> rules based on the runtime secure boot mode of the system.
>>
>> This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
>> config is enabled.
> ...
>> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
>> new file mode 100644
>> index 000000000000..c22d82965eb4
>> --- /dev/null
>> +++ b/arch/powerpc/kernel/ima_arch.c
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 IBM Corporation
>> + * Author: Nayna Jain
>> + */
>> +
>> +#include <linux/ima.h>
>> +#include <asm/secure_boot.h>
>> +
>> +bool arch_ima_get_secureboot(void)
>> +{
>> +	return is_powerpc_os_secureboot_enabled();
>> +}
>> +
>> +/* Defines IMA appraise rules for secureboot */
>> +static const char *const arch_rules[] = {
>> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>> +#if !IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
>> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>> +#endif
> This confuses me.
>
> If I spell it out we get:
>
> #if IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
> 	// nothing
> #else
> 	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> #endif
>
> Which is just:
>
> #ifdef CONFIG_MODULE_SIG_FORCE
> 	// nothing
> #else
> 	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> #endif
>
> But CONFIG_MODULE_SIG_FORCE enabled says that we *do* require modules to
> have a valid signature. Isn't that the inverse of what the rules say?
>
> Presumably I'm misunderstanding something :)

To avoid duplicate signature verification as much as possible, the IMA 
policy rule is added only if CONFIG_MODULE_SIG_FORCE is not enabled. 
CONFIG_MODULE_SIG_FORCE is part of modules support. IMA signature 
verification is based on policy.

Thanks & Regards,
      - Nayna

