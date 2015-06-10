Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BFA41A0F45
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 22:10:22 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E33D7140297
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:10:21 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 17:40:20 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 74376125805A
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:42:48 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5ACA9iu26345660
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:40:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5ACA8NP008852
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:40:09 +0530
Message-ID: <55782920.80909@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2015 17:40:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 06/10] powerpc, lib: Add new branch analysis support
 functions
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-6-git-send-email-khandual@linux.vnet.ibm.com>
 <1433914391.3096.40.camel@axtens.net>
In-Reply-To: <1433914391.3096.40.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2015 11:03 AM, Daniel Axtens wrote:
> 
>> +static int instr_is_branch_xlform(unsigned int instr)
>> +{
>> +	return branch_opcode(instr) == 19;
>> +}
> Why do these not return bool? The functions below do.

Yeah they can, will change it.

>> +
>> +bool instr_is_indirect_func_call(unsigned int instr)
>> +{
>> +	/* XL-form instruction with LR set */
>> +	if (instr_is_branch_xlform(instr) && is_branch_link_set(instr))
>> +		return true;
>> +
>> +	return false;
>> +}

> Both of these functions could be made into a single 'return' statement,
> right?

Yeah, right.
