Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0FA01A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 16:39:42 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 11:09:39 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CD27A1258056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 11:09:38 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC5fl2Q1311134
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 11:11:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC5dZaO025603
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 11:09:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V2] powerpc/TM: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
In-Reply-To: <1415753046.5175.22.camel@neuling.org>
References: <1414938762-20126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1415753046.5175.22.camel@neuling.org>
Date: Wed, 12 Nov 2014 11:09:33 +0530
Message-ID: <87d28tasfe.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> On Sun, 2014-11-02 at 20:02 +0530, Aneesh Kumar K.V wrote:
>> Runtime disable transactional memory feature looking at pa-features
>> device tree entry. We need to do this so that we can run a kernel
>> built with TM config in PR mode. 
>
> I'm happy to turn this off but why do we need to do this in PR mode?
> Can you explain this in the commit message.

Hmm, that commit message needs an update. I initially did the patch for
P8 PR support and wanted a mechanism to disable TM. Alex added basic TM
support for PR mode after that. So we can drop the PR part of the
commit message.

Michael Ellerman,

Let me know if you want me to send an updated version with the those
part of the commit message dropped

>
>> For PR guest we provide a device
>> tree entry with TM feature disabled in pa-features
>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> Changes from V1:
>> * rebase to latest linus
>> 
>>  arch/powerpc/kernel/prom.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 099f27e6d1b0..3e22930f15d1 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -160,6 +160,11 @@ static struct ibm_pa_feature {
>>  	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
>>  	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
>>  	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
>> +	/*
>> +	 * We should use CPU_FTR_TM_COMP so that if we disable TM, it won't get
>> +	 * enabled via device tree
>> +	 */
>> +	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
>>  };
>>  
>>  static void __init scan_features(unsigned long node, const unsigned char *ftrs,
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
