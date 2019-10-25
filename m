Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB84BCA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 18:04:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE3B205F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 18:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="czTwe7iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE3B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 470BpN6yQKzDqsJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 05:04:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 470Bm81ylDzDqfs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2019 05:02:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.b="czTwe7iE"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 470Bm80w3Vz8t4P
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2019 05:02:48 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 470Bm80b2Sz9sPc; Sat, 26 Oct 2019 05:02:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.b="czTwe7iE"; dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by ozlabs.org (Postfix) with ESMTP id 470Bm75JHnz9sPL;
 Sat, 26 Oct 2019 05:02:47 +1100 (AEDT)
Received: from [10.137.112.111] (unknown [131.107.147.111])
 by linux.microsoft.com (Postfix) with ESMTPSA id 35AE72010AC6;
 Fri, 25 Oct 2019 11:02:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35AE72010AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1572026566;
 bh=7hGCl+P0baIDKMMzceGB2joTvpQFYOW1rsl65AwaESg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=czTwe7iEXiYO6JkheRJPPNMnL5Cbg61vTN7/+dfgsvKoyQ7DzcAkTVmgEHaD44Y/h
 jbDjF2ZBpVUKnbsyoUyslQapQJhi9p/QuR0SQXCtdREc4TW2b9zURqy/JaFZ00xmBr
 UuMXyYCz38KvLS+eL4dyR4/GY0NDH+IiFMK2xe2E=
Subject: Re: [PATCH v9 2/8] powerpc/ima: add support to initialize ima policy
 rules
To: Nayna Jain <nayna@linux.vnet.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
 linux-integrity@vger.kernel.org
References: <20191024034717.70552-1-nayna@linux.ibm.com>
 <20191024034717.70552-3-nayna@linux.ibm.com>
 <dd7e04fc-25e8-280f-b565-bdb031939655@linux.microsoft.com>
 <27dbe08e-5473-4dd0-d2ad-2df591e23f5e@linux.vnet.ibm.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <482b2f08-f810-6ed0-4b32-0d5e64246ece@linux.microsoft.com>
Date: Fri, 25 Oct 2019 11:03:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <27dbe08e-5473-4dd0-d2ad-2df591e23f5e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 Eric Ricther <erichte@linux.ibm.com>, Prakhar Srivastava <prsriva02@gmail.com>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 Elaine Palmer <erpalmer@us.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/25/2019 10:02 AM, Nayna Jain wrote:

 >> Is there any way to not use conditional compilation in
 >> the above array definition? Maybe define different functions to get
 >> "secure_rules" for when CONFIG_MODULE_SIG_FORCE is defined and when
 >> it is not defined.
 >
 > How will you decide which function to be called ?

Define the array in the C file:

const char *const secure_rules_kernel_check[] = {
    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
    NULL
};

const char *const secure_rules_kernel_module_check[] = {
    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
    "appraise func=MODULE_CHECK appraise_type=imasig|modsig",
    NULL
};

And, in the header file :

extern const char *const secure_rules_kernel_check;
extern const char *const secure_rules_kernel_module_check;

#ifdef CONFIG_MODULE_SIG_FORCE
const char *secure_rules() { return secure_rules_kernel_check; }
#else
const char *secure_rules() { return secure_rules_kernel_module_check;}
#endif // #ifdef CONFIG_MODULE_SIG_FORCE

If you want to avoid duplication, secure_rules_kernel_check and 
secure_rules_kernel_module_check could be defined in separate C files 
and conditionally compiled (in Makefile).


I was just trying to suggest the guidelines given in
"Section 21) Conditional Compilation" in coding-style.rst.

It says:
Whenever possible don't use preprocessor conditionals (#ifdef, #if) in 
.c files;...

Feel free to do what you think is appropriate.

thanks,
  -lakshmi


