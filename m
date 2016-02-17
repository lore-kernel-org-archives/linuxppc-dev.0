Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419981A029E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 19:34:39 +1100 (AEDT)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:34:12 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H843vX29556916
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 13:34:04 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H83fbX024348
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 13:33:42 +0530
Message-ID: <56C42954.3000801@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2016 13:33:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>, Paul Mackerras <paulus@ozlabs.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: Fix BUG_ON() reporting in real mode on powerpc
References: <1455684191.3089.3.camel@gmail.com>
 <20160217045606.GA19276@oak.ozlabs.ibm.com>
 <1455693365.3089.8.camel@gmail.com>
In-Reply-To: <1455693365.3089.8.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 12:46 PM, Balbir Singh wrote:
>> > It might be a little better to do this:
>> > 
>> > 		bugaddr = regs->nip;
>> > 		if (REGION_ID(bugaddr) == 0 && !(regs->msr & MSR_IR))
>> > 			bugaddr += PAGE_OFFSET;
>> > 
>> > It is possible to execute from addresses with the 0xc000... on top in
>> > real mode, because the CPU ignores the top 4 address bits in real
>> > mode.
> Good catch! Thank you
> 
> Changelog:
>      Don't add PAGE_OFFSET blindly, check if REGION_ID is 0

Cant we use USER_REGION_ID directly ?
