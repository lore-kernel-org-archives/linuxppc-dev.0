Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53BB32C00B1
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Dec 2013 17:10:56 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 10 Dec 2013 11:40:53 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2EB26394005C
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Dec 2013 11:40:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBA6Am1t61341908
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Dec 2013 11:40:48 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBA6AnS5011835
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Dec 2013 11:40:50 +0530
Message-ID: <52A6B028.3090001@linux.vnet.ibm.com>
Date: Tue, 10 Dec 2013 11:39:44 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4 07/10] powerpc, lib: Add new branch instruction analysis
 support functions
References: <20131209062146.6D5C12C00BF@ozlabs.org>
In-Reply-To: <20131209062146.6D5C12C00BF@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, acme@ghostprotocols.net,
 sukadev@linux.vnet.ibm.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/2013 11:51 AM, Michael Ellerman wrote:
> On Wed, 2013-04-12 at 10:32:39 UTC, Anshuman Khandual wrote:
>> Generic powerpc branch instruction analysis support added in the code
>> patching library which will help the subsequent patch on SW based
>> filtering of branch records in perf. This patch also converts and
>> exports some of the existing local static functions through the header
>> file to be used else where.
>>
>> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
>> index a6f8c7a..8bab417 100644
>> --- a/arch/powerpc/include/asm/code-patching.h
>> +++ b/arch/powerpc/include/asm/code-patching.h
>> @@ -22,6 +22,36 @@
>>  #define BRANCH_SET_LINK	0x1
>>  #define BRANCH_ABSOLUTE	0x2
>>  
>> +#define XL_FORM_LR  0x4C000020
>> +#define XL_FORM_CTR 0x4C000420
>> +#define XL_FORM_TAR 0x4C000460
>> +
>> +#define BO_ALWAYS    0x02800000
>> +#define BO_CTR       0x02000000
>> +#define BO_CRBI_OFF  0x00800000
>> +#define BO_CRBI_ON   0x01800000
>> +#define BO_CRBI_HINT 0x00400000
>> +
>> +/* Forms of branch instruction */
>> +int instr_is_branch_iform(unsigned int instr);
>> +int instr_is_branch_bform(unsigned int instr);
>> +int instr_is_branch_xlform(unsigned int instr);
>> +
>> +/* Classification of XL-form instruction */
>> +int is_xlform_lr(unsigned int instr);
>> +int is_xlform_ctr(unsigned int instr);
>> +int is_xlform_tar(unsigned int instr);
>> +
>> +/* Branch instruction is a call */
>> +int is_branch_link_set(unsigned int instr);
>> +
>> +/* BO field analysis (B-form or XL-form) */
>> +int is_bo_always(unsigned int instr);
>> +int is_bo_ctr(unsigned int instr);
>> +int is_bo_crbi_off(unsigned int instr);
>> +int is_bo_crbi_on(unsigned int instr);
>> +int is_bo_crbi_hint(unsigned int instr);
> 
> 
> I think this is the wrong API.
> 
> We end up with all these micro checks, which don't actually encapsulate much,
> and don't implement the logic perf needs. If we had another user for this level
> of detail then it might make sense, but for a single user I think we're better
> off just implementing the semantics it wants.
> 

Having a comprehensive list of branch instruction analysis APIs which some other
user can also use in the future does not make it wrong. Being more elaborate and
detailed makes this one a better choice than the API you have suggested below.

> So that would be something more like:
> 
> bool instr_is_return_branch(unsigned int instr);
> bool instr_is_conditional_branch(unsigned int instr);
> bool instr_is_func_call(unsigned int instr);
> bool instr_is_indirect_func_call(unsigned int instr);
> 
> 
> These would then encapsulate something like the logic in your 8/10 patch. You
> can hopefully also optimise the checking logic in each routine because you know
> the exact semantics you're implementing.
